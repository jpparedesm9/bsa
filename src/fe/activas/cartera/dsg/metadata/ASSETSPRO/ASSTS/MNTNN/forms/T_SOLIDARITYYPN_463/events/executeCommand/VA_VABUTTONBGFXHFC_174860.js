//Entity: SolidarityPayment
    //SolidarityPayment. (Button) View: SolidarityPaymentForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONBGFXHFC_174860 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.SolidarityPayment = true;
    executeCommandEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
    
};