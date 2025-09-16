# Formatting & mounting disks

```sh
sudo cfdisk /dev/vda # create partitions (no need if already exists...just Formatting)

sudo mkfs.vfat -n EFI /dev/vda1 # do not format efi if already exists!!

sudo mkfs.btrfs -L nixos /dev/vda2 # format the root partition

# create & mount btrfs subvolumes
sudo mount -t btrfs /dev/disk/by-label/nixos /mnt

sudo btrfs subvol create /mnt/{@root,@home}

sudo umount /mnt

sudo mount -o subvol=@root,compress=zstd,noatime /dev/disk/by-label/nixos /mnt

sudo mkdir -p /mnt/boot/efi
sudo mkdir -p /mnt/home

sudo mount -o subvol=@home,compress=zstd,noatime /dev/disk/by-label/nixos /mnt/home
sudo mount /dev/disk/by-label/EFI /mnt/boot/efi
```

# Generate initial config

```sh
sudo nixos-generate-config --flake --root /mnt

# Edit generated config
```

# Install

```sh
sudo nixos-install --no-root-passwd --flake '/mnt/etc/nixos/flake.nix#nixos'

sudo nixos-enter --root /mnt -c 'passwd logoes'

reboot
```
