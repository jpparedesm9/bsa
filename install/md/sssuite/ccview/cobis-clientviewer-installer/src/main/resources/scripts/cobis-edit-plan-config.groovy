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

def planProductReportImpl = new Node(null, "plan",
	[ id: "cobis-reports",
	  reloadable: "true"])
	   
planProductReportImpl.append(new Node(null, "plugin",
	[name: "groovy",
	 path:"../../clientviewer/plugins/reports/groovy-all-2.0.1.jar"]))	 

planProductReportImpl.append(new Node(null, "plugin",
	[name: "jasperreports-fonts-5.1.0",
	 path:"../../clientviewer/plugins/reports/jasperreports-fonts-5.1.0.jar"]))	 	 

planProductReportImpl.append(new Node(null, "plugin",
	[name: "jxl",
	 path:"../../clientviewer/plugins/reports/jxl-2.6.6.jar"]))	 	 
	 
planProductReportImpl.append(new Node(null, "plugin",
	[name: "jasperreports",
	 path:"../../clientviewer/plugins/reports/jasperreports-5.1.0.jar"]))	 	 	 


	 
def planRemittancesBase = new Node(null, "plan",
	[ id: "BankingServicesVCC",
	  reloadable: "true"])
	  
planRemittancesBase.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.BankingServices.Remittance.DTO",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.BankingServices.Remittance.DTO-1.0.0.0.jar"]))
	 
planRemittancesBase.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.BankingServices.Remittance.Service",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.BankingServices.Remittance.Service-1.0.0.0.jar"]))



def remittancevcc = new Node(null, "plan",
	[ id: "RemittanceVCC",
	  reloadable: "true"])

remittancevcc.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.Remittance.DTO",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.Remittance.DTO-1.0.0.0.jar"]))
	 
remittancevcc.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.Remittance.Service",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.Remittance.Service-1.0.0.0.jar"]))
	 


 
def planContactManagementCustomer = new Node(null, "plan",
	[ id: "ContactManagementCustomerVCC",
	  reloadable: "true"])
	  
planContactManagementCustomer.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.ContactManagement.DTO",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.ContactManagement.DTO-1.0.0.0.jar"]))
	 
planContactManagementCustomer.append(new Node(null, "plugin",
	[name: "COBISCorp.eCOBIS.ContactManagement.Service",
	 path: "../../clientviewer/plugins/COBISCorp.eCOBIS.ContactManagement.Service-1.0.0.0.jar"]))		 

	 
	 

def VCCServiceDto = new Node(null, "plan",
	[ id: "VCCService-dto",
	  reloadable: "true"])

VCCServiceDto.append(new Node(null, "plugin",
	[name: "cobis-clientviewer-dto",
	 path: "../../clientviewer/plugins/cobis-clientviewer-dto-1.0.0.jar"]))

def VCCServiceDal = new Node(null, "plan",
	[ id: "VCCService-dal",
	  reloadable: "true"])
	  
VCCServiceDal.append(new Node(null, "plugin",
	[name: "cobis-clientviewer-dal",
	 path: "../../clientviewer/plugins/cobis-clientviewer-dal-1.0.0.jar"]))

def VCCServiceExternalServiceBl = new Node(null, "plan",
	[ id: "VCCService-external-service-bl",
	  reloadable: "true"])
	  
VCCServiceExternalServiceBl.append(new Node(null, "plugin",
	[name: "cobis-external-services-bl",
	 path: "../../clientviewer/plugins/cobis-external-services-bl-1.0.0.jar"]))
	 
def VCCServiceBl = new Node(null, "plan",
	[ id: "VCCService-bl",
	  reloadable: "true"])	 
	 
VCCServiceBl.append(new Node(null, "plugin",
	[name: "cobis-clientviewer-bl",
	 path: "../../clientviewer/plugins/cobis-clientviewer-bl-1.0.0.jar"]))

def VCCServiceService = new Node(null, "plan",
	[ id: "VCCService-service",
	  reloadable: "true"])	
	  
VCCServiceService.append(new Node(null, "plugin",
	[name: "cobis-clientviewer-services",
	 path: "../../clientviewer/plugins/cobis-clientviewer-services-1.0.0.jar"]))


	 
	 
	 
def VCCWebDTO = new Node(null, "plan",
	[ id: "VCCWeb-dto",
	  reloadable: "true"])

VCCWebDTO.append(new Node(null, "plugin",
	[name: "cobis-web-clientviewer-dto",
	 path: "../../clientviewer/plugins/cobis-web-clientviewer-dto-1.0.0.jar"]))
	 
def VCCWebServices = new Node(null, "plan",
	[ id: "VCCWeb-services",
	  reloadable: "true"])	 

VCCWebServices.append(new Node(null, "plugin",
	[name: "cobis-web-clientviewer-services",
	 path: "../../clientviewer/plugins/cobis-web-clientviewer-services-1.0.0.jar"]))

def VCCWebExternalServices = new Node(null, "plan",
	[ id: "VCCWeb-external-services",
	  reloadable: "true"])
	  
VCCWebExternalServices.append(new Node(null, "plugin",
	[name: "cobis-web-clientviewer-external-services",
	 path: "../../clientviewer/plugins/cobis-web-clientviewer-external-services-1.0.0.jar"]))
	 
def VCCReporting = new Node(null, "plan",
	[ id: "VCC-reporting",
	  reloadable: "true"])	 
	 
VCCReporting.append(new Node(null, "plugin",
	[name: "report-clientviewer",
	 path: "../../clientviewer/plugins/report-clientviewer-impl-1.0.0.jar"]))
	 
	 
	 

def adminvcc = new Node(null, "plan",
	[ id: "admin-vcc",
	  reloadable: "true"])
	  
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.tasksectionsmaintaining.services",
	 path: "../../clientviewer/plugins/latfo.ucspm.tasksectionsmaintaining.services-1.0.0.jar"]))
	 
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.tasksectionsmaintaining.customevents",
	 path: "../../clientviewer/plugins/latfo.ucspm.tasksectionsmaintaining.customevents-1.0.0.jar"]))
	 
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.taskdtolist.services",
	 path: "../../clientviewer/plugins/latfo.ucspm.taskdtolist.services-1.0.0.jar"]))
	 
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.taskdtolist.customevents",
	 path: "../../clientviewer/plugins/latfo.ucspm.taskdtolist.customevents-1.0.0.jar"]))
	 
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.taskdtomaintaining.services",
	 path: "../../clientviewer/plugins/latfo.ucspm.taskdtomaintaining.services-1.0.0.jar"]))
	 
adminvcc.append(new Node(null, "plugin",
	[name: "latfo.ucspm.taskdtomaintaining.customevents",
	 path: "../../clientviewer/plugins/latfo.ucspm.taskdtomaintaining.customevents-1.0.0.jar"]))
	 
//Añade el node después de MakerAndChecker ó si no existe lo añade después de workflow-report
//Si no existen los dos nodos, añade al final del archivo la información

modPlan.removePlan(root,"VCCService-externalServicebl")
modPlan.removePlan(root,"cobis-web-clientviewer-dto")
modPlan.removePlan(root,"cobis-web-clientviewer-services")
modPlan.removePlan(root,"cobis-web-clientviewer-external-services")
modPlan.removePlan(root,"clientviewer-reporting-service")

modPlan.addPlanAfterDeleteIfExistsAndOtherPlan(root, "cobis-sales-services","MakerAndChecker", planRemittancesBase)
modPlan.addPlanAfterDeleteIfExists(root, "BankingServicesVCC", remittancevcc)
modPlan.addPlanAfterDeleteIfExists(root, "RemittanceVCC", planContactManagementCustomer)
modPlan.addPlanAfterDeleteIfExists(root, "ContactManagementCustomerVCC", planProductReportImpl)

modPlan.addPlanAfterDeleteIfExists(root, "cobis-reports", VCCServiceDto)
modPlan.addPlanAfterDeleteIfExists(root, "VCCService-dto", VCCServiceDal)
modPlan.addPlanAfterDeleteIfExists(root, "VCCService-dal", VCCServiceExternalServiceBl)
modPlan.addPlanAfterDeleteIfExists(root, "VCCService-external-service-bl", VCCServiceBl)
modPlan.addPlanAfterDeleteIfExists(root, "VCCService-bl", VCCServiceService)

modPlan.addPlanAfterDeleteIfExists(root, "VCCService-service", VCCWebDTO)
modPlan.addPlanAfterDeleteIfExists(root, "VCCWeb-dto", VCCWebServices)
modPlan.addPlanAfterDeleteIfExists(root, "VCCWeb-services", VCCWebExternalServices)
modPlan.addPlanAfterDeleteIfExists(root, "VCCWeb-external-services", VCCReporting)


modPlan.addPlanAfterDeleteIfExists(root, "VCC-reporting", adminvcc)

def planApiUcsp = new Node(null, "plan",[ id: "API-UCSP", reloadable: "true"])
planApiUcsp.append(new Node(null, "plugin",[name: "UCSP-Admin-DTO", path: "../../clientviewer/plugins/COBISCorp.eCOBIS.UCSP.Admin.DTO-4.2.0.0.jar"]))
planApiUcsp.append(new Node(null, "plugin",[name: "UCSP-Admin-Service", path: "../../clientviewer/plugins/COBISCorp.eCOBIS.UCSP.Admin.Service-4.2.0.0.jar"]))

modPlan.addPlanAfterDeleteIfExists(root,"API-PLATFORM", planApiUcsp)


