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

		// Metodo que inserta un nodo despues de confirmar que exista el plan primario
		// si no existe busca un plan secundario y lo agrega
		void addPlanAfterPlans(Node rootVar, Object id, Object idOther, Node nodeVar) {
			def configs =  rootVar.own[0].children()
			def config = configs.find{ it.@id == id }
			if(config == null) {
				config = configs.find{ it.@id == idOther }
		    }
            
            //Si no encuentra los dos nodos especificados añade al final del archivo la información
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
		
		// Metodo que remueve un plan, según su identificador indicado.
		void removePlan(Node rootVar, Object id) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == id }
			if(config != null) {
				 configs.remove(config)
			}
		}
}

def modPlan = new ModifyPlans()

//BUSINESS-COMMONS
def planBusinessCommons = new Node(null, "plan", [ id: "BUSINESS-COMMONS", reloadable: "true"])
planBusinessCommons.append(new Node(null, "plugin", [name: "busin-commons-dto", path: "../../BUSINESSCOMMONSPLATFORM/plugins/busin-commons-dto-1.0.0.jar"]))
planBusinessCommons.append(new Node(null, "plugin", [name: "busin-commons-services", path: "../../BUSINESSCOMMONSPLATFORM/plugins/busin-commons-services-1.0.0.jar"]))

//ADMIN-PROCESS
def planAdmin = new Node(null, "plan", [ id: "ADMIN-PROCESS", reloadable: "true"])
planAdmin.append(new Node(null, "plugin", [name: "System.Configuration.DTO", path: "../../ADMIN/plugins/COBISCorp.eCOBIS.SystemConfiguration.DTO-2.0.0.0.jar"]))
planAdmin.append(new Node(null, "plugin", [name: "System.Configuration.Service", path: "../../ADMIN/plugins/COBISCorp.eCOBIS.SystemConfiguration.Service-2.0.0.0.jar"]))

//CUSTOMER-PROCESS
def planCustomer = new Node(null, "plan", [ id: "CUSTOMER-PROCESS", reloadable: "true"])
planCustomer.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Customer.DTO", path: "../../CUSTOMER/plugins/COBISCorp.eCOBIS.CustomerDataManagement.DTO-2.1.0.0.jar"]))
planCustomer.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Customer.Service", path: "../../CUSTOMER/plugins/COBISCorp.eCOBIS.CustomerDataManagementService.Service-2.1.0.0.jar"]))


//BUSINESS-COMMONS-PLATFORM
def planBusinessCommonsPlatform = new Node(null, "plan", [ id: "BUSINESS-PLATFORM-COMMONS", reloadable: "true"])
planBusinessCommonsPlatform.append(new Node(null, "plugin", [name: "business-commons-platform-utils", path: "../../BUSINESSCOMMONSPLATFORM/plugins/business-commons-platform-utils-1.0.0.jar"]))
planBusinessCommonsPlatform.append(new Node(null, "plugin", [name: "business-commons-platform-services", path: "../../BUSINESSCOMMONSPLATFORM/plugins/business-commons-platform-services-1.0.0.jar"]))


modPlan.removePlan(root, "BUSINESS-PROCESS-COMMONS")
modPlan.addPlanAfterDeleteIfExists(root, "API-PLATFORM",  planBusinessCommons)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-COMMONS",  planAdmin)
modPlan.addPlanAfterDeleteIfExists(root, "ADMIN-PROCESS",  planCustomer)
modPlan.addPlanAfterDeleteIfExists(root, "CUSTOMER-PROCESS", planBusinessCommonsPlatform)