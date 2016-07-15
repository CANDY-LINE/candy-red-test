CANDY-Red installation tests
===

# Prerequisites

 * Vagrant v1.8.4+
 * vagrant-vbguest v0.12.0+([Use `export ARCHFLAGS=-Wno-error=unused-command-line-argument-hard-error-in-future` for Mac users](https://github.com/devopsgroup-io/vagrant-digitalocean/issues/232))

# Debian/Ubuntu/CentOS/EL

**Manually install Docker on your Linux prior to running the following script**

```
$ sudo ./run_test.sh
```

# Mac/Windows

Use Vagrant in order to mount OS file images.

```
(host) $ vagrant up # => may fail (E: Could not get lock /var/lib/dpkg/lock - open (11: Resource temporarily unavailable) ...)
 ** Run the following 2 commands when the first vagrant up fails: **
(host) $ vagrant up # => retry then VM is up
(host) $ vagrant reload # => vbguest plugin will work


(host) $ vagrant ssh

(vagrant) $ cd /vagrant
(vagrant) $ time sudo test/run_tests.sh
```

Docker installation is included in `Vagrantfile`.
