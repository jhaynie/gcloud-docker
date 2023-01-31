FROM golang:1.19-alpine as builder

ENV GCLOUD_VERSION 412.0.0

RUN apk add curl

RUN cd /tmp && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-cli-${GCLOUD_VERSION}-linux-x86_64.tar.gz && \
	 tar xfv google-cloud-cli-412.0.0-linux-x86_64.tar.gz && \
	 rm -rf /tmp/google-cloud-sdk/rpm && rm -rf /tmp/google-cloud-sdk/deb && \
	 rm -rf /tmp/google-cloud-sdk/RELEASE_NOTES && \
	 rm -rf google-cloud-cli-412.0.0-linux-x86_64.tar.gz

RUN apk add python3

ENV PATH $PATH:/tmp/google-cloud-sdk/bin

ENV GOOGLE_APPLICATION_CREDENTIALS /google.json

RUN /tmp/google-cloud-sdk/install.sh -q && \
	gcloud components install beta && \
	gcloud components remove bq && \
	apk del curl && \
	rm -rf /tmp/google-cloud-sdk/.install
