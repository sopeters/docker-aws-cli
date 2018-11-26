FROM alpine:3.8

ARG AWS_CLI_VERSION
ENV AWS_CLI_VERSION=${AWS_CLI_VERSION}

ARG JP_VERSION
ENV JP_VERSION=${JP_VERSION}

RUN apk -v --no-cache --update add \
        python \
        py-pip \
        ca-certificates \
        groff \
        less \
        bash \
        make \
        curl \
        wget \
        zip \
        git \
        openssh-client \
        rsync \
        && \
    pip install --no-cache-dir --upgrade awscli==$AWS_CLI_VERSION && \
    update-ca-certificates && \
    apk -v --purge del py-pip
RUN curl -o /usr/local/bin/jp -L https://github.com/jmespath/jp/releases/download/$JP_VERSION/jp-linux-amd64 && \
    chmod +x /usr/local/bin/jp

VOLUME [ "/root/.aws" ]
VOLUME [ "/opt/app" ]
WORKDIR /opt/app

CMD ["aws", "--version"]
