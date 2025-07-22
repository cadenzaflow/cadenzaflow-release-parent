#!/bin/bash

# CadenzaFlow Release Script
# Bu script cadenzaflow-release-parent projesini 1.0.0 versiyonunda release eder

echo "CadenzaFlow Release Parent - Release Script"
echo "============================================"

# Settings.xml dosyasının yolunu belirt
SETTINGS_XML="/Users/yusufcoskun/.m2/settings.xml"

# Release parametreleri
RELEASE_VERSION="1.0.0"
DEVELOPMENT_VERSION="1.0.1-SNAPSHOT"
TAG="1.0.0"

echo "Release Version: $RELEASE_VERSION"
echo "Development Version: $DEVELOPMENT_VERSION"
echo "Tag: $TAG"
echo "Settings XML: $SETTINGS_XML"
echo ""

# 1. Clean ve compile
echo "1. Cleaning and compiling project..."
mvn clean compile -DskipTests --settings="$SETTINGS_XML"

if [ $? -ne 0 ]; then
    echo "ERROR: Compilation failed!"
    exit 1
fi

# 2. Test deploy (snapshot)
echo ""
echo "2. Testing snapshot deployment..."
mvn clean deploy -DskipTests --settings="$SETTINGS_XML"

if [ $? -ne 0 ]; then
    echo "ERROR: Snapshot deployment failed!"
    exit 1
fi

# 3. Release prepare ve perform
echo ""
echo "3. Preparing and performing release..."
mvn release:prepare release:perform \
    -B -Dresume=false \
    -Dtag="$TAG" \
    -DreleaseVersion="$RELEASE_VERSION" \
    -DdevelopmentVersion="$DEVELOPMENT_VERSION" \
    -Darguments="--settings=$SETTINGS_XML" \
    --settings="$SETTINGS_XML"

if [ $? -ne 0 ]; then
    echo "ERROR: Release failed!"
    exit 1
fi

echo ""
echo "SUCCESS: CadenzaFlow Release Parent $RELEASE_VERSION has been released!"
echo "Artifacts deployed to:"
echo "  - Release: http://18.157.182.187:32265/repository/cadenzaflow-release/"
echo "  - Snapshot: http://18.157.182.187:32265/repository/cadenzaflow-snapshot/" 