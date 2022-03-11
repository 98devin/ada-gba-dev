FROM ubuntu:focal

ARG RUNTIME=noninteractive

RUN apt-get update && apt-get upgrade

RUN apt-get -y install \
    git wget curl sudo unzip fish

ARG ALR_VER=1.1.2
RUN wget --inet4-only https://github.com/alire-project/alire/releases/download/v${ALR_VER}/alr-${ALR_VER}-bin-x86_64-linux.zip
RUN unzip -j alr-${ALR_VER}-bin-x86_64-linux.zip -d /usr/bin bin/alr

RUN mkdir /alire
RUN alr toolchain --install gnat_arm_elf --disable-assistant --install-dir=/alire
RUN alr toolchain --install gprbuild     --disable-assistant --install-dir=/alire

RUN chsh -s fish
SHELL [ "fish", "-c" ]

RUN set -U fish_user_paths /alire/(ls /alire)/bin $fish_user_paths

ENTRYPOINT [ "fish" ]