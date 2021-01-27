FROM docker:18.09.2

RUN apk add --no-cache \
    curl \
    bash \
    coreutils \
    git \
    python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    pip3 install --upgrade --no-cache-dir pip setuptools && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi

ENV HELM_VERSION="v3.4.2"
ENV SKAFFOLD_VERSION="v1.17.2"
ENV AWS_CLI_VERSION="1.18.201"

RUN wget -q https://get.helm.sh/helm-${HELM_VERSION}-linux-amd64.tar.gz -O - | tar -xzO linux-amd64/helm > /usr/local/bin/helm \
    && chmod +x /usr/local/bin/helm

RUN curl -Lo skaffold https://storage.googleapis.com/skaffold/releases/${SKAFFOLD_VERSION}/skaffold-linux-amd64 \
    && install skaffold /usr/local/bin/

RUN pip -Iv install awscli==${AWS_CLI_VERSION}

VOLUME ["/root/.config"]
CMD bash