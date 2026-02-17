# 2-26_2_16の作業記録。

# データのパスを現状にあわせて改変
# "260213trainExceptHuman.R"を参照すること。

# 環境構築・呼び出し
# conda env create -f=environment.yml
conda activate develop

python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_stratified.csv" \
        datamodule=detector num_epochs=50

# testの実行。いくつかハードルがあった。
# まず、configs/test.yamlが必要だったので、configs/train.yamlをコピペしてリネーム。
# 重みのファイル(ckpt_path)についての項目を加筆する必要があったので、末尾に以下を追記。
# ckpt_path: path/to/the/weight.pth
# 次に、Pytorch2.6以降の重みファイルでセキュリティが高くなったため、重みファイルについているメタデータ（今回はチェックポイント情報）がエラーを起こしていたので対応。
# src/testing_pipeline.pyのtorch.load()にweights_only=Falseを追記
# これで以下のコードが通る。

python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_stratified.csv" \
        datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_15-50-24/checkpoints/best.pth
#結果
#[2026-02-15 16:44:30,009][src.testing_pipeline][INFO] - Start testining!
#[2026-02-15 16:44:30,010][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-15 16:44:30,096][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-15 16:44:32,283][src.testing_pipeline][INFO] - load checkpoint : epoch=41
#[2026-02-15 16:44:42,489][src.testing_pipeline][INFO] - test acc : 0.9168329238891602
#[2026-02-15 16:44:42,572][src.testing_pipeline][INFO] - class wise acc | bear:0.725 | bird:0.642 | boar:0.918 | cat:0.000 | deer:0.968 | fox:0.685 | masked:0.647 | monkey:0.000 | mustelidae:0.655 | rabbit:0.091 | raccoondog:0.807 | serow:0.848 | squirrel:0.658

# 2024年度のデータで外挿
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" \
        datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_15-50-24/checkpoints/best.pth
#結果
#[2026-02-16 23:45:20,891][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:45:20,891][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:45:20,980][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:45:23,230][src.testing_pipeline][INFO] - load checkpoint : epoch=41
#[2026-02-16 23:45:56,644][src.testing_pipeline][INFO] - test acc : 0.8474157452583313
#[2026-02-16 23:45:56,735][src.testing_pipeline][INFO] - class wise acc | bear:0.446 | bird:0.631 | boar:0.862 | cat:0.027 | deer:0.942 | fox:0.571 | masked:0.281 | monkey:0.000 | mustelidae:0.654 | rabbit:0.187 | raccoondog:0.712 | serow:0.578 | squirrel:0.356
