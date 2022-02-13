# nomad-traefik

Traefik service for HashiCorp Nomad

You need [Shuttle](https://github.com/lunarway/shuttle) cli to use this repo.

The desired state is defined in `shuttle.yaml` and the plan in `plan.yaml`. 

Shuttle can be put in a container by
```
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

RUN apk add --update curl git && \
    rm -rf /var/cache/apk/*

RUN curl -LO https://github.com/lunarway/shuttle/releases/download/$(curl -Lso /dev/null -w %{url_effective} https://github.com/lunarway/shuttle/releases/latest | grep -o '[^/]*$')/shuttle-linux-amd64
RUN chmod +x shuttle-linux-amd64
RUN mv shuttle-linux-amd64 /usr/local/bin/shuttle

WORKDIR /tmp/shuttle/

USER docker

CMD ["shuttle"]
```

Build the container
```
docker build hoeghh/shuttle .
```

And an alias can be created via
```
alias shuttle="docker run -it -v $(pwd):/tmp/shuttle hoeghh/shuttle shuttle"
```

> If your scripts uses bash, then you need to install bash into the Alpine docker image for it to work

## Generate Nomad stanzas
```
shuttle run generate_hcl
```

This will create a folder called `.shuttle/temp/traefik/` with the generated HCL files. These can be deployed to Nomad.
