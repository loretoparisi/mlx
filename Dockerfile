FROM python:3.9-slim

LABEL maintainer="loretoparisi@gmail.com"

ENV ROOT_APPLICATION /app
WORKDIR $ROOT_APPLICATION

RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    pkg-config \
    cmake \
    libopenblas-dev \
    python3-pip \
    curl \
    git

COPY mlx $ROOT_APPLICATION/mlx

# build
RUN cd $ROOT_APPLICATION/mlx && \
    mkdir -p build && cd build && \
    cmake .. && make -j && \
    make test && \
    make install && \
    cd $ROOT_APPLICATION/mlx

# test
RUN cd $ROOT_APPLICATION/mlx/ && \
    cd build/examples/cpp && \
    ./logistic_regression && \
    ./linear_regression && \
    cd $ROOT_APPLICATION/mlx

CMD ["bash"]
