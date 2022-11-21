let
  gpuIDs = [
    "1002:67df" # video
    "1002:aaf0" # audio
  ];
in
  {
    pkgs,
    lib,
    config,
    ...
  }: {
    # https://astrid.tech/2022/09/22/0/nixos-gpu-vfio/
    options.vfio.enable = lib.mkEnableOption "Configure the machine for VFIO";

    config = let
      vfioCfg = config.vfio;
    in {
      boot = {
        initrd.kernelModules = [
          # load vfio first so it can claim
          "vfio_pci"
          "vfio"
          "vfio_iommu_type1"
          "vfio_virqfd"

          "nvidia"
          "nvidia_modeset"
          "nvidia_uvm"
          "nvidia_drm"
        ];

        kernelParams =
          [
            # unnecessary AFAIK since it is enabled by default
            "amd_iommu=on"
          ]
          # isolate the GPU
          ++ lib.optional vfioCfg.enable ("vfio-pci.ids=" + lib.concatStringsSep "," gpuIDs);
      };

      services.udev.extraRules = ''
        SUBSYSTEM=="vfio", OWNER="root", GROUP="kvm"
      '';

      hardware.opengl.enable = true;
      virtualisation.spiceUSBRedirection.enable = true;
    };
  }
