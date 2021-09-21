# vim: ft=bash
# Sourced from: profile

# add_to_path function
add_to_path() {
    local x
	[[ $# -ne 1 ]] && return 1
	for x in $1; do
		case ":${PATH}:" in
			*":${x}:"*) ;; # already there
			*) PATH="$x:$PATH";;
		esac
	done
    export PATH
}

# add_to_manpath function
add_to_manpath() {
    local x
	[[ $# -ne 1 ]] && return 1
	for x in $1; do
		case ":${MANPATH}:" in
			*":${x}:"*) ;; # already there
			*) MANPATH="$x:$MANPATH";;
		esac
	done
    export MANPATH
}

# copy terminfo
ssh_copy_terminfo() {
	local EXEC
    EXEC='command ssh'
    [[ $# -eq 0 ]] && { echo "Missing [user@]hostname"; return 1; }
    infocmp $TERM &>/dev/null || { echo "Either infocmp is not installed or missing $TERM terminfo"; return 1; }
    echo "Copying $TERM terminfo to $*"
    infocmp | $EXEC "$*" "tic -"
}

# tests if $1 > $2
_greater_than() {
    [ ${1%.*} -eq ${2%.*} ] && [ ${1#*.} \> ${2#*.} ] || [ ${1%.*} -gt ${2%.*} ]
}

# le pasas una fecha y la muestra en varios husos horarios
udate() {
    local EXE actual fecha MYTZ
    actual="$(date +"%Y-%m-%d %H:%M:%S")"
    echo -n "Fecha a convertir (Default: $actual): "
    read -r fecha
    fecha="${fecha:-$actual}"
    echo -n "TZ: (Default: Europe/Madrid): "
    read -r MYTZ
    MYTZ="${MYTZ:-Europe/Madrid}"
    EXE='command date'
    if command -v gdate >/dev/null 2>&1; then EXE='command gdate'; fi
    {
        export TZ="${MYTZ}"; echo -n "UNIX: "; $EXE +%s --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="${MYTZ}"; echo -n "${TZ}: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
		echo '- - - - - - -'
        export TZ="UTC"; echo -n "${TZ}/GMT: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="Europe/Madrid"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="Europe/London"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="America/New_York"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="America/Los_Angeles"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="Asia/Hong_Kong"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
        export TZ="Asia/Tokyo"; echo -n "$TZ: "; $EXE --date=@$(export TZ="$MYTZ"; $EXE "+%s" --date="$fecha");
    } | column -t | BAT_STYLE="grid" bat
    unset TZ BAT_STYLE
}

# le pasas timestamp en unix y te lo muestra en varios husos horarios
unixdate() {
    local EXE timestamp MYTZ
    timestamp="${1:-}"
    [[ -z $timestamp ]] && { echo -n "Unix timestamp: "; read -r timestamp; }
    MYTZ="${MYTZ:-Europe/Madrid}"
    EXE='command date'
    if command -v gdate >/dev/null 2>&1; then EXE='command gdate'; fi
    {
        export TZ="UTC"; echo -n "${TZ}/GMT: "; $EXE --date=@$timestamp
        export TZ="Europe/Madrid"; echo -n "$TZ: "; $EXE --date=@$timestamp
    } | column -t | BAT_STYLE="grid" bat
    unset TZ
}

# ls octal permissions
lso() {
    ls -l "$@" | awk '{k=0;for(i=0;i<=8;i++)k+=((substr($1,i+2,1)~/[rwx]/)*2^(8-i));if(k)printf(" %0o ",k);print}'
}

# generate random password
randompassword() {
    echo "$(date +%s; uname -a; ps -e; uptime) $PPID $? $_ $$ $COLUMNS" | sha256sum | base64 | head -c 18
    echo
}

# pinta conteo de threads
threadscounter() {
    ps -o uid,ppid,command -eT |sort -k3 |uniq -c |sort -n |tail
}

biggest_files() {
    1>&2 echo "Running: 'find . -type f -exec du -ah {} \; | sort -h' ..."
    find . -type f -exec du -ah {} \; | sort -h 2>/dev/null
}

# Easy CD into dotfiles
dotfiles() {
    local TOPICS
    [[ -n "$1" ]] || { echo "Changing dir to $DOTFILES"; cd $DOTFILES || return 1; return 0; }
    TOPICS=(
        $(find $DOTFILES/topics/* -maxdepth 0 -type d -exec basename {} \;)
        $(find $PRIVATE_DOTFILES/topics/* -maxdepth 0 -type d -exec basename {} \;)
    )
    for topic in $DOTFILES/topics/* $PRIVATE_DOTFILES/topics/*; do
        if echo "$(basename $topic)" | grep -Ewq "$1"; then
            cd "$topic" && echo "Found $1 ... changing directory." && return 0
        fi
    done
    echo "Unable to find topic: \"$1\"."; return 1;
}

bytes_to() {
    local denominator scale usage
    usage() { echo "Usage: ${FUNCNAME[1]} <value> kib|mib|gib|tib [<scale>]"; return 1; }
    [[ $1 =~ ^[0-9]+ ]] || usage || return 1
    scale=${3:-4}
    case $2 in
        kib) denominator=1024 ;;
        mib) denominator=1048576 ;;
        gib) denominator=1073741824 ;;
        tib) denominator=1099511627776 ;;
        *) usage || return 1 ;;
    esac
    echo "scale=$scale; $1 / $denominator" | bc -l
}

to_bytes() {
    local mult scale usage
    usage() { echo "Usage: ${FUNCNAME[1]} <value> kib|mib|gib|tib [<scale>]"; return 1; }
    [[ $1 =~ ^[0-9]+ ]] || usage || return 1
    scale=${3:-4}
    case $2 in
        kib) mult=1024 ;;
        mib) mult=1048576 ;;
        gib) mult=1073741824 ;;
        tib) mult=1099511627776 ;;
        *) usage || return 1 ;;
    esac
    echo "scale=$scale; $1 * $mult" | bc -l
}

check_cert_matches_key() {
    local cert key format
    cert="$1"
    key="$2"
    [[ -f "$cert" ]] && [[ -f "$key" ]] || { echo "Usage: ${FUNCNAME[0]} <cert_path> <key_path>"; return 1; }
    if cat "$key" | grep 'BEGIN ' | grep -q ' RSA '; then
        format="rsa"
    fi

    # TODO: more formats
    if [[ "$format" == "rsa" ]]; then
        if ! openssl rsa -check -noout -in "$key"; then
            echo "Private key check failed, is it a valid RSA key?"
            return 1
        fi

        cert_modulus="$(openssl x509 -noout -modulus -in "$cert")"
        key_modulus="$(openssl rsa -noout -modulus -in "$key")"
    else
        echo "Unrecognized certificate format or key is not the second parameter."
        echo "Available formats: rsa"
        return 1
    fi

    if [[ ! $cert_modulus =~ ^Modulus=.* ]]; then
        echo "Error retrieving modulus from certificate file."
        return 1
    elif [[ ! $key_modulus =~ ^Modulus=.* ]]; then
        echo "Error retrieving modulus from key file."
        return 1
    fi

    cert_md5="$(openssl md5 <<< "$cert_modulus")"
    key_md5="$(openssl md5 <<< "$key_modulus")"

    if [[ "$cert_md5" == "$key_md5" ]]; then
        echo "Match! $cert_md5"
        return 0
    else
        echo "Cert and key don't match."
        echo "Cert: $cert_md5"
        echo "Key: $key_md5"
        return 1
    fi
}

check_cert_for_domain() {
    [[ -n "$1" ]] || { echo "Usage: ${FUNCNAME[0]} <domain>"; return 1; }
    echo -e "$(tput setaf 3)$ echo -n | openssl s_client -servername ${1} -connect ${1}:443 2>/dev/null$(tput sgr0)"
    echo -n | openssl s_client -servername ${1} -connect ${1}:443 2>/dev/null
    echo -e "$(tput setaf 3)$ echo -n | openssl s_client -servername ${1} -connect ${1}:443 2>/dev/null | openssl x509 -noout -dates$(tput sgr0)"
    echo -n | openssl s_client -servername ${1} -connect ${1}:443 2>/dev/null | openssl x509 -noout -dates
}

change_vim_theme() {
    local dtheme ltheme
    read -rp 'Dark theme [ENTER to SKIP]: ' dtheme
    read -rp 'Light theme [ENTER to SKIP]: ' ltheme
    [[ -z "$dtheme" ]] || echo "$dtheme" > ~/.local/share/vim/dark_theme
    [[ -z "$ltheme" ]] || echo "$ltheme" > ~/.local/share/vim/light_theme
}
