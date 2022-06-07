FROM tdp-builder:latest

RUN apt-get -q update \
    && apt-get -q install -y --no-install-recommends \
    libkrb5-dev \
    python-dev \
    python3-dev

RUN pip2 install \
    flake8 \
    flaky \
    pytest \
    pytest-runner \
    'setuptools<36' \
    'cloudpickle>=0.2.1' \
    'configparser>=3.5.0' \
    'future>=0.15.2' \
    'futures>=3.0.5' \
    'mock~=3.0.5' \
    'requests>=2.10.0' \
    'responses>=0.5.1' \
    'requests-kerberos>=0.11.0'


RUN pip3 install \
    cloudpickle \
    flaky \
    pytest \
    pytest-runner \
    'setuptools<36' \
    'cloudpickle>=0.2.1' \
    'configparser>=3.5.0' \
    'future>=0.15.2' \
    'futures>=3.0.5' \
    'mock~=3.0.5' \
    'requests>=2.10.0' \
    'responses>=0.5.1' \
    'requests-kerberos>=0.11.0'

RUN update-alternatives --set java /usr/lib/jvm/java-8-openjdk-amd64/jre/bin/java
