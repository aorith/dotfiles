# vim: ft=bash

shopt -s nullglob

for shell in bash; do
    global_env_file="${DOTFILES}/topics/shell/etc/${shell}/${shell}.env"
    echo -e "# vim: ft=${shell}\n# Sourced from: bashrc" > "${global_env_file}"

    # topic/<topic_name>/env/<OS>/<shell>/*
    env_files="$(for env_file in \
        "${DOTFILES}"/topics/*/env/all/${shell}/* \
        "${DOTFILES}"/topics/*/env/$(uname -s)/${shell}/* \
        "${PRIVATE_DOTFILES}"/topics/*/env/all/${shell}/* \
        "${PRIVATE_DOTFILES}"/topics/*/env/$(uname -s)/${shell}/*
    do
        echo "$env_file"
        # awk: sort by "basename" and print the full path
    done | awk -F '/' '{print $NF,$0}' | sort -n | awk '{print $2}')" #01_functions /path/to/01_functions

    for env_file in $env_files
    do
        printf '\n### %s\n' "$(echo $env_file | awk -F'/' '{print $(NF-4)"/"$(NF-3)"/"$(NF-2)"/"$(NF-1)"/"$NF}')" >> "$global_env_file"
        grep -Ev '^# vim' "$env_file" >> "$global_env_file"
    done
done

shopt -u nullglob
unset global_env_file env_files env_file

exit 0
