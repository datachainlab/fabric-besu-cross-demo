# Demo

## Requirements

- [Go](https://go.dev/) 1.16–1.18
- [Docker](https://www.docker.com/products/docker-desktop)
- [jq](https://stedolan.github.io/jq/)
- Node.js v12-v16

## Testing the demo

This demo is primarily developed and validated on **Go 1.18**, and is supported on **Go 1.16–1.18**.  
**Go 1.19 and later may exhibit unstable behavior** due to dependency and runtime differences.  
To ensure a reproducible setup, we **strongly recommend Go 1.18**.

```
# 1) Build artifacts and tools
make build

# 2) Start local networks (Besu / Fabric / Proxy)
make network

# 3) Run demo scenarios
make demo
```

## Tear Down / Clean

```
# Stop networks and clean up
make network-down

# Clean generated files only
make clean
```
