{ pkgs ? import <nixpkgs> {} }:
let
  # packages to include in the docker image
  packages = pkgs; 

  # alpine = pkgs.dockerTools.pullImage {
  #   imageName = "alpine";
  #   imageDigest= "25fad2a32ad1f6f510e528448ae1ec69a28ef81916a004d3629874104f8a7f70";
  #   finalImageTag = "3.18.2";
  #   finalImageName = "apline";
  # };
  # docker image configuration
  dockerImage = pkgs.dockerTools.streamLayeredImage {
    name = "nix-dev-machine";
    tag = "latest";
    created = "now";

    config = {
      cmd = [ "/bin/zsh" ]; # command run on container start
    };

    contents = [ 
      packages.zsh
      packages.bash
      packages.coreutils
      packages.curl
      packages.nixVersions.nix_2_16
    ];
  };
in
  dockerImage

