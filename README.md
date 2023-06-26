# sworkstyle
nix flake for swayest_workstyle

### ❄️ How-to

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
