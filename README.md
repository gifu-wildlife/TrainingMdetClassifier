# TrainingMdetClassifier

MegaDetectorで切り出されたカメラトラップ画像を分類するためのディープラーニングモデル訓練フレームワーク  
A deep learning model training framework for classifying cropped camera trap images by MegaDetector    

## Overview　/　概要

TrainingMdetClassifier is a deep learning training repository designed to classify images cropped by wildlife detectors.

Key features:

- Automates the process of training, testing, and predicting with image classification models
- Configuration management using Hydra
- Transfer learning using pretrained models such as ResNet
- Tools for dataset management and preprocessing
- Logging and visualization of experiment results

You can train deep learning models to classify species using a dataset of wildlife images.

TrainingMdetClassifierは、野生動物検出器によって切り出された画像を分類するための深層学習モデル訓練用リポジトリです。

主な特徴:

- 画像分類モデルのトレーニング、テスト、予測の一連のプロセスを自動化
- Hydraを使用した設定管理
- ResNetなどの事前学習済みモデルを利用した転移学習
- データセットの管理と前処理のためのツール
- 実験結果の記録と可視化

野生動物の画像データセットを使用して、種の分類を行うための深層学習モデルをトレーニングできます。

## Get Started / はじめに

This section describes how to set up the project in your local environment.  
このセクションでは、プロジェクトのローカル環境でのセットアップ方法について説明します。

### Package Management / パッケージ管理

This project uses either `conda` or `uv` to manage Python dependencies. Please choose one of them to install.  
このプロジェクトでは、Pythonの依存関係を管理するために`conda`または`uv`を使用します。どちらか一方を選択してインストールしてください。

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
`uv`は、Pythonの依存関係を管理するためのRust製ツールです。
Pythonのインストールが別途必要となります．pyenvを使用する場合は[pyenvのインストール方法](docs/install_python.md)を参照してください。

```bash
# uvのインストール (for linux)
# https://github.com/astral-sh/uv
curl -sSf https://install.astral.sh | sh

# Windows
winget install --id=astral-sh.uv  -e
```

### Package Installation / パッケージのインストール

Install dependencies using the method selected in the Package Management section.  
パッケージ管理のセクションで選択した方法に応じて、以下の手順で依存関係をインストールします。

#### Clone the repository / リポジトリのクローン

Clone the repository locally.   
ローカル環境にリポジトリをクローンします．

```bash
git clone https://github.com/gifu-wildlife/TrainingMdetClassifier.git
cd TrainingMdetClassifier
```

#### Environment Setup using conda / condaによる環境構築

```bash
conda env create -f environment.yml
conda activate develop
```

#### Environment Setup using uv / uvによる環境構築

```bash
# 開発環境を含めてインストール
# Install including development dependencies
uv sync

# GPUを使用する場合（CUDA 11.3）
# For GPU (CUDA 11.3)
uv sync --extras cu113

# CPUのみを使用する場合
# For CPU only
uv sync --extras cpu
```

## Usage / 使用方法

This framework provides three main functions: training, testing, and prediction.  
このフレームワークは、トレーニング、テスト、予測の3つの主要な機能を提供します。

### Preparing the Data / データの準備

Prepare the classification dataset in the following CSV format:  
分類用データセットは以下の形式のCSVファイルで準備します:  

```csv
fullpath,crop_path,category,learning_phase
/path/to/image1.jpg,/path/to/crop/image1.jpg,class1,0
/path/to/image2.jpg,/path/to/crop/image2.jpg,class2,0
```

- `fullpath`: Path to the original image / 元画像のパス
- `crop_path`: Path to the cropped image / 切り抜き画像のパス
- `category`: Class label / クラスラベル
- `learning_phase`: 0 = train, 1 = validation, 2 = test / 0=訓練、1=検証、2=テスト

### Train the model / モデルのトレーニング

```bash
# Basic training command
# 基本的なトレーニングコマンド
python train.py

# Train using a specific experiment config
# 実験設定を指定してトレーニング
python train.py experiment=detector_cls

# Override specific parameters during training
# 特定のパラメータを上書きしてトレーニング
python train.py experiment=detector_cls optimizer.lr=0.001
```

### Test the model / モデルのテスト

WIP  
(under construction)

<!-- ```bash
# Evaluate the model using the test dataset
# テストデータセットでモデルを評価
python test.py experiment=detector_cls
``` -->

### Run prediction / 予測の実行

```bash
# Run prediction on new images
# 新しい画像に対して予測を実行
python predict.py --data_source /path/to/images --log_dir logs/experiments/runs/default/YYYY-MM-DD_HH-MM-SS
```

The main experiment settings are defined in the YAML files in the `configs/experiment/`.
See [`docs/configs.md`](docs/configs.md) for more details.  
主要な実験設定は`configs/experiment/`ディレクトリ内のYAMLファイルで定義されています。詳細は[`docs/configs.md`](docs/configs.md)を参照してください。

## License / ライセンス

Distributed under the MIT License.
See the [`LICENSE`](LICENSE) file for more information.  
MITライセンスの下で配布されています。詳細については[`LICENSE`](LICENSE)ファイルを参照してください。

<!-- 
## 連絡先

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com
 -->

<!--
Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)
-->

<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
