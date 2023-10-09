$source = "<DRIVE>\cobishome"
$destination = "<DRIVE>\rollbackInstaller\cobishome"

Write-Output "Source: $source"
Write-Output "Destination: $destination"

Write-Output "CSTMR.js"
New-Item -Path $destination\CEW\assets\languages\ -ItemType Directory -Force 
Copy-Item -Path $source\CEW\assets\languages\CSTMR.js -Destination $destination\CEW\assets\languages\CSTMR.js -recurse -force
Write-Output "CSTMR-es.js"
Copy-Item -Path $source\CEW\assets\languages\CSTMR-es.js -Destination $destination\CEW\assets\languages\CSTMR-es.js -recurse -force
Write-Output "CSTMR-es_EC.js"
Copy-Item -Path $source\CEW\assets\languages\CSTMR-es_EC.js -Destination $destination\CEW\assets\languages\CSTMR-es_EC.js -recurse -force
Write-Output "LOANS.js"
Copy-Item -Path $source\CEW\assets\languages\LOANS.js -Destination $destination\CEW\assets\languages\LOANS.js -recurse -force
Write-Output "LOANS-es.js"
Copy-Item -Path $source\CEW\assets\languages\LOANS-es.js -Destination $destination\CEW\assets\languages\LOANS-es.js -recurse -force
Write-Output "LOANS-es_EC.js"
Copy-Item -Path $source\CEW\assets\languages\LOANS-es_EC.js -Destination $destination\CEW\assets\languages\LOANS-es_EC.js -recurse -force

Write-Output "VC_CUSTOMEROI_208680.js"
New-Item -Path $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\ -ItemType Directory -Force 
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680.js -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680.js -recurse -force
Write-Output "VC_CUSTOMEROI_208680.min.js"
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680.min.js -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680.min.js -recurse -force
Write-Output "VC_CUSTOMEROI_208680_FORM.html"
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680_FORM.html -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERCOETP_680\1.0.0\VC_CUSTOMEROI_208680_FORM.html -recurse -force

Write-Output "VC_CUSTOMERIF_745226.js"
New-Item -Path $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\ -ItemType Directory -Force 
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226.js -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226.js -recurse -force
Write-Output "VC_CUSTOMERIF_745226.min.js"
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226.min.js -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226.min.js -recurse -force
Write-Output "VC_CUSTOMERIF_745226_FORM.html"
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226_FORM.html -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226_FORM.html -recurse -force
Write-Output "VC_CUSTOMERIF_745226_TASK.html"
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226_TASK.html -Destination $destination\CEW\views\CSTMR\CSTMR\T_CUSTOMERGEIFR_226\1.0.0\VC_CUSTOMERIF_745226_TASK.html -recurse -force

Write-Output "VC_PROSPECTMI_213684_TASK.html"
New-Item -Path $destination\CEW\views\CSTMR\CSTMR\T_PROSPECTCOOSS_684\1.0.0\ -ItemType Directory -Force 
Copy-Item -Path $source\CEW\views\CSTMR\CSTMR\T_PROSPECTCOOSS_684\1.0.0\VC_PROSPECTMI_213684_TASK.html -Destination $destination\CEW\views\CSTMR\CSTMR\T_PROSPECTCOOSS_684\1.0.0\VC_PROSPECTMI_213684_TASK.html -recurse -force

Write-Output "VC_MEMBERXIGR_697740.js"
New-Item -Path $destination\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\ -ItemType Directory -Force 
Copy-Item -Path $source\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740.js -Destination $destination\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740.js -recurse -force
Write-Output "VC_MEMBERXIGR_697740.min.js"
Copy-Item -Path $source\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740.min.js -Destination $destination\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740.min.js -recurse -force
Write-Output "VC_MEMBERXIGR_697740_TASK.html"
Copy-Item -Path $source\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740_TASK.html -Destination $destination\CEW\views\LOANS\GROUP\T_MEMBERHUJKTOU_740\1.0.0\VC_MEMBERXIGR_697740_TASK.html -recurse -force

Write-Output "cobis-cloud-orch-rest-1.0.0.jar"
New-Item -Path $destination\CLOUD-MOBILE\plugins\ -ItemType Directory -Force 
Copy-Item -Path $source\CLOUD-MOBILE\plugins\cobis-cloud-orch-rest-1.0.0.jar -Destination $destination\CLOUD-MOBILE\plugins\cobis-cloud-orch-rest-1.0.0.jar -recurse -force

Write-Output "cobis-cobiscloudburo-bsl-1.0.0.jar"
New-Item -Path $destination\CREDIT\integration\plugins\ -ItemType Directory -Force 
Copy-Item -Path $source\CREDIT\integration\plugins\cobis-cobiscloudburo-bsl-1.0.0.jar -Destination $destination\CREDIT\integration\plugins\cobis-cobiscloudburo-bsl-1.0.0.jar -recurse -force
Write-Output "cobis-cobiscloudburo-bsl-impl-1.0.0.jar"
Copy-Item -Path $source\CREDIT\integration\plugins\cobis-cobiscloudburo-bsl-impl-1.0.0.jar -Destination $destination\CREDIT\integration\plugins\cobis-cobiscloudburo-bsl-impl-1.0.0.jar -recurse -force
Write-Output "cobis-cobiscloudorchestration-bsl-1.0.0.jar"
Copy-Item -Path $source\CREDIT\integration\plugins\cobis-cobiscloudorchestration-bsl-1.0.0.jar -Destination $destination\CREDIT\integration\plugins\cobis-cobiscloudorchestration-bsl-1.0.0.jar -recurse -force
Write-Output "cobis-cobiscloudorchestration-bsl-impl-1.0.0.jar"
Copy-Item -Path $source\CREDIT\integration\plugins\cobis-cobiscloudorchestration-bsl-impl-1.0.0.jar -Destination $destination\CREDIT\integration\plugins\cobis-cobiscloudorchestration-bsl-impl-1.0.0.jar -recurse -force

Write-Output "COBISCorp.eCOBIS.CustomerDataManagement.DTO-2.1.0.0.jar"
New-Item -Path $destination\CUSTOMER\plugins\ -ItemType Directory -Force 
Copy-Item -Path $source\CUSTOMER\plugins\COBISCorp.eCOBIS.CustomerDataManagement.DTO-2.1.0.0.jar -Destination $destination\CUSTOMER\plugins\COBISCorp.eCOBIS.CustomerDataManagement.DTO-2.1.0.0.jar -recurse -force
Write-Output "COBISCorp.eCOBIS.CustomerDataManagementService.Service-2.1.0.0.jar"
Copy-Item -Path $source\CUSTOMER\plugins\COBISCorp.eCOBIS.CustomerDataManagementService.Service-2.1.0.0.jar -Destination $destination\CUSTOMER\plugins\COBISCorp.eCOBIS.CustomerDataManagementService.Service-2.1.0.0.jar -recurse -force
Write-Output "cstmr.commons.events-1.0.0.jar"
Copy-Item -Path $source\CUSTOMER\plugins\cstmr.commons.events-1.0.0.jar -Destination $destination\CUSTOMER\plugins\cstmr.commons.events-1.0.0.jar -recurse -force
Write-Output "cstmr.cstmr.customercomposite.customevents-1.0.0.jar"
Copy-Item -Path $source\CUSTOMER\plugins\cstmr.cstmr.customercomposite.customevents-1.0.0.jar -Destination $destination\CUSTOMER\plugins\cstmr.cstmr.customercomposite.customevents-1.0.0.jar -recurse -force
Write-Output "cstmr.cstmr.prospectcomposite.customevents-1.0.0.jar"
Copy-Item -Path $source\CUSTOMER\plugins\cstmr.cstmr.prospectcomposite.customevents-1.0.0.jar -Destination $destination\CUSTOMER\plugins\cstmr.cstmr.prospectcomposite.customevents-1.0.0.jar -recurse -force
Write-Output "cstmr.domains-1.0.0.jar"
Copy-Item -Path $source\CUSTOMER\plugins\cstmr.domains-1.0.0.jar -Destination $destination\CUSTOMER\plugins\cstmr.domains-1.0.0.jar -recurse -force

Write-Output "loans.group.groupcomposite.customevents-1.0.0.jar"
New-Item -Path $destination\LOANS-GROUP\plugins\ -ItemType Directory -Force 
Copy-Item -Path $source\LOANS-GROUP\plugins\loans.group.groupcomposite.customevents-1.0.0.jar -Destination $destination\LOANS-GROUP\plugins\loans.group.groupcomposite.customevents-1.0.0.jar -recurse -force
