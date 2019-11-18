# Running Tensorflow on Docker

## Setting up Nvidia-Docker (only for GPU)

In a machine running Ubuntu 16.04 (64). Install CUDA

```bash
apt-get update
wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
dpkg -i cuda-repo-ubuntu1604_10.0.130-1_amd64.deb

# the cuda 10.0 key
apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub

# install it!
apt-get update
apt-get install cuda
```

Then, install Docker

```bash
# Uninstall old versions
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install Docker
apt-get update

apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -

add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

apt-get update

apt-get install docker-ce docker-ce-cli containerd.io

# Test install
docker run hello-worldx
```

Finally, install nvidia-docker (version 2)

```bash
# Add package repositories
curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
  sudo apt-key add -

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list

apt-get update

# Install nvidia-docker2 and reload Docker daemon configuration
apt-get install -y nvidia-docker2
pkill -SIGHUP dockerd

# Test install
docker run --runtime=nvidia --rm nvidia/cuda nvidia-smi
```

## Run Docker container

Download happy-walrus GitHub repo.

```bash
cd /
git clone https://github.com/r5cm/happy-walrus.git
```

Build docker image.

```bash
cd /happy-walrus/tensorflow/docker

# If running on GPU
docker build -f Dockerfile.tf_1_15_gpu -t tf_1_15_gpu . 

# If running on CPU
docker build -f Dockerfile.tf_1_15_cpu -t tf_1_15_cpu . 
```

Run Docker container

```bash
# If running on GPU
docker run -it -p 8888:8888 -p 6006:6006 --runtime=nvidia --name tf_1_15_gpu -v /happy-walrus:/happy-walrus tf_1_15_gpu

# If running on CPU
docker run -it -p 8888:8888 -p 6006:6006 --name tf_1_15_cpu -v /happy-walrus:/happy-walrus tf_1_15_cpu
```

Inside the container run Jupyter Notebook.

```bash
~/.local/bin/jupyter-notebook --ip=0.0.0.0 --allow-root --notebook-dir=/happy-walrus/
```
