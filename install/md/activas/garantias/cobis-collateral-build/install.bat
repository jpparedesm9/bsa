if "%1" == "" (mvn clean install)
if "%1" == "SQL" (mvn clean install -P SQLServer)