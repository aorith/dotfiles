default:
  just --list

bios:
  systemctl reboot --firmware-setup

distrobox-fbox:
  echo "Creating fbox ..."
  distrobox create --image ghcr.io/aorith/fbox:latest -n fbox -Y

distrobox-ubuntu:
  echo "Creating ubuntu ..."
  mkdir -p "$HOME/homes"
  distrobox create --image quay.io/toolbx-images/ubuntu-toolbox:22.04 -n ubuntu -Y --home "$HOME/homes/ubuntu"

update:
  @printf '\nUpdating NixOS ...\n'
  cd "$HOME/githome/nixconf" && make switch

  @printf '\nUpdating flatpaks ...\n'
  flatpak update -y

  @printf '\nUpdating distroboxes ...\n'
  @printf 'This will stop currently active distroboxes ...\n'
  @read -n 1 -p 'continue? (y/n): '; echo; if [[ "${REPLY:-n}" =~ ^y|Y ]]; then ,distrobox-update-all; fi;
  @echo
