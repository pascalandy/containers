## Swap manager

The goal of this container is setting up swap and managing it for the
host. On startup it will create a swap file of $SWAPSIZE gb and turn it
on for the host, when the container exits, it will turn it off.

## Running the container

``` sh
docker run --privileged -e SWAPSIZE=1 -it boomtownroi/swap-manager:latest
```

Where SWAPSIZE is the number of GB to set aside for swap.

## Caveats

This will not work on `docker for mac` or `docker for windows`, however,
seems to work fine on regular linux hosts.
