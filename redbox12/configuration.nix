# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  config,
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
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
  swapDevices = [{device = "/dev/disk/by-uuid/f0a3b235-96e1-4ad7-81ce-024e5e8f7cb1";}];

  networking.hostName = "redbox12"; # Define your hostname.
  networking.wireless.enable =
    false; # Enables wireless support via wpa_supplicant.

  # Set your time zone.
  time.timeZone = "America/Los_Angeles";

  # The global useDHCP flag is deprecated, therefore explicitly set to false here.
  # Per-interface useDHCP will be mandatory in the future, so this generated config
  # replicates the default behaviour.
  networking.useDHCP = false;
  networking.interfaces.enp24s0.useDHCP = true;
  #networking.interfaces.wlo1.useDHCP = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod.enabled = "fcitx5";
  i18n.inputMethod.fcitx5.addons = [pkgs.fcitx5-chinese-addons];

  fonts.fonts = [pkgs.noto-fonts-cjk];
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  # };

  environment.pathsToLink = [
    "/libexec" # links /libexec from derivations to /run/current-system/sw
    "/share/zsh" # zsh completions for commands
  ];

  # Enable DConf for gtk3 applications and firefox
  programs.dconf.enable = true;
  # Needed for flameshot
  services.dbus.enable = true;

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  # Channel compat
  # https://ayats.org/blog/channels-to-flakes/
  environment.etc."nix/inputs/nixpkgs".source = inputs.nixpkgs.outPath;
  environment.etc."nix/inputs/home-manager".source =
    inputs.home-manager.outPath;
  nix.nixPath = [
    "nixpkgs=/etc/nix/inputs/nixpkgs"
    "home-manager=/etc/nix/inputs/home-manager"
  ];
  nix.registry = with lib;
    mapAttrs' (name: value: nameValuePair name {flake = value;}) inputs;

  boot.kernelModules = ["amdgpu" "nbd"];
  hardware.opengl.driSupport = true;
  hardware.opengl.driSupport32Bit = true;

  services.xserver = {
    enable = true;
    videoDrivers = ["amdgpu"];

    # Configure keymap in X11
    layout = "us";
    xkbOptions = "caps:escape_shifted_capslock";

    displayManager = {
      # password is needed to unlock disk so don't ask again
      autoLogin = {
        enable = true;
        user = "spencer";
      };
      session = [
        {
          # name is purely cosmetic
          name = "i3";
          manage = "window";
          start = ''
            ${pkgs.runtimeShell} $HOME/.hm-xsession &
            waitPID=$!
          '';
        }
      ];
      # also cosmetic, but should match above
      defaultSession = "none+i3";
    };
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;
  services.printing.drivers = [pkgs.gutenprint];
  services.avahi.enable = true;
  services.avahi.nssmdns = true;

  # Enable sound.
  sound.enable = true;
  hardware.pulseaudio = {
    enable = true;
    extraConfig = ''
      set-default-sink alsa_output.usb-Razer_Razer_Barracuda_X-00.analog-stereo
      set-default-source alsa_input.usb-Blue_Microphones_Yeti_Nano_2042SG00DZP8_888-000154040606-00.analog-stereo
    '';
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
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable steam games
  programs.steam.enable = true;

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

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
      "steam-run"
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
