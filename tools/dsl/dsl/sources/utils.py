K = 1024
M = 1024 ** 2
G = 1024 ** 3


def humanize(n) -> str:
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

    fixed = str(h).ljust(5, "0")[:5]
    return f"{fixed}{unit}"
