## Swap manager

The goal of this container is setting up swap and managing it for the
host. On startup it will create a swap file of $SWAPSIZE gb and turn it
on for the host, when the container exits, it will turn it off.