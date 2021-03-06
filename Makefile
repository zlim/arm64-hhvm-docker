BASE_IMAGE_URL := http://cdimage.ubuntu.com/ubuntu-base/releases/16.04/release/ubuntu-base-16.04-core-arm64.tar.gz
BASE_IMAGE := ./ubuntu-base-16.04-core-arm64.tar.gz

#LIBBOOST_URL := http://downloads.sourceforge.net/project/boost/boost/1.61.0/boost_1_61_0.tar.bz2
#LIBBOOST := ./boost_1_61_0.tar.bz2

LIBBOOST_URL := http://downloads.sourceforge.net/project/boost/boost/1.60.0/boost_1_60_0.tar.bz2
LIBBOOST := ./boost_1_60_0.tar.bz2

IMAGETAG := zlim/arm64-ubuntu-hhvm

.PHONY: build
build: $(BASE_IMAGE) $(LIBBOOST)
	docker build --no-cache \
		--build-arg BASE_IMAGE=$(BASE_IMAGE) \
		--build-arg LIBBOOST=$(LIBBOOST) \
		-t $(IMAGETAG) .

.PHONY: push
push:
	docker push $(IMAGETAG)

$(BASE_IMAGE):
	wget $(BASE_IMAGE_URL)

$(LIBBOOST):
	wget $(LIBBOOST_URL)

HHVM_PATH := /git/hhvm
CONTAINER_HHVM_PATH := /git/hhvm
DOCKER_OPTS := -v $(HHVM_PATH):$(CONTAINER_HHVM_PATH) -w $(CONTAINER_HHVM_PATH)

CMAKE_BUILD_TYPE := Release
DOCKER_OPTS += -e CMAKE_BUILD_TYPE=$(CMAKE_BUILD_TYPE)
BUILD_SH := $(PWD)/build_hhvm.sh
CONTAINER_BUILD_SH := /tmp/build_hhvm.sh
DOCKER_OPTS += -v $(BUILD_SH):$(CONTAINER_BUILD_SH):ro

CLEAN_SH := $(PWD)/clean_hhvm.sh
CONTAINER_CLEAN_SH := /tmp/clean_hhvm.sh
DOCKER_OPTS += -v $(CLEAN_SH):$(CONTAINER_CLEAN_SH):ro

.PHONY: run
run:
	docker run -it --rm $(DOCKER_OPTS) $(IMAGETAG)

.PHONY: hhvm
hhvm:
	docker run --rm $(DOCKER_OPTS) $(IMAGETAG) -x $(CONTAINER_BUILD_SH)

.PHONY: clean
clean:
	docker run --rm $(DOCKER_OPTS) $(IMAGETAG) -x $(CONTAINER_CLEAN_SH)

.PHONY: get
get:
	HHVM_PATH=$(HHVM_PATH) bash -ex get_hhvm.sh

HPHP_TEST := quick
DOCKER_OPTS += -e HPHP_TEST=$(HPHP_TEST)
TEST_SH := $(PWD)/test_hhvm.sh
CONTAINER_TEST_SH := /tmp/test_hhvm.sh
DOCKER_OPTS += -v $(TEST_SH):$(CONTAINER_TEST_SH):ro

.PHONY: test
test:
	#HHVM_PATH=$(HHVM_PATH) HPHP_TEST=$(HPHP_TEST) bash -ex test_hhvm.sh
	docker run --rm $(DOCKER_OPTS) $(IMAGETAG) -x $(CONTAINER_TEST_SH)

.PHONY: summary
summary:
	HHVM_PATH=$(HHVM_PATH) bash -e summary_hhvm.sh

