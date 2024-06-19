{ pkgs, ... }:

{
  # NOTE: Aliases for NixOS are not set up.
  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    initExtra = ''
      if [ -e "$HOME/.profile" ]; then                       
		    source $HOME/.profile         
	    fi

      source $HOME/.zshrc

      if [ -e "$HOME/.config/zsh/extra.zsh" ]; then
        source $HOME/.config/zsh/extra.zsh
      fi
    '';
    history = {
      save = 10000;
      size = 10000;
      path = "$HOME/.zsh_history";
    };
    shellAliases = {
      x86_sh = "$env /usr/bin/arch -x86_64 /bin/zsh"; # Rosetta shell alias.

      nu  = "nix-channel --update && sudo nix-channel --update || true";  # Update Nix channels.
      nrs = "darwin-rebuild switch --flake ~/.config/nix-darwin"; # Rebuild Nix config.
      nhs = "home-manager switch";  # Rebuild Home Manager config.
      nsh = "nix-shell ~/.config/nixpkgs/shell.nix";  # Run Nix Shell.
      ncg = "nix-collect-garbage -d && sudo nix-collect-garbage -d && nix-store --gc && sudo nix-store --gc"; # Collect Nix Store garbage.

      py    = "python3";  # Run Python.
      pym   = "python3 -m"; # Run a Python module.
      pyb   = "python3 -m build"; # Run Python Build System.
      pyi   = "python3 -m pip install"; # Install Pip package.
      pyr   = "python3 -m pip uninstall"; # Uninstall Pip package;
      pyir  = "python3 -m pip install -r requirements.txt"; # Install Python project requirements using Pip.
      venv  = "python3 -m venv venv && sed -i '' 's/false/true/g' venv/pyvenv.cfg"; # Create new Virtualenv container; trailing command enables site packages.
      avenv = "sh -c 'source venv/bin/activate; exec zsh -i'"; # Activate Virtualenv container in a new ZSH instance.
    };
    plugins = [
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          hash = "sha256-iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
      {
        name = "zsh-history-substring-search";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-history-substring-search";
          rev = "v1.1.0";
          hash = "sha256-GSEvgvgWi1rrsgikTzDXokHTROoyPRlU0FVpAoEmXG4=";
        };
      }
      {
        name = "nix-zsh-completions";
        src = pkgs.fetchFromGitHub {
          owner = "nix-community";
          repo = "nix-zsh-completions";
          rev = "0.5.1";
          hash = "sha256-bgbMc4HqigqgdkvUe/CWbUclwxpl17ESLzCIP8Sz+F8=";
        };
      }
      {
        name = "zsh-nix-shell";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          hash = "sha256-Z6EYQdasvpl1P78poj9efnnLj7QQg13Me8x1Ryyw+dM=";
        };
      }
    ];
  };
}