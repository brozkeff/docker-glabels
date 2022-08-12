FROM ubuntu:18.04

RUN sudo cp /etc/apt/sources.list /etc/apt/sources.list~ && \
    sudo sed -Ei 's/^# deb-src /deb-src /' /etc/apt/sources.list

RUN apt-get update && \
    apt-get install -y \
	libxml2-dev \
	intltool \
	itstool \
	libxml2-utils \
	libgtk-3-dev \
	librsvg2-dev \
	libqrencode-dev \
	wget \
	gnome-common \
	fonts-roboto \
	tex-gyre && \
    apt-get build-dep -y \
        glabels

RUN wget https://github.com/brozkeff/glabels/archive/refs/tags/glabels-3_4_1b_batchcollate.tar.gz \ 
	-O glabels.tar.gz && \
	tar xvf glabels.tar.gz

WORKDIR /glabels-glabels-3_4_1b_batchcollate/

RUN ./autogen.sh && \
	make && \
	make install && \
	ldconfig

RUN useradd -m glabels

USER glabels

WORKDIR /home/glabels

ENTRYPOINT glabels-3
