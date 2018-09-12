#!/bin/bash

# build & zip the function
build_func() {
    START=$(date +"%s")

    FUNC_NAME=$1
    rm -rf $FUNC_NAME $FUNC_NAME.zip

    echo
    echo "##############################"
    echo "##### build"
    echo "##############################"
    rm -rf $FUNC_NAME
    GOOS=linux GOARCH=amd64 go build -o $FUNC_NAME $FUNC_NAME.go
    if [[ $? != 0 ]]; then
        echo "!!!Error: build failed."
        return 1
    fi
    echo "SUCCESS"

    echo
    echo "##############################"
    echo "##### zip"
    echo "##############################"
    zip $FUNC_NAME.zip $FUNC_NAME
    if [[ $? != 0 ]]; then
        echo "!!!Error: zip failed."
        return 1
    fi
    echo "SUCCESS"
    rm -rf $FUNC_NAME

    FINISH=$(date +"%s")
    echo
    echo "##### Time elapsed ($(($FINISH - $START)))"
    return 0
}

# main process
build_func "start-ec2-instances" &&
build_func "stop-ec2-instances"
