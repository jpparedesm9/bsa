import groovy.util.Node;
/**
 * No se debe modificar la clase
 * @author fabad
 *
 */
class ModifyPlans {

	   //Metodo para agreagar al ultimo
	   void addConfigAtTheEndDeleteIfExist(Node rootVar, Node nodeVar){
		  def configs =  rootVar.own[0].children()
		  def config = configs.find { it.@id == nodeVar.@id }
		  if(config != null) {
              configs.remove(config)
		  }
		  rootVar.own[0].append(nodeVar)
	   }
	
		//Metodos de agregacion
	
		void addPlanBefore(Node rootVar, Object id, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find{ it.@id == nodeVar.@id }
			def index = configs.indexOf(config)
			println it.@id
			println nodeVar.@id
			println config
			
			configs.add(index, nodeVar)
		}
 
		void addPlanAfter(Node rootVar, Object id, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find{ it.@id == id }
			def index = configs.indexOf(config)
			configs.add(index + 1, nodeVar)
		}
		
		void addPlanBeforeDeleteIfExists(Node rootVar, Object id, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == nodeVar.@id }
			if(config != null) {
				 configs.remove(config)
			}
			addPlanBefore(rootVar, id, nodeVar)
		}
		
		void addPlanAfterDeleteIfExists(Node rootVar, Object id, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == nodeVar.@id }
			if(config != null) {
				configs.remove(config)
			}
			addPlanAfter(rootVar, id, nodeVar)
		}
	 
		void movePlanBefore(Node rootVar, Object idMove, Node id){
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == id }
			configs.remove(config)
			addPlanBefore(rootVar, id, config)
		}
	 
		void movePlanAfter(Node rootVar, Object idMove, Object id){
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == idMove }
			configs.remove(config)
			addPlanAfter(rootVar, id, config)
		}

		void addPlanWithReferenceToPlan(Node rootVar, Node referencePlan, Node nodeVar, boolean insertBefore) {
			def configs =  rootVar.own[0].children()

			if ( referencePlan == null) {
				throw RuntimeException("reference plan:" + referencePlan + " must not be null");
			}
			def index = configs.indexOf(referencePlan)
			if(insertBefore) {
				configs.add(index, nodeVar)
			} else {
				configs.add(index + 1, nodeVar)
			}
		}		

		// Metodo que inserta un nodo despues de confirmar que exista el plan primario
		// si no existe busca un plan secundario y lo agrega
		void addPlanAfterPlans(Node rootVar, Object id, Object idOther, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find{ it.@id == id }
			if(config == null) {
				config = configs.find{ it.@id == idOther }
		    }
            
            //Si no encuentra los dos nodos especificados a�ade al final del archivo la informaci�n
            if(config == null){
                addConfigAtTheEndDeleteIfExist(rootVar, nodeVar)
            }else{
                def index = configs.indexOf(config)
                configs.add(index + 1, nodeVar)
            }
		}
		
		// Metodo que inserta un nodo despues de confirmar que exista el plan primario
		// si no existe busca un plan secundario y lo agrega
		void addPlanAfterDeleteIfExistsAndOtherPlan(Node rootVar, Object id, Object idOther, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == nodeVar.@id }
			if(config != null) {
				configs.remove(config)
			}
			addPlanAfterPlans(rootVar, id,idOther, nodeVar)
		}
		
		// Metodo que remueve un plan, seg�n su identificador indicado.
		void removePlan(Node rootVar, Object id) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == id }
			if(config != null) {
				 configs.remove(config)
			}
		}
		void addPlanOrUpdateIfExists(Node rootVar, Node referencePlan, Node nodeVar,
		  boolean insertBefore) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == nodeVar.@id }
			if(config != null) {
				configs.remove(config)
			}
			
			addPlanWithReferenceToPlan(rootVar, referencePlan, nodeVar, insertBefore)
		}

		void addOrUpdatePlanPlugin(Node rootVar, String referencePlanId,
		boolean includeVersionInPlanId, boolean insertBefore, String pluginName,
		String pluginVersion, String destDir) {
			def referencePlanNode = rootVar."**".plan.find{ it.@id == referencePlanId }
			if(referencePlanNode == null) {
				throw new RuntimeException("Reference node not found:"+ referencePlanNodeId);
			}
			addOrUpdatePlanPlugin(rootVar, referencePlanNode, includeVersionInPlanId,
				insertBefore, pluginName, pluginVersion, destDir)
		}
		void addOrUpdatePlanPlugin(Node rootVar, Node referencePlanNode, 
		boolean includeVersionInPlanId, boolean insertBefore, String pluginName,
		String pluginVersion, String destDir) {
			String wPlanId =  pluginName + "-plan"
			if ( includeVersionInPlanId ) {
				wPlanId =  pluginName + "-" + pluginVersion + "-plan"
			} 


			String wDestPath = destDir + pluginName +"-" + pluginVersion + ".jar"
			def plugin = rootVar."**".plugin.find { it.@name == wPlanId }
			if(plugin != null) {
					plugin.@path = wDestPath
					println "Plugin ["+ pluginName +"] updated"
			} else {
			def wPlanCurrent = new Node(null, "plan",
				[ id: wPlanId,
					reloadable: "true"])
			wPlanCurrent.append(new Node(null, "plugin",
				[name: wPlanId,
				path: wDestPath]))
				addPlanOrUpdateIfExists(rootVar, referencePlanNode, wPlanCurrent, insertBefore)
			}
		}
}
println("parameters:" + this.args) 

def modPlan = new ModifyPlans()


def planMobile = new Node(null, "plan", [ id: "cobis-cloud-mobile-orchestration-rest", reloadable: "true"])
planMobile.append(new Node(null, "plugin", [name: "cobis-cloud-mobile-orchestration-rest", path: "../../CLOUD-MOBILE/plugins/cobis-cloud-orch-rest-1.0.0.jar"]))

def planMobileUtil = new Node(null, "plan", [ id: "cobis-cobiscloudsynchronization-util-plan", reloadable: "true"])
planMobileUtil.append(new Node(null, "plugin", [name: "cobis-cobiscloudsynchronization-util", path: "../../CLOUD-MOBILE/plugins/cobis-cobiscloudsynchronization-util-1.0.0.jar"]))

def planMobileBsl = new Node(null, "plan", [ id: "cobis-cobiscloudsynchronization-bsl-plan", reloadable: "true"])
planMobileBsl.append(new Node(null, "plugin", [name: "cobis-cobiscloudsynchronization-bsl", path: "../../CLOUD-MOBILE/plugins/cobis-cobiscloudsynchronization-bsl-1.0.0.jar"]))

def planMobileBslImpl = new Node(null, "plan", [ id: "cobis-cobiscloudsynchronization-bsl-impl-plan", reloadable: "true"])
planMobileBslImpl.append(new Node(null, "plugin", [name: "cobis-cobiscloudsynchronization-bsl-impl", path: "../../CLOUD-MOBILE/plugins/cobis-cobiscloudsynchronization-bsl-impl-1.0.0.jar"]))

def planMobileRest = new Node(null, "plan", [ id: "cobis-cobiscloudsynchronization-rest-plan", reloadable: "true"])
planMobileRest.append(new Node(null, "plugin", [name: "cobis-cobiscloudsynchronization-rest", path: "../../CLOUD-MOBILE/plugins/cobis-cobiscloudsynchronization-rest-1.0.0.jar"]))


def planMobileManagement = new Node(null, "plan", [ id: "MOBILE-MANAGEMENT", reloadable: "true"])
planMobileManagement.append(new Node(null, "plugin", [name: "MobileManagement.DTO", path: "../../CLOUD-MOBILE/plugins/COBISCorp.eCOBIS.MobileManagement.DTO-1.0.0.0.jar"]))
planMobileManagement.append(new Node(null, "plugin", [name: "MobileManagement.Services", path: "../../CLOUD-MOBILE/plugins/COBISCorp.eCOBIS.MobileManagement.Service-1.0.0.0.jar"]))

def planMobileCommons = new Node(null, "plan", [ id: "MOBILE-COMMONS", reloadable: "true"])
planMobileCommons.append(new Node(null, "plugin", [name: "mobile-commons-services", path: "../../CLOUD-MOBILE/plugins/mobile-commons-services-1.0.0.jar"]))
planMobileCommons.append(new Node(null, "plugin", [name: "mobile-commons-utils", path: "../../CLOUD-MOBILE/plugins/mobile-commons-utils-1.0.0.jar"]))

def planMobileCobisCommons = new Node(null, "plan", [ id: "mbile.mobilemanagementform.commons", reloadable: "true"])
planMobileCobisCommons.append(new Node(null, "plugin", [name: "mbile.domains", path: "../../CLOUD-MOBILE/plugins/mbile.domains-1.0.0.jar"]))
planMobileCobisCommons.append(new Node(null, "plugin", [name: "mbile.commons.events", path: "../../CLOUD-MOBILE/plugins/mbile.commons.events-1.0.0.jar"]))

def planMobileServices = new Node(null, "plan", [ id: "mbile.mobilemanagementform.services", reloadable: "true"])
planMobileServices.append(new Node(null, "plugin", [name: "mbile.admin.mobilemanagementform.services", path: "../../CLOUD-MOBILE/plugins/mbile.admin.mobilemanagementform.services-1.0.0.jar"]))
planMobileServices.append(new Node(null, "plugin", [name: "mbile.admin.mobilepopupform.services", path: "../../CLOUD-MOBILE/plugins/mbile.admin.mobilepopupform.services-1.0.0.jar"]))
planMobileServices.append(new Node(null, "plugin", [name: "mbile.admin.syncmanagementform.services", path: "../../CLOUD-MOBILE/plugins/mbile.admin.syncmanagementform.services-1.0.0.jar"]))
planMobileServices.append(new Node(null, "plugin", [name: "mbile.admin.terminalmanagementform.services", path: "../../CLOUD-MOBILE/plugins/mbile.admin.terminalmanagementform.services-1.0.0.jar"]))

def planMobileCustomevents = new Node(null, "plan", [ id: "mbile.mobilemanagementform.customevents", reloadable: "true"])
planMobileCustomevents.append(new Node(null, "plugin", [name: "mbile.admin.mobilemanagementform.customevents", path: "../../CLOUD-MOBILE/plugins/mbile.admin.mobilemanagementform.customevents-1.0.0.jar"]))
planMobileCustomevents.append(new Node(null, "plugin", [name: "mbile.admin.mobilepopupform.customevents", path: "../../CLOUD-MOBILE/plugins/mbile.admin.mobilepopupform.customevents-1.0.0.jar"]))
planMobileCustomevents.append(new Node(null, "plugin", [name: "mbile.admin.syncmanagementform.customevents", path: "../../CLOUD-MOBILE/plugins/mbile.admin.syncmanagementform.customevents-1.0.0.jar"]))
planMobileCustomevents.append(new Node(null, "plugin", [name: "mbile.admin.terminalmanagementform.customevents", path: "../../CLOUD-MOBILE/plugins/mbile.admin.terminalmanagementform.customevents-1.0.0.jar"]))


def plan_mbile_terminalmanagementform_licensegenerator_api = new Node(null, "plan", [ id: "mbile.terminalmanagementform.licensegenerator-api", reloadable: "true"])
plan_mbile_terminalmanagementform_licensegenerator_api.append(new Node(null, "plugin", [name: "cobis-device-command-api", 
	path: "../../CLOUD-MOBILE/plugins/cobis-device-command-api-1.0.3.jar"]))

def plan_mbile_terminalmanagementform_licensegenerator_rest = new Node(null, "plan", [ id: "mbile.terminalmanagementform.licensegenerator-rest", reloadable: "true"])
plan_mbile_terminalmanagementform_licensegenerator_rest.append(new Node(null, "plugin", [name: "cobis-device-command-api", 
	path: "../../CLOUD-MOBILE/plugins/cobis-cloud-device-license-rest-1.0.0.jar"]))





modPlan.addPlanAfterDeleteIfExists(root,"INTEGRATION-ORCHESTRATION",  planMobile)

modPlan.addPlanAfterDeleteIfExists(root,"cobis-cloud-mobile-orchestration-rest",  planMobileUtil)
modPlan.addPlanAfterDeleteIfExists(root,"cobis-cobiscloudsynchronization-util-plan",  planMobileBsl)
modPlan.addPlanAfterDeleteIfExists(root,"cobis-cobiscloudsynchronization-bsl-plan",  planMobileBslImpl)
modPlan.addPlanAfterDeleteIfExists(root,"cobis-cobiscloudsynchronization-bsl-impl-plan",  planMobileRest)

modPlan.addPlanAfterDeleteIfExists(root,"cobis-cobiscloudsynchronization-rest-plan",  planMobileManagement)
modPlan.addPlanAfterDeleteIfExists(root,"MOBILE-MANAGEMENT",  planMobileCommons)
modPlan.addPlanAfterDeleteIfExists(root,"MOBILE-COMMONS",  planMobileCobisCommons)
modPlan.addPlanAfterDeleteIfExists(root,"mbile.mobilemanagementform.commons",  planMobileServices)
modPlan.addPlanAfterDeleteIfExists(root,"mbile.mobilemanagementform.services",  planMobileCustomevents)
modPlan.addPlanAfterDeleteIfExists(root,"mbile.mobilemanagementform.customevents",  plan_mbile_terminalmanagementform_licensegenerator_api)
modPlan.addPlanAfterDeleteIfExists(root,"mbile.terminalmanagementform.licensegenerator-api",  plan_mbile_terminalmanagementform_licensegenerator_rest)


//servicios de registro
def mobileDestDir = "../../CLOUD-MOBILE/plugins/"
modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", true, true, 
	"jackson-core", "2.7.8", mobileDestDir)
		
modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", true, true,
	"jackson-databind", "2.7.8", mobileDestDir)
		

modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", true, true,
	"jackson-dataformat-cbor", "2.7.8", mobileDestDir)
		

modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", true, true,
	"jackson-annotations", "2.8.5", mobileDestDir)


modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", false, true,
 "com-cobiscorp-jjwt",
	"0.7.1", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, "CobisFramework", false, true,
"cts-web-token",
	"1.0.0", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, planMobileRest, false, false,
"cobis-cobiscloudsecurity-rest",
	"1.0.0", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, planMobileRest, false, false,
"cobis-cobisclouddevicemanagement-rest",
	"1.0.0", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, planMobileRest, false, false,
"cobis-cobisclouddevicemanagement-bsl-impl",
	"1.0.0", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, planMobileRest, false, false,
"cobis-cobisclouddevicemanagement-bsl",
	"1.0.0", mobileDestDir)

modPlan.addOrUpdatePlanPlugin(root, planMobileRest, false, false,
"cobis-cobisclouddevicemanagement-util",
	"1.0.0", mobileDestDir)

modPlan.removePlan(root, 'cobis-cobiscloudloginvalidationext-impl-plan')
modPlan.addOrUpdatePlanPlugin(root, "cobis-web-container-api", false, false,
"cobis-cobiscloudloginvalidationext-impl",
	"1.0.0", mobileDestDir)

def plugin = root."**".plugin.find { it.@name == "CTSHandlers" }
if(plugin != null) {
	plugin.@path = plugin.@path.replaceFirst(/([0-9]+\.)+/, "1.1.8.1.")
	println "Plugin [CTSHandlers] updated"
}



def sourceFileCTSHandlers = this.args[0] + "/" + this.args[1] + "/plugins/CTSHandlers-1.1.8.1.jar"
def targetFileCTSHandlers = this.args[0] + "/CTS_MF/plugins/CTSHandlers-1.1.8.1.jar"

new File(targetFileCTSHandlers).bytes = new File(sourceFileCTSHandlers).bytes