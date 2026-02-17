# 2-26_2_16の作業記録。

# データのパスを現状にあわせて改変
# 多すぎるデータを2000でキャップした。
# "260scripts/local/260216train_St_noStcap.R"を参照すること。

# 環境構築・呼び出し
# conda env create -f=environment.yml
conda activate develop

# まずはnSt_capデータから。
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_nSt_cap_260216.csv" datamodule=detector num_epochs=50
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_nSt_cap_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_22-50-11/checkpoints/best.pth
#結果
#[2026-02-16 23:14:18,004][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:14:18,004][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:14:18,321][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:14:20,550][src.testing_pipeline][INFO] - load checkpoint : epoch=38
#[2026-02-16 23:14:27,282][src.testing_pipeline][INFO] - test acc : 0.8792082667350769
#[2026-02-16 23:14:27,363][src.testing_pipeline][INFO] - class wise acc | bear:0.908 | bird:0.918 | boar:0.894 | cat:0.562 | deer:0.883 | fox:0.776 | masked:0.487 | monkey:0.636 | mustelidae:0.836 | rabbit:0.900 | raccoondog:0.898 | serow:0.911 | squirrel:0.878

# nSt_capモデルで2024年度の外挿データをtest
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_22-50-11/checkpoints/best.pth
#結果
#[2026-02-16 23:14:53,172][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:14:53,173][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:14:53,262][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:14:55,487][src.testing_pipeline][INFO] - load checkpoint : epoch=38
#[2026-02-16 23:15:29,154][src.testing_pipeline][INFO] - test acc : 0.8696675896644592
#[2026-02-16 23:15:29,247][src.testing_pipeline][INFO] - class wise acc | bear:0.802 | bird:0.863 | boar:0.871 | cat:0.321 | deer:0.901 | fox:0.791 | masked:0.781 | monkey:0.533 | mustelidae:0.852 | rabbit:0.832 | raccoondog:0.886 | serow:0.643 | squirrel:0.794

# 次はSt_capデータから。
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_St_cap_260216.csv" datamodule=detector num_epochs=50
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/d_St_cap_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_23-16-14/checkpoints/best.pth
#結果
#[2026-02-16 23:40:23,620][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:40:23,621][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:40:23,945][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:40:26,193][src.testing_pipeline][INFO] - load checkpoint : epoch=43
#[2026-02-16 23:40:32,574][src.testing_pipeline][INFO] - test acc : 0.8518957495689392
#[2026-02-16 23:40:32,662][src.testing_pipeline][INFO] - class wise acc | bear:0.856 | bird:0.848 | boar:0.849 | cat:0.333 | deer:0.892 | fox:0.750 | masked:0.526 | monkey:0.500 | mustelidae:0.836 | rabbit:0.812 | raccoondog:0.873 | serow:0.884 | squirrel:0.852

# St_capモデルで2024年度の外挿データをtest
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-16_23-16-14/checkpoints/best.pth
#結果
#[2026-02-16 23:40:38,524][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:40:38,525][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:40:38,615][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:40:40,845][src.testing_pipeline][INFO] - load checkpoint : epoch=43
#[2026-02-16 23:41:15,378][src.testing_pipeline][INFO] - test acc : 0.8695498704910278
#[2026-02-16 23:41:15,470][src.testing_pipeline][INFO] - class wise acc | bear:0.818 | bird:0.869 | boar:0.830 | cat:0.188 | deer:0.905 | fox:0.775 | masked:0.625 | monkey:0.467 | mustelidae:0.861 | rabbit:0.793 | raccoondog:0.870 | serow:0.704 | squirrel:0.794
