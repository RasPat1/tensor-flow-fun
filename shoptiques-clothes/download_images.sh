#!/bin/bash
find . -name urls.txt -execdir sh -c "xargs -n 1 curl -O < urls.txt" \;
