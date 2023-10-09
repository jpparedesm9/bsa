@echo off
REM %1 $INSTALL_PATH
REM %4 $INSTALLATION_TYPE

if "%4" == "32" (
  set CONFIG_FILE=%1\NotificationScheduler.ini
) else (
  set CONFIG_FILE=%1\NotificationScheduler64.ini
)

echo classpath.1=%1\notification\cloud-notification-service-1.0.0-jar-with-dependencies.jar> %CONFIG_FILE%
echo vm.version.min=1.6>> %CONFIG_FILE%
echo service.class=com.cobiscorp.cloud.scheduler.service.Launcher>> %CONFIG_FILE%
echo service.id=NotificationScheduler>> %CONFIG_FILE%
echo service.name=Notification Scheduler>> %CONFIG_FILE%
echo service.description=Notification Scheduler>> %CONFIG_FILE%
echo service.startup=auto>> %CONFIG_FILE%
echo arg.1=%3>> %CONFIG_FILE%
echo log=%1\winrun4j.log>> %CONFIG_FILE%

if "%4" == "32" (
  %1\NotificationScheduler.exe --WinRun4J:RegisterService
) else (
  %1\NotificationScheduler64.exe --WinRun4J:RegisterService
)

set np=%1
echo %path%|find /i "%np%">nul || setx path "%path%;%np%"
