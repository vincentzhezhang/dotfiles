import asyncio
import psutil
import typing as t

from .utils import humanize


class System:
    def __init__(self) -> None:
        self._source: t.Dict[str] = {}

    async def start(self) -> None:
        recv_last = 0
        sent_last = 0

        while True:
            vm = psutil.virtual_memory()
            sm = psutil.swap_memory()
            cpu = psutil.cpu_percent()
            net = psutil.net_io_counters()

            cpu_temp = psutil.sensors_temperatures()["k10temp"][0].current
            load = psutil.getloadavg()[0]

            self._source["rx"] = humanize(net.bytes_recv - recv_last) if recv_last != 0 else "N/A"
            self._source["tx"] = humanize(net.bytes_sent - sent_last) if sent_last != 0 else "N/A"
            self._source["vm"] = humanize(vm.used)
            self._source["sm"] = humanize(sm.used)
            self._source["hot"] = f"{cpu:4.1f}% {load:4.1f} {cpu_temp:4.1f}°C"

            recv_last = net.bytes_recv
            sent_last = net.bytes_sent

            await asyncio.sleep(1)

    def as_argos(self) -> str:
        return " ".join(
            (
                f":package: {self._source['vm']} {self._source['sm']}",
                f":fire: {self._source['hot']}",
                f":small_red_triangle_down: {self._source['rx']}",
                f":small_red_triangle: {self._source['tx']}",
            )
        )
