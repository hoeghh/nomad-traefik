# nomad-traefik

Traefik service for HashiCorp Nomad

You need [Shuttle](https://github.com/lunarway/shuttle) cli to use this repo.

The desired state is defined in `shuttle.yaml` and the plan in `plan.yaml`. 

Shuttle can be put in a container building the Dockerfile supplied in this root folder

Build the container
```
docker build hoeghh/shuttle .
```

And an alias can be created via
```
alias shuttle="docker run -it -v \$(pwd):/tmp/shuttle hoeghh/shuttle shuttle"
```

> If your scripts uses bash, then you need to install bash into the Alpine docker image for it to work

## Generate Nomad stanzas
```
shuttle run generate_hcl
```

This will create a folder called `.shuttle/temp/traefik/` with the generated HCL files. These can be deployed to Nomad.
