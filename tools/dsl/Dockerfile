FROM continuumio/miniconda3:4.9.2 as build_env
COPY . .
RUN env \
    && conda env create --name dsl --file environment.yaml \
    && conda info \
    && conda clean --all --yes --force-pkgs-dirs \
    && /opt/conda/envs/dsl/bin/python setup.py install

FROM ubuntu:20.04
COPY --from=build_env /opt/conda/envs/dsl /opt/conda/envs/dsl
ENV PATH=/opt/conda/envs/dsl/bin/:$PATH
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install \
        --yes \
        --fix-missing \
        --no-install-recommends \
        iputils-ping \
        netcat \
        ssh \
    && apt-get autoclean \
    && apt-get autoremove \
    && rm -rf /var/lig/apt/lists/* /var/log/dpkh.log

# CMD "bash -c dsl"
