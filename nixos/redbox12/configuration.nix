# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix

    ../modules/dconf-dbus.nix
    ../modules/nix.nix
    ../modules/xserver.nix
  ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  fileSystems."/boot" = {
    device = "/dev/disk/by-partuuid/11a82a3d-bf69-46a4-9441-b8e22e9eaac4";
    fsType = "vfat";
  };

  boot.initrd.luks.devices = {
    root = {
      device = "/dev/disk/by-partuuid/60d2ef2f-5a20-4758-b16a-fad73b7600c9";
      preLVM = true;
    };
  };

  # like /, swap partition is part of luks group
  swapDevices = [ { device = "/dev/disk/by-uuid/f0a3b235-96e1-4ad7-81ce-024e5e8f7cb1"; } ];

  # 2nd drive
  fileSystems."/mnt/basement" = {
    device = "/dev/disk/by-partuuid/5217ae9d-3ae9-42af-80e7-0824676c720c";
    fsType = "ntfs3";
    options = [
      "defaults"
      "noatime"
      "nofail"
      "force"
    ];
  };
  fileSystems."/mnt/cubby" = {
    device = "/dev/disk/by-partuuid/41a7ec62-6f1f-4b81-961a-0eb5927d594c";
    options = [
      "defaults"
      "noatime"
      "nofail"
    ];
  };

  networking.hostName = "redbox12"; # Define your hostname.
  networking.wireless.enable = true; # Enables wireless support via wpa_supplicant.
  # Open sockets that wpa_cli can talk to
  networking.wireless.extraConfig = "ctrl_interface=DIR=/run/wpa_supplicant GROUP=wheel";

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # Enable DHCP by default for non-configured interfaces
  networking.useDHCP = true;
  # Explicitly enable DHCP for main interfaces
  networking.interfaces.enp34s0.useDHCP = true;
  networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  environment.pathsToLink = [
    "/libexec" # links /libexec from derivations to /run/current-system/sw
    "/share/zsh" # zsh completions for commands
  ];

  boot.kernelModules = [
    "amdgpu"
    "nbd"
  ];
  hardware.graphics.extraPackages = [
    pkgs.intel-compute-runtime
    pkgs.rocmPackages.clr.icd
  ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  environment.variables = {
    ROC_ENABLE_PRE_VEGA = "1";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.gutenprint ];
  services.avahi.enable = true;
  services.avahi.nssmdns4 = true;

  # Enable sound.
  services.pipewire = {
    enable = true;
    pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.spencer = {
    isNormalUser = true;
    extraGroups = [
      "wheel" # wheel = Enable ‘sudo’ for the user.
      "vboxusers"
      "libvirtd"
      "kvm"
      "input"
      "dialout" # dialout = access serial ports (/dev/ttyACM0, /dev/ttyS{0,1,2,3})
    ];
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    curl
    wget
    file
    psmisc # fuser, killall and pstree
    lsof
    pciutils
    htop
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = [
    pkgs.fuse
    pkgs.glib
    pkgs.libglvnd
    pkgs.nss
    pkgs.nspr
    pkgs.expat
    pkgs.freetype
    pkgs.fontconfig.lib
    pkgs.xorg.libX11
    pkgs.xorg.libxcb
    pkgs.xorg.libXcomposite
    pkgs.xorg.libXcursor
    pkgs.xorg.libXdamage
    pkgs.xorg.libXfixes
    pkgs.xorg.libXi
    pkgs.xorg.libXrender
    pkgs.xorg.libXtst
    pkgs.alsa-lib
    pkgs.dbus.lib
  ];

  # List services that you want to enable:

  # Enable steam games
  programs.steam.enable = true;

  services.udisks2.enable = true;

  services.tlp.enable = true;

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = false;
      ovmf.enable = true;
    };
  };
  virtualisation.docker.enable = true;

  programs.ssh.startAgent = true;

  # XKCD: Coordinate Precision
  # https://xkcd.com/2170/
  location = {
    provider = "manual";
    latitude = 34.05;
    longitude = -118.24;
  };
  services.redshift = {
    enable = true;
    temperature.night = 3000;
  };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
      "steam-run"
      "steam-unwrapped"
      "nvidia-x11"
      "nvidia-settings"
    ];

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?
}
