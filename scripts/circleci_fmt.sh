#!/bin/sh

echo "starting terraform fmt"
echo

if [ $(terraform fmt | grep -v .terraform | tee fmt_result.txt | wc -l) -gt 0 ]; then
  echo "[DEV] Format of this terraform files is not appropriate:"
  echo
  cat fmt_result.txt
  echo
  echo "Please run terraform fmt"
  exit 1
fi
echo "OK"
echo "DONE."
