//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QuotaDetailPaymentsModal
    task.initData.VC_QUOTADETAA_445745 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = true;
        //initDataEventArgs.commons.serverParameters.entityName = true;
        entities.Loan = initDataEventArgs.commons.api.parentVc.model.Loan;
     entities.Payment = initDataEventArgs.commons.api.parentVc.model.Payment;
    };