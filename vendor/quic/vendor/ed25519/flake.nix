{
  description = "dev";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
    flake-utils.url = "github:numtide/flake-utils";
    dev-env.url = "github:spyderorg/dev-env";
    quic.url = "github:spyderorg/quic";
  };

  outputs =
    {
      self,
      nixpkgs,
      dev-env,
      flake-utils,
      quic,
      ...
    }:
    let
      flakeForSystem =
        nixpkgs: system:
        let
          pkgs = import nixpkgs {
            inherit system;
            config = { allowUnfree = true; };
          };

          zigPkg = dev-env.packages.${system}.zigPackages;
          quicPkg = quic.packages.${system}.quic;
          quicDebugPkg = quic.packages.${system}.quic-debug;

          agent = pkgs.callPackage ./nix/agent.nix {
            zig = zigPkg;
            pkg-config = pkgs.pkg-config;
            git = pkgs.git;
            revision = (self.rev or "dirty");
            optimize = "ReleaseFast";
            enableXdp = false;
          };
          
          # Single source of truth for the development environment packages
          devShellPackages = with pkgs; [
            zigPkg
            tcpdump
            file
          ];
        in
        {
          packages = {
            agent = agent;
            default = agent;
          };
          devShell = pkgs.mkShell {
            shellHook = '''';
            env = { };
            packages =
              (with dev-env.packages.${system}; [
                zigPackages
                goPackages
                commonPackages
              ])
              ++ ([
                quicPkg
                quicDebugPkg
                pkgs.tcpdump
                pkgs.tshark
                pkgs.file
              ]);
          };
        };
    in
    flake-utils.lib.eachDefaultSystem (system: flakeForSystem nixpkgs system);

  nixConfig = {
    extra-substituters = [ "https://spyder.cachix.org" ];
    extra-trusted-public-keys = [
      "spyder.cachix.org-1:xZG2a8INH6yNyOAwtN2Ojjys0GO9D1pXEe3PNriT04E="
    ];
  };
}
