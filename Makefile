SYMLINK_RCFILES=	screenrc \
		gitconfig \
		cvsrc \
		perltidyrc \
		vimrc \
		vim \
		tmux.conf \
		zshrc \
		zsh \
		porttools

CP_RCFILES=	login_conf

.PHONY: $(SYMLINK_RCFILES) $(CP_RCFILES)

install: $(SYMLINK_RCFILES) $(CP_RCFILES)

$(SYMLINK_RCFILES):
	/bin/ln -nfs $(PWD)/$@ $$HOME/.$@

$(CP_RCFILES):
	/bin/cp $(PWD)/$@ $$HOME/.$@

vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

update:
	git pull --rebase
	vim +PluginInstall +qall
