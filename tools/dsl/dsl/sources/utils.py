import datetime as dt
import itertools
import typing as t

from collections import deque

K = 1024
M = 1024 ** 2
G = 1024 ** 3


def humanize(n, *, length=5, with_unit=True) -> str:
    # TODO
    # - support custom scale
    # - support custom units
    if type(n) not in (int, float):
        return 'N/A'

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

    output = str(h).ljust(length, "0")[:length]

    if with_unit:
        output += unit

    return output


MAX_LEN = 120
MOVING_AVG_LEN = 10


class TimeSeriesStore():
    def __init__(self, *, max_len: int = MAX_LEN, default_value = 'N/A') -> None:
        self._history: t.Deque[t.Dict[str, t.Any]] = deque(maxlen=max_len)
        self._default_value = default_value

    def add(self, val: t.Any, ts: t.Optional[float] = None) -> None:
        if not ts:
            ts = dt.datetime.now().timestamp()

        self._history.append({
            "ts": ts,
            "val": val,
        })

    def last_val(self) -> t.Any:
        try:
            return self._history[-1]["val"]
        except IndexError:
            return self._default_value

    def moving_average(self, last_n: int = MOVING_AVG_LEN) -> t.Any:
        n = 0.0
        s = 0.0

        for i in range(-1, -(min(last_n, len(self._history)) + 1), -1):
            n += 1.0
            s += float(self._history[i]["val"])

        try:
            return s / n
        except ZeroDivisionError:
            return self._default_value
