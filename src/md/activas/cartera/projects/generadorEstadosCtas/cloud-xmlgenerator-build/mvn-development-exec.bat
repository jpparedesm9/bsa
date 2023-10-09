:: Cambiar esta línea por la ubicación local de en la máquina
set ANT_HOME=C:\Java\springsource\maven-2.2.1.RELEASE
set PATH=%PATH%;%ANT_HOME%\bin
mvn archetype:generate -DgroupId=com.mkyong -DartifactId=TestApp -DarchetypeArtifactId=maven-archetype-webapp -DinteractiveMode=false