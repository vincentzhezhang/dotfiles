import asyncio
import typing as t
from collections import defaultdict

from .utils import humanize, TimeSeriesStore


class Latency:
    def __init__(self) -> None:
        self._cache: t.Dict[str, TimeSeriesStore] = {}

    async def shell(self, *cmd, name: str = "Unknown") -> None:
        # FIXME this is not shell, it's coupled with PING behaviour atm
        proc = await asyncio.create_subprocess_exec(
            *cmd,
            stdout=asyncio.subprocess.PIPE,
        )

        self._cache[name] = TimeSeriesStore()

        while True:
            await asyncio.sleep(1)

            line = (await proc.stdout.readline()).decode()

            if "PING" in line:
                continue

            try:
                latency = float(line.split(" ")[-2].split("=")[1]) * 1000
                self._cache[name].add(latency)
            except IndexError:
                continue

    async def start(self) -> None:
        await asyncio.gather(
            self.shell("ping", "192.168.3.1", name="here"),
            self.shell("ping", "chinavpn.akunacapital.com", name="vpn"),
            self.shell("ssh", "sha", "ping", "syd-dev-l014", name="sha_to_syd"),
            self.shell("ssh", "sha", "ping", "ch1devptn01", name="sha_to_chi"),
        )

    def as_argos(self) -> str:
        return " ".join(
            (
                ":zap:",
                humanize(self._cache["here"].moving_average(), with_unit=False),
                humanize(self._cache["vpn"].moving_average(), with_unit=False),
                humanize(self._cache["sha_to_syd"].moving_average(), with_unit=False),
                humanize(self._cache["sha_to_chi"].moving_average(), with_unit=False),
            )
        )
