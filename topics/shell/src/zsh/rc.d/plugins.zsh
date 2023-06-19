case "$OSTYPE" in
    linux*)
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ;;
    darwin*) ;;
    solaris*) ;;
    bsd*) ;;
    *) echo "unknown: $OSTYPE" ;;
esac
