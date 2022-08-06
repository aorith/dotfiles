# vim: ft=bash
# Sourced from: profile

if [[ -f /run/.containerenv ]]; then
    source /run/.containerenv
    export _CONTAINER_NAME="$name"
    alias podman='podman --remote'

fi

# Distrobox config
export DBX_CONTAINER_ALWAYS_PULL=1
export DBX_CONTAINER_IMAGE="docker.io/aorith/fbox:latest"
export DBX_CONTAINER_NAME="fbox"
