#
#  Author: Hari Sekhon
#  Date: 2022-05-16 15:06:57 +0100 (Mon, 16 May 2022)
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

.PHONY: *
default: build
	@:

build:
	@# symlinks don't work with Kustomize
	@#ln -svf ../../buildkite* .
	cp -avf ../../buildkite* .
	@# refuses to use a symlink
	cat buildkite-kustomization.yaml > kustomization.yaml
	kubectl config use-context docker-desktop
	kubectl create ns buildkite || :
	kubectl config set-context docker-desktop --namespace buildkite
	kubectl delete secret buildkite-agent-token || :
	kubectl_kv_to_secret.sh buildkite buildkite-agent-token buildkite-agent-token="$$BUILDKITE_AGENT_TOKEN"
	kustomize build | kubectl apply -f -

clean:
	rm -f *.yaml
	kubectl delete ns buildkite
