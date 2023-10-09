IF %PROCESSOR_ARCHITECTURE%==X86 GOTO SET_PATHS_X86
IF %PROCESSOR_ARCHITECTURE%==AMD64 GOTO SET_PATHS_X64

:SET_PATHS_X86
SET PATH_ASM=%ProgramFiles%\COBIS\COBIS Services Generator
GOTO GENERATE_INSTALL

:SET_PATHS_X64
SET PATH_ASM=%ProgramFiles% (x86)\COBIS\COBIS Services Generator

:GENERATE_INSTALL
"%PATH_ASM%\CENServicesGenerator.exe" "..\..\..\..\middleware\SG\Loans\Loans.sgp" -c -v "SG-OUTPUT-DIR|c:\COBIS-SG\Output\;MVN-REP-ID|cobis-dev;MVN-REP-URL|http://repolib.cobiscorp.com:8081/nexus/content/repositories/cobis-dev-maven/;MVN-GOAL|install;NUGET-REP-URL|local"
"%PATH_ASM%\CENServicesGenerator.exe" "..\..\..\..\middleware\SG\IndividualLoan\IndividualLoan.sgp" -c -v "SG-OUTPUT-DIR|c:\COBIS-SG\Output\;MVN-REP-ID|cobis-dev;MVN-REP-URL|http://repolib.cobiscorp.com:8081/nexus/content/repositories/cobis-dev-maven/;MVN-GOAL|install;NUGET-REP-URL|local"


mvn clean install
