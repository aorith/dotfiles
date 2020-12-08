# marks prompt with special character ' ' "\u202f"
def marker(text):
    for i, ch in enumerate(text):
        if ch == '\u202f':
            yield 0, i, 3
