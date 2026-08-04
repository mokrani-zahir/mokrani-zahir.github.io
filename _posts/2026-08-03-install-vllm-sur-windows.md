---
layout: post

title: "Guide complet : Installation de vLLM avec NVIDIA CUDA sur Windows"
description: "Guide pratique pour installer et configurer vLLM avec une carte graphique NVIDIA sur Windows via WSL2. Cet article présente la préparation de l'environnement Linux, l'installation de CUDA, Python, UV et le déploiement d'un serveur d'inférence LLM haute performance."
tags: [linux, windows, ubuntu, wsl, llm, IA, vLLM, python]
---

## Avant d'entrer dans le vif du sujet

Avant de commencer l'installation et la configuration de vLLM, il est important de comprendre son objectif principal.

vLLM est un moteur d'inférence conçu principalement pour le déploiement de modèles de langage en environnement Linux et en production. Il est particulièrement adapté aux serveurs GPU, aux applications nécessitant une API LLM, et aux scénarios avec plusieurs utilisateurs grâce à ses optimisations comme le batching continu et la gestion efficace de la mémoire GPU.

Cependant, pour une utilisation personnelle ou pour simplement tester des modèles d'intelligence artificielle en local, vLLM n'est pas toujours la solution la plus simple.

Des alternatives plus accessibles existent :

- **Ollama** ou **LM Studio** : des solutions simples avec interface graphique ou API locale permettant d'exécuter rapidement des modèles sans configuration complexe.

- **llama.cpp** : une solution plus proche du système, utilisable directement depuis un terminal. Elle fonctionne sur plusieurs systèmes d'exploitation et distributions Linux, Windows et macOS, et permet d'exécuter des modèles au format GGUF avec une grande flexibilité.

Dans cet article, nous allons nous concentrer sur l'utilisation de vLLM avec une carte graphique NVIDIA. Nous allons voir comment préparer l'environnement, installer les dépendances nécessaires et déployer un modèle optimisé pour l'inférence GPU.

L'objectif est de comprendre comment passer d'une utilisation locale d'un modèle IA à un véritable service d'inférence capable de répondre via une API.

## Sommaire

- [Installation de WSL (Linux sur Windows)](#installation-de-wsl-linux-sur-windows)
  - [Vérifier le BIOS](#vérifier-le-bios)
  - [Vérifier que la virtualisation est activée sur Windows](#vérifier-que-la-virtualisation-est-activée-sur-windows)
  - [Installation WSL (Ubunut)](#installation-wsl)

- [Installation des dépendances](#installation-des-dépendances)
  - [Installation de CUDA 12.6](#installation-de-cuda-126)
  - [Installation de Python 3.12 et PyTorch](#installation-de-python-312)
  - [Installation de curl et UV](#installation-de-uv)

- [Installation de vLLM](#installation-de-vllm)
    - [Pourquoi utiliser un environnement virtuel Python](#pourquoi-utiliser-un-environnement-virtuel-python)
    - [Installation de vLLM](#installation-de-vllm)

- [Test rapide du modèle](#test-rapide-du-modèle)
- [Bonus : Automatiser l’installation de vLLM avec un script Shell](#Bonus-:-Automatiser-l’installation-de-vLLM-avec-un-script-Shell)

## Installation de WSL (Linux sur Windows)

vLLM est conçu pour le système Linux, donc pour le faire fonctionner sur Windows, il faut utiliser la virtualisation, soit avec VMware, VirtualBox, etc. Mais depuis Windows 10, Microsoft propose directement une machine virtuelle intégrée à Windows appelée WSL. Pour cela, il faut toujours vérifier que la virtualisation est bien activée au niveau du CPU et du système Windows.

### Vérifier le BIOS

**En général, elle est activée par défaut, mais certains constructeurs la désactivent.**

Pour vérifier :

1. Ouvrir le **Gestionnaire des tâches**.
    1. 1. Faire un clic droit sur la barre des tâches.
    1. 2. Sélectionner **Gestionnaire des tâches**.
2. Aller dans **Performances → Processeur (CPU)**.
3. Vérifier la ligne **Virtualisation**.

Si elle est désactivée, il faut l'activer depuis le BIOS/UEFI.

Pour accéder au BIOS, la méthode peut être différente d'un constructeur à un autre, et cela dépend également du type de PC. Je vais donc présenter la méthode la plus universelle possible pour accéder au BIOS.

<a href="https://www.youtube.com/watch?v=vkVsHAH4Bv4" target="_blank" rel="noopener noreferrer"> Voici une vidéo explicative pour activer la virtualisation matérielle</a>



### Vérifier que la virtualisation est activée sur Windows

1. Appuyer sur **Windows + R**.
2. Taper : **optionalfeatures**
3. Vérifier que les options suivantes sont cochées :\
    **Plateform d'ordinateur virtuel** (EN :*Virtual Machine Platform*)\
    **Sous-système Windows pour Linux** (EN :*Windows Subsystem for Linux*) \
    ![Description de l'image](/assets/imgs/optionalfeatures.png)
4. Cliquer sur OK puis redémarrer Windows.

### Installation WSL

1. Ouvrir **PowerShell** en mode administrateur.
```bash
wsl --install
```
2. Lors de la première configuration, Ubuntu vous demandera de créer un nom d'utilisateur et un mot de passe. \
    *Il est important de bien mémoriser ce mot de passe, car il sera utilisé pour exécuter des commandes administrateur avec sudo dans Linux.*

## Installation des dépendances

### Installation de CUDA 12.6

*Au moment de la rédaction de cet article, vLLM utilise CUDA 12.6. Il est donc recommandé de toujours vérifier la documentation officielle pour connaître la version de CUDA compatible.*

Voici le lien officiel d'installation de CUDA pour Ubuntu WSL :

<a href="https://developer.nvidia.com/cuda-12-6-0-download-archive?target_os=Linux&target_arch=x86_64&Distribution=WSL-Ubuntu&target_version=2.0&target_type=deb_network" target="_blank" rel="noopener noreferrer">Site officiel NVIDIA CUDA</a>

```bash
wget https://developer.download.nvidia.com/compute/cuda/repos/wsl-ubuntu/x86_64/cuda-keyring_1.1-1_all.deb
sudo dpkg -i cuda-keyring_1.1-1_all.deb
sudo apt-get update
sudo apt-get -y install cuda-toolkit-12-6
```

*Le mot de passe demandé correspond au mot de passe que vous avez créé lors de la configuration initiale de WSL.*

Maintenant, il faut ajouter les exécutables CUDA dans les variables d'environnement afin de pouvoir les utiliser facilement depuis le terminal.

Ajouter les chemins suivants dans la variable `PATH` :

```bash
export PATH=/usr/local/cuda-12.6/bin:$PATH
export LD_LIBRARY_PATH=/usr/local/cuda-12.6/lib64:$LD_LIBRARY_PATH
```

Pour appliquer les modifications automatiquement à chaque ouverture du terminal, ajouter ces lignes dans le fichier :

```bash
nano ~/.bashrc
source ~/.bashrc
```

Ensuite, vérifier que CUDA est bien installé :
```bash
nvcc --version
```

### Installation de Python 3.12

*Au moment de la rédaction de cet article, vLLM utilise python 3.12. Il est donc recommandé de toujours vérifier la documentation officielle pour connaître la version de python compatible.*

```bash
sudo apt install python3.12-dev python3.12-venv libpython3.12-dev
sudo apt install build-essential
```

### Installation de UV

Pour installer **UV**, c'est simple :

```bash
wget -qO- https://astral.sh/uv/install.sh | sh
```


## Installation de vLLM

### Pourquoi utiliser un environnement virtuel Python

Il existe deux façons d'installer des paquets Python :

#### 1. Installation globale

Les paquets sont installés directement dans le système et deviennent accessibles pour tous les projets.

*Avantage :*
- Il n'est pas nécessaire d'activer un environnement virtuel avant d'utiliser les paquets.

*Inconvénient :*
- Si plusieurs projets utilisent des versions différentes d'un même paquet, cela peut provoquer des conflits entre les dépendances (versions incompatibles).

#### 2. Installation dans un environnement virtuel Python

Pour éviter les problèmes de conflits de versions, on utilise un environnement virtuel Python.

*Avantages :*
- Chaque projet possède ses propres dépendances.
- Les versions des paquets sont isolées, ce qui évite les conflits avec d'autres projets.

*Inconvénient :*
- À chaque utilisation de vLLM, il faut activer l'environnement virtuel avant d'exécuter les commandes.

### Creer un variable envirenement

Pour créer un environnement virtuel, il faut d'abord créer un dossier avec un nom clair afin d'éviter les difficultés lors de son utilisation. Dans notre cas, nous allons l'appeler `vllm`.

```bash
mkdir vllm
cd vllm
```

Créer et activer l'environnement virtuel :

```bash
uv venv --python 3.12 --seed
source .venv/bin/activate
```

Ensuite, installer vLLM et PyTorch :

```bash
uv pip install vllm --torch-backend=cu126
```

## Test rapide du modèle

Nous allons installer un modèle très léger uniquement pour effectuer des tests.

```bash
vllm serve Qwen/Qwen3Guard-Gen-0.6B
```

Vous pouvez trouver différents modèles compatibles sur <a href="https://huggingface.co/models?apps=vllm&sort=trending" target="_blank" rel="noopener noreferrer"> Hugging Face </a>.

Ensuite, nous allons effectuer un test simple en envoyant une petite question au modèle :

```bash
curl http://localhost:8000/v1/chat/completions \
-H "Content-Type: application/json" \
-d '{
    "model": "Qwen/Qwen3Guard-Gen-0.6B",
    "messages": [
        {
            "role": "user",
            "content": "Bonjour !"
        }
    ]
}'
```

## Bonus : Automatiser l'installation de vLLM avec un script Shell

Pour éviter de refaire toutes les étapes manuellement, surtout avec le risque d'en oublier certaines, j'ai créé un script Shell afin de faciliter l'installation. En réalité, ce script regroupe simplement toutes les étapes nécessaires dans un seul fichier.

Télécharger et exécuter le script d'installation :

```bash
wget -qO- https://mokrani-zahir.github.io/assets/files/install_vllm_2026_08_04.sh | sh
```

Pour utiliser vLLM, il faut d'abord activer l'environnement virtuel Python :

```bash
cd vllm
source .venv/bin/activate
```
