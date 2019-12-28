#!/bin/bash

if [ -z "$1" ] ; then
  echo "Please Provide Required Input"
  exit 0;
fi

status=$(systemctl status $1 | grep Active | awk '{print $2}')
inactive="inactive"

if [ $status == $inactive ]; then
  echo "NOOOOOO, you've been Claptrapped!"
else
  echo "AANNNDDDD your status is $status"
fi
  
