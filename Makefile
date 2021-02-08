#
#  Author: Hari Sekhon
#  Date: 2021-01-18 18:15:39 +0000 (Mon, 18 Jan 2021)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/HariSekhon/Kubernetes-templates
#
#  If you're using my code you're welcome to connect with me on LinkedIn and optionally send me feedback to help steer this or other code I publish
#
#  https://www.linkedin.com/in/HariSekhon
#

SHELL = /usr/bin/env bash

PATH := $(PATH):$(PWD)/bash-tools

.PHONY: default
default: build
	@:

.PHONY: build
build:
	@echo "nothing to build"

.PHONY: bash-tools
bash-tools:
	@if ! command -v check_pytools.sh; then \
		curl -L https://git.io/bash-bootstrap | sh; \
	fi

.PHONY: test
test: bash-tools
	check_pytools.sh

.PHONY: wc
wc:
	find . -type f -name '*.yaml'  | xargs wc -l
