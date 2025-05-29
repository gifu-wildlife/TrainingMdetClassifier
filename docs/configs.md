# TrainingMdetClassifierの設定ファイルについて

## 目次

- [Hydra の使用方法](#hydra-の使用方法)
- [基本設定ファイル](#基本設定ファイル)
- [データモジュール設定](#データモジュール設定)
- [モデル設定](#モデル設定)
- [オプティマイザ設定](#オプティマイザ設定)
- [スケジューラ設定](#スケジューラ設定)
- [実験設定](#実験設定)
- [ハイパーパラメータ探索設定](#ハイパーパラメータ探索設定)
- [ログディレクトリ設定](#ログディレクトリ設定)

## Hydra の使用方法

### CLI引数による設定上書き

Hydraでは、コマンドライン引数を使用して設定を上書きできます。

```bash
# 基本的な実行
python train.py

# バッチサイズを変更
python train.py datamodule.batch_size=128

# 学習率とエポック数を変更
python train.py optimizer.lr=0.01 num_epochs=5

# GPUを無効化
python train.py gpu=0

# 設定グループ全体を変更（異なるオプティマイザを使用）
python train.py optimizer=sgd
```

### 実験設定ファイルの使用

実験設定は複数のパラメータをまとめて設定できます。

```bash
# detector_cls実験設定を使用
python train.py experiment=detector_cls

# 実験設定を使いつつ、一部のパラメータを上書き
python train.py experiment=detector_cls optimizer.lr=0.005
```

### 新しい実験設定の作成

新しい実験設定を作成するには、`configs/experiment/`ディレクトリに新しいYAMLファイルを作成します。

```yaml
# configs/experiment/my_experiment.yaml
# @package _global_

name: "my_experiment"

defaults:
  - override /datamodule: detector.yaml
  - override /model: resnet.yaml
  - override /optimizer: adam.yaml
  - override /scheduler: steplr.yaml

model:
  arch: "resnet18"
  pretrain: True

optimizer:
  lr: 0.0005
  weight_decay: 0.001

num_epochs: 10
```

実行方法:

```bash
python train.py experiment=my_experiment
```

### マルチランの実行（複数シードでの実験）

複数のシード値で実験を行う場合は、`--multirun`オプションと`-m`オプションを使用します。

```bash
# 3つの異なるシード値で実験を実行
python train.py --multirun seed=1,2,3

# シード値の範囲を指定
python train.py --multirun seed=range(1,6)

# 実験設定と組み合わせ
python train.py --multirun experiment=detector_cls seed=1,2,3
```

### ハイパーパラメータ探索

Optunaを使用したハイパーパラメータ探索を行う場合：

```bash
# 基本的なハイパーパラメータ探索
python train.py -m hparams_search=optuna experiment=detector_cls

# 探索試行回数を変更
python train.py -m hparams_search=optuna hydra.sweeper.n_trials=20 experiment=detector_cls

# 特定のパラメータのみ探索
python train.py -m hparams_search=optuna \
    hydra.sweeper.params.optimizer.lr=range(0.0001,0.01) \
    hydra.sweeper.params.model.arch=choice(\"resnet18\",\"resnet34\",\"resnet50\") \
    experiment=detector_cls
```

## 基本設定ファイル

### train.yaml

`configs/train.yaml`は訓練プロセスの基本設定を行います。

```yaml
# @package _global_

defaults:
  - _self_
  - datamodule: cifar.yaml
  - model: resnet.yaml
  - optimizer: adam.yaml
  - scheduler: steplr.yaml
  - log_dir: default.yaml

  - experiment: null
  - debug: null
  - hparams_search: null

  - override hydra/hydra_logging: colorlog
  - override hydra/job_logging: colorlog

original_work_dir: ${hydra:runtime.cwd}
data_dir: ${original_work_dir}/data/

seed: 9999
num_epochs: 3
gpu: 1
train: True
test: True
name: "default"
pretrain_ckpt_path: null
```

主な設定項目：

- `defaults`: 各種設定ファイルの読み込み
- `data_dir`: データディレクトリのパス
- `seed`: 乱数シード
- `num_epochs`: 訓練エポック数
- `gpu`: 使用するGPUの数
- `train`: 訓練を実行するかどうか
- `test`: テストを実行するかどうか
- `pretrain_ckpt_path`: 事前学習モデルのチェックポイントパス

### test.yaml

`configs/test.yaml`はテストプロセスの基本設定を行います。

```yaml
# @package _global_

defaults:
  - _self_
  - datamodule: cifar.yaml
  - model: resnet.yaml
  - optimizer: adam.yaml
  - scheduler: steplr.yaml
  - log_dir: default.yaml

  - experiment: null
  - debug: null
  - hparams_search: null

  - override hydra/hydra_logging: colorlog
  - override hydra/job_logging: colorlog

original_work_dir: ${hydra:runtime.cwd}
data_dir: ${original_work_dir}/data/

seed: 9999
num_epochs: 3
gpu: 1
train: True
test: True
name: "default"

pretrain_ckpt_path: null
ckpt_path: path/to/the/weight.pth
```

train.yamlとの主な違い：

- `ckpt_path`: テスト時に読み込む訓練済みモデルのパス

## データモジュール設定

### cifar.yaml

`configs/datamodule/cifar.yaml`はCIFARデータセットの設定を行います。

```yaml
_target_: src.datamodules.cifar.CIFARDataModule

data_source: ${data_dir}
batch_size: 64
train_val_test_split: [45_000, 5_000, 10_000]
num_workers: 4
pin_memory: True
```

主な設定項目：

- `_target_`: 使用するデータモジュールクラス
- `data_source`: データの場所
- `batch_size`: バッチサイズ
- `train_val_test_split`: 訓練/検証/テスト分割
- `num_workers`: データローダーのワーカー数
- `pin_memory`: GPUメモリにデータをピンするかどうか

### detector.yaml

`configs/datamodule/detector.yaml`は野生動物検出器用のデータセット設定です。

```yaml
_target_: src.datamodules.detector.DetectorDataModule

data_source: ${data_dir}/d4cls/d4cls.csv
batch_size: 64
num_workers: 4
pin_memory: True
```

主な設定項目：

- `data_source`: CSVファイルの場所
- その他の項目はcifar.yamlと同様

## モデル設定

### resnet.yaml

`configs/model/resnet.yaml`はResNetモデルの設定を行います。

```yaml
_target_: src.models.resnet.Classifire

arch: "resnet50"
pretrain: True
num_classes: -1
```

主な設定項目：

- `_target_`: 使用するモデルクラス
- `arch`: ResNetのアーキテクチャ（resnet18, resnet34, resnet50, resnet101, resnet152）
- `pretrain`: 事前学習済みの重みを使用するかどうか
- `num_classes`: クラス数（-1の場合はデータセットから自動取得）

## オプティマイザ設定

### adam.yaml

`configs/optimizer/adam.yaml`はAdamオプティマイザの設定を行います。

```yaml
_target_: torch.optim.Adam
lr: 0.001
betas:
  - 0.9
  - 0.999
eps: 1e-8
weight_decay: 0
```

主な設定項目：

- `_target_`: 使用するオプティマイザ
- `lr`: 学習率
- `betas`: Adamのモーメンタムパラメータ
- `eps`: 数値安定性のための小さな値
- `weight_decay`: 重み減衰（L2正則化）

## スケジューラ設定

### steplr.yaml

`configs/scheduler/steplr.yaml`は学習率スケジューラの設定を行います。

```yaml
_target_: torch.optim.lr_scheduler.StepLR
step_size: 30
gamma: 0.1
```

主な設定項目：

- `_target_`: 使用するスケジューラ
- `step_size`: 学習率を減衰させるエポック間隔
- `gamma`: 学習率の減衰率

## 実験設定

### detector_cls.yaml

`configs/experiment/detector_cls.yaml`は検出器分類タスクの実験設定です。

```yaml
# @package _global_

name: "default"

defaults:
  - override /datamodule: detector.yaml
  - override /model: resnet.yaml
  - override /optimizer: adam.yaml
  - override /scheduler: steplr.yaml

model:
  arch: "resnet50"
  pretrain: True

datamodule:
  batch_size: 64
  num_workers: 4

optimizer:
  lr: 0.001

num_epochs: 2
gpu: 1
train: True
test: True
```

実験設定では、基本設定を上書きして特定のタスクに最適化された設定を提供します。

## ハイパーパラメータ探索設定

### optuna.yaml

`configs/hparam_search/optuna.yaml`はOptunaを用いたハイパーパラメータ探索の設定です。

```yaml
defaults:
  - override /hydra/sweeper: optuna

optimized_metric: "val/acc_best"

hydra:
  sweeper:
    _target_: hydra_plugins.hydra_optuna_sweeper.optuna_sweeper.OptunaSweeper
    storage: null
    study_name: null
    n_jobs: 1
    direction: maximize
    n_trials: 10
    
    sampler:
      _target_: optuna.samplers.TPESampler
      seed: 12345
      n_startup_trials: 8
    
    params:
      datamodule.batch_size: choice(32, 64, 128)
      optimizer.lr: range(0.0001, 0.2)
      optimizer.weight_decay: range(0, 0.1)
      scheduler.step_size: choices(10, 20, 30)
      scheduler.gamma: range(0.1, 0.5)
```

主な設定項目：

- `optimized_metric`: 最適化する評価指標
- `direction`: 最大化か最小化か
- `n_trials`: 試行回数
- `sampler`: パラメータサンプリング方法
- `params`: 探索するパラメータとその範囲

## ログディレクトリ設定

### default.yaml

`configs/log_dir/default.yaml`はログディレクトリの設定を行います。

```yaml
# @package _global_

hydra:
  output_subdir: config
  run:
    dir: logs/experiments/runs/${name}/${now:%Y-%m-%d}_${now:%H-%M-%S}
  sweep:
    dir: logs/experiments/multiruns/${name}/${now:%Y-%m-%d}_${now:%H-%M-%S}
    subdir: ${hydra.job.num}
```

主な設定項目：

- `run.dir`: 単一実行時のログディレクトリ
- `sweep.dir`: マルチラン時のログディレクトリ
