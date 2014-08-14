RCFILES=	screenrc gitconfig cvsrc perltidyrc

.PHONY: $(RCFILES)

install: $(RCFILES)

$(RCFILES):
	/bin/ln -nfs $(.CURDIR)/$@ $$HOME/.$@

update:
	git pull --rebase
