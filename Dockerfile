FROM ubuntu:cosmic 

RUN apt update 
RUN apt-get install -y ca-certificates nodejs npm python-dev python-pip python3-dev python3-pip apt-transport-https ripgrep xsel git wget tmux software-properties-common curl zsh 

RUN apt-add-repository ppa:neovim-ppa/unstable && apt-get update && apt-get install -y neovim
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

RUN cd /tmp \
    && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb \
    && dpkg -i ripgrep_0.10.0_amd64.deb

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true


RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
&& ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"


RUN cd \
    && git clone https://github.com/Vinchenso/dotfiles.git 

RUN mkdir /root/.config
RUN mkdir /root/.config/nvim

RUN mkdir /root/coding
RUN mkdir /root/coding/app

WORKDIR /root/coding/app

RUN ln -sf /root/dotfiles/init.vim /root/.config/nvim/init.vim \
    && ln -sf /root/dotfiles/tmux.conf /root/tmux.conf 

RUN chsh -s /bin/zsh 

CMD ["zsh"]
