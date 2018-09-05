FROM tensorflow/tensorflow:latest-gpu-py3 

RUN apt-get clean && \
    apt-get update && \
    apt-get install -y wget --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN wget https://repo.anaconda.com/archive/Anaconda3-5.2.0-Linux-x86_64.sh && \
    bash Anaconda3-5.2.0-Linux-x86_64.sh -b -p /root/anaconda

RUN . /root/anaconda/bin/activate && conda config --add channels conda-forge

WORKDIR /root
COPY conda.txt /root/
RUN anaconda/bin/conda create --name python3 --file conda.txt
COPY requirements.txt /root/
RUN /root/anaconda/envs/python3/bin/pip install -r requirements.txt

COPY . /root/

