BASE:=$(realpath $(dir $(lastword $(MAKEFILE_LIST))))
DOCKER_IMAGE?=ubuntu-embedded
DOCKER_SERVICE?=$(notdir $(DOCKER_IMAGE))
DOCKER_NAMESPACE?=$(shell dirname $(DOCKER_IMAGE))
DOCKER_COMMAND?=bash

include $(BASE)/ve-root/Makefile

