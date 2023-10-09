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


def modPlan = new ModifyPlans()
/*SERVICIOS BACK-END - FPM*/
def planSevicesBackEnd = new Node(null, "plan",
	[ id: "FPMDao",
	  reloadable: "true"])
    planSevicesBackEnd.append(new Node(null, "plugin",
        [name: "fpm-dao",
         path: "../../FPM/plugins/fpm-dao-4.3.0.0.jar"]))
    planSevicesBackEnd.append(new Node(null, "plugin",
        [name: "fpm-cobis-portfolio-dao",
         path: "../../FPM/plugins/fpm-cobis-portfolio-dao-4.3.0.0.jar"]))
    planSevicesBackEnd.append(new Node(null, "plugin",
        [name: "fpm-cobis-catalogs-dao",
         path: "../../FPM/plugins/fpm-cobis-catalogs-dao-4.3.0.0.jar"]))

def planSevicesFPMCatalogs = new Node(null, "plan",
	[ id: "FPMCatalogs",
	  reloadable: "true"])
    planSevicesFPMCatalogs.append(new Node(null, "plugin",
        [name: "fpm-catalogs-services",
         path: "../../FPM/plugins/fpm-catalogs-services-4.3.0.0.jar"]))
    planSevicesFPMCatalogs.append(new Node(null, "plugin",
        [name: "fpm-cobis-catalogs-services-impl",
         path: "../../FPM/plugins/fpm-cobis-catalogs-services-impl-4.3.0.0.jar"]))

def planSevicesFPMServices = new Node(null, "plan",
	[ id: "FPMServices",
	  reloadable: "true"])
    planSevicesFPMServices.append(new Node(null, "plugin",
        [name: "fpm-services",
         path: "../../FPM/plugins/fpm-services-4.3.0.0.jar"]))
    planSevicesFPMServices.append(new Node(null, "plugin",
        [name: "fpm-cobis-portfolio-services",
         path: "../../FPM/plugins/fpm-cobis-portfolio-services-4.3.0.0.jar"]))
    planSevicesFPMServices.append(new Node(null, "plugin",
        [name: "fpm-services-integration",
         path: "../../FPM/plugins/fpm-services-integration-4.3.0.0.jar"]))

def planSevicesFPMServicesIntegration = new Node(null, "plan",
	[ id: "FPMServicesIntegration",
	  reloadable: "true"])
    planSevicesFPMServicesIntegration.append(new Node(null, "plugin",
        [name: "fpm-services-impl",
         path: "../../FPM/plugins/fpm-services-impl-4.3.0.0.jar"]))
    planSevicesFPMServicesIntegration.append(new Node(null, "plugin",
        [name: "fpm-cobis-portfolio-services-impl",
         path: "../../FPM/plugins/fpm-cobis-portfolio-services-impl-4.3.0.0.jar"]))
    planSevicesFPMServicesIntegration.append(new Node(null, "plugin",
        [name: "fpm-cobis-portfolio-services-integration-impl",
         path: "../../FPM/plugins/fpm-cobis-portfolio-services-integration-impl-4.3.0.0.jar"]))
    planSevicesFPMServicesIntegration.append(new Node(null, "plugin",
        [name: "fpm-cobis-administration-services-integration-impl",
         path: "../../FPM/plugins/fpm-cobis-administration-services-integration-impl-4.3.0.0.jar"]))

def planSevicesFPMExtractors = new Node(null, "plan",
	[ id: "FPMExtractorsServices",
	  reloadable: "true"])
    planSevicesFPMExtractors.append(new Node(null, "plugin",
        [name: "fpm-cobis-extractors-dao",
         path: "../../FPM/plugins/fpm-cobis-extractors-dao-4.3.0.0.jar"]))
    planSevicesFPMExtractors.append(new Node(null, "plugin",
        [name: "fpm-cobis-extractors-services",
         path: "../../FPM/plugins/fpm-cobis-extractors-services-4.3.0.0.jar"]))
    planSevicesFPMExtractors.append(new Node(null, "plugin",
        [name: "fpm-cobis-extractors-services-impl",
         path: "../../FPM/plugins/fpm-cobis-extractors-services-impl-4.3.0.0.jar"]))
  
def planSevicesFPMInterceptors = new Node(null, "plan",
	[ id: "FPMInterceptors",
	  reloadable: "true"])
    planSevicesFPMInterceptors.append(new Node(null, "plugin",
        [name: "fpm-cobis-portfolio-interceptors",
         path: "../../FPM/plugins/fpm-cobis-portfolio-interceptors-4.3.0.0.jar"]))

def planSevicesFPMExtractorData= new Node(null, "plan",
	[ id: "FPMExtractors",
	  reloadable: "true"])
    planSevicesFPMExtractorData.append(new Node(null, "plugin",
        [name: "COBISCorp.eCOBIS.ExtractorFPM.DTO",
         path: "../../FPM/plugins/COBISCorp.eCOBIS.ExtractorFPM.DTO-4.3.0.0.jar"]))
    planSevicesFPMExtractorData.append(new Node(null, "plugin",
        [name: "COBISCorp.eCOBIS.ExtractorFPM.Service",
         path: "../../FPM/plugins/COBISCorp.eCOBIS.ExtractorFPM.Service-4.3.0.0.jar"]))
    planSevicesFPMExtractorData.append(new Node(null, "plugin",
        [name: "COBISCorp.eCOBIS.ExtractorFPM.Service-Impl",
         path: "../../FPM/plugins/COBISCorp.eCOBIS.ExtractorFPM.Service-Impl-4.3.0.0.jar"]))

def planFPMProductManagment= new Node(null, "plan",
	[ id: "FPMProductmanagment",
	  reloadable: "true"])
    planFPMProductManagment.append(new Node(null, "plugin",
        [name: "cobis-productmanagment-api",
         path: "../../FPM/plugins/cobis-productmanagment-api-1.0.0.0.jar"]))
    planFPMProductManagment.append(new Node(null, "plugin",
        [name: "cobis-productmanagment-api-impl",
         path: "../../FPM/plugins/cobis-productmanagment-api-impl-1.0.0.0.jar"]))
   

/*SERVICIOS FRONT-END - FPM*/

def planCatalogsApi = new Node(null, "plan",
	[ id: "FPM-load-catalogs",
	  reloadable: "true"])

planCatalogsApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.catalogs",
	 path: "../../FPM/plugins/finpm.mprod.catalogs-1.0.0.jar"]))

def planDomainsApi = new Node(null, "plan",
	[ id: "FPM-web-domains",
	  reloadable: "true"])

planDomainsApi.append(new Node(null, "plugin",
	[name: "finpm.domains",
	 path: "../../FPM/plugins/finpm.domains-1.0.0.jar"]))

def planAdministrationApi = new Node(null, "plan",
	[ id: "FPM-web-administration-services",
	  reloadable: "true"])

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.financialgrouptask.services",
	 path: "../../FPM/plugins/finpm.mprod.financialgrouptask.services-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.financialgrouptask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.financialgrouptask.customevents-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.productgrouptask.services",
	 path: "../../FPM/plugins/finpm.mprod.productgrouptask.services-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.productgrouptask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.productgrouptask.customevents-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.definitionparameterstask.services",
	 path: "../../FPM/plugins/finpm.mprod.definitionparameterstask.services-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.definitionparameterstask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.definitionparameterstask.customevents-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.valuedetailtask.services",
	 path: "../../FPM/plugins/finpm.mprod.valuedetailtask.services-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.valuedetailtask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.valuedetailtask.customevents-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.validatordetailtask.services",
	 path: "../../FPM/plugins/finpm.mprod.validatordetailtask.services-1.0.0.jar"]))

planAdministrationApi.append(new Node(null, "plugin",
	[name: "finpm.mprod.validatordetailtask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.validatordetailtask.customevents-1.0.0.jar"]))



def planOperationServices= new Node(null, "plan",
	[ id: "FPM-web-operation-services",
	  reloadable: "true"])
planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.bankingproducttask.services",
	 path: "../../FPM/plugins/finpm.mprod.bankingproducttask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.bankingproducttask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.bankingproducttask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.itemspagetask.services",
	 path: "../../FPM/plugins/finpm.mprod.itemspagetask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.itemspagetask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.itemspagetask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.ruleselectortask.services",
	 path: "../../FPM/plugins/finpm.mprod.ruleselectortask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.ruleselectortask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.ruleselectortask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.currencypolicytask.services",
	 path: "../../FPM/plugins/finpm.mprod.currencypolicytask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.currencypolicytask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.currencypolicytask.customevents-1.0.0.jar"]))
	 
planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.selectoritembyproducttask.services",
	 path: "../../FPM/plugins/finpm.mprod.selectoritembyproducttask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.selectoritembyproducttask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.selectoritembyproducttask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.destinationpurposetask.services",
	 path: "../../FPM/plugins/finpm.mprod.destinationpurposetask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.destinationpurposetask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.destinationpurposetask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.itemstatustask.services",
	 path: "../../FPM/plugins/finpm.mprod.itemstatustask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.itemstatustask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.itemstatustask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.operationstatustask.services",
	 path: "../../FPM/plugins/finpm.mprod.operationstatustask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.operationstatustask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.operationstatustask.customevents-1.0.0.jar"]))


planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.accountingprofiletask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.accountingprofiletask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.accountingprofiletask.services",
	 path: "../../FPM/plugins/finpm.mprod.accountingprofiletask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.bankingproductmodalstask.services",
	 path: "../../FPM/plugins/finpm.mprod.bankingproductmodalstask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.bankingproductmodalstask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.bankingproductmodalstask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.historicquerytask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.historicquerytask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.historicquerytask.services",
	 path: "../../FPM/plugins/finpm.mprod.historicquerytask.services-1.0.0.jar"]))	 

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.rendertask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.rendertask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.rendertask.services",
	 path: "../../FPM/plugins/finpm.mprod.rendertask.services-1.0.0.jar"]))	 

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.displayrendertask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.displayrendertask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.displayrendertask.services",
	 path: "../../FPM/plugins/finpm.mprod.displayrendertask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.unitfunctionalitytask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.unitfunctionalitytask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.unitfunctionalitytask.services",
	 path: "../../FPM/plugins/finpm.mprod.unitfunctionalitytask.services-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.fieldbyproducttask.customevents",
	 path: "../../FPM/plugins/finpm.mprod.fieldbyproducttask.customevents-1.0.0.jar"]))

planOperationServices.append(new Node(null, "plugin",
	[name: "finpm.mprod.fieldbyproducttask.services",
	 path: "../../FPM/plugins/finpm.mprod.fieldbyproducttask.services-1.0.0.jar"]))

def planCatalogServices= new Node(null, "plan",
	[ id: "FPM-web-catalogs-services",
	  reloadable: "true"])
planCatalogServices.append(new Node(null, "plugin",
	[name: "cobis-web-fpm-catalogs-services",
	 path: "../../FPM/plugins/cobis-web-fpm-catalogs-services-1.0.0.jar"]))

def planWebServices= new Node(null, "plan",
	[ id: "FPM-web-services",
	  reloadable: "true"])
planWebServices.append(new Node(null, "plugin",
	[name: "cobis-web-fpm-services",
	 path: "../../FPM/plugins/cobis-web-fpm-services-1.0.0.jar"]))


//Añade el node después de inbox-file-servlet ó si no existe lo añade después de workflow-report
//Si no existen los dos nodos, añade al final del archivo la información
modPlan.addPlanAfterDeleteIfExistsAndOtherPlan(root,"inbox-file-servlet", "workflow-report", planSevicesBackEnd)

modPlan.addPlanAfterDeleteIfExists(root, "FPMDao", planFPMProductManagment)
modPlan.addPlanAfterDeleteIfExists(root, "FPMProductmanagment", planSevicesFPMCatalogs)
modPlan.addPlanAfterDeleteIfExists(root, "FPMCatalogs", planSevicesFPMServices)
modPlan.addPlanAfterDeleteIfExists(root, "FPMServices", planSevicesFPMServicesIntegration)
modPlan.addPlanAfterDeleteIfExists(root, "FPMServicesIntegration", planSevicesFPMExtractors)
modPlan.addPlanAfterDeleteIfExists(root, "FPMExtractorsServices", planSevicesFPMExtractorData)
modPlan.addPlanAfterDeleteIfExists(root, "FPMExtractors", planSevicesFPMInterceptors)

modPlan.addPlanAfterDeleteIfExists(root, "FPMInterceptors", planCatalogsApi)
modPlan.addPlanAfterDeleteIfExists(root, "FPM-load-catalogs", planDomainsApi)
modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-domains", planAdministrationApi)
modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-administration-services", planOperationServices)
modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-operation-services", planCatalogServices)
modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-catalogs-services", planWebServices)




