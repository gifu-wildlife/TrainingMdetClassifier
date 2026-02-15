scp data/detector_output-annotation_data_250530.csv ando@10.224.202.53:~/git/TrainingMdetClassifier/data/
scp data/detector_output-annotation_data_260213.csv ando@10.224.202.53:~/git/TrainingMdetClassifier/data/

data/ensyurin_MachineLearning/ensyurin-crop

rsync -avzP -e ssh data/ensyurin_MachineLearning/ensyurin-crop ando@10.224.202.53:~/git/TrainingMdetClassifier/data/ensyurin_MachineLearning/
