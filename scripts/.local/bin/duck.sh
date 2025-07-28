#! /bin/bash
mkdir -p ~/.local/log
echo url="https://www.duckdns.org/update?domains=joshsurber&token=${DUCKDNS}=" | curl -k -o ~/.local/log/duck.log -K -
