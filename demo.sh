#!/bin/bash

## remove all containers and cache
docker rm $(docker ps -a -q)
docker rmi $(docker images -a -q)

cd Dropbox/JetBrains
git clone https://github.com/tonytonov/jbresearch
cd jbresearch

docker build --rm -t tonytonov/jbresearch .

## win:
docker create -p 8787:8787 -v /c/Users/Anton.Antonov/Dropbox/JetBrains/jbresearch:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined --name="jbresearch-instance" tonytonov/jbresearch
## linux:
docker create -p 8787:8787 -v /home/tonytonov/Dropbox/JetBrains/jbresearch:/home/rstudio/ -e ROOT=TRUE --security-opt seccomp:unconfined --name="jbresearch-instance" tonytonov/jbresearch

docker start jbresearch-instance
docker exec -it jbresearch-instance /bin/bash

cd /home/rstudio/jbresearch
./install_gdrive
gdrive about
## 4/kCeQskU6JB9DtU-6zVVMXpCle1Gwp7sw9tXdIA9o_bg
gdrive list | grep docx
make clean all
gdrive upload report/avian_whitepaper.docx
gdrive import report/avian_whitepaper.docx
make clean
git diff
