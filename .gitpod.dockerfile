# ArchLinux Docker Image
FROM ubuntu:22.04

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update all packages
RUN apt update -y
RUN apt upgrade -y
RUN apt install zsh nano bc bison ca-certificates curl flex gcc git libc6-dev libssl-dev openssl python-is-python3 ssh wget zip zstd make clang gcc-arm-linux-gnueabi software-properties-common build-essential libarchive-tools gcc-aarch64-linux-gnu -y && apt install build-essential -y && apt install libssl-dev libffi-dev libncurses5-dev zlib1g zlib1g-dev libreadline-dev libbz2-dev libsqlite3-dev make gcc -y && apt install pigz -y && apt install python2 -y && apt install python3 -y && apt install cpio -y && apt install lld -y && apt install llvm -y && apt-get install g++-aarch64-linux-gnu -y && apt install libelf-dev -y && apt install neofetch -y && neofetch

# Create user gitpod
RUN useradd -l -u 33333 -G sudo -md /home/gitpod -s /bin/zsh -p gitpod gitpod && \
    # passwordless sudo for users in the 'sudo' group
    sed -i.bkp -e 's/%sudo\s\+ALL=(ALL\(:ALL\)\?)\s\+ALL/%sudo ALL=NOPASSWD:ALL/g' /etc/sudoers

# Switch to Gitpod User
USER gitpod

# Setup Localtime
RUN sudo ln -sf /usr/share/zoneinfo/Asia/Jakarta /etc/localtime

# Set the locale
ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8
RUN sudo locale-gen en_US.UTF-8

# Change Shell to ZSH
RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true
CMD [ "source ~/.zshrc && zsh" ]
