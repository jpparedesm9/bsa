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

//BUSINESS-PROCESS
def planBusiness = new Node(null, "plan", [ id: "BUSINESS-PROCESS", reloadable: "true"])
planBusiness.append(new Node(null, "plugin", [name: "busin.domains", path: "../../BUSINESSPROCESS/plugins/busin.domains-1.0.0.jar"]))
planBusiness.append(new Node(null, "plugin", [name: "busin.flcre.commons", path: "../../BUSINESSPROCESS/plugins/busin.flcre.commons-1.0.0.jar"]))

//ADMIN-PROCESS
def planAdmin = new Node(null, "plan", [ id: "ADMIN-PROCESS", reloadable: "true"])
planAdmin.append(new Node(null, "plugin", [name: "System.Configuration.DTO", path: "../../ADMIN/plugins/COBISCorp.eCOBIS.SystemConfiguration.DTO-2.0.0.0.jar"]))
planAdmin.append(new Node(null, "plugin", [name: "System.Configuration.Service", path: "../../ADMIN/plugins/COBISCorp.eCOBIS.SystemConfiguration.Service-2.0.0.0.jar"]))


//CUSTOMER-PROCESS
def planCustomer = new Node(null, "plan", [ id: "CUSTOMER-PROCESS", reloadable: "true"])
planCustomer.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Customer.DTO", path: "../../CUSTOMER/plugins/COBISCorp.eCOBIS.CustomerDataManagement.DTO-2.1.0.0.jar"]))
planCustomer.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Customer.Service", path: "../../CUSTOMER/plugins/COBISCorp.eCOBIS.CustomerDataManagementService.Service-2.1.0.0.jar"]))

//ACCOUNT-PROCESS
def planAccount = new Node(null, "plan", [ id: "ACCOUNT-PROCESS", reloadable: "true"])
planAccount.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Account.DTO", path: "../../ACCOUNT/plugins/COBISCorp.eCOBIS.Account.DTO-2.0.0.0.jar"]))
planAccount.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Account.Service", path: "../../ACCOUNT/plugins/COBISCorp.eCOBIS.Account.Service-2.0.0.0.jar"]))

//CAF-PROCESS
def planCAF = new Node(null, "plan", [ id: "CAF-PROCESS", reloadable: "true"])
planCAF.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.FinanEval.FinanEvalQuery.DTO", path: "../../CAF/plugins/COBISCorp.eCOBIS.FinanEval.FinanEvalQuery.DTO-2.0.0.0.jar"]))
planCAF.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.FinanEval.FinanEvalQuery.Service", path: "../../CAF/plugins/COBISCorp.eCOBIS.FinanEval.FinanEvalQuery.Service-2.0.0.0.jar"]))

//MONEYMARKET-PROCESS
def planMoneyMarket = new Node(null, "plan", [ id: "MONEYMARKET-PROCESS", reloadable: "true"])
planMoneyMarket.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.MoneyMarket.DTO", path: "../../MONEYMARKET/plugins/COBISCorp.eCOBIS.MoneyMarket.DTO-2.0.0.0.jar"]))
planMoneyMarket.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.MoneyMarket.Service", path: "../../MONEYMARKET/plugins/COBISCorp.eCOBIS.MoneyMarket.Service-2.0.0.0.jar"]))


//CREDIT-REPORT-VALIDATION-PROCESS
def planCreditReportValidation = new Node(null, "plan", [ id: "CREDIT-REPORT-VALIDATION-PROCESS", reloadable: "true"])
planCreditReportValidation.append(new Node(null, "plugin", [name: "Credit.Report.Validation.DTO", path: "../../BUSINESSPROCESS/plugins/COBISCorp.eCOBIS.Credit.Report.Validation.DTO-1.0.0.0.jar"]))
planCreditReportValidation.append(new Node(null, "plugin", [name: "Credit.Report.Validation.Service", path: "../../BUSINESSPROCESS/plugins/COBISCorp.eCOBIS.Credit.Report.Validation.Service-1.0.0.0.jar"]))


//CREDIT-FACILITY-PROCESS
def planCreditFacility = new Node(null, "plan", [ id: "CREDIT-FACILITY-PROCESS", reloadable: "true"])
planCreditFacility.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.CreditFacility.DTO", path: "../../BUSINESSPROCESS/plugins/COBISCorp.eCOBIS.CreditFacility.DTO-1.0.0.0.jar"]))
planCreditFacility.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.CreditFacility.Service", path: "../../BUSINESSPROCESS/plugins/COBISCorp.eCOBIS.CreditFacility.Service-1.0.0.0.jar"]))

//LOANS-GROUP
def planLoansGroup = new Node(null, "plan", [ id: "LOANS-GROUP", reloadable: "true"])
planLoansGroup.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanGroup.DTO", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanGroup.DTO-1.0.0.0.jar"]))
planLoansGroup.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanGroup.Service", path: "../../LOANS-GROUP/plugins/COBISCorp.eCOBIS.LoanGroup.Service-1.0.0.0.jar"]))

//COLLATERAL
def planCollateral = new Node(null, "plan", [ id: "COLLATERAL-PROCESS", reloadable: "true"])
planCollateral.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.LoanRequest.General.DTO", path: "../../COLLATERAL/plugins/COBISCorp.eCOBIS.LoanRequest.General.DTO-2.0.0.0.jar"])) 
planCollateral.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Collateral.DTO", path: "../../COLLATERAL/plugins/COBISCorp.eCOBIS.Collateral.DTO-2.0.0.0.jar"]))
planCollateral.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Collateral.Service", path: "../../COLLATERAL/plugins/COBISCorp.eCOBIS.Collateral.Service-2.0.0.0.jar"]))



//BUSINESS-COMMONS-PLATFORM
def planBusinessCommonsPlatform = new Node(null, "plan", [ id: "BUSINESS-PLATFORM-COMMONS", reloadable: "true"])
planBusinessCommonsPlatform.append(new Node(null, "plugin", [name: "business-commons-platform-utils", path: "../../BUSINESSCOMMONSPLATFORM/plugins/business-commons-platform-utils-1.0.0.jar"]))
planBusinessCommonsPlatform.append(new Node(null, "plugin", [name: "business-commons-platform-services", path: "../../BUSINESSCOMMONSPLATFORM/plugins/business-commons-platform-services-1.0.0.jar"]))


//BUSINESS PROCESS EVENTS
def planBPGenericAplication = new Node(null, "plan", [ id: "BUSINESS-PROCESS-GENERIC-APPLICATION", reloadable: "true"])
planBPGenericAplication.append(new Node(null, "plugin", [name: "busin.flcre.genericapplication.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.genericapplication.services-1.0.0.jar"]))
planBPGenericAplication.append(new Node(null, "plugin", [name: "busin.flcre.genericapplication.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.genericapplication.customevents-1.0.0.jar"]))

def planBPPaymentPlan = new Node(null, "plan", [ id: "BUSINESS-PROCESS-PLAYMENT-PLAN", reloadable: "true"])
planBPPaymentPlan.append(new Node(null, "plugin", [name: "busin.flcre.tpaymentplan.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.tpaymentplan.services-1.0.0.jar"]))
planBPPaymentPlan.append(new Node(null, "plugin", [name: "busin.flcre.tpaymentplan.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.tpaymentplan.customevents-1.0.0.jar"]))

def planBPApplication = new Node(null, "plan", [ id: "BUSINESS-PROCESS-APPLICATION", reloadable: "true"])
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.entrywarranty.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.entrywarranty.services-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.entrywarranty.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.entrywarranty.customevents-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.guaranteessearch.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.guaranteessearch.services-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.guaranteessearch.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.guaranteessearch.customevents-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.plazofijoporcliente.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.plazofijoporcliente.services-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.plazofijoporcliente.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.plazofijoporcliente.customevents-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.editentityinsharedwarranty.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.editentityinsharedwarranty.services-1.0.0.jar"]))
planBPApplication.append(new Node(null, "plugin", [name: "busin.flcre.editentityinsharedwarranty.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.editentityinsharedwarranty.customevents-1.0.0.jar"]))

def planBPDisbursement = new Node(null, "plan", [ id: "BUSINESS-PROCESS-DISBURSEMENT", reloadable: "true"])
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskdisbursementform.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskdisbursementform.services-1.0.0.jar"]))
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskdisbursementform.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskdisbursementform.customevents-1.0.0.jar"]))
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskconsultdisbursementforms.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskconsultdisbursementforms.services-1.0.0.jar"]))
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskconsultdisbursementforms.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskconsultdisbursementforms.customevents-1.0.0.jar"]))
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskdisbursementincome.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskdisbursementincome.services-1.0.0.jar"]))
planBPDisbursement.append(new Node(null, "plugin", [name: "busin.flcre.taskdisbursementincome.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.taskdisbursementincome.customevents-1.0.0.jar"]))

def planBPDataVerificationServices = new Node(null, "plan", [ id: "BUSINESS-PROCESS-VERIF-DATA-SERVICES", reloadable: "true"])
planBPDataVerificationServices.append(new Node(null, "plugin", [name: "busin.flcre.dataverificationquestions.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.dataverificationquestions.customevents-1.0.0.jar"]))
planBPDataVerificationServices.append(new Node(null, "plugin", [name: "busin.flcre.dataverificationquestionscompound.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.dataverificationquestionscompound.services-1.0.0.jar"]))

def planBPDataVerificationCustom = new Node(null, "plan", [ id: "BUSINESS-PROCESS-VERIF-DATA-CUSTOMEVENTS", reloadable: "true"])
planBPDataVerificationCustom.append(new Node(null, "plugin", [name: "busin.flcre.dataverificationquestions.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.dataverificationquestions.services-1.0.0.jar"]))
planBPDataVerificationCustom.append(new Node(null, "plugin", [name: "busin.flcre.dataverificationquestionscompound.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.dataverificationquestionscompound.customevents-1.0.0.jar"]))


def planprintDocument = new Node(null, "plan", [ id: "BUSINESS-PROCESS-PRINTING-ACTIVITY", reloadable: "true"])
planprintDocument.append(new Node(null, "plugin", [name: "busin.flcre.printingactivity.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.printingactivity.customevents-1.0.0.jar"]))
planprintDocument.append(new Node(null, "plugin", [name: "busin.flcre.printingactivity.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.printingactivity.services-1.0.0.jar"]))

def planBPReprintDocument = new Node(null, "plan", [ id: "BUSINESS-PROCESS-REPRINT-DOCUMENT", reloadable: "true"])
planBPReprintDocument.append(new Node(null, "plugin", [name: "busin.flcre.reprintdocument.customevents", path: "../../BUSINESSPROCESS/plugins/busin.flcre.reprintdocument.customevents-1.0.0.jar"]))
planBPReprintDocument.append(new Node(null, "plugin", [name: "busin.flcre.reprintdocument.services", path: "../../BUSINESSPROCESS/plugins/busin.flcre.reprintdocument.services-1.0.0.jar"]))


//CONECTOR-ORCHESTATOR
def planBPConectorOrchestador = new Node(null, "plan", [ id: "CONECTOR-ORCHESTATOR", reloadable: "true"])
planBPConectorOrchestador.append(new Node(null, "plugin", [name: "cobis-business-process-connector", path: "../../BUSINESSPROCESS/plugins/cobis-business-process-connector-1.0.0.jar"]))
planBPConectorOrchestador.append(new Node(null, "plugin", [name: "cobis-business-process-orchestrator", path: "../../BUSINESSPROCESS/plugins/cobis-business-process-orchestrator-1.0.0.jar"]))

//REST
def planBusinessProcessRest = new Node(null, "plan", [ id: "BUSINESS-PROCESS-REST", reloadable: "true"])
planBusinessProcessRest.append(new Node(null, "plugin", [name: "cobis-web-busin-services", path: "../../BUSINESSPROCESS/plugins/cobis-web-busin-services-1.0.0.jar"]))



modPlan.removePlan(root, "BUSINESS-PROCESS-COMMONS")
modPlan.addPlanAfterDeleteIfExists(root, "API-PLATFORM",  planBusinessCommons)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-COMMONS",  planAdmin)
modPlan.addPlanAfterDeleteIfExists(root, "ADMIN-PROCESS",  planCreditReportValidation)
modPlan.addPlanAfterDeleteIfExists(root, "CREDIT-REPORT-VALIDATION-PROCESS",  planLoansGroup)
modPlan.addPlanAfterDeleteIfExists(root, "LOANS-GROUP",  planCustomer)
modPlan.addPlanAfterDeleteIfExists(root, "CUSTOMER-PROCESS",  planMoneyMarket)
modPlan.addPlanAfterDeleteIfExists(root, "MONEYMARKET-PROCES",  planCAF)
modPlan.addPlanAfterDeleteIfExists(root, "CAF-PROCES",  planCreditFacility)
modPlan.addPlanAfterDeleteIfExists(root, "CREDIT-FACILITY-PROCESS",  planAccount)
modPlan.addPlanAfterDeleteIfExists(root, "ACCOUNT-PROCESS", planCollateral)
modPlan.addPlanAfterDeleteIfExists(root, "COLLATERAL-PROCESS", planAccount)
modPlan.addPlanAfterDeleteIfExists(root, "cstmr-customer-services", planBPConectorOrchestador)
modPlan.addPlanAfterDeleteIfExists(root, "CONECTOR-ORCHESTATOR", planBusiness)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS", planBPGenericAplication)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-GENERIC-APPLICATION", planBPPaymentPlan)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-PLAYMENT-PLAN", planBPApplication)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-APPLICATION", planBPDisbursement)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-DISBURSEMENT", planBPDataVerificationServices)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-VERIF-DATA-SERVICES", planBPDataVerificationCustom)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-VERIF-DATA-CUSTOMEVENTS", planprintDocument)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-PRINTING-ACTIVITY", planBPReprintDocument)
modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-REPRINT-DOCUMENT", planBusinessProcessRest)





