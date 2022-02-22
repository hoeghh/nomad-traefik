FROM alpine:3.14

ENV USER=docker
ENV GROUP=docker
ENV UID=1000

RUN addgroup -g "$UID" "$GROUP"

RUN adduser \
    --disabled-password \
    --gecos "" \
    --home "/tmp/shuttle/" \
    --ingroup "$GROUP" \
    --no-create-home \
    --uid "$UID" \
    "$USER"

RUN apk add --update curl git bash && \
    rm -rf /var/cache/apk/*

RUN curl -LO https://github.com/lunarway/shuttle/releases/download/$(curl -Lso /dev/null -w %{url_effective} https://github.com/lunarway/shuttle/releases/latest | grep -o '[^/]*$')/shuttle-linux-amd64
RUN chmod +x shuttle-linux-amd64
RUN mv shuttle-linux-amd64 /usr/local/bin/shuttle

WORKDIR /tmp/shuttle/

USER docker

CMD ["shuttle"]
