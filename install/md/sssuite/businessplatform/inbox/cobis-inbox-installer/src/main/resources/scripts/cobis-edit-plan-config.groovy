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
}

/* plans */

def modPlan = new ModifyPlans()


	
def planStorageAlfresco = new Node(null, "plan",
	[ id: "inbox-storage-officeAlfresco",
	  reloadable: "true"])

planStorageAlfresco.append(new Node(null, "plugin",
	[name: "inbox-storage-officeAlfresco",
    path: "../../inbox/plugins/inbox-storage-alfresco-1.0.0.0.jar"]))
	

modPlan.addPlanAfterDeleteIfExists(root, "inbox-storage-office365", planStorageAlfresco)

