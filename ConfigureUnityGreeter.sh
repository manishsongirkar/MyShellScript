#!/bin/bash
GRID=$1
DYNAMIC_BG=$2
BG_IMAGE=$3

usage ()
{
  echo "Usage: ConfigureUnityGreeter <draw grid> <draw user bg> <bg image>" >&2
  echo "         <draw grid>   : true or false" >&2
  echo "         <draw user bg>: true or false" >&2
  echo "         <bg image>    : full path to image file" >&2
}

if [ -z "$GRID" ]
then
  usage
else
  if [ "$GRID" != "true" -a "$GRID" != "false" ]
  then
    echo "Grid parameter must be 'true' or 'false'!\n" >&2
    usage
  fi
fi

if [ -z "$DYNAMIC_BG" ]
then
  usage
else
  if [ "$DYNAMIC_BG" != "true" -a "$DYNAMIC_BG" != "false" ]
  then
    echo "User background parameter must be 'true' or 'false'!\n" >&2
    usage
  fi
fi

if [ "$DYNAMIC_BG" == "false" ]
then
  BG_IMAGE_CMD="set"
  if [ -z "$BG_IMAGE" ]
  then
    echo "Missing background image file name." >&2
    usage
  fi
else
  BG_IMAGE_CMD="reset"
  if [ -n "$BG_IMAGE" ]
  then
    echo "Background image file name ignored!" >&2
    BG_IMAGE=""
  fi
fi

sudo xhost +SI:localuser:lightdm
sudo su lightdm -s /bin/bash <<EOF
set -x
gsettings set com.canonical.unity-greeter draw-grid $GRID
gsettings set com.canonical.unity-greeter draw-user-backgrounds $DYNAMIC_BG
gsettings $BG_IMAGE_CMD com.canonical.unity-greeter background $BG_IMAGE
exit
EOF
