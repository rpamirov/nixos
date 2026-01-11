{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    # work-specific tools
    docker
    docker-compose
    python3
    python311Packages.virtualenv
    ros2
    colcon
    wireshark
    tcpdump
    can-utils
  ];

  programs.wireshark.enable = true;
  users.users.rpamirov.extraGroups = [
    "docker"
    "wireshark"
  ];
}
