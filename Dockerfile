FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive

# Install apt packages
RUN apt -y update
RUN apt -y install vim cmake wget git zsh wget curl neovim build-essential libncurses5 libpython2.7

WORKDIR /root/

# Config zsh and install plugins
RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
RUN git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
RUN git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
RUN chsh -s /usr/bin/zsh
COPY .zshrc /root/

# Install and config spacevim
RUN curl -sLf https://spacevim.org/install.sh | bash
RUN mkdir -p /root/.SpaceVim.d/colors
RUN curl https://gist.githubusercontent.com/subicura/91696d2da58ad28b5e8b2877193015e1/raw/6fb5928c9bda2040b3c9561d1e928231dbcc9184/snazzy-custom.vim -o /root/.SpaceVim.d/colors/snazzy-custom.vim
COPY init.toml /root/.SpaceVim.d/

# Install aarch64 toolchain 6.3.1
WORKDIR /opt/
RUN wget https://releases.linaro.org/components/toolchain/binaries/6.3-2017.05/aarch64-linux-gnu/gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz
RUN wget https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.gz
RUN tar -xf gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz
RUN tar -xzf boost_1_69_0.tar.gz
RUN rm gcc-linaro-6.3.1-2017.05-x86_64_aarch64-linux-gnu.tar.xz boost_1_69_0.tar.gz

WORKDIR /root/