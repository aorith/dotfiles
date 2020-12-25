# vim: ft=bash

# Generate zsh.env file
[[ -z "$ENV_FILES_FOLDER" ]] && { log_error "ENV_FILES_FOLDER not set."; exit 1; }
global_env_file="${ENV_FILES_FOLDER}/zsh.env"
echo "# vim: ft=zsh" > "${global_env_file}"
shopt -s nullglob
for env_file in "${ENV_FILES_FOLDER}"/zsh/*; do
    printf '\n### %s\n' "$(basename $env_file)" >> "$global_env_file"
    grep -Ev '^# vim' "$env_file" >> "$global_env_file"
done
shopt -u nullglob

exit 0
