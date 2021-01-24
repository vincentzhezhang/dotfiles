import asyncio
import typing as t
from collections import defaultdict

from .utils import humanize


class Latency:
    def __init__(self) -> None:
        self._cache: t.DefaultDict[str] = defaultdict(lambda: "N/A")

    async def shell(self, *cmd, name: str = "Unknown") -> None:
        # FIXME this is not shell, it's coupled with PING behaviour atm
        proc = await asyncio.create_subprocess_exec(
            *cmd,
            stdout=asyncio.subprocess.PIPE,
        )

        while True:
            line = (await proc.stdout.readline()).decode()
            if "PING" in line:
                continue

            try:
                # HACK the format here is hacked, should have the same scale param support
                latency = humanize(float(line.split(" ")[-2].split("=")[1]) * 1000)[:-1]
                self._cache[name] = latency
            except IndexError:
                self._cache[name] = "N/A"

            await asyncio.sleep(1)

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
                str(self._cache["here"]),
                str(self._cache["vpn"]),
                str(self._cache["sha_to_syd"]),
                str(self._cache["sha_to_chi"]),
            )
        )
