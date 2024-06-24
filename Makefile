# version
DMD_VER = 2.109.0

# dirs
DISTR = $(HOME)/distr

# tool
CURL   = curl -L -o
CF     = clang-format -style=file
DUB    = /usr/bin/dub
DMD    = /usr/bin/dmd
DC     = $(DMD)
RUN    = $(DUB) run   --compiler=$(DC)
BLD    = $(DUB) build --compiler=$(DC)

# package
DMD_DEB = dmd_$(DMD_VER)-0_amd64.deb

# install
.PHONY: install update ref gz
install: ref gz $(DUB)
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
ref:
gz:

$(DUB): $(DISTR)/Linux/tools/$(DMD_DEB)
	sudo dpkg -i $< && sudo touch $@
$(DISTR)/Linux/tools/$(DMD_DEB):
	$(CURL) $@ https://downloads.dlang.org/releases/2.x/$(DMD_VER)/$(DMD_DEB)
