# To run container, CD into happy_walrus main folder and run "docker run -it -p 8888:8888 --name tf_cpu -v $pwd/tensorflow:/walrus tf_cpu"

# FROM tensorflow/tensorflow:latest-py3
FROM tensorflow/tensorflow:1.15.0-py3
ENV DEBIAN_FRONTEND=noninteractive

# Install python libraries
RUN apt update
RUN apt-get update && apt-get install -y protobuf-compiler python-pil python-lxml python-tk
RUN pip3 install --upgrade pip
RUN pip3 install --user Cython
RUN pip3 install --user contextlib2
RUN pip3 install --user jupyter
RUN pip3 install --user matplotlib
RUN pip3 install --user pillow
RUN pip3 install --user pandas

# Dowload tensorflow/model files
RUN apt-get install -y git
RUN git clone https://github.com/tensorflow/models.git

# Install pycocotools
RUN apt install python-setuptools
RUN git clone https://github.com/cocodataset/cocoapi.git 
RUN cd cocoapi/PythonAPI && make
RUN cd cocoapi/PythonAPI && cp -r pycocotools /models/research

# Compile protocol buffer description files to Python and export path 
RUN cd /models/research && protoc object_detection/protos/*.proto --python_out=. 

# Run following lines inside container
# export PYTHONPATH=$PYTHONPATH:/models/research:/models/research/slim
# cd /models/research/object_detection
# apt update
# apt-get install wget
# apt-get install zip
# wget "http://download.tensorflow.org/models/object_detection/faster_rcnn_inception_v2_coco_2018_01_28.tar.gz"
# tar xvzf faster_rcnn_inception_v2_coco_2018_01_28.tar.gz
# wget -O ./windows_10_tutorial.zip "https://github.com/EdjeElectronics/TensorFlow-Object-Detection-API-Tutorial-Train-Multiple-Objects-Windows-10/archive/master.zip"
# unzip windows_10_tutorial.zip
# rm TensorFlow-Object-Detection-API-Tutorial-Train-Multiple-Objects-Windows-10-master/README.md
# mv TensorFlow-Object-Detection-API-Tutorial-Train-Multiple-Objects-Windows-10-master/* .
# ~/.local/bin/jupyter-notebook --ip=0.0.0.0 --allow-root