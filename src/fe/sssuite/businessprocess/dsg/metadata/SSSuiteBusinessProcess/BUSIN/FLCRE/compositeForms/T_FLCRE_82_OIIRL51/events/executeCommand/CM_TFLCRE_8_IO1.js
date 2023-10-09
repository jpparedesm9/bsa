// (Button) 
task.executeCommand.CM_TFLCRE_8_IO1 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    let flag = true;

    if (entities.ApplicationInfoAux.nivelColectivo == undefined || entities.ApplicationInfoAux.nivelColectivo == null || "" == entities.ApplicationInfoAux.nivelColectivo.trim()){
        flag = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.LBL_BUSIN_ELCAMPOIU_45642');
    } 
    
    if(entities.ApplicationInfoAux.ingresosMensuales == undefined || entities.ApplicationInfoAux.ingresosMensuales == null || entities.ApplicationInfoAux.ingresosMensuales == 0) {
        flag = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.LBL_BUSIN_ELCAMPOIA_57961');
    } 
    
    if (flag){
         executeCommandEventArgs.commons.execServer = true;
    }
    
    
    
};