{
  description = "Flake for Fetchcord";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable"; # or a specific version
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs {
        inherit system;
      };
    in {
      packages.fetchcord = pkgs.python3Packages.buildPythonApplication {
        pname = "fetchcord";
        version = "2.7.7"; # Replace with the actual version

        src = pkgs.fetchFromGitHub {
          owner = "fetchcord"; # Replace with the actual owner
          repo = "fetchcord"; # Replace with the actual repository name
          rev = "3833c0f1464fb5703e712db4ebf0e7f88f22a829"; # Replace with the actual commit hash
          sha256 = "sKbXCxK3FlmV2rp3/Fjf9CPwdUpZrtllcGZt9s4JqW4="; # Replace with the actual hash
        };

        buildInputs = with pkgs.python3Packages; [ setuptools ];
        propagatedBuildInputs = with pkgs; [ neofetch python3Packages.pypresence python3Packages.psutil]; # Added pypresence here

        meta = with pkgs.lib; {
          description = "A Discord fetch tool that displays system information.";
          homepage = "https://github.com/YourGitHubUsername/fetchcord"; # Replace with the actual homepage
          license = licenses.mit; # Replace with the actual license
          maintainers = with maintainers; [yourMaintainerName]; # Replace with actual maintainer name
          platforms = platforms.unix;
          mainProgram = "fetchcord"; # Replace with the actual main program
        };
      };
    });
}