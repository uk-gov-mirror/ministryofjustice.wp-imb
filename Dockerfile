FROM ministryofjustice/wordpress-base:latest

ADD . /bedrock

WORKDIR /bedrock

ARG COMPOSER_USER
ARG COMPOSER_PASS

RUN echo "{ \"allow_root\": true }" > /root/.bowerrc

# Set execute bit permissions before running build scripts
RUN chmod +x bin/* && sleep 1 && \
    make clean && \
    bin/composer-auth.sh && \
    make build && \
    rm -f auth.json
