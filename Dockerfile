FROM registry.access.redhat.com/ubi8/ubi

RUN curl -L https://github.com/stedolan/jq/releases/download/jq-1.6/jq-linux64 -o /usr/bin/jq &&\
    curl -L https://github.com/mikefarah/yq/releases/download/v4.25.1/yq_linux_amd64 -o /usr/bin/yq &&\
    curl -L https://dl.k8s.io/release/v1.25.0/bin/linux/amd64/kubectl -o /usr/bin/kubectl &&\
    chmod +x /usr/bin/jq /usr/bin/yq /usr/bin/kubectl

RUN dnf -y --setopt=tsflags=nodocs install \
    git \
    skopeo \
    krb5-workstation \
    && dnf clean all

# Set HOME variable to something else than `/` to avoid 'permission denied' problems when writing files.
ENV HOME=/tekton/home
