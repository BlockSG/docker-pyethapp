FROM ubuntu:17.10
RUN apt-get update
RUN apt-get install -y python-pip
RUN apt-get install -y python3-pip
RUN apt-get install -y git libssl-dev build-essential automake pkg-config libtool libffi-dev libgmp-dev libyaml-cpp-dev
RUN pip install virtualenv

# Download and install Pyethereum
WORKDIR /code
RUN git clone https://github.com/ethereum/pyethereum.git
WORKDIR /code/pyethereum
RUN python setup.py install

# Download and install PyDevP2P
WORKDIR /code
RUN git clone https://github.com/ethereum/pydevp2p.git
WORKDIR /code/pydevp2p
RUN python setup.py install

RUN pip install virtualenvwrapper

WORKDIR /code
RUN mkdir ve
WORKDIR /code/ve
RUN mkdir pyethapp
RUN virtualenv /code/ve/pyethapp
WORKDIR /code/ve/pyethapp/bin
RUN cd /code/ve/pyethapp/bin
RUN #!/bin/bash source activate .

# Download and install Pyethapp
WORKDIR /code
RUN git clone https://github.com/ethereum/pyethapp.git
WORKDIR /code/pyethapp
RUN python setup.py install
RUN pip install pyethapp==1.5.1a0

RUN pip uninstall -y scrypt
RUN pip install scrypt

RUN apt-get install -y pandoc
RUN pip install pandoc

RUN apt-get install -y software-properties-common
RUN apt-get update

RUN add-apt-repository -y ppa:ethereum/ethereum
RUN apt-get update
RUN apt-get install -y solc
RUN pip install py-solc
RUN pip install eth-testrpc

