{config, pkgs, inputs, ...}:

{
  environment.systemPackages = with pkgs; [
    ghidra
    gdb
    burpsuite
    sqlmap
    wireshark
    pwntools
  ];
}
