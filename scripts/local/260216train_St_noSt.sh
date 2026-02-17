# 2-26_2_16の作業記録。

# データのパスを現状にあわせて改変
# "260scripts/local/260216train_St_noSt.R"を参照すること。

# 環境構築・呼び出し
# conda env create -f=environment.yml
conda activate develop

# まずはnot stratifiedtデータから。
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_nSt_260216.csv" datamodule=detector num_epochs=50
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_nSt_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_10-31-29/checkpoints/best.pth
#結果
#[2026-02-16 12:50:27,658][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 12:50:27,658][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 12:50:27,976][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 12:50:30,181][src.testing_pipeline][INFO] - load checkpoint : epoch=47
#[2026-02-16 12:51:04,432][src.testing_pipeline][INFO] - test acc : 0.9521886110305786
#[2026-02-16 12:51:04,529][src.testing_pipeline][INFO] - class wise acc | bear:0.872 | bird:0.879 | boar:0.912 | cat:0.406 | deer:0.988 | fox:0.713 | masked:0.449 | monkey:0.727 | mustelidae:0.798 | rabbit:0.846 | raccoondog:0.863 | serow:0.910 | squirrel:0.843

# not stratifiedtモデルで2024年度の外挿データをtest
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_10-31-29/checkpoints/best.pth
#結果
#[2026-02-16 17:11:31,101][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 17:11:31,101][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 17:11:31,191][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 17:11:33,409][src.testing_pipeline][INFO] - load checkpoint : epoch=47
#[2026-02-16 17:12:06,742][src.testing_pipeline][INFO] - test acc : 0.9187629818916321
#[2026-02-16 17:12:06,837][src.testing_pipeline][INFO] - class wise acc | bear:0.744 | bird:0.811 | boar:0.874 | cat:0.161 | deer:0.984 | fox:0.703 | masked:0.750 | monkey:0.200 | mustelidae:0.832 | rabbit:0.741 | raccoondog:0.834 | serow:0.656 | squirrel:0.733


# 次はstratifiedtデータから。
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_St_260216.csv" datamodule=detector num_epochs=50
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_St_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_12-51-48/checkpoints/best.pth
#結果
#[2026-02-16 15:24:05,799][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 15:24:05,799][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 15:24:06,117][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 15:24:08,318][src.testing_pipeline][INFO] - load checkpoint : epoch=45
#[2026-02-16 15:24:41,895][src.testing_pipeline][INFO] - test acc : 0.9402769804000854
#[2026-02-16 15:24:41,985][src.testing_pipeline][INFO] - class wise acc | bear:0.737 | bird:0.781 | boar:0.892 | cat:0.367 | deer:0.987 | fox:0.741 | masked:0.436 | monkey:0.200 | mustelidae:0.805 | rabbit:0.746 | raccoondog:0.855 | serow:0.850 | squirrel:0.808

# stratifiedtモデルで2024年度の外挿データをtest
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_12-51-48/checkpoints/best.pth
#[2026-02-16 17:13:29,222][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 17:13:29,222][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 17:13:29,312][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 17:13:31,554][src.testing_pipeline][INFO] - load checkpoint : epoch=45
#[2026-02-16 17:14:04,971][src.testing_pipeline][INFO] - test acc : 0.9197441339492798
#[2026-02-16 17:14:05,061][src.testing_pipeline][INFO] - class wise acc | bear:0.719 | bird:0.785 | boar:0.864 | cat:0.214 | deer:0.987 | fox:0.775 | masked:0.688 | monkey:0.600 | mustelidae:0.833 | rabbit:0.747 | raccoondog:0.861 | serow:0.637 | squirrel:0.721

