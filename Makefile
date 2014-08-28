RCFILES=	screenrc \
		gitconfig \
		cvsrc \
		perltidyrc \
		vimrc \
		vim \
		xterm.conf

.PHONY: $(RCFILES)

install: $(RCFILES)

$(RCFILES):
	/bin/ln -nfs $(.CURDIR)/$@ $$HOME/.$@

vundle:
	git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim

update:
	git pull --rebase
	vim +PluginInstall +qall
