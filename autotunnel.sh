#!/bin/bash
/usr/bin/ssh -fqN -R 17218:localhost:22 root@185.169.235.5 -p 17222
if [[ $? -eq 0 ]]; then
    echo Tunnels to machineB has been created successfully
else
    echo An error occurred creating a tunnel to machineB RC was $?
fi
