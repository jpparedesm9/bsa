//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: SolidarityPaymentForm
task.initData.VC_SOLIDARIEN_259463 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    
    initDataEventArgs.commons.serverParameters.SolidarityPayment = true;
    initDataEventArgs.commons.serverParameters.SolidarityPaymentDetail = true;
};