import asyncio as ai
import pytz
import datetime as dt
import typing as t

from pytz.tzinfo import DstTzInfo


# TODO abstract base class
class WorldClock:
    def __init__(self, tz_names=t.List[str]) -> None:
        self._timezones: t.Set[DstTzInfo] = {pytz.timezone(tz) for tz in tz_names}
        self._source: t.Dict[str] = {}

    async def start(self):
        while True:
            now = dt.datetime.now()
            for tz in self._timezones:
                self._source[tz.zone] = now.astimezone(tz).strftime("%I%p")

            await ai.sleep(5)

    def as_argos(self) -> str:
        return " ".join(
            (
                f":us: {self._source['America/Chicago']}",
                f":gb: {self._source['UTC']}",
                f":au: {self._source['Australia/Sydney']}",
                f":hk: {self._source['Asia/Hong_Kong']}",
                f":kr: {self._source['Asia/Seoul']}",
            )
        )

    def get(self) -> str:
        return " ".join(": ".join(pair) for pair in self._source.items())
