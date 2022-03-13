FROM ubuntu:focal

ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get upgrade

RUN apt-get install -y \
    git wget curl sudo unzip gcc g++ apt-transport-https

# install gba related tools
COPY ./tools tools
RUN gcc tools/src/gbafix.c -o /usr/bin/gbafix
RUN g++ tools/src/gbalzss.cpp -o /usr/bin/gbalzss

# install alire
ARG ALR_VER=1.1.2
RUN wget --inet4-only https://github.com/alire-project/alire/releases/download/v${ALR_VER}/alr-${ALR_VER}-bin-x86_64-linux.zip
RUN unzip -j alr-${ALR_VER}-bin-x86_64-linux.zip -d /usr/bin bin/alr

# install powershell (for cross platform build scripts)
RUN wget -q https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb
RUN dpkg -i packages-microsoft-prod.deb

RUN apt-get update
RUN apt-get install -y powershell

# install GNAT arm toolchain
RUN mkdir /alire
RUN alr toolchain --install gnat_arm_elf --disable-assistant --install-dir=/alire
RUN alr toolchain --install gprbuild     --disable-assistant --install-dir=/alire

RUN chsh -s pwsh
SHELL [ "pwsh", "-c" ]

RUN PowerShellGet\Install-Module posh-git -Scope AllUsers -Force
RUN Add-PoshGitToProfile -AllHosts

ADD ./setup-path.ps1 .
RUN . ./setup-path.ps1

ENTRYPOINT [ "pwsh" ]