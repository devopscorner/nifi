#!/usr/bin/env sh

export GOTO_GOPATH=`echo $GOPATH`
export GOTO_PROJECT="$GOTO_GOPATH/src/github.com/devopscorner"

export TARGET=$1
#echo "Target Folder: $TARGET"

if [ "$TARGET" = "" ]; then
  export GOTO_FOLDER="$GOTO_PROJECT"
else
  if [ -d "$GOTO_PROJECT/$TARGET" ]
  then
    export GOTO_FOLDER="$GOTO_PROJECT/$TARGET"
  else
    export GOTO_FOLDER="$GOTO_PROJECT"
  fi
fi

echo "-------------------------------------------------------------"
echo " WORKDIR: $GOTO_FOLDER "
echo "-------------------------------------------------------------"

cd $GOTO_FOLDER
exec zsh
#exec bash
