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


/* estos son planes de prueba deberan hacerse en funcion de cada producto, reeplazar product por el nombre del producto atm, branch*/
def modPlan = new ModifyPlans()

def planCollateralCommons = new Node(null, "plan",
	[ id: "collateral-commons",
	  reloadable: "true"])
	  
planCollateralCommons.append(new Node(null, "plugin",
	[name: "collateral.commons",
	 path: "../../COLLATERAL/plugins/wrrnt.commons-1.0.0.jar"]))
	 
planCollateralCommons.append(new Node(null, "plugin",
	[name: "collateral.domains",
	 path: "../../COLLATERAL/plugins/wrrnt.domains-1.0.0.jar"]))



def planCollateralMantenaince = new Node(null, "plan",
	[ id: "collateral-mantenaince",
	  reloadable: "true"])

planCollateralMantenaince.append(new Node(null, "plugin",
	[name: "wrrnt.mntnn.liberation.customevents",
	 path: "../../COLLATERAL/plugins/wrrnt.mntnn.liberation.customevents-1.0.0.jar"]))
	 
planCollateralMantenaince.append(new Node(null, "plugin",
	[name: "wrrnt.mntnn.liberation.services",
	 path: "../../COLLATERAL/plugins/wrrnt.mntnn.liberation.services-1.0.0.jar"]))
	 
planCollateralMantenaince.append(new Node(null, "plugin",
	[name: "wrrnt.mntnn.changevalue.customevents",
	 path: "../../COLLATERAL/plugins/wrrnt.mntnn.changevalue.customevents-1.0.0.jar"]))
	 
planCollateralMantenaince.append(new Node(null, "plugin",
	[name: "wrrnt.mntnn.changevalue.services",
	 path: "../../COLLATERAL/plugins/wrrnt.mntnn.changevalue.services-1.0.0.jar"]))
	 
	 
def planCollateralWebServices = new Node(null, "plan",
	[ id: "COLLATERAL-WEB-SERVICES",
	  reloadable: "true"])
	   
planCollateralWebServices.append(new Node(null, "plugin",
	[name: "cobis-collateral-web-service",
	 path:"../../COLLATERAL/plugins/cobis-collateral-web-service-1.0.0.jar"]))	 



modPlan.addConfigAtTheEndDeleteIfExist(root,  planCollateralCommons)
modPlan.addConfigAtTheEndDeleteIfExist(root,  planCollateralMantenaince)
modPlan.addConfigAtTheEndDeleteIfExist(root,  planCollateralWebServices)


