#!/bin/bash

main() {
  temp_dir=$(mkdir /tmp/someFolder)
  touch /tmp/someFolder/someFile
}

main "$@"