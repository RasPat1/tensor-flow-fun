Steps
-------
1. Export environment variables using ```source ~/.FILE_NAME```
1. Use getUrl script to get product images.
1. Then run bash script to download images
1. Use Tensorflow (TF) to build training and testing sets in TFRecord format
1. From TF rot dir build retrainer: ```bazel build -c opt --copt=-mavx tensorflow/examples/image_retraining:retrain```
1. Run to train ```bazel-bin/tensorflow/examples/image_retraining/retrain --image_dir /Users/Rasesh/Documents/repos/tensor-flow-fun/shoptiques-clothes/images```
1. Build Identifier ```bazel build tensorflow/examples/label_image:label_image```
1. Run Identifier ```bazel-bin/tensorflow/examples/label_image/label_image \
--graph=/tmp/output_graph.pb --labels=/tmp/output_labels.txt \
--output_layer=final_result \
--image=IMAGE_PATH
```

CUDA support
------------
* Development in progress may not work
* Download CUDA toolkit try to compile TF with CUDA support


Notes
-----
* Currently usinig highest level categories but goal is to have high success on second level categories
* TF needs the folder structure to be ```LABEL_NAME/IMAGE_NAME```
