import asyncio
import psutil
import typing as t

from .utils import humanize, TimeSeriesStore


class System:
    def __init__(self) -> None:
        self._cache: t.Dict[str] = {}
        self._cache["rx"] = TimeSeriesStore()
        self._cache["tx"] = TimeSeriesStore()
        self._cache["vm"] = TimeSeriesStore()
        self._cache["sm"] = TimeSeriesStore()
        self._cache["cpu"] = TimeSeriesStore(default_value=0)
        self._cache["load_avg"] = TimeSeriesStore(default_value=0)
        self._cache["cpu_temp"] = TimeSeriesStore(default_value=0)

    async def start(self) -> None:
        net = psutil.net_io_counters()
        recv_last = net.bytes_recv
        sent_last = net.bytes_sent

        while True:
            await asyncio.sleep(1)

            vm = psutil.virtual_memory()
            sm = psutil.swap_memory()
            cpu = psutil.cpu_percent()
            net = psutil.net_io_counters()

            cpu_temp = psutil.sensors_temperatures()["k10temp"][0].current
            load = psutil.getloadavg()[0]

            self._cache["rx"].add(net.bytes_recv - recv_last)
            self._cache["tx"].add(net.bytes_sent - sent_last)
            self._cache["vm"].add(vm.used)
            self._cache["sm"].add(sm.used)
            self._cache["cpu"].add(cpu)
            self._cache["load_avg"].add(load)
            self._cache["cpu_temp"].add(cpu_temp)

            recv_last = net.bytes_recv
            sent_last = net.bytes_sent

    def as_argos(self) -> str:
        memory = " ".join((
            humanize(self._cache['vm'].moving_average()),
            humanize(self._cache['sm'].moving_average()),
        ))
        load = " ".join((
            f"{self._cache['cpu'].moving_average():4.1f}%",
            f"{self._cache['load_avg'].moving_average():4.1f}",
            f"{self._cache['cpu_temp'].moving_average():4.1f}°C",
        ))
        download_speed = humanize(self._cache['rx'].moving_average())
        upload_speed = humanize(self._cache['tx'].moving_average())

        return " ".join(
            (
                f":package: {memory}",
                f":fire: {load}",
                f":small_red_triangle_down: {download_speed}",
                f":small_red_triangle: {upload_speed}",
            )
        )
