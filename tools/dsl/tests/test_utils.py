import pytest

from dsl.sources.utils import TimeSeriesStore


def test_time_series_store():
    store = TimeSeriesStore(max_len=10, default_value='N/A')

    assert store.last_val() == 'N/A'
    assert store.moving_average() == 'N/A'

    store.add(1)
    assert store.last_val() == 1
    assert store.moving_average() == 1

    store.add(2)
    assert store.last_val() == 2
    assert store.moving_average() == 1.5

    store.add(3)
    assert store.last_val() == 3
    assert store.moving_average() == 2

    store.add(4)
    store.add(5)
    store.add(6)
    store.add(7)
    store.add(8)
    store.add(9)
    store.add(10)
    store.add(11)
    store.add(12)
    store.add(13)

    assert store.last_val() == 13
    assert store.moving_average() == 8.5
    assert store.moving_average(3) == 12
