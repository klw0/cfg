dotfiles_dir := $(PWD)/dotfiles
dotfiles := $(wildcard $(dotfiles_dir)/*)
symlinks := $(patsubst $(dotfiles_dir)/%, ${HOME}/.%, $(dotfiles))

.PHONY: install
install: $(symlinks)

$(symlinks): ${HOME}/.%: $(dotfiles_dir)/%
	ln -sf $< $@
