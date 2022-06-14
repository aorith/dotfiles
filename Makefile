.PHONY: bootstrap shell

bootstrap:
	./bootstrap.sh

shell:
	./bootstrap.sh shell
	./bootstrap.sh shell-private

scripts:
	./bootstrap.sh scripts
	./bootstrap.sh scripts-private
