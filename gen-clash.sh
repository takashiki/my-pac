#!/bin/bash
cat ./my-rules.txt > my-clash.txt
sed -i "s/^/  - '+/g" my-clash.txt
sed -i "s/$/'/g" my-clash.txt
sed -i '1i\payload:' my-clash.txt
