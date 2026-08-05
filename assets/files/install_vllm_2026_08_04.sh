#!/bin/bash

set -e

echo "=== Mise à jour du système ==="
sudo apt update

echo "=== Installation des dépendances ==="
sudo apt install -y wget curl build-essential python3-dev python3-venv

echo "=== Installation CUDA 12.6 ==="
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb

sudo dpkg -i cuda-keyring_1.1-1_all.deb

sudo apt update

sudo apt install -y cuda-toolkit-12-6


echo "=== Configuration des variables CUDA ==="

if ! grep -q "/usr/local/cuda-12.6/bin" ~/.bashrc; then
    echo 'export PATH=/usr/local/cuda-12.6/bin:$PATH' >> ~/.bashrc
    echo 'export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:$LD_LIBRARY_PATH' >> ~/.bashrc
fi

echo "=== Installation de UV ==="
if ! command -v uv &> /dev/null; then
    wget -qO- https://astral.sh/uv/install.sh | sh
else
    echo "UV est déjà installé."
fi

export PATH="$HOME/.local/bin:$PATH"


echo "=== Création environnement vLLM ==="

mkdir -p ~/vllm

cd ~/vllm


uv venv --python 3.12 --seed


source .venv/bin/activate


echo "=== Installation vLLM ==="

uv pip install vllm --torch-backend=cu126


echo "=== Installation terminée ==="

echo ""
echo "Pour utiliser vLLM :"
echo "cd ~/vllm"
echo "source .venv/bin/activate"
echo ""
echo "Vérification CUDA :"
echo "nvcc --version"