CANDY-Red installation tests
===

[![GitHub release](https://img.shields.io/github/release/CANDY-LINE/candy-red-test.svg)](https://github.com/CANDY-LINE/ltepi2-service/releases/latest)
[![License MIT](https://img.shields.io/github/license/CANDY-LINE/candy-red-test.svg)](http://opensource.org/licenses/MIT)

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
(host) $ vagrant up
```

=> MAY fail (`E: Could not get lock /var/lib/dpkg/lock - open (11: Resource temporarily unavailable) ...`)

** Run the following 2 commands only when the first `vagrant up` fails: **

```
(host) $ vagrant up # => retry then VM is up
(host) $ vagrant reload # => vbguest plugin will work
```

After vagrant is up, run the following command to enter vagrant box.

```
(host) $ vagrant ssh
```

Move to `/vagrant`,

```
(vagrant) $ cd /vagrant
```

Then you can choose one of the following commands, the first one for running tests, and the other for entering bash mode.

```
(vagrant) $ time sudo test/run_tests.sh

(vagrant) $ time sudo SHELL=1 test/run_tests.sh
```

Docker installation is included in `Vagrantfile`.

## Revision History
* 1.0.0
  - Initial Release
  - Add Raspbian installation test
