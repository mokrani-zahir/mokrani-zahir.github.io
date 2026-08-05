#!/bin/bash

set -e

echo "=== Mise à jour du système ==="
sudo apt update

echo "=== Installation des dépendances ==="
sudo apt install -y \
    wget \
    curl \
    build-essential \
    python3-dev \
    python3-venv


echo "=== Vérification NVIDIA ==="

if ! command -v nvidia-smi &> /dev/null; then
    echo "Erreur: NVIDIA driver absent"
    exit 1
fi

nvidia-smi


echo "=== Installation UV ==="

if ! command -v uv &> /dev/null; then
    wget -qO- https://astral.sh/uv/install.sh | sh
    . "$HOME/.local/bin/env"
else
    echo "UV déjà installé"
fi

export PATH="$HOME/.local/bin:$PATH"


echo "=== Installation Python 3.12 ==="

uv python install 3.12


echo "=== Création environnement vLLM ==="

mkdir -p ~/vllm
cd ~/vllm

uv venv --python 3.12 --seed --managed-python


. .venv/bin/activate


echo "=== Installation vLLM ==="

uv pip install vllm --torch-backend=auto


echo "=== Test CUDA PyTorch ==="

python -c "
import torch
print('PyTorch:', torch.__version__)
print('CUDA:', torch.version.cuda)
print('GPU:', torch.cuda.get_device_name(0))
"


echo "=== Installation terminée ==="