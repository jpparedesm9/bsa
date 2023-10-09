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

}
//plugins
def planCommonsSG = new Node(null, "plan", [ id: "ASSETS-CLOUD-COMMONS-SG", reloadable: "true"])
planCommonsSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Assets.Cloud.DTO", path: "../../ASSETS/COBISCorp.eCOBIS.Assets.Cloud.DTO-2.0.0.0.jar"]))
planCommonsSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.Assets.Cloud.Service", path: "../../ASSETS/COBISCorp.eCOBIS.Assets.Cloud.Service-2.0.0.0.jar"]))
planCommonsSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.IndividualLoan.DTO", path: "../../ASSETS/COBISCorp.eCOBIS.IndividualLoan.DTO-2.0.0.0.jar"]))
planCommonsSG.append(new Node(null, "plugin", [name: "COBISCorp.eCOBIS.IndividualLoan.Service", path: "../../ASSETS/COBISCorp.eCOBIS.IndividualLoan.Service-2.0.0.0.jar"]))

def planCommons = new Node(null, "plan", [ id: "ASSETS-CLOUD-COMMONS", reloadable: "true"])
planCommons.append(new Node(null, "plugin", [name: "assts.domains", path: "../../ASSETS/commons/assts.domains-1.0.0.jar"]))
planCommons.append(new Node(null, "plugin", [name: "assts.commons.events", path: "../../ASSETS/commons/assts.commons.events-1.0.0.jar"])
planCommons.append(new Node(null, "plugin", [name: "cobis-alfresco-services", path: "../../ASSETS/commons/cobis-alfresco-services-1.0.0.jar"]))

def planCommonsServices = new Node(null, "plan", [ id: "ASSETS-CLOUD-COMMONS-SERVICES", reloadable: "true"])
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.loanheaderinfoform.services", path: "../../ASSETS/commons-events/assts.cmmns.loanheaderinfoform.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.loansearchform.services", path: "../../ASSETS/commons-events/assts.cmmns.loansearchform.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.loansearchgroupform.services", path: "../../ASSETS/commons-events/assts.cmmns.loansearchgroupform.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.loanstatuschangemain.services", path: "../../ASSETS/commons-events/assts.cmmns.loanstatuschangemain.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.loanstatuschangeform.services", path: "../../ASSETS/commons-events/assts.cmmns.loanstatuschangeform.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.statuslistform.services", path: "../../ASSETS/commons-events/assts.cmmns.statuslistform.services-1.0.0.jar"]))
planCommonsServices.append(new Node(null, "plugin", [name: "assts.cmmns.conciliationsearchform.services", path: "../../ASSETS/commons-events/assts.cmmns.conciliationsearchform.services-1.0.0.jar"]))

def planCommonsEvents = new Node(null, "plan", [ id: "ASSETS-CLOUD-COMMONS-EVENTS", reloadable: "true"])
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.loanheaderinfoform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.loanheaderinfoform.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.loansearchform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.loansearchform.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.loansearchgroupform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.loansearchgroupform.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.loanstatuschangemain.customevents", path: "../../ASSETS/commons-events/assts.cmmns.loanstatuschangemain.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.loanstatuschangeform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.loanstatuschangeform.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name:"assts.cmmns.statuslistform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.statuslistform.customevents-1.0.0.jar"]))
planCommonsEvents.append(new Node(null, "plugin", [name: "assts.cmmns.conciliationsearchform.customevents", path: "../../ASSETS/commons-events/assts.cmmns.conciliationsearchform.customevents-1.0.0.jar"]))

def planMtnServices = new Node(null, "plan", [ id: "ASSETS-CLOUD-MNTNN-SERVICES", reloadable: "true"])
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.amortizationquotedetailform.services", path: "../../ASSETS/management/assts.mntnn.amortizationquotedetailform.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.readjustmentdetalilsloanform.services", path: "../../ASSETS/management/assts.mntnn.readjustmentdetalilsloanform.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.reajuste.services", path: "../../ASSETS/management/assts.mntnn.reajuste.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.documentprintingmain.services", path: "../../ASSETS/management/assts.mntnn.documentprintingmain.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.beforeprintpaymentform.services", path: "../../ASSETS/management/assts.mntnn.beforeprintpaymentform.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.projectothercharges.services", path: "../../ASSETS/management/assts.mntnn.projectothercharges.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.othercharges.services", path: "../../ASSETS/management/assts.mntnn.othercharges.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.projectionquotaformmain.services", path: "../../ASSETS/management/assts.mntnn.projectionquotaformmain.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.documentprinting.services", path: "../../ASSETS/management/assts.mntnn.documentprinting.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.extendsquotaformmain.services", path: "../../ASSETS/management/assts.mntnn.extendsquotaformmain.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.paymentmaintenance.services", path: "../../ASSETS/management/assts.mntnn.paymentmaintenance.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.paymentmaintenancemodal.services", path: "../../ASSETS/management/assts.mntnn.paymentmaintenancemodal.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.valuerates.services", path: "../../ASSETS/management/assts.mntnn.valuerates.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.typeratesmodal.services", path: "../../ASSETS/management/assts.mntnn.typeratesmodal.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.ratesmodal.services", path: "../../ASSETS/management/assts.mntnn.ratesmodal.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.detailsaho.services", path: "../../ASSETS/management/assts.mntnn.detailsaho.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.solidaritypaymentform.services", path: "../../ASSETS/management/assts.mntnn.solidaritypaymentform.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.paymentapplication.services", path: "../../ASSETS/management/assts.mntnn.paymentapplication.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.fund.services", path: "../../ASSETS/management/assts.mntnn.fund.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.detailfund.services", path: "../../ASSETS/management/assts.mntnn.detailfund.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.disbursementreportsform.services", path: "../../ASSETS/management/assts.mntnn.disbursementreportsform.services-1.0.0.jar"]))
planMtnServices.append(new Node(null, "plugin", [name:"assts.mntnn.creditblockcomposite.services", path: "../../ASSETS/management/assts.mntnn.creditblockcomposite.services-1.0.0.jar"]))



def planMtnEvents = new Node(null, "plan", [ id: "ASSETS-CLOUD-MNTNN", reloadable: "true"])
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.amortizationquotedetailform.customevents", path: "../../ASSETS/management/assts.mntnn.amortizationquotedetailform.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.readjustmentdetalilsloanform.customevents", path: "../../ASSETS/management/assts.mntnn.readjustmentdetalilsloanform.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.reajuste.customevents", path: "../../ASSETS/management/assts.mntnn.reajuste.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.documentprintingmain.customevents", path: "../../ASSETS/management/assts.mntnn.documentprintingmain.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.beforeprintpaymentform.customevents", path: "../../ASSETS/management/assts.mntnn.beforeprintpaymentform.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.projectothercharges.customevents", path: "../../ASSETS/management/assts.mntnn.projectothercharges.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.othercharges.customevents", path: "../../ASSETS/management/assts.mntnn.othercharges.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.projectionquotaformmain.customevents", path: "../../ASSETS/management/assts.mntnn.projectionquotaformmain.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.documentprinting.customevents", path: "../../ASSETS/management/assts.mntnn.documentprinting.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.extendsquotaformmain.customevents", path: "../../ASSETS/management/assts.mntnn.extendsquotaformmain.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.paymentmaintenance.customevents", path: "../../ASSETS/management/assts.mntnn.paymentmaintenance.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.paymentmaintenancemodal.customevents", path: "../../ASSETS/management/assts.mntnn.paymentmaintenancemodal.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.valuerates.customevents", path: "../../ASSETS/management/assts.mntnn.valuerates.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.typeratesmodal.customevents", path: "../../ASSETS/management/assts.mntnn.typeratesmodal.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.ratesmodal.customevents", path: "../../ASSETS/management/assts.mntnn.ratesmodal.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.detailsaho.customevents", path: "../../ASSETS/management/assts.mntnn.detailsaho.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.solidaritypaymentform.customevents", path: "../../ASSETS/management/assts.mntnn.solidaritypaymentform.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.paymentapplication.customevents", path: "../../ASSETS/management/assts.mntnn.paymentapplication.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.fund.customevents", path: "../../ASSETS/management/assts.mntnn.fund.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.detailfund.customevents", path: "../../ASSETS/management/assts.mntnn.detailfund.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.disbursementreportsform.customevents", path: "../../ASSETS/management/assts.mntnn.disbursementreportsform.customevents-1.0.0.jar"]))
planMtnEvents.append(new Node(null, "plugin", [name:"assts.mntnn.creditblockcomposite.customevents", path: "../../ASSETS/management/assts.mntnn.creditblockcomposite.customevents-1.0.0.jar"]))


def planQueriesServices = new Node(null, "plan", [ id: "ASSETS-CLOUD-QUERIES-SERVICES", reloadable: "true"])
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.paymentdetailform.services", path: "../../ASSETS/querys/assts.qerys.paymentdetailform.services-1.0.0.jar"]))
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querygeneralinformationmain.services", path: "../../ASSETS/querys/assts.qerys.querygeneralinformationmain.services-1.0.0.jar"]))
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.debitorderprocessinglog.services", path: "../../ASSETS/querys/assts.qerys.debitorderprocessinglog.services-1.0.0.jar"]))
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querydocuments.services", path: "../../ASSETS/querys/assts.qerys.querydocuments.services-1.0.0.jar"]))
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentsgriddetail.services", path: "../../ASSETS/querys/assts.qerys.querydocumentsgriddetail.services-1.0.0.jar"])
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentshistory.services", path: "../../ASSETS/querys/assts.qerys.querydocumentshistory.services-1.0.0.jar"])
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentscycle.services", path: "../../ASSETS/querys/assts.qerys.querydocumentscycle.services-1.0.0.jar"]))
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentsbyfilter.services", path: "../../ASSETS/querys/assts.qerys.querydocumentsbyfilter.services-1.0.0.jar"])
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.creditcandidates.services", path: "../../ASSETS/querys/assts.qerys.creditcandidates.customevents-1.0.0.jar"])
planQueriesServices.append(new Node(null, "plugin", [name:"assts.qerys.creditcandidatespopupform.services", path: "../../ASSETS/querys/assts.qerys.creditcandidatespopupform.customevents-1.0.0.jar"])


def planQueriesEvents = new Node(null, "plan", [ id: "ASSETS-CLOUD-QUERIES", reloadable: "true"])
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.paymentdetailform.customevents", path: "../../ASSETS/querys/assts.qerys.paymentdetailform.customevents-1.0.0.jar"]))
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querygeneralinformationmain.customevents", path: "../../ASSETS/querys/assts.qerys.querygeneralinformationmain.customevents-1.0.0.jar"]))
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.debitorderprocessinglog.customevents", path: "../../ASSETS/querys/assts.qerys.debitorderprocessinglog.customevents-1.0.0.jar"]))
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querydocuments.customevents", path: "../../ASSETS/querys/assts.qerys.querydocuments.customevents-1.0.0.jar"]))
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentsgriddetail.customevents", path: "../../ASSETS/querys/assts.qerys.querydocumentsgriddetail.customevents-1.0.0.jar"])
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentshistory.customevents", path: "../../ASSETS/querys/assts.qerys.querydocumentshistory.customevents-1.0.0.jar"])
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentscycle.customevents", path: "../../ASSETS/querys/assts.qerys.querydocumentscycle.customevents-1.0.0.jar"]))
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.querydocumentsbyfilter.customevents", path: "../../ASSETS/querys/assts.qerys.querydocumentsbyfilter.customevents-1.0.0.jar"])
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.creditcandidates.customevents", path: "../../ASSETS/querys/assts.qerys.creditcandidates.customevents-1.0.0.jar"])
planQueriesEvents.append(new Node(null, "plugin", [name:"assts.qerys.creditcandidatespopupform.customevents", path: "../../ASSETS/querys/assts.qerys.creditcandidatespopupform.customevents-1.0.0.jar"])

def planTrnServices = new Node(null, "plan", [ id: "ASSETS-CLOUD-TRANSACTIONS-SERVICES", reloadable: "true"])
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.applyclause.services", path: "../../ASSETS/transactions/assts.trnsc.applyclause.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.loanrefinancing.services", path: "../../ASSETS/transactions/assts.trnsc.loanrefinancing.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.valuedatemain.services", path: "../../ASSETS/transactions/assts.trnsc.valuedatemain.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.valuedateform.services", path: "../../ASSETS/transactions/assts.trnsc.valuedateform.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.paymentsmain.services", path: "../../ASSETS/transactions/assts.trnsc.paymentsmain.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.prioritiespaymentsmodal.services", path: "../../ASSETS/transactions/assts.trnsc.prioritiespaymentsmodal.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.bankaccountslistform.services", path: "../../ASSETS/transactions/assts.trnsc.bankaccountslistform.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.leftoverpaymentsmodal.services", path: "../../ASSETS/transactions/assts.trnsc.leftoverpaymentsmodal.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.quotadetailpaymentsmodal.services", path: "../../ASSETS/transactions/assts.trnsc.quotadetailpaymentsmodal.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.refinanceloansfilter.services", path: "../../ASSETS/transactions/assts.trnsc.refinanceloansfilter.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.loandisbursementmain.services", path: "../../ASSETS/transactions/assts.trnsc.loandisbursementmain.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.paymentmodeform.services", path: "../../ASSETS/transactions/assts.trnsc.paymentmodeform.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.condonationdetailform.services", path: "../../ASSETS/transactions/assts.trnsc.condonationdetailform.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.bankaccountsmodal.services", path: "../../ASSETS/transactions/assts.trnsc.bankaccountsmodal.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.negotiationpaymentsmodal.services", path: "../../ASSETS/transactions/assts.trnsc.negotiationpaymentsmodal.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.grouppayment.services", path: "../../ASSETS/transactions/assts.trnsc.grouppayment.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.manualconciliation.services", path: "../../ASSETS/transactions/assts.trnsc.manualconciliation.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.voucherpaymentmail.services", path: "../../ASSETS/transactions/assts.trnsc.voucherpaymentmail.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.precancellationloanreference.services", path: "../../ASSETS/transactions/assts.trnsc.precancellationloanreference.services-1.0.0.jar"]))
planTrnServices.append(new Node(null, "plugin", [name:"assts.trnsc.accountstatusform.services", path: "../../ASSETS/transactions/assts.trnsc.accountstatusform.services-1.0.0.jar"]))


def planTrnEvents = new Node(null, "plan", [ id: "ASSETS-CLOUD-TRANSACTIONS", reloadable:"true"])
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.applyclause.customevents", path: "../../ASSETS/transactions/assts.trnsc.applyclause.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.loanrefinancing.customevents", path: "../../ASSETS/transactions/assts.trnsc.loanrefinancing.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.valuedatemain.customevents", path: "../../ASSETS/transactions/assts.trnsc.valuedatemain.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.valuedateform.customevents", path: "../../ASSETS/transactions/assts.trnsc.valuedateform.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.paymentsmain.customevents", path: "../../ASSETS/transactions/assts.trnsc.paymentsmain.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.prioritiespaymentsmodal.customevents", path: "../../ASSETS/transactions/assts.trnsc.prioritiespaymentsmodal.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.bankaccountslistform.customevents", path: "../../ASSETS/transactions/assts.trnsc.bankaccountslistform.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.leftoverpaymentsmodal.customevents", path: "../../ASSETS/transactions/assts.trnsc.leftoverpaymentsmodal.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.quotadetailpaymentsmodal.customevents", path: "../../ASSETS/transactions/assts.trnsc.quotadetailpaymentsmodal.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.refinanceloansfilter.customevents", path: "../../ASSETS/transactions/assts.trnsc.refinanceloansfilter.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.loandisbursementmain.customevents", path: "../../ASSETS/transactions/assts.trnsc.loandisbursementmain.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.paymentmodeform.customevents", path: "../../ASSETS/transactions/assts.trnsc.paymentmodeform.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.condonationdetailform.customevents", path: "../../ASSETS/transactions/assts.trnsc.condonationdetailform.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.bankaccountsmodal.customevents", path: "../../ASSETS/transactions/assts.trnsc.bankaccountsmodal.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.negotiationpaymentsmodal.customevents", path: "../../ASSETS/transactions/assts.trnsc.negotiationpaymentsmodal.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.grouppayment.customevents", path: "../../ASSETS/transactions/assts.trnsc.grouppayment.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.manualconciliation.customevents", path: "../../ASSETS/transactions/assts.trnsc.manualconciliation.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.voucherpaymentmail.customevents", path: "../../ASSETS/transactions/assts.trnsc.voucherpaymentmail.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.precancellationloanreference.customevents", path: "../../ASSETS/transactions/assts.trnsc.precancellationloanreference.customevents-1.0.0.jar"]))
planTrnEvents.append(new Node(null, "plugin", [name:"assts.trnsc.accountstatusform.customevents", path: "../../ASSETS/transactions/assts.trnsc.accountstatusform.customevents-1.0.0.jar"]))

def planReports = new Node(null, "plan", [ id: "ASSETS-CLOUD-REPORT", reloadable:"true"])
planReports.append(new Node(null, "plugin", [name:"cobis-web-assets-reportes", path: "../../ASSETS/reports/cobis-web-assets-reportes-1.0.0.jar"]))

def planServices = new Node(null, "plan", [ id: "ASSETS-CLOUD-SERVICES", reloadable:"true"])
planServices.append(new Node(null, "plugin", [name:"cobis-web-assets-services", path: "../../ASSETS/services/cobis-web-assets-services-1.0.0.jar"]))

def modPlan = new ModifyPlans()
modPlan.addPlanAfterDeleteIfExists(root, "FPM-web-services", planCommonsSG)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-COMMONS-SG", planCommons)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-COMMONS", planCommonsServices)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-COMMONS-SERVICES", planCommonsEvents)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-COMMONS-EVENTS", planMtnServices)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-MNTNN-SERVICES", planMtnEvents)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-MNTNN", planQueriesServices)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-QUERIES-SERVICES", planQueriesEvents)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-QUERIES", planTrnServices)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-TRANSACTIONS-SERVICES", planTrnEvents)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-TRANSACTIONS", planReports)
modPlan.addPlanAfterDeleteIfExists(root, "ASSETS-CLOUD-REPORT", planServices)


