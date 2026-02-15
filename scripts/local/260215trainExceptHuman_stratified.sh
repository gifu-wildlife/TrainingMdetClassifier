# 2-26_2_16の作業記録。

# データのパスを現状にあわせて改変
# "260213trainExceptHuman.R"を参照すること。

# 環境構築・呼び出し
# conda env create -f=environment.yml
conda activate develop

python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_stratified.csv" datamodule=detector num_epochs=50

# testの実行。いくつかハードルがあった。
# まず、configs/test.yamlが必要だったので、configs/train.yamlをコピペしてリネーム。
# 重みのファイル(ckpt_path)についての項目を加筆する必要があったので、末尾に以下を追記。
# ckpt_path: path/to/the/weight.pth
# 次に、Pytorch2.6以降の重みファイルでセキュリティが高くなったため、重みファイルについているメタデータ（今回はチェックポイント情報）がエラーを起こしていたので対応。
# src/testing_pipeline.pyのtorch.load()にweights_only=Falseを追記
# これで以下のコードが通る。

python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_stratified.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_15-50-24/checkpoints/best.pth