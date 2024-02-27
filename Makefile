.PHONY: install
install:
	sudo make install-system
	make install-user

.PHONY: install-system
install-system:
	cp -rf ./system/* /etc/nixos/
	rm /etc/nixos/Makefile
	nixos-rebuild switch

.PHONY: install-user
install-user:
	ln -sfT $(shell pwd)/home $$HOME/.config/home-manager
	home-manager switch
