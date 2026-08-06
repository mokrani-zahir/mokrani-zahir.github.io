#!/bin/bash

set -e

echo "=== Mise à jour du système ==="
sudo apt update

echo "=== Installation des dépendances ==="
sudo apt install -y wget build-essential


echo "=== Vérification NVIDIA ==="

if command -v nvidia-smi &> /dev/null; then
    nvidia-smi

elif [ -x "/usr/lib/wsl/lib/nvidia-smi" ]; then
    /usr/lib/wsl/lib/nvidia-smi

else
    echo "Erreur: NVIDIA driver absent"
    exit 1
fi


echo "=== Installation UV ==="

if ! command -v uv &> /dev/null; then
    wget -qO- https://astral.sh/uv/install.sh | sh
    . "$HOME/.local/bin/env"
else
    echo "UV déjà installé"
fi

export PATH="$HOME/.local/bin:$PATH"


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


echo "=== Configuration des variables d'environnement WSL / vLLM ==="

# Actif immédiatement dans la session courante
export VLLM_WSL2_ENABLE_PIN_MEMORY=1
export VLLM_USE_FLASHINFER_SAMPLER=0

# Persisté pour les futurs terminaux
grep -qxF 'export VLLM_WSL2_ENABLE_PIN_MEMORY=1' ~/.bashrc || echo 'export VLLM_WSL2_ENABLE_PIN_MEMORY=1' >> ~/.bashrc
grep -qxF 'export VLLM_USE_FLASHINFER_SAMPLER=0' ~/.bashrc || echo 'export VLLM_USE_FLASHINFER_SAMPLER=0' >> ~/.bashrc


echo "=== Installation terminée ==="

echo ""
echo "Pour utiliser vLLM :"
echo "source ~/.bashrc      # active les variables VLLM_* dans ce terminal"
echo "cd ~/vllm"
echo "source .venv/bin/activate"