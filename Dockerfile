FROM ubuntu:20.04
RUN apt update && \
    apt install nano -y && \
    apt install wget -y && \
    apt install software-properties-common -y && \
    apt-add-repository ppa:ansible/ansible && \
    apt install -y gnupg software-properties-common curl && \
    curl -fsSL https://apt.releases.hashicorp.com/gpg | apt-key add -  && \
    apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"  && \
    apt update  && \
    apt install awscli -y  && \
    apt install terraform -y  && \
    apt install ansible -y && \
    apt install git -y   && \
    ansible-galaxy collection install amazon.aws&& \
    apt install python3-boto3 -y && \
    apt-get -y install python3-distutils && \
    wget https://bootstrap.pypa.io/get-pip.py -O /tmp/get-pip.py && \
    python3 /tmp/get-pip.py
