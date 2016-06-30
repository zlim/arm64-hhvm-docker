HHVM_PATH := /git/hhvm

BASE_IMAGE_URL := http://cdimage.ubuntu.com/ubuntu-base/releases/16.04/release/ubuntu-base-16.04-core-arm64.tar.gz
BASE_IMAGE := ./ubuntu-base-16.04-core-arm64.tar.gz

LIBBOOST_URL := http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2
LIBBOOST := ./boost_1_61_0.tar.bz2

IMAGETAG := zlim/arm64-ubuntu-hhvm

.PHONY: build
build: $(BASE_IMAGE) $(LIBBOOST)
	docker build \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg LIBBOOST=$(LIBBOOST) \
		-t $(IMAGETAG) .

$(BASE_IMAGE):
	wget $(BASE_IMAGE_URL)

$(LIBBOOST):
	wget $(LIBBOOST_URL)

.PHONY: run
run:
	docker run -it --rm -v $(HHVM_PATH):$(HHVM_PATH) $(IMAGETAG)

