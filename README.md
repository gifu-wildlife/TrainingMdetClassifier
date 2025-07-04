(in [`English`](README_E.md))

# TrainingMdetClassifier

MegaDetectorで切り出されたカメラトラップ画像を分類するためのディープラーニングモデル訓練フレームワーク  

## 概要

TrainingMdetClassifierは、野生動物検出器によって切り出された画像を分類するための深層学習モデル訓練用リポジトリです。

主な特徴:

- 画像分類モデルのトレーニング、テスト、予測の一連のプロセスを自動化
- Hydraを使用した設定管理
- ResNetなどの事前学習済みモデルを利用した転移学習
- データセットの管理と前処理のためのツール
- 実験結果の記録と可視化

野生動物の画像データセットを使用して、種の分類を行うための深層学習モデルをトレーニングできます。

## Get Started

このセクションでは、プロジェクトのローカル環境でのセットアップ方法について説明します。

### Package Management

このプロジェクトでは、Pythonの依存関係を管理するために`conda`または`uv`を使用します。どちらか一方を選択してインストールしてください。

#### conda

```bash
# linux (conda-installer-name = Miniconda3 or Anaconda3 or Mambaforge)
bash <conda-installer-name>-latest-Linux-x86_64.sh

# Windows
# WIP
```

#### uv

`uv`は、Pythonの依存関係を管理するためのRust製ツールです。
Pythonのインストールが別途必要となります．pyenvを使用する場合は[pyenvのインストール方法](docs/install_python.md)を参照してください。

```bash
# uvのインストール (for linux)
# https://github.com/astral-sh/uv
curl -sSf https://install.astral.sh | sh

# Windows
winget install --id=astral-sh.uv  -e
```

### Package Installation

Package Managementのセクションで選択した方法に応じて、以下の手順で依存関係をインストールします。

#### Clone the repository / リポジトリのクローン

ローカル環境にリポジトリをクローンします．

```bash
git clone https://github.com/gifu-wildlife/TrainingMdetClassifier.git
cd TrainingMdetClassifier
```

#### condaによる環境構築

```bash
conda env create -f environment.yml
conda activate develop
```

#### uvによる環境構築

```bash
# 開発環境を含めてインストール
uv sync

# GPUを使用する場合（CUDA 11.3）
uv sync --extras cu113

# CPUのみを使用する場合
uv sync --extras cpu
```

## Usage

このフレームワークは、トレーニング、テスト、予測の3つの主要な機能を提供します。

### データの準備

分類用データセットは以下の形式のCSVファイルで準備します:  

```csv
fullpath,crop_path,category,learning_phase
/path/to/image1.jpg,/path/to/crop/image1.jpg,class1,0
/path/to/image2.jpg,/path/to/crop/image2.jpg,class2,0
```

- `fullpath`: 元画像のパス
- `crop_path`: 切り抜き画像のパス
- `category`: クラスラベル
- `learning_phase`: 0=訓練、1=検証、2=テスト

### Train the model / モデルのトレーニング

```bash
# 基本的なトレーニングコマンド
python train.py

# 実験設定を指定してトレーニング
python train.py experiment=detector_cls

# 特定のパラメータを上書きしてトレーニング
python train.py experiment=detector_cls optimizer.lr=0.001
```

### Test the model / モデルのテスト

WIP  
(under construction)

<!-- ```bash
# テストデータセットでモデルを評価
python test.py experiment=detector_cls
``` -->

### Run prediction / 予測の実行

```bash
# 新しい画像に対して予測を実行
python predict.py --data_source /path/to/images --log_dir logs/experiments/runs/default/YYYY-MM-DD_HH-MM-SS
```

主要な実験設定は`configs/experiment/`ディレクトリ内のYAMLファイルで定義されています。詳細は[`docs/configs.md`](docs/configs.md)を参照してください。

## License / ライセンス

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
