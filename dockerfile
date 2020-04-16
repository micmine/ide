FROM debian:stable

RUN apt update -y
RUN apt upgrade -y

# basic
RUN apt install -y bash ssh git neovim fzf ripgrep curl tmux

# basic lib
RUN apt install -y python3-pip nodejs npm golang-go
RUN npm install eslint --global
RUN pip3 install Pillow

# cli tools
RUN apt install -y ranger tree

# php lib
# java lib
# python lib
# javascript lib

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