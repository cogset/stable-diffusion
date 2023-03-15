FROM debian:buster

ENV ANACONDA_VERSION=py310_23.1.0

RUN set -eux; \
        \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                ca-certificates \
                git \
                libfontconfig1  \
                libglib2.0-0 \
                libsm6  \
                libxext-dev \
                libxrender-dev \
                wget \
        ; \
        rm -r /var/lib/apt/lists/*; \
        \
        wget -O miniconda-installer.sh https://repo.anaconda.com/miniconda/Miniconda3-${ANACONDA_VERSION}-1-Linux-x86_64.sh; \
        bash miniconda-installer.sh -ub -p /usr/local; \
        \
        git clone https://github.com/CompVis/stable-diffusion.git /root/stable-diffusion; \
        \
        mkdir -p /root/models/stable-diffusion /root/stable-diffusion/models/ldm/stable-diffusion-v1; \
        wget -O /root/models/stable-diffusion/v1-5-pruned-emaonly.ckpt https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.ckpt; \
        ln -s /root/models/stable-diffusion/v1-5-pruned-emaonly.ckpt /root/stable-diffusion/models/ldm/stable-diffusion-v1/model.ckpt;

WORKDIR /root/stable-diffusion

COPY environment.yaml /root/stable-diffusion
COPY docker-entrypoint.sh /usr/local/bin

RUN set -eux; \
        \
        conda env create -f environment.yaml;

ENTRYPOINT ["docker-entrypoint.sh"]
