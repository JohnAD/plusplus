#!/bin/bash

# cd web_petshop
# echo "======================================== ** WEB_PETSHOP"
# nim c -d:htmlfilename=index.html -d:jsfilename=index.js -r index.nim
# rm index
# echo "======================================== WEB HTML DONE"
# nim js -d:htmlfilename=index.html -d:jsfilename=index.js -d:release index.nim
# echo "======================================== JS Done"
# cd ..
cd api_main
echo "======================================== ** API_MAIN"
nim c -d:site=main main.nim
cd ..
