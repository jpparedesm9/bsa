//Entity: PaymentForm
    //PaymentForm.payAmount (TextInputBox) View: PaymentModeForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_8983QPJHQZZOSML_321216 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = false;
        //changeEventArgs.commons.serverParameters.PaymentForm = true;
        var api = changeEventArgs.commons.api;
        if(api.navigation.getCustomDialogParameters().difference >=
            entities.PaymentForm.payAmount){
            if(entities.LoanAdditionalInformation.quotation == undefined){
               entities.LoanAdditionalInformation.quotation=entities.Loan.codCurrency;
            }
            api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
            cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152')+": "+
            kendo.toString((entities.PaymentForm.payAmount*entities.LoanAdditionalInformation.quotation), 'c')+" "+
            entities.Loan.currencyName +
            cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+
            entities.LoanAdditionalInformation.quotation;
        }else{
            api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
            changeEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_VALORDEEA_97215'));
            changeEventArgs.commons.execServer = true;
        }
    };