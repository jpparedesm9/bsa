/**
 * No se debe modificar la clase
 * @author fabad
 *
 */
class ModifyPlans {

    //Metodo para agreagar al ultimo
    void addConfigAtTheEndDeleteIfExist(Node rootVar, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == nodeVar.@id }
        if (config != null) {
            configs.remove(config)
        }
        rootVar.own[0].append(nodeVar)
    }

    //Metodos de agregacion

    void addPlanBefore(Node rootVar, Object id, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == nodeVar.@id }
        def index = configs.indexOf(config)
        println it.@id
        println nodeVar.@id
        println config

        configs.add(index, nodeVar)
    }

    void addPlanAfter(Node rootVar, Object id, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == id }
        def index = configs.indexOf(config)
        configs.add(index + 1, nodeVar)
    }

    void addPlanBeforeDeleteIfExists(Node rootVar, Object id, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == nodeVar.@id }
        if (config != null) {
            configs.remove(config)
        }
        addPlanBefore(rootVar, id, nodeVar)
    }

    void addPlanAfterDeleteIfExists(Node rootVar, Object id, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == nodeVar.@id }
        if (config != null) {
            configs.remove(config)
        }
        addPlanAfter(rootVar, id, nodeVar)
    }

    void movePlanBefore(Node rootVar, Object idMove, Node id) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == id }
        configs.remove(config)
        addPlanBefore(rootVar, id, config)
    }

    void movePlanAfter(Node rootVar, Object idMove, Object id) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == idMove }
        configs.remove(config)
        addPlanAfter(rootVar, id, config)
    }

    // Metodo que inserta un nodo despues de confirmar que exista el plan primario
    // si no existe busca un plan secundario y lo agrega
    void addPlanAfterPlans(Node rootVar, Object id, Object idOther, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == id }
        if (config == null) {
            config = configs.find { it.@id == idOther }
        }

        //Si no encuentra los dos nodos especificados a�ade al final del archivo la informaci�n
        if (config == null) {
            addConfigAtTheEndDeleteIfExist(rootVar, nodeVar)
        } else {
            def index = configs.indexOf(config)
            configs.add(index + 1, nodeVar)
        }
    }

    // Metodo que inserta un nodo despues de confirmar que exista el plan primario
    // si no existe busca un plan secundario y lo agrega
    void addPlanAfterDeleteIfExistsAndOtherPlan(Node rootVar, Object id, Object idOther, Node nodeVar) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == nodeVar.@id }
        if (config != null) {
            configs.remove(config)
        }
        addPlanAfterPlans(rootVar, id, idOther, nodeVar)
    }

    // Metodo que remueve un plan, seg�n su identificador indicado.
    void removePlan(Node rootVar, Object id) {
        def configs = rootVar.own[0].children()
        def config = configs.find { it.@id == id }
        if (config != null) {
            configs.remove(config)
        }
    }
}

def modPlan = new ModifyPlans()

//INTEGRATION-UTILS
def planIntegrationUtils = new Node(null, "plan", [id: "INTEGRATION-UTILS", reloadable: "true"])
planIntegrationUtils.append(new Node(null, "plugin", [name: "cobis-cobiscloudburo-util", path: "../../CREDIT/integration/plugins/cobis-cobiscloudburo-util-1.0.0.jar"]))
planIntegrationUtils.append(new Node(null, "plugin", [name: "cobis-cobiscloudburo-zip-util", path: "../../CREDIT/integration/plugins/cobis-cobiscloudburo-zip-util-1.0.0.jar"]))

//INTEGRATION-BURO
def planIntegrationBuro = new Node(null, "plan", [id: "INTEGRATION-BURO", reloadable: "true"])
planIntegrationBuro.append(new Node(null, "plugin", [name: "cobis-cobiscloudburo-bsl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudburo-bsl-1.0.0.jar"]))
planIntegrationBuro.append(new Node(null, "plugin", [name: "cobis-cobiscloudburo-bsl-impl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudburo-bsl-impl-1.0.0.jar"]))

//INTEGRATION-SANTANDER
def planIntegrationSantander = new Node(null, "plan", [id: "INTEGRATION-SANTANDER", reloadable: "true"])
planIntegrationSantander.append(new Node(null, "plugin", [name: "cobis-cobiscloudsantander-bsl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudsantander-bsl-1.0.0.jar"]))
planIntegrationSantander.append(new Node(null, "plugin", [name: "cobis-cobiscloudsantander-bsl-impl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudsantander-bsl-impl-1.0.0.jar"]))

//INTEGRATION-PARTY
def planIntegrationParty = new Node(null, "plan", [id: "INTEGRATION-PARTY", reloadable: "true"])
planIntegrationParty.append(new Node(null, "plugin", [name: "cobis-cobiscloudparty-bsl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudparty-bsl-1.0.0.jar"]))
planIntegrationParty.append(new Node(null, "plugin", [name: "cobis-cobiscloudparty-bsl-impl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudparty-bsl-impl-1.0.0.jar"]))

//INTEGRATION-ORCHESTRATION
def planIntegrationOrchestration = new Node(null, "plan", [id: "INTEGRATION-ORCHESTRATION", reloadable: "true"])
planIntegrationOrchestration.append(new Node(null, "plugin", [name: "cobis-cobiscloudorchestration-bsl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudorchestration-bsl-1.0.0.jar"]))
planIntegrationOrchestration.append(new Node(null, "plugin", [name: "cobis-cobiscloudparty-bsl-impl", path: "../../CREDIT/integration/plugins/cobis-cobiscloudorchestration-bsl-impl-1.0.0.jar"]))
planIntegrationOrchestration.append(new Node(null, "plugin", [name: "cobis-cobiscloudorchestration-rest", path: "../../CREDIT/integration/plugins/cobis-cobiscloudorchestration-rest-1.0.0.jar"]))

//cloud-sofom-interface-customers
def planInterfaceCustomersId = "cloud-sofom-interface-customers"
def planInterfaceCustomers = new Node(null, "plan", [id: planInterfaceCustomersId, reloadable: "true"])
planInterfaceCustomers.append(new Node(null, "plugin", [name: "cloud.sofom.customers.utils", path: "../../CREDIT/integration/plugins/cloud.sofom.customers.utils-1.0.0.jar"]))
planInterfaceCustomers.append(new Node(null, "plugin", [name: "cloud.sofom.referencedata.party", path: "../../CREDIT/integration/plugins/cloud.sofom.referencedata.party-1.0.0.jar"]))
planInterfaceCustomers.append(new Node(null, "plugin", [name: "cloud.sofom.referencedata.party.impl", path: "../../CREDIT/integration/plugins/cloud.sofom.referencedata.party.impl-1.0.0.jar"]))
planInterfaceCustomers.append(new Node(null, "plugin", [name: "cloud.sofom.salesservice.customermanagement", path: "../../CREDIT/integration/plugins/cloud.sofom.salesservice.customermanagement-1.0.0.jar"]))
planInterfaceCustomers.append(new Node(null, "plugin", [name: "cloud.sofom.salesservice.customermanagement.impl", path: "../../CREDIT/integration/plugins/cloud.sofom.salesservice.customermanagement.impl-1.0.0.jar"]))

//cloud-sofom-interface-direct-debits-batch
def planInterfaceDirectDebitsId = "cloud-sofom-interface-direct-debits-batch"
def planInterfaceDirectDebits = new Node(null, "plan", [id: planInterfaceDirectDebitsId, reloadable: "true"])
planInterfaceDirectDebits.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.tradebanking.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.tradebanking.batch-1.0.0.jar"]))

//cloud-sofom-interface-regulationscompliance-batch
def planRegulationsCompliance = new Node(null, "plan", [id: "cloud-sofom-interface-regulationscompliance-batch", reloadable: "true"])
planRegulationsCompliance.append(new Node(null, "plugin", [name: "cloud.sofom.riskcompliance.regulationscompliance.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.riskcompliance.regulationscompliance.batch-1.0.0.jar"]))

//cloud-sofom-interface-disbursements
def planIntegrationDisbursements = new Node(null, "plan", [id: "cloud-sofom-interface-disbursements", reloadable: "true"])
planIntegrationDisbursements.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.operationalservices", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.operationalservices-1.0.0.jar"]))
planIntegrationDisbursements.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.operationalservices.impl", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.operationalservices.impl-1.0.0.jar"]))
planIntegrationDisbursements.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.operationalservices.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.operationalservices.batch-1.0.0.jar"]))
planIntegrationDisbursements.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.operationalservicescheck.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.operationalservicescheck.batch-1.0.0.jar"]))

//cloud-sofom-interface-payments-rest
def planIntegrationPayments = new Node(null, "plan", [id: "cloud-sofom-interface-payments-rest", reloadable: "true"])
planIntegrationPayments.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.payments", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.payments-1.0.0.jar"]))

//cloud-sofom-interface-accounts-receivable-batch
def planInterfaceAccountsReceivableBatch = new Node(null, "plan", [id: "cloud-sofom-interface-accounts-receivable-batch", reloadable: "true"])
planInterfaceAccountsReceivableBatch.append(new Node(null, "plugin", [name: "cloud.sofom.operationsexecution.accountmanagement.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.accountmanagement.batch-1.0.0.jar"]))

//cloud-sofom-batch
def planInterfaceBatchCommonId = "cloud-sofom-batch"
def planInterfaceBatchCommon = new Node(null, "plan", [id: planInterfaceBatchCommonId, reloadable: "true"])
planInterfaceBatchCommon.append(new Node(null, "plugin", [name: "cloud.sofom.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.batch-1.0.0.jar"]))

//Santander batch Colectivos
def planSantaderBatchCol = new Node(null, "plan", [ id: "cloud-sofom-interface-santander-rest", reloadable:"true"])
planSantaderBatchCol.append(new Node(null, "plugin", [name:"cloud.sofom.operationsexecution.santander.batch", path: "../../CREDIT/integration/plugins/cloud.sofom.operationsexecution.santander.batch-1.0.0.jar"]))


modPlan.addPlanAfterDeleteIfExists(root, "BUSINESS-PROCESS-PRINTING-ACTIVITY", planInterfaceCustomers)
modPlan.addPlanAfterDeleteIfExists(root, planInterfaceCustomersId, planInterfaceBatchCommon)
modPlan.addPlanAfterDeleteIfExists(root, planInterfaceBatchCommonId, planInterfaceDirectDebits)
modPlan.addPlanAfterDeleteIfExists(root, planInterfaceDirectDebitsId, planIntegrationDisbursements)
modPlan.addPlanAfterDeleteIfExists(root, "cloud-sofom-interface-disbursements", planIntegrationPayments)
modPlan.addPlanAfterDeleteIfExists(root, "cloud-sofom-interface-payments-rest", planIntegrationUtils)
modPlan.addPlanAfterDeleteIfExists(root, "INTEGRATION-UTILS", planIntegrationBuro)
modPlan.addPlanAfterDeleteIfExists(root, "INTEGRATION-BURO", planIntegrationSantander)
modPlan.addPlanAfterDeleteIfExists(root, "INTEGRATION-SANTANDER", planIntegrationParty)
modPlan.addPlanAfterDeleteIfExists(root, "INTEGRATION-PARTY", planIntegrationOrchestration)
modPlan.addPlanAfterDeleteIfExists(root, "cloud-sofom-interface-payments-rest", planRegulationsCompliance)
modPlan.addPlanAfterDeleteIfExists(root, "cloud-sofom-interface-regulationscompliance-batch", planInterfaceAccountsReceivableBatch)
modPlan.addPlanAfterDeleteIfExists(root, "cloud-sofom-interface-accounts-receivable-batch", planSantaderBatchCol)
