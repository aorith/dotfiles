# vim: ft=bash

# Generate .bash.env file
[[ -z "$ENV_FILES_FOLDER" ]] && { log_error "ENV_FILES_FOLDER not set."; exit 1; }
global_env_file="${ENV_FILES_FOLDER}/.bash.env"
echo "# vim: ft=bash" > "${global_env_file}"
for env_file in "${ENV_FILES_FOLDER}"/*; do
    printf '\n### %s\n' "$(basename $env_file)" >> "$global_env_file"
    grep -Ev '^# vim' "$env_file" >> "$global_env_file"
done

exit 0
