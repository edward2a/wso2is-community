SHELL = /bin/bash
BUILD_CONTAINER = wso2is-build:alp315-jdk11019

help:
	@echo -e "\n    Targets:\n"
	@echo -e "        build-container"
	@echo -e "        runtime-container"
	@echo -e "        2stage-container"
	@echo -e "        release-container"
	@echo -e "        wso2is-container"
	@echo -e "        clean\n"

build-container:
	docker build -t wso2is-build:alp315-jdk11019 -f containers/Dockerfile-build containers

runtime-container:
	@echo -e "\n\tTBD\n"

2stage-container:
	docker build -f Dockerfile-2stage ./ -t wso2is-multistage

release-container:
	@mkdir output && chmod g+s output
	docker run -ti --rm --name wso2is-build --user :$$(id -g) -e FS_USER=$$(id -u) -v "$${PWD}/scripts:/scripts" -v "$${PWD}/output:/output" $(BUILD_CONTAINER) /scripts/build_wso2is_alpine.sh

clean:
	rm -rf ./output
