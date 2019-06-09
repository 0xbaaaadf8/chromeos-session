.PHONY: default deb skip ch clean install

default: skip

all: skip

everything: doclean douninstall ch deb doinstall

ch:
	git-dch -R --auto -c --git-author

deb:
	git-buildpackage --git-ignore-new

doclean: 
	rm -rf ../build-area/* || exit 0

doinstall:
	sudo dpkg -i ../build-area/*.deb

douninstall:
	sudo dpkg -P chromeos-desktop

skip:
	echo "Tabularasa"
