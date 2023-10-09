//gridCommand (Button) QueryView: QV_5973_48889
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_5973_48889_606 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.DetailPaymentForm = true;
        //Open Modal
      var nav = gridExecuteCommandEventArgs.commons.api.navigation;
      if(entities.LiquidateResult.sumTotal > entities.DisbursementResult.sumTotal){      
         nav.label = cobis.translate('ASSTS.LBL_ASSTS_APAGOKXFB_84081'); //Forma de Pago
         nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_PAYMENTMODEEE_368',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_PAYMENTMDE_245368'
         };
         nav.queryParameters = {
            mode: 1
         };
         nav.modalProperties = {
            size: 'lg',
            callFromGrid: false
         };
         
         nav.customDialogParameters = {
            operationTypeId: entities.Loan.operationTypeID,
            codCurrency: entities.Loan.codCurrency,
            dateToDisburse: entities.LoanAdditionalInformation.dateToDisburse,
            loanAddInf: entities.LoanAdditionalInformation,
            difference: entities.DisbursementResult.difference,
            loanBankID: entities.Loan.loanBankID,
            loan:entities.Loan
         }; 
         nav.openModalWindow("CEQV_201QV_5973_48889_606", gridExecuteCommandEventArgs);      
      }else{         
         gridExecuteCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate('ASSTS.MSG_ASSTS_ELDESEMST_32467'));
      }
    };