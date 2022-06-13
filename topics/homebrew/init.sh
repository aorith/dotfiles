# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

### bootstrap
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
    "cmake"
    "java"
    "telnet"
    "autopep8"
    "golang"
    "gpg"
    "git-flow"
    "tig"
    "bitwarden-cli"
    "pylint"
    "black"
    "ipython"
    "fd"
    "util-linux"
)

formulae_source_packages=(
    "tmux --HEAD"
)

cask_packages=(
    "alacritty"
    "kitty"
    "apache-directory-studio"
    "firefox"
    "font-dejavu"
    "font-fira-code"
    "font-hack-nerd-font"
    "font-jetbrains-mono"
    "font-sauce-code-pro-nerd-font"
    "hammerspoon"
    "iterm2"
    "joplin"
    "keepassxc"
    "libreoffice"
    "libreoffice-language-pack"
    "rectangle"
    "visual-studio-code"
    "vlc"
    "mpv"
    "emacs"
    "openwebstart"
    "font-noto-color-emoji"
    "tigervnc-viewer"
    "flameshot"
    "sublime-text"
)

/usr/local/bin/brew update
/usr/local/bin/brew tap homebrew/cask-fonts
/usr/local/bin/brew tap homebrew-ffmpeg/ffmpeg

# Compiled Formulaes
current_formulaes="$(brew list --formulae -1)"
for package in "${formulae_source_packages[@]}"; do
    # do not quote $package
    /usr/local/bin/brew install --formulae --build-from-source $package
done

# Formulaes
for package in "${formulae_packages[@]}"; do
    if ! grep -qw "$package" <<< "$current_formulaes"; then
        /usr/local/bin/brew install --formulae $package
    fi
done

# Casks
current_casks="$(brew list --cask -1)"
for package in "${cask_packages[@]}"; do
    if ! grep -qw "$package" <<< "$current_casks"; then
        /usr/local/bin/brew install --cask $package
    fi
done
unset package formulae_packages formulae_source_packages cask_packages current_formulaes current_casks
/usr/local/bin/brew cleanup

if ! grep -q '/usr/local/bin/bash' /etc/shells; then
  echo '/usr/local/bin/bash' | sudo tee -a /etc/shells;
  chsh -s /usr/local/bin/bash;
fi;

###
exit 0
