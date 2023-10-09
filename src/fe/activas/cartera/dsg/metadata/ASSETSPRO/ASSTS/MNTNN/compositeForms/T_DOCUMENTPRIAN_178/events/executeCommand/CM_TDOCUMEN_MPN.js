// FICHA DE PAGO
task.executeCommand.CM_TDOCUMEN_MPN = function (entities, executeCommandEventArgs) {
    var itemReporte;
    var reportTitle = "FICHA DE PAGO";
    var sendMail = executeCommandEventArgs.commons.api.vc.serverParameters.sendMail; //SOLO PDF
    var args;
    var crearReporte = true;
    var loan = entities.Loan;

    executeCommandEventArgs.commons.execServer = false;
    if (operationType == 'GRUPAL' && groupSummary == "S") {
        itemReporte = "CorresponsalPayment";
        args = [['bank', entities.Loan.loanBankID.trim()], ['sendMail', sendMail]]

    } else if (operationType == 'GRUPAL' && groupSummary == "N") {
        cobis.showMessageWindow.alertInfo("No se admiten pagos individuales a un Cr\u00e9dito Grupal", "AVISO");
        crearReporte = false;
    } else if (operationType == 'REVOLVENTE') {
        itemReporte = "paymentCard";
        args = [['numOperation', entities.Loan.loanBankID.trim()], ['sendMail', sendMail]]

    } else if (operationType == 'INDIVIDUAL' && groupSummary == "N") {
        itemReporte = "CorresponsalPayment";
        args = [['bank', entities.Loan.loanBankID.trim()], ['sendMail', sendMail], ['operationType', operationType]]

    } else {
        cobis.showMessageWindow.alertError("Formato a\u00fan no desarrollado", "ERROR");
        crearReporte = false;
    }

    if (crearReporte) {
        if (loan.statusID == 3) {
            var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.LBL_ASSTS_PRSTAMOGN_18497');
            cobis.showMessageWindow.alert(message, 'FICHA DE PAGO', buttons)
        } else {
            executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "1"; //PDF
            args[1] = ['sendMail', '1']
            var buttons = ['NO', 'SI'];
            var message = executeCommandEventArgs.commons.api.viewState.translate('ASSTS.MSG_ASSTS_DESEAENCR_40641');

            if (operationType == 'INDIVIDUAL') {
                ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
                
            } else {
                cobis.showMessageWindow.confirm('\u00bfDesea enviar la Ficha de Pago al Correo\u003f', 'AVISO', buttons).then(function (resp) {
                    switch (resp.buttonIndex) {
                        case 1: //accept
                            executeCommandEventArgs.commons.api.vc.serverParameters.sendMail = "2"; // ENVIO CORREO
                            args[1] = ['sendMail', '2']
                            break;
                    }
                    if (operationType == 'REVOLVENTE') {

                        executeCommandEventArgs.commons.api.vc.executeCommand('CM_TDOCUMEN_5CO', 'DocumentPrintingMain', undefined, true, false, 'VC_DOCUMENTIG_406178', false);

                    } else {
                        ASSETS.Utils.generarReporte(itemReporte, args, reportTitle);
                    }
                });
            }



        }
    }
};