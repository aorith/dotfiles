# vim: ft=bash
# Sourced from: profile

if [[ -f /run/.containerenv ]]; then
    source /run/.containerenv
    export _CONTAINER_NAME="$name"
    alias podman='podman --remote'
fi
