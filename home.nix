{ config, pkgs, ... }:

{
	imports = [
		./nvim
		./zsh
		./fzf
		./tmux
		./kitty
	];

	home.username = "nurtai";
	home.homeDirectory = "/home/nurtai";

	home.stateVersion = "25.05";

	programs.git = {
		enable = true;
		settings.user.name = "nurtai325";
		settings.user.email = "nurtolymbek23@gmail.com";
	};

	home.packages = [
		pkgs.zsh-powerlevel10k
		pkgs.tree-sitter
		pkgs.nodejs
		pkgs.ripgrep
		pkgs.lazygit
		pkgs.gnumake
		pkgs.gcc
		pkgs.go
		pkgs.zip
		pkgs.unzip
		pkgs.clang-tools
		pkgs.istioctl
		pkgs.kind
		pkgs.kubectl
		pkgs.rustc
		pkgs.python312

		(pkgs.writeShellScriptBin "sd" (builtins.readFile ./zsh/sd.sh))
	];

	home.file = {
		".p10k.zsh".source = ./zsh/p10k.zsh;
		".config/nvim/init.lua".source = ./nvim/config/init.lua;
		".config/nvim/lua".source = ./nvim/config/lua;
	};

	home.sessionVariables = {
	};

	programs.home-manager.enable = true;
}
