// (Button) 
task.executeCommand.CM_TASSCRMF_NWA = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;

    if (entities.PrefilledRequest.clientId == null && entities.PrefilledRequest.groupRequest == 'N' && entities.PrefilledRequest.renewalsRequest == 'N') {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_SELECCIIT_59694", true);
    } else if (entities.PrefilledRequest.clientId == null) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_ELCDIGOOO_78756", true);
    } else if (entities.PrefilledRequest.groupRequest == 'N' && entities.PrefilledRequest.renewalsRequest == 'N') {
        executeCommandEventArgs.commons.messageHandler.showMessagesError("ASSCR.MSG_ASSCR_TIPODESBO_87191", true);
    } else {
        var itemReporte = '';
        var reportTitle = '';
        var isGroup = '';
        var idTramite = 0;

        if (!entities.PrefilledRequest.isGroup) {
            isGroup = 'N'
        } else if (entities.PrefilledRequest.isGroup) {
            isGroup = 'S'
        }

        if (entities.PrefilledRequest.groupRequest != 'N') {
            itemReporte = "solicitudCreditoGrupalPrellenada";
            reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSCR.LBL_ASSCR_SOLICITUU_72787');
            var args = [
            ['report.module', 'cartera'],
            ['report.name', itemReporte],
            ['idTramite', idTramite],
            ['clientID', entities.PrefilledRequest.clientId],
            ['isGroup', isGroup]];

            ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
        }
        if (entities.PrefilledRequest.renewalsRequest != 'N') {
            itemReporte = "solicitudCreditoRenovFinanPrellenada";
            reportTitle = executeCommandEventArgs.commons.api.viewState.translate('ASSCR.LBL_ASSCR_SOLICITCN_36303');
            var args = [
            ['report.module', 'cartera'],
            ['report.name', itemReporte],
            ['idTramite', idTramite],
            ['clientID', entities.PrefilledRequest.clientId],
            ['isGroup', isGroup]];

            ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
        }

    }

};