//Entity: SolidarityPayment
    //SolidarityPayment. (ImageButton) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VAIMAGEBUTTONNN_542860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = false;
    
        if(entities.SolidarityPayment.modificationFee>1){
            entities.SolidarityPayment.modificationFee = entities.SolidarityPayment.modificationFee - 1;
        }
        
    };