# vim: ft=bash

### bootstrap
current_shell="$(grep -E "^${USERNAME}" /etc/passwd | cut -d':' -f7)"
create_link "${PWD}/src/xprofile" "$HOME/.xprofile"
if [[ "$current_shell" =~ bash ]]; then
    create_link "${PWD}/src/inputrc" "$HOME/.inputrc"
    create_link "${PWD}/src/bashrc" "$HOME/.bashrc"
    create_link "${PWD}/src/profile.bash" "$HOME/.profile"
    create_link "${PWD}/src/bash_profile" "$HOME/.bash_profile"
elif [[ "$current_shell" =~ zsh ]]; then
    create_link "${PWD}/src/zshenv" "$HOME/.zshenv"
    mkdir -p ~/.config/zsh
    create_link "${PWD}/src/zsh/zshenv" "$HOME/.config/zsh/.zshenv"
    create_link "${PWD}/src/zsh/zshrc" "$HOME/.config/zsh/.zshrc"
    create_link "${PWD}/src/profile.zsh" "$HOME/.profile"
    create_link "${PWD}/src/zsh/zprofile" "$HOME/.config/zsh/.zprofile"
fi
unset current_shell
###
exit 0
