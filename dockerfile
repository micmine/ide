FROM debian:stable

RUN apt update -y
RUN apt upgrade -y

# basic
RUN apt install -y bash \
	ssh \
	git \
	neovim \
	fzf \
	ripgrep \
	curl \
	wget \
	tmux \
	unzip \
	zip

RUN git clone https://github.com/jimeh/tmux-themepack.git ~/.config/tmux-themepack

# basic lib
RUN apt install -y python3-pip \
	nodejs \
	npm \
	golang-go
RUN npm install eslint --global
RUN pip3 install Pillow
RUN curl -s "https://get.sdkman.io" | bash

# cli tools
RUN apt install -y ranger \
	tree
RUN npm install http-server

# java lib
RUN bash -c ". ~/.bashrc && sdk install java 11.0.6-open"
RUN bash -c ". ~/.bashrc && sdk install gradle"

# javascript lib
RUN npm install -g @vue/cli

# terminal
RUN mkdir -p /usr/share/fonts/truetype
RUN curl -o "/usr/share/fonts/truetype/Sauce\ Code\ Pro\ Nerd\ Font\ Complete.ttf" \
	https://github.com/ryanoasis/nerd-fonts/blob/master/patched-fonts/SourceCodePro/Regular/complete/Sauce%20Code%20Pro%20Nerd%20Font%20Complete.ttf?raw=true

# fuzzy finder
RUN touch /root/.bashrc
RUN echo "if type rg &> /dev/null; then export FZF_DEFAULT_COMMAND='rg --files --hidden' fi" >> /root/.bashrc

# vim-plug
RUN curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
	https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

RUN mkdir -p ~/.config

# load dotfiles
RUN git clone https://github.com/micmine/dotfiles /tmp/dotfiles

# install vim plugins
RUN cp -r /tmp/dotfiles/.config/nvim ~/.config
RUN nvim +PlugInstall +qall

RUN cp -r /tmp/dotfiles/.config/.tmux.conf ~/.tmux.conf

CMD /bin/bash
