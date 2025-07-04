# TrainingMdetClassifier

A deep learning model training framework for classifying cropped camera trap images by MegaDetector

## Overview

TrainingMdetClassifier is a deep learning training repository designed to classify images cropped by wildlife detectors.

Key features:

- Automates the process of training, testing, and predicting with image classification models
- Configuration management using Hydra
- Transfer learning using pretrained models such as ResNet
- Tools for dataset management and preprocessing
- Logging and visualization of experiment results

You can train deep learning models to classify species using a dataset of wildlife images.

## Get Started

This section describes how to set up the project in your local environment.

### Package Management

This project uses either `conda` or `uv` to manage Python dependencies. Please choose one of them to install.

#### conda

```bash
# linux (conda-installer-name = Miniconda3 or Anaconda3 or Mambaforge)
bash <conda-installer-name>-latest-Linux-x86_64.sh

# Windows
# WIP
```

#### uv

`uv` is a Rust-based tool for managing Python dependencies.  
You need to install Python separately. If using pyenv, refer to [Installing Python with pyenv](docs/install_python.md).

```bash
# Install uv (for linux)
# https://github.com/astral-sh/uv
curl -sSf https://install.astral.sh | sh

# Windows
winget install --id=astral-sh.uv  -e
```

### Package Installation

Install dependencies using the method selected in the Package Management section.

#### Clone the repository

Clone the repository locally.

```bash
git clone https://github.com/gifu-wildlife/TrainingMdetClassifier.git
cd TrainingMdetClassifier
```

#### Environment Setup using conda

```bash
conda env create -f environment.yml
conda activate develop
```

#### Environment Setup using uv

```bash
# Install including development dependencies
uv sync

# For GPU (CUDA 11.3)
uv sync --extras cu113

# For CPU only
uv sync --extras cpu
```

## Usage

This framework provides three main functions: training, testing, and prediction.

### Preparing the Data

Prepare the classification dataset in the following CSV format:

```csv
fullpath,crop_path,category,learning_phase
/path/to/image1.jpg,/path/to/crop/image1.jpg,class1,0
/path/to/image2.jpg,/path/to/crop/image2.jpg,class2,0
```

- `fullpath`: Path to the original image
- `crop_path`: Path to the cropped image
- `category`: Class label
- `learning_phase`: 0 = train, 1 = validation, 2 = test

### Train the model

```bash
# Basic training command
python train.py

# Train using a specific experiment config
python train.py experiment=detector_cls

# Override specific parameters during training
python train.py experiment=detector_cls optimizer.lr=0.001
```

### Test the model

WIP  
(under construction)

<!--
# Evaluate the model using the test dataset
python test.py experiment=detector_cls
-->

### Run prediction

```bash
# Run prediction on new images
python predict.py --data_source /path/to/images --log_dir logs/experiments/runs/default/YYYY-MM-DD_HH-MM-SS
```

The main experiment settings are defined in the YAML files in the `configs/experiment/` directory.  
See [`docs/configs.md`](docs/configs.md) for more details.

## License

Distributed under the MIT License.  
See the [`LICENSE`](LICENSE) file for more information.