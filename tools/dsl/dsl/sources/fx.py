import asyncio
import aiohttp
import typing as t
from collections import defaultdict


DEFAULT_AMOUNT = 2500
PRECISION = 2
URL = "https://transferwise.com/gateway/v2/quotes/"
HEADERS = {"accept": "application/json", "content-type": "application/json"}
PAYLOAD = b'{"sourceAmount":1000,"sourceCurrency":"AUD","targetCurrency":"CNY","preferredPayIn":null,"guaranteedTargetAmount":false}'


class Fx:
    def __init__(self) -> None:
        self._cache: t.DefaultDict[str] = defaultdict(lambda: "N/A")

    async def start(self) -> None:
        while True:
            try:
                async with aiohttp.ClientSession() as session:
                    async with session.post(URL, headers=HEADERS, data=PAYLOAD) as response:
                        json = await response.json()
                        rate = round(json["rate"], PRECISION)
                        effective_rate = round(
                            next(
                                opt
                                for opt in json["paymentOptions"]
                                if opt["payIn"] == "OSKO" and opt["payOut"] == "BANK_TRANSFER"
                            )["targetAmount"]
                            / 1000.0,
                            PRECISION,
                        )
                        # FIXME
                        # total may not be calculated like this, the handling fee
                        # could be different, needs double check
                        total = round(DEFAULT_AMOUNT * effective_rate, PRECISION)
                        self._cache["aud_to_cny"] = " ".join(
                            (
                                f":moneybag: {rate}",
                                f"{effective_rate}",
                                f"{total}",
                            )
                        )
            except aiohttp.client_exceptions.ServerDisconnectedError:
                print("ServerDisconnected when fetching fx, skip to next")
                continue

            await asyncio.sleep(3600)

    def as_argos(self) -> str:
        return self._cache["aud_to_cny"]
