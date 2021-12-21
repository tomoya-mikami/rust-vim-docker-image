FROM rust:1.57.0-buster

SHELL ["/bin/bash", "-c"]

WORKDIR /home/tools


RUN apt-get update
RUN apt-get install -y curl git ncurses-dev

RUN wget https://github.com/vim/vim/archive/master.zip
RUN unzip master.zip

WORKDIR /home/tools/vim-master/src
RUN ./configure
RUN make
RUN make install

WORKDIR /home/workspace

ENV LANG=ja_JP.UTF-8
ENV LC_CTYPE=ja_JP.UTF-8
ENV LANGUAGE=ja_JP.UTF-8

COPY ./vim-setting /home/tools/vim-setting

RUN ln -s /home/tools/vim-setting/vimrc ~/.vimrc

# rustのライブラリを追加する
RUN rustup component add rustfmt rls rust-analysis rust-src

# vimまわりの準備
RUN curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

