//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PaymentModeForm
    task.initData.VC_PAYMENTMDE_245368 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
         entities.PaymentForm.currencyFlagAux = '0';
         var api = initDataEventArgs.commons.api;
         api.vc.viewState.VA_VACOMPOSITENOLL_984216.visible = false;
         api.vc.viewState.Spacer1695.visible = false;
         
         entities.Loan = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().loan;
         entities.LoanAdditionalInformation.dateToDisburse = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().dateToDisburse;
         entities.PaymentForm.payAmount = initDataEventArgs.commons.api.navigation.getCustomDialogParameters().difference;

         initDataEventArgs.commons.api.vc.viewState.VA_VASIMPLELABELLL_582216.label = 
         cobis.translate('ASSTS.LBL_ASSTS_CONVERSII_15152') + ": " +         
         kendo.toString(entities.PaymentForm.payAmount, 'c') + " " +
         entities.Loan.currencyName + " " +
         cobis.translate('ASSTS.LBL_ASSTS_COTIZACNN_31924')+': '+1;
        
    };