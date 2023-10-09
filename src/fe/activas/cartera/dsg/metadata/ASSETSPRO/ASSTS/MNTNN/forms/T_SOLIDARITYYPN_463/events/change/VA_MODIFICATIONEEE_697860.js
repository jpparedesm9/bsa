//Entity: SolidarityPayment
    //SolidarityPayment.modificationFee (TextInputBox) View: SolidarityPaymentForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_MODIFICATIONEEE_697860 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    changedEventArgs.commons.serverParameters.SolidarityPayment = true;
    changedEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
    
    //changedEventArgs.commons.api.vc.executeCommand('VA_VABUTTONBGFXHFC_174860', undefined, true, false, 'VC_SOLIDARIEN_259463', false);
    
};