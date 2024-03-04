.PHONY: install
install:
	sudo make install-system
	make install-user

.PHONY: install-system
install-system:
	cp -rf ./system/* /etc/nixos/
	nixos-rebuild switch -j 7 --upgrade-all --show-trace

.PHONY: install-user
install-user:
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	home-manager switch -j 7 --show-trace

.PHONY: fix
fix:
	nixfmt .

.PHONY: lint
lint:
	nixfmt --check .
