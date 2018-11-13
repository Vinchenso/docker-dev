FROM ubuntu:cosmic 

RUN apt update 
RUN apt-get install -y ca-certificates python-dev python-pip python3-dev python3-pip apt-transport-https ripgrep xsel git wget tmux software-properties-common curl zsh 

RUN apt-add-repository ppa:neovim-ppa/unstable && apt-get update && apt-get install -y neovim

RUN cd /tmp \
    && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb \
    && dpkg -i ripgrep_0.10.0_amd64.deb

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true


RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
&& ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

RUN cd \
    && git clone https://github.com/Vinchenso/dotfiles.git \
    && cd dotfiles

RUN cd && mkdir .config
RUN cd && mkdir .config/nvim

RUN ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim \
    && ln -sf ~/dotfiles/tmux.conf ~/.tmux-conf 

CMD ["zsh"]
