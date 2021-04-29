#!/bin/bash

for DIRECTORY in modules/* ; do
   PACKAGE=$(basename $DIRECTORY)

   luarocks --tree "modules/$PACKAGE" show "$PACKAGE" > /dev/null 2>&1
   echo "Testing $PACKAGE"
   ./run_in_single_package.sh "$PACKAGE"
#   if [ $? -eq 0 ]; then
#      echo "Testing $PACKAGE"
#      ./run_in_single_package.sh "$PACKAGE"
#   else
#      echo "WARN: $PACKAGE not installed" >&2
#   fi
done
