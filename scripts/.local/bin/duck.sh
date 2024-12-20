mkdir -p ~/.local/log
echo url="https://www.duckdns.org/update?domains=joshsurber&token=b5aef6bb-afa1-42ef-b969-b4cbe91d36e1&ip=" | curl -k -o ~/.local/log/duck.log -K -
