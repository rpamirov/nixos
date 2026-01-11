{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # work-specific tools
    docker
    docker-compose
  ];

  programs.wireshark.enable = true;
  users.users.rpamirov.extraGroups = [
    "docker"
  ];
}
