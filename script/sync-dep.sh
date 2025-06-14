#!/bin/bash

# A shell script using wget to get the external library form github
# And download the library to the local directory ./external

UTIL_MAIN_URL="https://raw.githubusercontent.com/unsigend/util/main/module"
ROOT_PATH=$(pwd)
EXTERNAL_PATH=$ROOT_PATH/external

# if the external directory is not exist, create it
if [ ! -d $EXTERNAL_PATH ]; then
    mkdir -p $EXTERNAL_PATH
fi

# if the include directory is not exist, create it
if [ ! -d $EXTERNAL_PATH/include ]; then
    mkdir -p $EXTERNAL_PATH/include
fi
# if the src directory is not exist, create it
if [ ! -d $EXTERNAL_PATH/src ]; then
    mkdir -p $EXTERNAL_PATH/src
fi


# Argparse
wget -O $EXTERNAL_PATH/include/argparse.h $UTIL_MAIN_URL/argparse/include/argparse.h
wget -O $EXTERNAL_PATH/src/argparse.c $UTIL_MAIN_URL/argparse/src/argparse.c