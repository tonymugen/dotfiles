# System-wide files

Files in this directory must be moved to various places to work. Here is the list of locations:

- `11-nvidia-drm-outputclass.conf`: /usr/share/X11/xorg.conf.d/
- `10-nm-chrony.sh`: /etc/NetworManager/dispatcher.d/
- `60-fonts.conf`: /etc/X11/xorg.conf.d/
- `iptables.rules`: /etc/iptables/
- `chrony.conf`: /etc/
- `displaySetup.sh`, `lightdm-gtk-greeter.conf`, `lightdm.conf`: /etc/lightdm/
- `local.conf`: /etc/fonts/
- `login`: /etc/pam.d/
- `pacupdate.service` and `pacupdate.timer`: /etc/systemd/system/
- `pacman.conf`: /etc/
- `logind.conf`: /etc/systemd/system/
- `dwm.desktop`: /usr/share/xsessions/
- `mugen/`: /boot/grub/themes/
- `mugen/*.pf2`: /boot/grub/fonts/
- `mkinitcpio.conf`: /etc/
- `nvidia.hook`: /etc/pacman.d/hooks/
- `backlight.rules`: /etc/udev/rules.d/
- `wireless-regdom`: /etc/conf.d/

 The `emoji-data.txt` file is for the emoji picking script and should stay in this directory. The `dwm-tonymugen.diff` file has my patched and customized version of dwm. I added the `activetagindicatorbar`, `extrabar`, `statusallmons`, and `fullgaps` patches. After cloning the dwm repo, apply this patch to get my configuration. The same with the `dmenu-tonymugen.diff` patch. This applies a modified `dmenu-xyw` patch (the current version of dmenu allows window attachment with the -w flag, so I changed the width flag to -W).

To keep the system clock from drifting, I use `chrony`. The `chrony.conf` file provides a minimal configuration for `chronyd` (the `chrony` package must be installed and the `chronyd.service` enabled). The `10-nm-chrony.sh` script switches on the NTP servers once an internet connection is established. The `NetworkManager-dispatcher.service` must be enabled for it to work.

For the NVIDIA GPU to work properly, copy the `mkinitcpio.conf` file (it has modifications in addition to the ones already done during Arch install). Run

```sh
mkinitcpio -p linux
```

The `nvidia.hooks` file is to make sure `mkinitcpio` is run after a package update involving `linux` or `nvidia`. The `grub` file also has modifications to run my theme and also make sure the GPU works. Run

```sh
grub-mkconfig -o /boot/grub/grub.cfg
```

The `backlight.rules` module is to enable changing the backlight value without `sudo`. This requires adding the user to the `video` group.

The `wireless-regdom` file sets the regulatory domain for the wireless card. I am in the US, so I uncomment the `US` line. For this to work, `crda` must be installed.
