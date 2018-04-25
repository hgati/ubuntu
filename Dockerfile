FROM ubuntu:16.04

LABEL maintainer="hgati <cobays@gmail.com>"

COPY provision /tmp/

RUN set -ex \
    && sed -i 's/archive.ubuntu.com/ftp.daumkakao.com/g' /etc/apt/sources.list \
    && apt-get update \
    && apt-get install -y build-essential locales bash expect wget dos2unix htop git siege p7zip-full vim-nox \
    && locale-gen ko_KR.UTF-8 \
    && sed -ie 's/en_US/ko_KR/g' /etc/default/locale \
    && echo 'LANGUAGE="ko_KR:ko:en_US:en"' >> /etc/default/locale \
    && /bin/bash -c "source /etc/default/locale" \
    && wget https://github.com/sstalle/php7cc/releases/download/1.2.1/php7cc.phar -O /usr/local/bin/php7cc \
    && chmod +x /usr/local/bin/php7cc \
    && git config --global user.email "test@test.com" \
    && git config --global user.name "John Doe" \
    && cp /tmp/.utils/vimrc ~/.vimrc \
    && dos2unix ~/.vimrc \
    && git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim \
    && vim +PluginInstall +qall \
    && sed -i 's/"colorscheme railscasts/colorscheme railscasts/g' ~/.vimrc \
    && /bin/bash -c "source ~/.bashrc"

