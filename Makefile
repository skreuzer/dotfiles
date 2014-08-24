RCFILES=	screenrc gitconfig cvsrc perltidyrc vimrc vimrc.bundles vim

.PHONY: $(RCFILES)

install: $(RCFILES)

$(RCFILES):
	/bin/ln -nfs $(.CURDIR)/$@ $$HOME/.$@

update:
	git pull --rebase
