#!/bin/bash

sudo -v && wget -nv -O- https://download.calibre-ebook.com/linux-installer.py | sudo python -c "import sys; main=lambda x:sys.stderr.write('Download failed\n'); exec(sys.stdin.read()); main('/opt')"


