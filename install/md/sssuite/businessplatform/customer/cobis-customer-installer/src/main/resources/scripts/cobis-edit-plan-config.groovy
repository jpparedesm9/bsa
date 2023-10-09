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

/* estos son planes de prueba deberán hacerse en función de cada producto, reeplazar product por el nombre del producto atm, branch*/
def modPlan = new ModifyPlans()

def planCommonsDal = new Node(null, "plan",
	[ id: "cobis-commons-dal",
		  reloadable: "true"])

planCommonsDal.append(new Node(null, "plugin",
	[name: "cobis-commons-dal",
	 path: "../../CUSTOMER/plugins/cobis-commons-dal-1.0.0.jar"]))

def planCustomerApi = new Node(null, "plan",
	[ id: "cobis-customer-api",
	  reloadable: "true"])
planCustomerApi.append(new Node(null, "plugin",
	[name: "cobis-customer-api",
	 path: "../../CUSTOMER/plugins/cobis-customer-api-1.1.0.jar"]))
     

def planCustomerDal = new Node(null, "plan",
	[ id: "cobis-customer-dal",
	  reloadable: "true"])
planCustomerDal.append(new Node(null, "plugin",
	[name: "cobis-customer-dal",
	 path: "../../CUSTOMER/plugins/cobis-customer-dal-1.1.0.jar"]))
	 
def planCustomerBl = new Node(null, "plan",
	[ id: "cobis-customer-bl",
	  reloadable: "true"])
planCustomerBl.append(new Node(null, "plugin",
	[name: "cobis-customer-bl",
	 path: "../../CUSTOMER/plugins/cobis-customer-bl-1.1.0.jar"]))	 

	 
def planCustomerServices = new Node(null, "plan",
	[ id: "cobis-customer-services",
	  reloadable: "true"])
planCustomerServices.append(new Node(null, "plugin",
	[name: "cobis-customer-services",
	 path: "../../CUSTOMER/plugins/cobis-customer-services-1.1.0.jar"]))
planCustomerServices.append(new Node(null, "plugin",
	[name: "cobis-customer-web-service",
	 path: "../../CUSTOMER/plugins/cobis-customer-web-services-1.1.0.jar"]))


def planCommonsApi = new Node(null, "plan",
	[ id: "cobis-customer-commons-api",
	  reloadable: "true"])
planCommonsApi.append(new Node(null, "plugin",
	[name: "cobis-customer-commons-api",
	 path: "../../CUSTOMER/plugins/cobis-customer-commons-api-1.0.0.jar"]))
	 
def planCustoCommonsDal = new Node(null, "plan",
	[ id: "cobis-customer-commons-dal",
	  reloadable: "true"])
planCustoCommonsDal.append(new Node(null, "plugin",
	[name: "cobis-customer-commons-dal",
	 path: "../../CUSTOMER/plugins/cobis-customer-commons-dal-1.0.0.jar"]))
planCustoCommonsDal.append(new Node(null, "plugin",
	[name: "cobis-customer-commons-bl",
	 path: "../../CUSTOMER/plugins/cobis-customer-commons-bl-1.0.0.jar"]))		 
	 
def planCommonsImpl = new Node(null, "plan",
	[ id: "cobis-customer-commons-service",
	  reloadable: "true"])
planCommonsImpl.append(new Node(null, "plugin",
	[name: "cobis-customer-commons-service",
	 path: "../../CUSTOMER/plugins/cobis-customer-commons-services-1.0.0.jar"]))

planCommonsImpl.append(new Node(null, "plugin",
	[name: "cobis-customer-commons-web-service",
	 path: "../../CUSTOMER/plugins/cobis-customer-commons-web-services-1.0.0.jar"]))	 

def planAlfrescoIntegration = new Node(null, "plan",[ id: "ALFRESCO INTEGRATION",reloadable: "true"])
planAlfrescoIntegration.append(new Node(null, "plugin",
	[name: "cobis-web-servlet-storage-util",
	 path: "../../CUSTOMER/plugins/cobis-web-servlet-storage-util-1.0.0.jar"]))
planAlfrescoIntegration.append(new Node(null, "plugin",
	[name: "cobis-web-customer-servlet-file",
	 path: "../../CUSTOMER/plugins/cobis-web-customer-servlet-file-1.0.0.jar"]))




def planCustomerCommonsUtils = new Node(null, "plan",
	[ id: "customer-commons-utils",
	  reloadable: "true"])
planCustomerCommonsUtils.append(new Node(null, "plugin",
	[name: "customer-commons-utils",
	 path: "../../CUSTOMER/plugins/customer-commons-utils-1.0.0.jar"]))

def planCustomerCommonsServices = new Node(null, "plan",
	[ id: "customer-commons-services",
	  reloadable: "true"])
planCustomerCommonsServices.append(new Node(null, "plugin",
	[name: "customer-commons-services",
	 path: "../../CUSTOMER/plugins/customer-commons-services-1.0.0.jar"]))



def planDomainsAndEvents = new Node(null, "plan",
	[ id: "cstmr-domains-and-events",
	  reloadable: "true"])
planDomainsAndEvents.append(new Node(null, "plugin",
	[name: "cstmr.domains",
	 path: "../../CUSTOMER/plugins/cstmr.domains-1.0.0.jar"]))
planDomainsAndEvents.append(new Node(null, "plugin",
	[name: "cstmr.commons.events",
	 path: "../../CUSTOMER/plugins/cstmr.commons.events-1.0.0.jar"]))

	 //REPORTES
def planReportsWebCustomer = new Node(null, "plan",
	[ id: "cobis-reports-customer-web-reports",
	  reloadable: "true"])
planReportsWebCustomer.append(new Node(null, "plugin",
	[name: "cobis-reports-customer-web-reports",
	 path: "../../CUSTOMER/plugins/cobis-reports-customer-web-reports-1.0.0.jar"]))	 

	 //SCANNED DOCUMENTS
def planScannedDocuments = new Node(null, "plan",
	[ id: "scanned-documents",
	  reloadable: "true"])
planScannedDocuments.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.scanneddocuments.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.scanneddocuments.customevents-1.0.0.jar"]))
planScannedDocuments.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.scanneddocuments.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.scanneddocuments.services-1.0.0.jar"]))
planScannedDocuments.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.scanneddocuments.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.scanneddocumentsdetail.customevents-1.0.0.jar"]))
planScannedDocuments.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.scanneddocuments.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.scanneddocumentsdetail.services-1.0.0.jar"]))





	 
def planProspectWebEvents = new Node(null, "plan",
	[ id: "cstmr-prospect-customevents",
	  reloadable: "true"])
planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.prospectcomposite.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.prospectcomposite.customevents-1.0.0.jar"]))
planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.addressform.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.addressform.customevents-1.0.0.jar"]))

planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.businessform.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.businessform.customevents-1.0.0.jar"]))
	  
planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.businesspopupform.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.businesspopupform.customevents-1.0.0.jar"]))
	 
planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.referencesform.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.referencesform.customevents-1.0.0.jar"]))
	 
planProspectWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.referencespopupform.customevents",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.referencespopupform.customevents-1.0.0.jar"]))
	 
	 
	
def planProspectWebServices = new Node(null, "plan",
	[ id: "cstmr-prospect-services",
	  reloadable: "true"])
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.prospectcomposite.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.prospectcomposite.services-1.0.0.jar"]))
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.addressform.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.addressform.services-1.0.0.jar"]))
	 
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.businessform.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.businessform.services-1.0.0.jar"]))
	 
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.businesspopupform.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.businesspopupform.services-1.0.0.jar"]))
	 
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.referencesform.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.referencesform.services-1.0.0.jar"]))
	 
planProspectWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.referencespopupform.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.referencespopupform.services-1.0.0.jar"]))	 

	 
def planCustomerWebEvents = new Node(null, "plan",
	[ id: "cstmr-customer-customevents",
	  reloadable: "true"])
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.customercomposite.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.customercomposite.customevents-1.0.0.jar"]))
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.economicactivityform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.economicactivityform.customevents-1.0.0.jar"]))
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.economicactivitypopupform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.economicactivitypopupform.customevents-1.0.0.jar"]))
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.legalpersoncomposite.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.legalpersoncomposite.customevents-1.0.0.jar"]))

planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.relationform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.relationform.customevents-1.0.0.jar"]))	
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.modificationcurprfcform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.modificationcurprfcform.customevents-1.0.0.jar"]))
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.transferrequestform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.transferrequestform.customevents-1.0.0.jar"]))
planCustomerWebEvents.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.authorizationtransferform.customevents",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.authorizationtransferform.customevents-1.0.0.jar"]))			
	
	
def planCustomerWebServices = new Node(null, "plan",
	[ id: "cstmr-customer-services",
	  reloadable: "true"])
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.customercomposite.services",
	 path: "../../CUSTOMER/plugins/cstmr.cstmr.customercomposite.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.economicactivityform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.economicactivityform.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.economicactivitypopupform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.economicactivitypopupform.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.legalpersoncomposite.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.legalpersoncomposite.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.relationform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.relationform.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.modificationcurprfcform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.modificationcurprfcform.services-1.0.0.jar"]))	
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.transferrequestform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.transferrequestform.services-1.0.0.jar"]))
planCustomerWebServices.append(new Node(null, "plugin",
	[name: "cstmr.cstmr.authorizationtransferform.services",
	path: "../../CUSTOMER/plugins/cstmr.cstmr.authorizationtransferform.services-1.0.0.jar"]))			




	
modPlan.removePlan(root, "customer-commons-impl")
modPlan.addPlanAfterDeleteIfExistsAndOtherPlan(root, "cobis-admin-services","BUSINESS-PLATFORM-COMMONS",  planCommonsDal)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-commons-dal", planCustomerApi)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-api", planCustomerDal)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-dal", planCustomerBl)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-bl", planCustomerServices)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-services", planCommonsApi)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-commons-api", planCustoCommonsDal)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-commons-dal", planCommonsImpl)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-customer-commons-service", planCustomerCommonsUtils)

modPlan.addPlanAfterDeleteIfExists(root, "customer-commons-utils", planCustomerCommonsServices)
modPlan.addPlanAfterDeleteIfExists(root, "customer-commons-services", planDomainsAndEvents)
modPlan.addPlanAfterDeleteIfExists(root, "cstmr-domains-and-events", planScannedDocuments)
modPlan.addPlanAfterDeleteIfExists(root, "scanned-documents", planProspectWebEvents)
modPlan.addPlanAfterDeleteIfExists(root, "cstmr-prospect-customevents", planProspectWebServices)
modPlan.addPlanAfterDeleteIfExists(root, "cstmr-prospect-services", planCustomerWebEvents)
modPlan.addPlanAfterDeleteIfExists(root, "cstmr-customer-customevents", planCustomerWebServices)
modPlan.addPlanAfterDeleteIfExists(root, "cobis-reports-customer-web-reports", planReportsWebCustomer)


modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-services", planAlfrescoIntegration)

