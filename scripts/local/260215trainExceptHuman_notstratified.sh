# 再構築したデータで学習
conda env create -f=environment.yml
conda activate develop
# python train.py datamodule.data_source="/home/wildlife/TrainingMdetClassifier/data/detector_output-annotation_data_250530.csv" datamodule=detector

# エラーを吐いたが、以下の問題らしく、とりあえずchatGPTに従った。
pip install "torchmetrics<0.11"
# 0.11より大きいバージョンではエラーが出るので注意

# trainの実行
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_notstratified.csv" \
        datamodule=detector num_epochs=50

# testの実行
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_notstratified.csv" \
        datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_14-55-35/checkpoints/best.pth
#結果
#[2026-02-15 15:33:05,644][src.testing_pipeline][INFO] - Start testining!
#[2026-02-15 15:33:05,645][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-15 15:33:05,724][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-15 15:33:07,943][src.testing_pipeline][INFO] - load checkpoint : epoch=49
#[2026-02-15 15:33:18,549][src.testing_pipeline][INFO] - test acc : 0.9334151744842529
#[2026-02-15 15:33:18,635][src.testing_pipeline][INFO] - class wise acc | bear:0.802 | bird:0.635 | boar:0.934 | cat:0.375 | deer:0.969 | fox:0.787 | masked:0.765 | monkey:0.333 | mustelidae:0.663 | rabbit:0.100 | raccoondog:0.880 | serow:0.901 | squirrel:0.632

# not stratifiedtモデルで2024年度の外挿データをtest
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/testdata_260216.csv" \
        datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_14-55-35/checkpoints/best.pth
#結果
#[2026-02-16 23:43:51,959][src.testing_pipeline][INFO] - Start testining!
#[2026-02-16 23:43:51,960][src.testing_pipeline][INFO] - Instantiating dataset <src.datamodules.detector.DetectorDataModule>
#[2026-02-16 23:43:52,050][src.testing_pipeline][INFO] - Instantiating model <src.models.resnet.Classifire>
#[2026-02-16 23:43:54,329][src.testing_pipeline][INFO] - load checkpoint : epoch=49
#[2026-02-16 23:44:27,675][src.testing_pipeline][INFO] - test acc : 0.8405870795249939
#[2026-02-16 23:44:27,768][src.testing_pipeline][INFO] - class wise acc | bear:0.620 | bird:0.582 | boar:0.883 | cat:0.036 | deer:0.929 | fox:0.692 | masked:0.406 | monkey:0.000 | mustelidae:0.669 | rabbit:0.110 | raccoondog:0.752 | serow:0.575 | squirrel:0.332

