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
//SG LoansGroup
def planLoanGroupSG = new Node(null, "plan", [ id: "LOANS-GROUP", reloadable: "true"])
planLoanGroupSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanGroup.DTO", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanGroup.DTO-1.0.0.0.jar"]))
planLoanGroupSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanGroup.Service", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanGroup.Service-1.0.0.0.jar"]))

//SG LoansProcess
def planLoanProcessSG = new Node(null, "plan", [ id: "LOANS-PROCESS", reloadable: "true"])
planLoanProcessSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanProcess.DTO", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanProcess.DTO-1.0.0.0.jar"]))
planLoanProcessSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanProcess.Service", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanProcess.Service-1.0.0.0.jar"]))

//SG Colective
def plancolectiveSG = new Node(null, "plan", [ id: "Collective-SG", reloadable: "true"])
plancolectiveSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Entity.Collective.DTO", path: "../../COLLECTIVE-CLIENT/plugins/COBISCorp.eCOBIS.Entity.Collective.DTO-1.0.0.0.jar"]))
plancolectiveSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Entity.Collective.Service", path: "../../COLLECTIVE-CLIENT/plugins/COBISCorp.eCOBIS.Entity.Collective.Service-1.0.0.0.jar"]))

//SG LoansGroup domains
def planLoanGroupDomains = new Node(null, "plan", [ id: "loans-group-domains", reloadable: "true"])
planLoanGroupDomains.append(new Node(null, "plugin", [name: "loans-group.domains", path: "../../LOANS-GROUP/plugins/loans.domains-1.0.0.jar"]))

//SG Colective domains
def planColectiveDomains = new Node(null, "plan", [ id: "collective-domains", reloadable: "true"])
planColectiveDomains.append(new Node(null, "plugin", [name: "clcol.domains", path: "../../COLLECTIVE-CLIENT/plugins/clcol.domains-1.0.0.jar"]))

//SG Colective commons
def planColectiveCommosDomains = new Node(null, "plan", [ id: "collective-commons", reloadable: "true"])
planColectiveCommosDomains.append(new Node(null, "plugin", [name: "collective-commons-utils", path: "../../COLLECTIVE-CLIENT/plugins/collective-commons-utils-1.0.0.jar"]))
planColectiveCommosDomains.append(new Node(null, "plugin", [name: "collective-commons-services", path: "../../COLLECTIVE-CLIENT/plugins/collective-commons-services-1.0.0.jar"]))

//SG LoansGroup CustomEvents
def planLoanGroupCustomEvents = new Node(null, "plan", [ id: "loans-group-customevents", reloadable: "true"])
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans-group.groupcomposite.customevents", path: "../../LOANS-GROUP/plugins/loans.group.groupcomposite.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.memberpoppupform.customevents", path: "../../LOANS-GROUP/plugins/loans.group.memberpoppupform.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.reportsettlementsheet.customevents", path: "../../LOANS-GROUP/plugins/loans.group.reportsettlementsheet.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.reportgroupaccountstatement.customevents", path: "../../LOANS-GROUP/plugins/loans.group.reportgroupaccountstatement.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "cobis-loans-process-web-reports", path: "../../LOANS-GROUP/plugins/cobis-loans-process-web-reports-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.scanneddocuments.customevents", path: "../../LOANS-GROUP/plugins/loans.group.scanneddocuments.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.scanneddocumentsdetail.customevents", path: "../../LOANS-GROUP/plugins/loans.group.scanneddocumentsdetail.customevents-1.0.0.jar"]))
planLoanGroupCustomEvents.append(new Node(null, "plugin", [name: "loans.group.memberrisklevelform.customevents", path: "../../LOANS-GROUP/plugins/loans.group.memberrisklevelform.customevents-1.0.0.jar"]))

//SG LoansGroup CustomEventsServices
def planLoanGroupCustomServices = new Node(null, "plan", [ id: "loans-group-services", reloadable: "true"])
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.memberpoppupform.services", path: "../../LOANS-GROUP/plugins/loans.group.memberpoppupform.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.groupcomposite.services", path: "../../LOANS-GROUP/plugins/loans.group.groupcomposite.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.reportgroupaccountstatement.services", path: "../../LOANS-GROUP/plugins/loans.group.reportgroupaccountstatement.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.reportsettlementsheet.services", path: "../../LOANS-GROUP/plugins/loans.group.reportsettlementsheet.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.scanneddocuments.services", path: "../../LOANS-GROUP/plugins/loans.group.scanneddocuments.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.scanneddocumentsdetail.services", path: "../../LOANS-GROUP/plugins/loans.group.scanneddocumentsdetail.services-1.0.0.jar"]))
planLoanGroupCustomServices.append(new Node(null, "plugin", [name: "loans.group.memberrisklevelform.services", path: "../../LOANS-GROUP/plugins/loans.group.memberrisklevelform.services-1.0.0.jar"]))

//SG Colective CustomEvents
def planColectiveCustomEvents = new Node(null, "plan", [ id: "collective-events", reloadable: "true"])
planColectiveCustomEvents.append(new Node(null, "plugin", [name: "clcol.cltvo.loadcollectiveperson.customevents", path: "../../COLLECTIVE-CLIENT/plugins/clcol.cltvo.loadcollectiveperson.customevents-1.0.0.jar"]))
planColectiveCustomEvents.append(new Node(null, "plugin", [name: "clcol.cltvo.loadexternaladvisor.customevents", path: "../../COLLECTIVE-CLIENT/plugins/clcol.cltvo.loadexternaladvisor.customevents-1.0.0.jar"]))

//SG Colective CustomEventsServices
def planColectiveCustomServices = new Node(null, "plan", [ id: "collective-services", reloadable: "true"])
planColectiveCustomServices.append(new Node(null, "plugin", [name: "clcol.cltvo.loadcollectiveperson.services", path: "../../COLLECTIVE-CLIENT/plugins/clcol.cltvo.loadcollectiveperson.services-1.0.0.jar"]))
planColectiveCustomServices.append(new Node(null, "plugin", [name: "clcol.cltvo.loadexternaladvisor.services", path: "../../COLLECTIVE-CLIENT/plugins/clcol.cltvo.loadexternaladvisor.services-1.0.0.jar"]))

//SG Colective Report
def planColectiveReport = new Node(null, "plan", [ id: "collective-reports", reloadable: "true"])
planColectiveReport.append(new Node(null, "plugin", [name: "report-collective-impl", path: "../../COLLECTIVE-CLIENT/plugins/report-collective-impl-1.0.0.jar"]))


modPlan.addPlanAfterDeleteIfExists(root, "API-PLATFORM",  planLoanGroupSG)
modPlan.addPlanAfterDeleteIfExists(root, "API-PLATFORM",  planLoanProcessSG)
modPlan.addPlanAfterDeleteIfExists(root, "API-PLATFORM",  plancolectiveSG)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-REST",  planLoanGroupDomains)
modPlan.addPlanAfterDeleteIfExists(root, "loans-group-domains",  planLoanGroupCustomEvents)
modPlan.addPlanAfterDeleteIfExists(root, "loans-group-customevents",  planLoanGroupCustomServices)
modPlan.addPlanAfterDeleteIfExists(root, "loans-group-services",  planColectiveDomains)
modPlan.addPlanAfterDeleteIfExists(root, "collective-domains",  planColectiveCommosDomains)
modPlan.addPlanAfterDeleteIfExists(root, "collective-commons",  planColectiveCustomEvents)
modPlan.addPlanAfterDeleteIfExists(root, "collective-events",  planColectiveCustomServices)
modPlan.addPlanAfterDeleteIfExists(root, "collective-services",  planColectiveReport)






