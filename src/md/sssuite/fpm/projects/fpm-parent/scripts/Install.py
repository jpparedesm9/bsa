applicationName="fpm-bla" 
assetName="blueprint-eba-1.0.0.eba"
##
##AdminBLA.createEmptyBLA(applicationName,"")
##Use / as path separator \ doesn't work

##start the application
stopBLA(applicationName)
deleteBLA(applicationName)

##AdminBLA.importAsset("D:/workspaces/nuevocore2/blueprint/blueprint-eba/target/blueprint-eba-1.0.0.eba","FULL")

##weight=1 startWeight doesn't work like number
startWeight="1"
##deployUnits, cuName and  cuDescription works with "". We don't know about what values must be there 

AdminBLA.addCompUnit(applicationName,assetName,assetName,assetName,assetName,startWeight,"WebSphere:node=PC01TEC92Node02,server=server1","")
AdminBLA.addCompUnit(applicationName,assetName,"",assetName,"",startWeight,"WebSphere:node=PC01TEC92Node02,server=server1","")

def addCompUnit( blaName, cuSourceID, deployUnits, cuName, cuDescription, startingWeight, server, activationPlan)


##wsadmin -lang jython -c "AdminBLA.importAsset("asset.zip", "true", "true")"

AdminTask.listAssets('[-includeDescription true -includeDeplUnit true -assetID blueprint-eba-1.0.0.eba ]')
AdminTask.addCompUnit('[-blaID WebSphere:blaname=blueprint-sample -cuSourceID WebSphere:assetname=blueprint-eba-1.0.0.eba ]') 


AdminTask.addCompUnit('[-blaID WebSphere:blaname=blueprintsample -cuSourceID WebSphere:assetname=blueprint-eba-1.0.0.eba -CUOptions [[WebSphere:blaname=blueprintsample WebSphere:assetname=blueprint-eba-1.0.0.eba blueprint-eba-1.0.0_0001.eba "" 1 false DEFAULT]] -MapTargets [[ebaDeploymentUnit WebSphere:node=PC01TEC92Node02,server=server1]] -ContextRootStep [[blueprint-web 1.0.0 /BlueprintWeb]] -VirtualHostMappingStep [[blueprint-web 1.0.0 "" default_host]]]') 

AdminBLA.listAssets


AdminTask.addCompUnit('[-blaID WebSphere:blaname=blueprintsample -cuSourceID WebSphere:assetname=blueprint-eba-1.0.0.eba ]') 

AdminBLA.addCompUnit(applicationName, assetName, "default", "blueprint-eba-1.0.0_0001.eba", "cu description", "1", "server1", "specname=actplan1")


AdminBLA.addCompUnit(applicationName, "WebSphere:assetname=blueprint-eba-1.0.0.eba", "default", "WebSphere:cuname=blueprint-eba-1.0.0_0001.eba ", "cu description", "1", "server1", "specname=actplan1")