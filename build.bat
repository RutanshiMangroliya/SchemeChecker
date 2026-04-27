@echo off
set JAVA_HOME=C:\Program Files\Java\jdk-21
set TOMCAT_HOME=C:\Users\01\Downloads\apache-tomcat-9.0.117
set SRC_DIR=src
set WEB_DIR=WebContent
set BUILD_CLASSES=WebContent\WEB-INF\classes

echo Cleaning old build...
rmdir /s /q "%BUILD_CLASSES%" 2>nul
mkdir "%BUILD_CLASSES%"

echo Compiling Java Sources...
"%JAVA_HOME%\bin\javac" -cp "%TOMCAT_HOME%\lib\servlet-api.jar;%WEB_DIR%\WEB-INF\lib\*" -d "%BUILD_CLASSES%" %SRC_DIR%\controller\*.java %SRC_DIR%\dao\*.java %SRC_DIR%\model\*.java %SRC_DIR%\util\*.java

echo Packaging into WAR...
cd %WEB_DIR%
"%JAVA_HOME%\bin\jar" -cvf ..\SchemeChecker.war *
cd ..

echo Deploying to Tomcat...
copy /Y SchemeChecker.war "%TOMCAT_HOME%\webapps\"

echo Deployed! Open http://localhost:8080/SchemeChecker
pause
