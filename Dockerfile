FROM ubuntu:16.04

# Install shell utils
RUN apt-get update && apt-get -yq dist-upgrade && \
    apt-get install -yq --no-install-recommends \
    zsh sudo wget locales git vim tree screen bzip2 gcc make htop unzip curl apt-transport-https\
    build-essential ca-certificates fonts-liberation inkscape jed libsm6 \
    libxext-dev libxrender1 lmodern pandoc python-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# To set up a clean UTF-8 environment/locale in Linux
RUN echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    sudo dpkg-reconfigure locales && \
    echo "LC_ALL=en_US.UTF-8\nLANG=en_US.UTF-8" >> /etc/default/locale && \
    #needs to run again!
    sudo locale-gen "en_US.UTF-8"

# Set up Environemnt Variable :
ENV LC_ALL=en_US.UTF-8 \
    LANG=en_US.UTF-8 \
    LANGUAGE=en_US.UTF-8 \
    CONDA_DIR=/opt/conda

########################################################################################################################
############################################# MiniConda + Python Libraries##############################################
########################################################################################################################

# Copy Files into Docker Container
COPY requirements-conda.txt .

RUN wget -q https://repo.continuum.io/miniconda/Miniconda3-4.5.11-Linux-x86_64.sh -O /tmp/miniconda.sh  && \
    bash /tmp/miniconda.sh -f -b -p $CONDA_DIR && \
    $CONDA_DIR/bin/conda update -n base conda && \
    $CONDA_DIR/bin/conda config --system --prepend channels conda-forge && \
    $CONDA_DIR/bin/conda config --system --set auto_update_conda false && \
    $CONDA_DIR/bin/conda config --system --set show_channel_urls true && \
    $CONDA_DIR/bin/conda update --all --quiet --yes && \
    $CONDA_DIR/bin/conda install --yes -c conda-forge --file requirements-conda.txt && \
    $CONDA_DIR/bin/conda clean -tipsy && \
    rm -rf /root/.cache/yarn && \
    rm /tmp/miniconda.sh && \
    rm requirements-conda.txt

RUN $CONDA_DIR/bin/conda install -c fastai fastai
ENV PATH=$CONDA_DIR/bin:$PATH

########################################################################################################################
########################## Installing GCP libraries ####################################################################
########################################################################################################################

RUN pip install -U pip
COPY requirements-pip.txt /root/requirements-pip.txt
RUN pip install -r /root/requirements-pip.txt && \
    rm /root/requirements-pip.txt

########################################################################################################################
########################## Installing gsutil as part of the Google Cloud SDK ###########################################
########################################################################################################################

#ENV CLOUD_SDK_REPO="cloud-sdk-$(lsb_release -c -s)"
#RUN echo "deb http://packages.cloud.google.com/apt $CLOUD_SDK_REPO main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
#RUN curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
#RUN sudo apt-get update && sudo apt-get install google-cloud-sdk

########################################################################################################################
########################## Copy files ###########################################
########################################################################################################################

RUN mkdir -p coral_ai
RUN mkdir -p gcp_conf
RUN mkdir -p src

COPY /gcp_conf /gcp_conf/.
COPY /coral-ai-master /coral-ai-master/.
COPY /src /src/.

## Set environment variable for google autentificate
ENV GOOGLE_APPLICATION_CREDENTIALS="/gcp_conf/gcp_conf.json"
WORKDIR /coral-ai-master s
