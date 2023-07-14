case "$OSTYPE" in
    linux*)
        source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ;;
    darwin*)
        source /opt/homebrew/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh
        source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ;;
    solaris*) ;;
    bsd*) ;;
    *) echo "unknown: $OSTYPE" ;;
esac
