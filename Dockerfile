FROM bitnami/minideb

RUN install_packages ca-certificates python-dev python-pip python3-dev python3-pip xsel git wget tmux software-properties-common curl zsh 

RUN apt-add-repository ppa:neovim-ppa/stable && apt-get update && install_packages neovim

RUN cd /tmp \
    && curl -LO https://github.com/BurntSushi/ripgrep/releases/download/0.10.0/ripgrep_0.10.0_amd64.deb \
    && dpkg -i ripgrep_0.10.0_amd64.deb

RUN wget https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh -O - | zsh || true


RUN git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" \
&& ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

RUN cd \
    && git clone https://github.com/Vinchenso/dotfiles.git \
    && cd dotfiles

RUN mkdir .config
RUN mkdir .config/nvim

RUN ln -sf ~/dotfiles/init.vim ~/.config/nvim/init.vim \
    && ln -sf ~/dotfiles/tmux.conf ~/.tmux-conf 

CMD ["zsh"]
