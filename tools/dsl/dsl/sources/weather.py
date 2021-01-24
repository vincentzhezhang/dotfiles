import asyncio
import aiohttp
import typing as t
from collections import defaultdict


class Weather:
    def __init__(self, url: str) -> None:
        self.url = url
        self._cache: t.DefaultDict[str] = defaultdict(lambda: "N/A")

    async def start(self) -> None:
        while True:
            try:
                async with aiohttp.ClientSession() as session:
                    async with session.get(self.url) as response:
                        json = await response.json()
                        weather = json["data"]["real"]["weather"]
                        self._cache["lixian"] = " ".join(
                            (
                                f":sunny: {weather['temperature']}°C",
                                f"{weather['humidity']}%",
                                f"{weather['feelst']}°C",
                            )
                        )
            except asyncio.exceptions.TimeoutError:
                print("Timeout fetching weather, skip to next update")
                continue
            except aiohttp.client_exceptions.ClientConnectorError:
                print("Temporarily failed DNS fetching weather, skip to next update")
                continue

            await asyncio.sleep(300)

    def as_argos(self) -> str:
        return self._cache["lixian"]
