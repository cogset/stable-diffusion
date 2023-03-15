FROM python:3.10

RUN set -eux; \
        \
        apt-get update; \
        apt-get install -y --no-install-recommends \
                ca-certificates \
                libgl1 \
                vim \
        ; \
        rm -r /var/lib/apt/lists/*; \
        \
        git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git /root/stable-diffusion-webui;

WORKDIR /root/stable-diffusion-webui

RUN set -eux; \
        \
        pip install torch torchvision torchaudio --extra-index-url https://download.pytorch.org/whl/cu117; \
        pip install cython opencv-python-headless gfpgan open-clip-torch xformers pyngrok clip-anytorch; \
        pip install -r requirements_versions.txt; \
        \
        python launch.py --exit --skip-torch-cuda-test; \
        \
        wget -O /root/stable-diffusion-webui/models/Stable-diffusion/v1-5-pruned-emaonly.safetensors \
                https://huggingface.co/runwayml/stable-diffusion-v1-5/resolve/main/v1-5-pruned-emaonly.safetensors;

COPY docker-entrypoint.sh /usr/local/bin

ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 7860

CMD ["python", "launch.py"]
