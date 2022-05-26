#!/bin/#!/usr/bin/env bash
if [ -f ~/.fetchmailrc -a -f ~/.procmailrc ]; then

fetchmail -d 300 -N -kv -vv

else
  echo "ERROR: /var/lib/fetchmail/.fetchmailrc or /var/lib/fetchmail/.procmailrc not found."
fi
