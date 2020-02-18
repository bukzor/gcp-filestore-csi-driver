# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# (bukzor@ 2019-01-22)
#PROJECT=gchips-cloud-infra-224518
PROJECT=gchips-dev-bukzor
VERSION=v0.1.0-gchips1
###

IMAGE=gcr.io/$(PROJECT)/gcp-filestore-csi-driver

ifeq ($(VERSION),)
	VERSION=latest
endif

all: image

image: 
	docker build --build-arg TAG=$(VERSION) -t $(IMAGE):$(VERSION) .

local:	
	mkdir -p bin
	go build -ldflags "-X main.vendorVersion=${VERSION}" -o bin/gcfs-csi-driver ./cmd/

push:
	docker push $(IMAGE):$(VERSION)

skaffold-dev:
	skaffold dev -f deploy/skaffold/skaffold.yaml
