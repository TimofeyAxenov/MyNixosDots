{config, pkgs, ...}:

{

  boot.initrd.kernelModules = [ "amdgpu" ];

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };

    amdgpu.amdvlk = {
      enable = true;
      support32Bit.enable = true;
    };
  };

#  hardware.opengl.extraPackages = with pkgs; [
#    rocmPackages.clr.icd
#  ];

  services.xserver.videoDrivers = ["amdgpu"];

  environment.sessionVariables = {
    XR_RUNTIME_PATH = "/run/opengl-driver/share/openxr/1/openxr-loader.json";
  };

  boot.kernelPatches = [
    {
      name = "amdgpu-ignore-ctx-privileges";
      patch = pkgs.fetchpatch {
        name = "cap_sys_nice_begone.patch";
        url = "https://github.com/Frogging-Family/community-patches/raw/master/linux61-tkg/cap_sys_nice_begone.mypatch";
        hash = "sha256-Y3a0+x2xvHsfLax/uwycdJf3xLxvVfkfDVqjkxNaYEo=";
      };
    }
  ];

#  hardware.nvidia = {
#    modesetting.enable = true;
#
#    nvidiaSettings = true;

#    open = false;

#    package = config.boot.kernelPackages.nvidiaPackages.beta;
#  };

#  hardware.nvidia.prime = {
#    sync.enable = true;
#		# Make sure to use the correct Bus ID values for your system!
#		intelBusId = "PCI:0:2:0";
#		nvidiaBusId = "PCI:1:0:0";
                # amdgpuBusId = "PCI:54:0:0"; For AMD GPU
#	};
}
