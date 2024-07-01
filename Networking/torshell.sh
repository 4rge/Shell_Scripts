#!/usr/bin/env BASH

ACTIVATE='. torsocks on'
TORRC="HashedControlPassword $torpass\nControlPort 9051\n"

if [ -z "$(command -v tor)" ] ; then
  sudo apt install tor -y
fi

sudo systemctl enable tor

if [ -z $(cat ".$(basename ${SHELL})rc" | grep $ACTIVATE) \ ; then
  :
else
  echo ". torsocks on" >> ~/.bashrc
  torpass=$(tor --hash-password "my-tor-password")
fi

printf $TORRC | sudo tee -a /etc/tor/torrc
