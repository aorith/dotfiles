syntax match sshknownhostspubkey "AAAA[0-9a-zA-Z+/]\+[=]\{0,2}"
highlight def link sshknownhostspubkey Special

syntax match sshalg "\(ssh-rsa\|ecdsa[0-9a-zA-Z\-]\+\)"
highlight def link sshalg Identifier

syntax match sshknownhostsip "\<\(\d\{1,3}\.\)\{3}\d\{1,3}\>"
highlight def link sshknownhostsip Constant

syntax match sshhost "^[0-9a-zA-Z.-]\+"
highlight def link sshhost Directory
