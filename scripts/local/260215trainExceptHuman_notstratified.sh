# 再構築したデータで学習
conda env create -f=environment.yml
conda activate develop
# python train.py datamodule.data_source="/home/wildlife/TrainingMdetClassifier/data/detector_output-annotation_data_250530.csv" datamodule=detector

# エラーを吐いたが、以下の問題らしく、とりあえずchatGPTに従った。
pip install "torchmetrics<0.11"
# 0.11より大きいバージョンではエラーが出るので注意

# trainの実行
python train.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_notstratified.csv" datamodule=detector num_epochs=50

# testの実行
python test.py datamodule.data_source="/home/ando/git/TrainingMdetClassifier/data/detector_output-annotation_data_260215_notstratified.csv" datamodule=detector ckpt_path=logs/experiments/runs/default/2026-02-15_14-55-35/checkpoints/best.pth