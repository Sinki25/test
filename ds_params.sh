#!/bin/bash

INST_CAPT="DS "

logSeparator() {
  echo -ne "# -------------------------------------------------------------------------------\n"
}

log() {
  echo -ne "$INST_CAPT: $@\n"
  echo `date +"%T"`
}

logBeginAct() {
  logSeparator
  log $@
}

logEndAct() {
  log $@
  logSeparator
}
