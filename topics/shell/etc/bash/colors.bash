# vim: ft=bash
# Sourced from: bash_profile

set -a

# Foreground
: "${my_blk:=\[$(tput setaf 0)\]}"     # Black
: "${my_red:=\[$(tput setaf 1)\]}"     # Red
: "${my_grn:=\[$(tput setaf 2)\]}"     # Green
: "${my_ylw:=\[$(tput setaf 3)\]}"     # Yellow
: "${my_blu:=\[$(tput setaf 4)\]}"     # Blue
: "${my_pur:=\[$(tput setaf 5)\]}"     # Purple
: "${my_cyn:=\[$(tput setaf 6)\]}"     # Cyan
: "${my_wht:=\[$(tput setaf 7)\]}"     # White
: "${my_gry:=\[$(tput setaf 8)\]}"     # Grey
: "${my_red2:=\[$(tput setaf 9)\]}"    # Red 2
: "${my_grn2:=\[$(tput setaf 10)\]}"   # Green 2
: "${my_ylw2:=\[$(tput setaf 11)\]}"   # Yellow 2
: "${my_blu2:=\[$(tput setaf 12)\]}"   # Blue 2
: "${my_pur2:=\[$(tput setaf 13)\]}"   # Purple 2
: "${my_cyn2:=\[$(tput setaf 14)\]}"   # Cyan 2
: "${my_wht2:=\[$(tput setaf 15)\]}"   # White 2
: "${my_blk2:=\[$(tput setaf 16)\]}"   # Black 2

# Special
: "${my_bld:=\[$(tput bold)\]}"      # Bold
: "${my_und:=\[$(tput smul)\]}"      # Underline
: "${my_rvs:=\[$(tput rev)\]}"       # Reverse
: "${my_rst:=\[$(tput sgr0)\]}"      # Text Reset

set +a
