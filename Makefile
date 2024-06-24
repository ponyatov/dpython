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
TEST   = $(DUB) test  --compiler=$(DC)

# package
DMD_DEB = dmd_$(DMD_VER)-0_amd64.deb

# src
C += $(wildcard src/*.c*)
H += $(wildcard inc/*.h*)
D += $(wildcard src/*.d)
P += $(wildcard lib/*.py)
S  = $(C) $(H) $(D) $(P)

# all
.PHONY: all run test
all: $(S)
	$(BLD)
run: $(S)
	$(RUN) -- $(P)
test: $(S)
	$(TEST)

# format
.PHONY: format
format: tmp/format_c tmp/format_d
tmp/format_c: $(C) $(H)
	$(CF) -i $? && touch $@
tmp/format_d: $(D)
	$(RUN) dfmt -- -i $? && touch $@

# install
.PHONY: install update ref gz
install: ref gz $(DUB)
	$(MAKE) update
update:
	sudo apt update
	sudo apt install -uy `cat apt.txt`
ref: \
	ref/micropython/README.md

ref/micropython/README.md:
	git clone --depth 1 https://github.com/micropython/micropython.git ref/micropython

gz:

$(DUB): $(DISTR)/Linux/tools/$(DMD_DEB)
	sudo dpkg -i $< && sudo touch $@
$(DISTR)/Linux/tools/$(DMD_DEB):
	$(CURL) $@ https://downloads.dlang.org/releases/2.x/$(DMD_VER)/$(DMD_DEB)
