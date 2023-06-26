{
  description = "Sway workspace modifier called sworkstyle (swayland_workstyle)";

  inputs = {
    cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    # Use a github flake URL for real packages
    # cargo2nix.url = "github:cargo2nix/cargo2nix/release-0.11.0";
    flake-utils.follows = "cargo2nix/flake-utils";
    nixpkgs.follows = "cargo2nix/nixpkgs";
  };

  outputs = inputs: with inputs; # pass through all inputs and bring them into scope

    # Build the output set for each default system and map system sets into
    # attributes, resulting in paths such as:
    # nix build .#packages.x86_64-linux.<name>
    flake-utils.lib.eachDefaultSystem (system:

      # let-in expressions, very similar to Rust's let bindings.  These names
      # are used to express the output but not themselves paths in the output.
      let

        # create nixpkgs that contains rustBuilder from cargo2nix overlay
        pkgs = import nixpkgs {
          inherit system;
          overlays = [ cargo2nix.overlays.default ];
        };

        # create the workspace & dependencies package set
        rustPkgs = pkgs.rustBuilder.makePackageSet {
          rustVersion = "1.61.0";
          
          packageFun = import ./Cargo.nix;
          workspaceSrc = pkgs.fetchFromGitHub {
            owner = "Lyr-7D1h";
            repo = "swayest_workstyle";
            rev = "c5d50d313c2bcd8c5eb40da487e0e76a83854eb6";
            sha256 = "0idaksm5hwikh7y7vsksd5cxl62mab5mhprgrcgpaggv5h1ankhf";
          };
        };

      in rec {
        # this is the output (recursive) set (expressed for each system)

        # the packages in `nix build .#packages.<system>.<name>`
        packages = {
          # nix build .#hello-world
          # nix build .#packages.x86_64-linux.hello-world
          sworkstyle = (rustPkgs.workspace.sworkstyle {}).bin;
          # nix build
          default = packages.sworkstyle; # rec
        };
      }
    );
}
