import uvloop
import asyncio

from aiohttp import web

from .sources.world_clock import WorldClock
from .sources.system import System
from .sources.weather import Weather
from .sources.fx import Fx
from .sources.latency import Latency


# simplest way to achieve ~60fps
# uvloop reduces response time from ~18ms to ~16ms
# TODO may have even more performance solution
# - https://www.techempower.com/benchmarks/#section=data-r19&hw=ph&test=fortune&l=zijzen-1r
# - or use other framework, the goal is <15ms worst scenario
uvloop.install()


class Source:
    def __init__(self) -> None:
        pass

    def start(self) -> None:
        pass

    def stop(self) -> None:
        pass


async def handle(request) -> web.Response:
    model = request.app["model"]
    return web.Response(
        text=" ".join(
            (
                model["world_clock"].as_argos(),
                model["system"].as_argos(),
                model["weather"].as_argos(),
                model["fx"].as_argos(),
                model["latency"].as_argos(),
            )
        )
    )


async def setup_model(app):
    world_clock = WorldClock(["America/Chicago", "UTC", "Australia/Sydney", "Asia/Hong_Kong", "Asia/Seoul"])
    system = System()
    weather = Weather("http://www.nmc.cn/rest/weather?stationid=57565")
    fx = Fx()
    latency = Latency()

    loop = asyncio.get_event_loop()
    loop.create_task(world_clock.start())
    loop.create_task(system.start())
    loop.create_task(weather.start())
    loop.create_task(fx.start())
    loop.create_task(latency.start())

    app["model"] = {
        "world_clock": world_clock,
        "system": system,
        "weather": weather,
        "fx": fx,
        "latency": latency,
    }


def main():
    app = web.Application()
    app.add_routes([web.get("/", handle)])
    app.on_startup.append(setup_model)
    web.run_app(app)
