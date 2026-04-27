#!/bin/bash
JAVA_HOME="/usr/lib/jvm/java-17-openjdk"
TOMCAT_HOME="/opt/tomcat-10.x"
SRC_DIR="src"
WEB_DIR="WebContent"
BUILD_CLASSES="WebContent/WEB-INF/classes"

echo "Cleaning old build..."
rm -rf "$BUILD_CLASSES"
mkdir -p "$BUILD_CLASSES"

echo "Compiling Java Sources..."
find $SRC_DIR -name "*.java" > sources.txt
"$JAVA_HOME/bin/javac" -cp "$TOMCAT_HOME/lib/jakarta.servlet-api.jar:$WEB_DIR/WEB-INF/lib/*" -d "$BUILD_CLASSES" @sources.txt
rm sources.txt

echo "Packaging into WAR..."
cd $WEB_DIR
"$JAVA_HOME/bin/jar" -cvf ../SchemeChecker.war *
cd ..

echo "Deploying to Tomcat..."
cp SchemeChecker.war "$TOMCAT_HOME/webapps/"

echo "Deployed! Open http://localhost:8080/SchemeChecker"
