# vim: ft=bash

# macos only
[[ "$(uname -s)" == "Darwin" ]] || exit $_SKIP

### bootstrap
formulae_packages=(
    "ansible"
    "autopep8"
    "bash"
    "bash-completion@2"
    "bat"
    "bc"
    "black"
    "cmake"
    "coreutils"
    "curl"
    "diffutils"
    "fd"
    "findutils"
    "fzf"
    "gawk"
    "git"
    "git-delta"
    "git-flow"
    "glow"
    "gnu-sed"
    "golang"
    "gpg"
    "grep"
    "gron"
    "htop"
    "imagemagick"
    "ipython"
    "java"
    "jq"
    "less"
    "lesspipe"
    "moreutils"
    "mtr"
    "neofetch"
    "neovim"
    "nmap"
    "p7zip"
    "pylint"
    "ripgrep"
    "shellcheck"
    "telnet"
    "tig"
    "tmux"
    "tree"
    "util-linux"
    "vim"
    "watch"
    "wget"
    "xz"
    "zsh"
)

formulae_source_packages=(
    #"tmux --HEAD"
)

cask_packages=(
    "alacritty"
    "apache-directory-studio"
    "bitwarden"
    "docker"
    "firefox"
    "flameshot"
    "font-dejavu"
    "font-fira-code"
    "font-hack-nerd-font"
    "font-jetbrains-mono"
    "font-noto-color-emoji"
    "font-sauce-code-pro-nerd-font"
    "gimp"
    "hammerspoon"
    "iterm2"
    "joplin"
    "keepassxc"
    "kitty"
    "mpv"
    "openwebstart"
    "rectangle"
    "sublime-text"
    "tigervnc-viewer"
    "tunnelblick"
    "visual-studio-code"
    "vlc"
)

brew update
brew tap homebrew/cask-fonts
brew tap homebrew-ffmpeg/ffmpeg

# Compiled Formulaes
current_formulaes="$(brew list --formulae -1)"
for package in "${formulae_source_packages[@]}"; do
    # do not quote $package
    brew install --formulae --build-from-source $package
done

# Formulaes
for package in "${formulae_packages[@]}"; do
    if ! grep -qw "$package" <<< "$current_formulaes"; then
        brew install --formulae $package
    fi
done

# Casks
current_casks="$(brew list --cask -1)"
for package in "${cask_packages[@]}"; do
    if ! grep -qw "$package" <<< "$current_casks"; then
        brew install --cask $package
    fi
done
unset package formulae_packages formulae_source_packages cask_packages current_formulaes current_casks
brew cleanup

###
exit 0
