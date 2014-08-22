Scalr Docker
============

A repository of scripts to use Docker with Scalr.


Usage
=====

We recommend using those scripts with Scalarizr 2.9.31's "Script URI"
functionality, which lets you run a script by passing its URL, but you
can also copy them as Scalr Scripts.

To use Docker with Scalr, you'll need to create a new Role and add the
three following scripts. You'll also need to define a `CRANE_FILE_URL` Global
Variable, as explained below.


Install Docker
--------------

Use the script at `https://get.docker.io/` to install Docker itself.


Install Crane
-------------

We recommend using Crane for deployments. Crane is a lightweight wrapper
around Docker, which parses a configuration file and generates the
appropriate `docker pull` and `docker run` commands

Install Crane with the `install-crane.sh` script found in this repository.

Note that this script is designed to work on Debian / Ubuntu. Slight changes
would be required to make it work on RHEL / CentOS.


Run Crane
---------

Run Crane with the `run-crane.sh` script found in this repository. You'll
need to create a `CRANE_FILE_URL` and point it to a suitable Crane file for
this to work (see below for more information).


The Crane file
==============

The "Crane file" tells Crane how it should run your Docker application. It
defines the image Crane should use, the ports that should be exposed, the
volumes that should be mounted, etc.

A sample can be found in the examples in this repository. It'll deploy our
"3 Tier Webapp".
