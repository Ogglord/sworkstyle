# sworkstyle
❄️ nix flake ❄️ for swayest_workstyle

currently pinned to https://github.com/Lyr-7D1h/swayest_workstyle/releases/tag/1.3.5 

commit c5d50d313c2bcd8c5eb40da487e0e76a83854eb6

###  How-to

Add these packages to your `home.packages` or `environment.systemPackages` by
adding `sworkstyle` as an input:
```nix
  ...
  input.sworkstyle.url = "github:ogglord/sworkstyle";
  ...
```

Then, add the package (assuming you pass inputs to configuration.nix or home-manager via specialArgs or some other fancy way):
```nix
{pkgs, config, inputs, ...}: {
  environment.systemPackages = [ # or home.packages
    inputs.sworkstyle.packages.${pkgs.system}.sworkstyle # icons for sway workspaces
  ];
}
```

### Configuration

I prefer to copy a full config as part of my sway setup in home-manager
```nix
  home.file.".config/sworkstyle/config.toml".source = ./sworkstyle_config.toml;
```
