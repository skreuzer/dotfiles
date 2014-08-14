RCFILES=	screenrc gitconfig

.PHONY: $(RCFILES)

install: $(RCFILES)

$(RCFILES):
	/bin/ln -nfs $(.CURDIR)/$@ $$HOME/.$@

update:
	git pull --rebase
