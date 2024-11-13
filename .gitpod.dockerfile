# ArchLinux Docker Image
FROM ubuntu:22.04

# Non-interactive installation mode
ENV DEBIAN_FRONTEND=noninteractive

# Update all packages
RUN apt update -y
RUN apt upgrade -y
RUN apt install -y sudo locales locales-all curl wget zsh git make libssl-dev zip bc zstd flex bison libarchive-tools python3 default-jre

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
