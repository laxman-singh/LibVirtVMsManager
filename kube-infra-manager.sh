#!/bin/sh

function do_some_magic() {
  op=$1
  lib_virtd_op=$1

  if [[ "$1" == "shutdown" ]]; then
    lib_virtd_op='stop' 
  fi
  

  echo "Performing libvirtd: $lib_virtd_op"
  sudo systemctl $lib_virtd_op libvirtd.service
  echo "Vm operation: $op"
  virsh list --all
  virsh $op rocky8-netin-2-3
  virsh $op rocky8-netin-2-2
  virsh $op rocky8-netin-2
}

if [[ $# -eq 0 ]]; then
  operation=$(gum choose "start" "shutdown" "quit")
  if [[ "$operation" != "quit" ]]; then
    do_some_magic $operation
  fi
else
  do_some_magic $1
fi
