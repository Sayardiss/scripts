#!/bin/bash
rsync -avzr -e "ssh -p 17222" root@185.169.235.5:/root/Download/ .
