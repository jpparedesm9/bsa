//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MassivePayment
    task.initData.VC_MASSIVEPTY_109349 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        entities.MassivePaymentFile.fileObservations=0
        entities.MassivePaymentFile.processedRecords = 0
        entities.MassivePaymentFile.processedAmount = 0
        
    };