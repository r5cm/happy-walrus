FROM tensorflow/tensorflow:latest-gpu-py3-jupyter

ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt-get update && apt-get install -y protobuf-compiler python-pil python-lxml python-tk
RUN pip3 install --upgrade pip
RUN pip3 install --user Cython
RUN pip3 install --user contextlib2
RUN pip3 install --user jupyter
RUN pip3 install --user matplotlib
RUN mkdir /tensorbin
RUN apt-get install -y git

RUN git clone https://github.com/tensorflow/models.git
RUN apt install python-setuptools
RUN rm -f /usr/bin/python
RUN ln -s /usr/bin/python3 /usr/bin/python
RUN pip3 install cython
RUN mkdir /usr/local/coco
RUN cd /usr/local/coco
RUN git clone https://github.com/cocodataset/cocoapi.git 
RUN cd PythonAPI
RUN make
RUN cp -r pycocotools /models/research

RUN protoc object_detection/protos/*.proto --python_out=.
RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim

#RUN git clone https://github.com/cocodataset/cocoapi.git
#RUN cd cocoapi/PythonAPI
#RUN make
#RUN cp -r pycocotools /models/research/
#RUN cd /models/research
#RUN protoc object_detection/protos/*.proto --python_out=.
#RUN export PYTHONPATH=$PYTHONPATH:`pwd`:`pwd`/slim
