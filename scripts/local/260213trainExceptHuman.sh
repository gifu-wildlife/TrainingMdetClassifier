# 2-26_2_13の作業記録。

# 250530の作業の記録：データをサーバから取得
# sudo mkdir /mnt/mountpoint
# sudo mount -t cifs //10.224.202.45/Public /mnt/mountpoint -o user=wildlife
# sudo rsync -avn /mnt/mountpoint/ensyurin_MachineLearning ~/TrainingMdetClassifier/data/
# sudo chown -R wildlife:wildlife ensyurin_MachineLearning/
# sudo umount /mnt/mountpoint

# データのパスを現状にあわせて改変
# "260213trainExceptHuman.R"を参照すること。

# 再構築したデータで学習
# 環境構築・呼び出し
# conda env create -f=environment.yml
conda activate develop

# 3回テスト用のコード
# python train.py datamodule.data_source="/home/wildlife/TrainingMdetClassifier/data/detector_output-annotation_data_260213.csv" datamodule=detector

python train.py datamodule.data_source="/home/wildlife/TrainingMdetClassifier/data/detector_output-annotation_data_260213.csv" datamodule=detector num_epochs=50

# testの実行。いくつかハードルがあった。
# まず、configs/test.yamlが必要だったので、configs/train.yamlをコピペしてリネーム。
# 重みのファイル(ckpt_path)についての項目を加筆する必要があったので、末尾に以下を追記。
# ckpt_path: path/to/the/weight.pth
# 次に、Pytorch2.6以降の重みファイルでセキュリティが高くなったため、重みファイルについているメタデータ（今回はチェックポイント情報）がエラーを起こしていたので対応。
# src/testing_pipeline.pyのtorch.load()にweights_only=Falseを追記
# これで以下のコードが通る。

python test.py datamodule.data_source="/home/wildlife/TrainingMdetClassifier/data/detector_output-annotation_data_260213.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-13_16-21-36/checkpoints/best.pth