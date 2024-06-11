.PHONY: install
install:
	sudo make install-system
	make install-user

.PHONY: install-system
install-system:
	mkdir -p /etc/pkg
	cp -rf ./system/* /etc/nixos/
	cp -rf ./pkg/* /etc/pkg/
	nix-channel --update
	nixos-rebuild switch -j 7 --upgrade-all --show-trace

.PHONY: install-user
install-user:
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/release-24.05.tar.gz home-manager
	sudo nix-channel --update
	nix-channel --update
	mkdir -p $$HOME/.config
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	ln -sfT $(shell pwd)/pkg $$HOME/.config/pkg
	home-manager switch -j 7 --show-trace

.PHONY: fix
fix:
	nixfmt .

.PHONY: lint
lint:
	nixfmt --check .
