# vim: ft=bash

# macos only
[[ "$(uname -s)" != "Darwin" ]] && exit 0

### bootstrap
symlink_env

formulae_packages=(
    "bash"
    "bash-completion@2"
    "zsh"
    "coreutils"
    "findutils"
    "moreutils"
    "diffutils"
    "neovim"
    "git"
    "glow"
    "bat"
    "jq"
    "mtr"
    "lnav"
    "htop"
    "gnu-sed"
    "grep"
    "ripgrep"
    "curl"
    "wget"
    "homebrew-ffmpeg/ffmpeg/ffmpeg --with-webp --with-openssl@1.1 --with-openh264 --with-fdk-aac --with-xvid --with-opencore-amr"
    "navi"
    "less"
    "git-delta"
    "tree"
    "imagemagick"
    "nmap"
    "xz"
    "p7zip"
    "bc"
    "kakoune"
    "python@3.8"
    "shellcheck"
    "neofetch"
    "lesspipe"
    "watch"
    "gawk"
    "vim"
    "ansible"
    "fzf"
    "gron"
)

formulae_source_packages=(
    "tmux --HEAD"
)

cask_packages=(
    "alacritty"
    "kitty"
    "apache-directory-studio"
    "beyond-compare"
    "firefox"
    "font-dejavu"
    "font-fira-code"
    "font-hack"
    "font-jetbrains-mono"
    "font-source-code-pro"
    "hammerspoon"
    "iterm2"
    "joplin"
    "keepassxc"
    "libreoffice"
    "libreoffice-language-pack"
    "rectangle"
    "virtualbox"
    "virtualbox-extension-pack"
    "visual-studio-code"
    "vlc"
    "mpv"
)

/usr/local/bin/brew update
/usr/local/bin/brew tap homebrew/cask-fonts
/usr/local/bin/brew tap homebrew-ffmpeg/ffmpeg
for package in "${formulae_source_packages[@]}"; do
    /usr/local/bin/brew install --formulae --build-from-source $package
done
for package in "${formulae_packages[@]}"; do
    /usr/local/bin/brew install --formulae $package
done
for package in "${cask_packages[@]}"; do
    /usr/local/bin/brew install --cask $package
done
unset package formulae_packages formulae_source_packages cask_packages
/usr/local/bin/brew cleanup

if ! grep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

###
exit 0
