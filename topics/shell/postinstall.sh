# vim: ft=bash

shopt -s nullglob

for shell in bash zsh shell; do
    global_env_file="${DOTFILES}/topics/shell/etc/${shell}/${shell}.env"
    echo "# vim: ft=${shell/shell/bash}" > "${global_env_file}"

    env_files="$(for env_file in \
        "${DOTFILES}"/topics/*/env/all/${shell}/* \
        "${DOTFILES}"/topics/*/env/$(uname -s)/${shell}/* \
        "${PRIVATE_DOTFILES}"/topics/*/env/all/${shell}/* \
        "${PRIVATE_DOTFILES}"/topics/*/env/$(uname -s)/${shell}/*
    do
        echo "$env_file"
    done | awk -F '/' '{print $NF,$0}' | sort -n | awk '{print $2}')"

    for env_file in $env_files
    do
        printf '\n### %s\n' "$(echo $env_file | awk -F'/' '{print $(NF-4)"/"$(NF-3)"/"$(NF-2)"/"$(NF-1)"/"$NF}')" >> "$global_env_file"
        grep -Ev '^# vim' "$env_file" >> "$global_env_file"
    done
done

shopt -u nullglob
unset global_env_file env_files env_file

exit 0
