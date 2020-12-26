# marks prompt with special character ' ' "\u276F"
def marker(text):
    for i, ch in enumerate(text):
        if ch == '\u276F':
            yield 0, i, 3
