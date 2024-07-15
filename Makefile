NIX_VERSION=24.05
SUPPORTED_SHELLS=bash|dash|zsh|sh
SHELL_FILES=$(shell git ls-files | grep -El '#!/.*(bash|dash|zsh|sh)' | grep -v Makefile)
HASKELL_FILES=$(shell git ls-files '*.hs')
MAKE_FILES=$(shell find . -name 'Makefile' -o -name 'makefile' -o -name 'GNUmakefile' -o -name '*.mk' -o -name '*.make')

.ONESHELL:

.PHONY: all
all: install

.PHONY: install
install:
	sudo make install-system
	make install-user

.PHONY: install-system
install-system:
	nix-channel --add https://nixos.org/channels/nixos-"$(NIX_VERSION)" nixos
	mkdir -p /etc/pkg
	cp -rf ./system/* /etc/nixos/
	cp -rf ./pkg/* /etc/pkg/
	nix-channel --update
	nixos-rebuild switch -j 7 --upgrade-all --show-trace

.PHONY: install-user
install-user:
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-$(NIX_VERSION).tar.gz home-manager
	sudo nix-channel --update
	nix-channel --update
	mkdir -p $$HOME/.config
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	ln -sfT $(shell pwd)/pkg $$HOME/.config/pkg
	home-manager switch -j 7 --show-trace

.PHONY: fix
fix:
	nixfmt .
	ormolu --mode inplace $(HASKELL_FILES)
	shellharden --replace $(SHELL_FILES)

.PHONY: lint
lint:
	nixfmt --check .
	ormolu --mode check $(HASKELL_FILES)
	shellharden $(SHELL_FILES)
	checkmake Makefile
