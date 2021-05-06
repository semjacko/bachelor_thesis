#!/bin/bash

for DIRECTORY in modules/* ; do
   PACKAGE=$(basename $DIRECTORY)
   luarocks --tree "modules/$PACKAGE" show "$PACKAGE" > /dev/null 2>&1
   echo "Testing $PACKAGE"
   ./run_in_single_package.sh "$PACKAGE"
done
