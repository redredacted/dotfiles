#!/bin/sh
sh <(curl -L https://nixos.org/nix/install) --daemon
nix-env -e man-db
nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.05.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
echo 'experimental-features = nix-command flakes' >> /etc/nix/nix.conf
home-manager switch --flake /dotfiles/flake/
