from setuptools import setup, find_packages


setup(
    name="dsl",
    version="0.0.1",
    description="Dumb Status Line",
    url="TODO",
    author="Vincent Zhang",
    packages=find_packages(exclude=["*.tests"]),
    zip_safe=False,
    entry_points={"console_scripts": ["dsl=dsl.main:main"]},
)
