#!/bin/bash
autossh -M 0 -o "ServerAliveInterval 30" -o "ServerAliveCountMax 3" -N -R 17218:localhost:22 root@185.169.235.5 -p 17222
