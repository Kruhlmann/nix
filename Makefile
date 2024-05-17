.PHONY: install
install:
	sudo make install-system
	make install-user

.PHONY: install-system
install-system:
	cp -rf ./system/* /etc/nixos/
	nix-channel --update
	nixos-rebuild switch -j 7 --upgrade-all --show-trace

.PHONY: install-user
install-user:
	sudo nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
	sudo nix-channel --update
	nix-channel --update
	mkdir -p $$HOME/.config
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	home-manager switch -j 7 --show-trace

.PHONY: fix
fix:
	nixfmt .

.PHONY: lint
lint:
	nixfmt --check .
