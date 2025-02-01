FROM nvidia/cuda:11.8.0-cudnn8-devel-ubuntu22.04 AS base

ENV PYTHONUNBUFFERED=1

RUN apt-get update
RUN apt-get install -y --no-install-recommends \
    curl \
    git \
    python3.10 \
    python3-pip \
    libtcmalloc-minimal4 \
    build-essential

RUN pip install poetry

COPY pyproject.toml /app/
WORKDIR /app

RUN poetry config virtualenvs.in-project false && \
    poetry run python -m pip install -U pip && \
    poetry run python -m pip install -U setuptools && \
    poetry install --no-cache --no-root

# install dependencies
RUN poetry run python -m pip install torch==2.5.1+cu118 torchvision==0.20.1+cu118 --index-url https://download.pytorch.org/whl/cu118

# install sam2
WORKDIR /dependencies
RUN git clone https://github.com/facebookresearch/sam2.git && \
    cd sam2 && \
    pip install -U pip && \
    pip install -U setuptools && \
    pip install -e .

# install Real-ESRGAN
WORKDIR /dependencies
RUN git clone https://github.com/xinntao/Real-ESRGAN.git && \
    cd Real-ESRGAN && \
    pip install basicsr && \
    pip install facexlib && \
    pip install gfpgan && \
    pip install -r requirements.txt && \
    python3 setup.py develop

WORKDIR /app
COPY . .

CMD ["poetry", "run", "streamlit", "run", "src/app.py"]
