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
            
            //Si no encuentra los dos nodos especificados agrega al final del archivo la informacion
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
		
		// Metodo que remueve un plan, segun su identificador indicado.
		void removePlan(Node rootVar, Object id) {
			def configs =  rootVar.own[0].children()
			def config = configs.find { it.@id == id }
			if(config != null) {
				 configs.remove(config)
			}
		}
}

/* estos son planes de prueba deberan hacerse en funcion de cada producto, reeplazar product por el nombre del producto atm, branch*/
def modPlan = new ModifyPlans()

def b2cSG = new Node(null, "plan",
	[ id: "B2C-SG",
		  reloadable: "true"])
		  
b2cSG.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.BusinessToConsumer.DTO",
	 path: "../../Assets/B2C/COBISCorp.eCOBIS.BusinessToConsumer.DTO-2.0.0.0.jar"]))
	 
b2cSG.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.BusinessToConsumer.Service",
	 path: "../../Assets/B2C/COBISCorp.eCOBIS.BusinessToConsumer.Service-2.0.0.0.jar"]))


def mobileBanking = new Node(null, "plan",
	[ id: "MobileBanking",
		  reloadable: "true"])

mobileBanking.append(new Node(null, "plugin",
	[name: "cobis-b2c-jwt",
	 path: "../plugins/channels/MB/cobis-b2c-jwt-1.0-SNAPSHOT.jar"]))
	 
mobileBanking.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.MobileBanking.DTO",
	 path: "../plugins/channels/MB/COBISCorp.eCOBIS.MobileBanking.DTO-4.6.1.0.jar"]))
	 
mobileBanking.append(new Node(null, "plugin",
	[name: "commons-lang3",
	 path: "../plugins/channels/MB/commons-lang3-3.2.1.jar"]))
	 
mobileBanking.append(new Node(null, "plugin",
	[name: "cobis-mb-services-dtos",
	 path: "../plugins/channels/MB/cobis-mb-services-dtos-1.0.1.jar"]))

mobileBanking.append(new Node(null, "plugin",
	[name: "cobis-mb-services-interfaces",
	 path: "../plugins/channels/MB/cobis-mb-services-interfaces-1.0.1.jar"]))
	 
mobileBanking.append(new Node(null, "plugin",
	[name: "cobis-mb-services-impl",
	 path: "../plugins/channels/MB/cobis-mb-services-impl-1.0.1.jar"]))

def mobileBankingRest = new Node(null, "plan",
	[ id: "MobileBanking-Rest",
		  reloadable: "true"])

mobileBankingRest.append(new Node(null, "plugin",
	[name: "cobis-mb-services-integration",
	 path: "../plugins/channels/MB/cobis-mb-services-integration-1.0.1.jar"]))

modPlan.addConfigAtTheEndDeleteIfExist(root, b2cSG)	
modPlan.addConfigAtTheEndDeleteIfExist(root, mobileBanking)
modPlan.addConfigAtTheEndDeleteIfExist(root, mobileBankingRest)