// (Button) 
task.executeCommand.CM_TPROSPEC_T8S = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    var clientCode = null;
    var physicalAddresses = entities.PhysicalAddress.data();
    var virtualAddresses = entities.VirtualAddress.data();
    var hasMainPhisicalAddress = false;
    for (var i = 0; i < physicalAddresses.length; i++) {
        if (physicalAddresses[i].isMainAddress) {
            hasMainPhisicalAddress = true;
        }
    }

    if (hasMainPhisicalAddress && virtualAddresses.length > 0) {


        if (entities.Person.typePerson == 'P') {
            clientCode = entities.NaturalPerson.personSecuential;
        } else if (entities.Person.typePerson == 'C') {
            clientCode = entities.LegalPerson.personSecuential;
        }

        if (clientCode != null) {
            //var url = "/CTSProxy/services/cobis/web/views/clientviewer/container-clientviewer.html?ClientId=" + clientCode;
            var url = "/CTSProxy/services/cobis/web/views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html?ClientId=" + clientCode;
            //var menu = "Vista Consolidada";
            var menu = "Mantenimiento de Personas Naturales";
            cobis.container.tabs.openNewTab(menu, url, menu, true);
        }
    } else {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('CSTMR.MSG_CSTMR_ELPROSPIU_85243', true);
    }
};