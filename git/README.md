# Git?

Git in containerized form in order to manage a repository. It expects a few things to be passed in:

- Your .ssh file mapped to /.ssh_host on the container with a valid id_rsa[.pub] key

It is recommended that you create a container based on this one and set the workdir correctly like:

```
FROM boomtownroi/git

WORKDIR /var/www/
```

then build it and use it `git run --volumes-from my_data_container -v ~/.ssh:/.ssh_host git fetch`