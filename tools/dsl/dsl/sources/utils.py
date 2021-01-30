K = 1024
M = 1024 ** 2
G = 1024 ** 3


def humanize(n, *, length=5) -> str:
    # TODO
    # - support custom scale
    # - support custom units
    unit = "K"
    h = 0

    if n >= G:
        h = n / G
        unit = "G"
    elif n >= M:
        h = n / M
        unit = "M"
    else:
        h = n / K

    fixed = str(h).ljust(length, "0")[:length]
    return f"{fixed}{unit}"
