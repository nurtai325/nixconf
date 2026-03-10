{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages;

  networking.hostName = "nixos"; # Define your hostname.
  networking.networkmanager.wifi.scanRandMacAddress = false;
  networking.networkmanager.enable = true;

  time.timeZone = "Asia/Almaty";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "kk_KZ.UTF-8";
    LC_IDENTIFICATION = "kk_KZ.UTF-8";
    LC_MEASUREMENT = "kk_KZ.UTF-8";
    LC_MONETARY = "kk_KZ.UTF-8";
    LC_NAME = "kk_KZ.UTF-8";
    LC_NUMERIC = "kk_KZ.UTF-8";
    LC_PAPER = "kk_KZ.UTF-8";
    LC_TELEPHONE = "kk_KZ.UTF-8";
    LC_TIME = "kk_KZ.UTF-8";
  };

  services.xserver.enable = true;
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];
  services.xserver.xkb = {
    layout = "us,kz";
    variant = "";
  };

  services.printing.enable = true;
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  users.users.nurtai = {
    isNormalUser = true;
    description = "nurtai";
    extraGroups = [
      "networkmanager"
      "wheel"
      "docker"
    ];
  };
  users.defaultUserShell = pkgs.zsh;

  virtualisation.docker.enable = true;
  programs.zsh.enable = true;
  programs.firefox.enable = true;
  programs.nix-ld.enable = true;

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    git
    vim
    neovim
    zsh
  ];

  system.stateVersion = "25.11";

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.enableAllFirmware = true;
}
