# nomad-traefik

Traefik service for HashiCorp Nomad

You need [Shuttle](https://github.com/lunarway/shuttle) cli to use this repo.

The desired state is defined in `shuttle.yaml` and the plan in `plan.yaml`. 

## Generate Nomad stanzas
```
shuttle run generate_hcl
```

This will create a folder called `.shuttle/temp/traefik/` with the generated HCL files. These can be deployed to Nomad.
