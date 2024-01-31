#
#  Author: Hari Sekhon
#  Date: 2021-01-18 18:15:39 +0000 (Mon, 18 Jan 2021)
#
#  vim:ts=4:sts=4:sw=4:noet
#
#  https://github.com/HariSekhon/Kubernetes-configs
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
build: init
	@echo "nothing to build"

.PHONY: init
init:
	git submodule update --init --recursive

.PHONY: bash-tools
bash-tools:
	@if ! command -v check_pytools.sh; then \
		curl -L https://git.io/bash-bootstrap | sh; \
	fi

# ========
# Polaris breaks on JSON Patches - target more specific YAMLs than the whole dir
#
#	https://github.com/FairwindsOps/polaris/issues/667
#
.PHONY: polaris
polaris:
	if command -v polaris &>/dev/null; then \
		polaris audit --audit-path "$$PWD" ---config ./polaris-config.yaml -f pretty --only-show-failed-tests ; \
	fi

.PHONY: docker-polaris
docker-polaris:
	if command -v docker &>/dev/null; then \
		docker run --rm -ti -v "$$PWD:/pwd" quay.io/fairwinds/polaris:4.2.0 polaris audit --audit-path /pwd -f pretty --config /pwd/polaris-config.yaml -f pretty --only-show-failed-tests ; \
	fi

# ========

.PHONY: pluto
pluto:
	if command -v pluto &>/dev/null; then \
		pluto detect-files -d . ; \
	fi

.PHONY: test
test: bash-tools
	check_pytools.sh

.PHONY: datree-kustomize
datree-kustomize:
	for kustomization in *-kustomization.yaml; do cp -v $$kustomization kustomization.yaml; datree kustomize test . -- --enable-helm || exit 1; done

.PHONY: wc
wc:
	find . -type f -name '*.yaml' -o -type f -name '*.json' | xargs wc -l

envrc:
	@echo "Check each .envrc NAMESPACE matches the namespace in the base namespace.yaml or kustomization.yaml"
	@for base in */base; do \
		app="$${base%/base}"; \
		overlay="$$app/overlay"; \
		if [ "$$base" = fluxcd/base ]; then \
			continue; \
		fi; \
		BASE_NAMESPACE="$$(grep "NAMESPACE="  "$$base/.envrc"    | sed 's/.*=// ; s/"//g' | sed "s/'//g")"; \
		if [ -d "$$overlay" ]; then \
			OVERLAY_NAMESPACE="$$(grep "NAMESPACE=" "$$overlay/.envrc" | sed 's/.*=// ; s/"//g' | sed "s/'//g")"; \
		fi; \
		namespace="$$( \
		    if [ -f "$$base/namespace.yaml" ]; then \
		        grep "name:" "$$base/namespace.yaml"; \
		    elif [ -f "$$base/kustomization.yaml" ]; then \
		        grep -m1 "^[[:space:]]*namespace:" "$$base/kustomization.yaml" || \
				kustomize build --enable-helm "$$base" | \
				grep "^[[:space:]]*namespace:" | \
				awk '{print $$2}' | \
				sort | \
				uniq -c | \
				sort -r | \
				head -n 1; \
		    fi | \
		    awk '{print $$2}' \
		)"; \
		if [ "$$BASE_NAMESPACE" != "$$namespace" ]; then \
			echo "$$app: base: '$$BASE_NAMESPACE' != '$$namespace'"; \
			echo; \
		fi; \
		if [ -d "$$overlay" ]; then \
			if [ "$$OVERLAY_NAMESPACE" != "$$namespace" ]; then \
				echo "$$app: overlay: '$$BASE_NAMESPACE' != '$$namespace'"; \
				echo; \
			fi; \
		fi; \
	done
	@echo
	@if type -P check_bash_syntax.sh >/dev/null 2>&1; then \
		check_bash_syntax.sh $$(find . -type f -name .envrc); \
	fi

clean:
	find . -type d -name charts -exec rm -fr {} \;
	find . -type f -name kustomization.materialized.yaml -exec rm -f {} \;
