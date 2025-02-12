{config, pkgs, ...}:

{
  environment.systemPackages = with pkgs; [
    postgresql
    protobuf
    gnumake
    go-migrate
    buf
    rpi-imager
    mqttx
#    jetbrains.pycharm-professional
#    jetbrains.goland
#    jetbrains.clion
  ];
}
