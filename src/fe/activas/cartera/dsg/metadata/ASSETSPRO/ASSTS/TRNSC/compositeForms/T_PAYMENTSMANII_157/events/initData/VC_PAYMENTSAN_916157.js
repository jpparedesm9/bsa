//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PaymentsMain
    task.initData.VC_PAYMENTSAN_916157 = function (entities, initDataEventArgs){
        var commons = initDataEventArgs.commons;
        var api=initDataEventArgs.commons.api;
        var parameters=api.navigation.getCustomDialogParameters(); 
        entities.LoanInstancia = parameters.parameters.loanInstancia;
        //PRO
        screenCall = parameters.parameters.screenCall;
        //PRO
        initDataEventArgs.commons.api.viewState.hide("VA_NUMCHECKQLTBIOX_669141");
        initDataEventArgs.commons.api.viewState.hide("VA_TEXTINPUTBOXSJQ_831141");
        initDataEventArgs.commons.api.viewState.hide("VA_VASIMPLELABELLL_923141");
        entities.Payment.onLine = true;
        entities.Payment.value = 0;
        entities.Payment.retention = 0;
        entities.LeftOverPayment.value = 0
        commons.execServer = true; 
        
        var parentVc=api.parentVc;
        
        if(screenCall=='refinance'){
            parentVc.closeDialog();     
        }
    };