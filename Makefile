NIX_VERSION=26.05
SUPPORTED_SHELLS=bash|dash|zsh|sh
SHELL_FILES=$(shell git ls-files | grep -El '#!/.*(bash|dash|zsh|sh)' | grep -v Makefile)
HASKELL_FILES=$(shell git ls-files '*.hs')
NIX_FILES=$(shell git ls-files '*.nix')
MAKE_FILES=$(shell find . -name 'Makefile' -o -name 'makefile' -o -name 'GNUmakefile' -o -name '*.mk' -o -name '*.make')

.ONESHELL:

.PHONY: FORCE
FORCE:

.PHONY: all
all: install

install-%: FORCE machines/%.nix
	sudo make install-system-$*
	make install-user

install-system-%: FORCE install-symlinks machines/%.nix
	cp machines/$*.nix /etc/nixos/configuration.nix
	nixos-rebuild switch -j $(shell nproc) --upgrade-all --show-trace

.PHONY: install-syslinks
install-symlinks:
	nix-channel --add "https://nixos.org/channels/nixos-$(NIX_VERSION)" nixos && nix-channel --update
	mkdir -p /etc/pkg
	cp -rf ./system/* /etc/nixos/
	cp -rf ./pkg/* /etc/pkg/

.PHONY: install-user
install-user:
	nix-channel --add "https://github.com/nix-community/home-manager/archive/release-$(NIX_VERSION).tar.gz" home-manager && nix-channel --update
	mkdir -p $$HOME/.config
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	ln -sfT $(shell pwd)/pkg $$HOME/.config/pkg
	home-manager switch -j $(shell nproc) --show-trace

.PHONY: fix
fix:
	nixfmt $(NIX_FILES)
	ormolu --mode inplace $(HASKELL_FILES)
	shellharden --replace $(SHELL_FILES)

.PHONY: lint
lint:
	nixfmt --check $(NIX_FILES)
	ormolu --mode check $(HASKELL_FILES)
	shellharden $(SHELL_FILES)
	checkmake Makefile

.PHONY: test
test:
	true

.PHONY: clean
clean:
	true
