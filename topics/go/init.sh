# vim: ft=bash

if [[ -e /etc/nixos ]]; then
    log_skip "go"
    exit 0
fi

go install mvdan.cc/gofumpt@latest
go install golang.org/x/tools/cmd/goimports@latest
go install github.com/grafana/jsonnet-language-server@latest
