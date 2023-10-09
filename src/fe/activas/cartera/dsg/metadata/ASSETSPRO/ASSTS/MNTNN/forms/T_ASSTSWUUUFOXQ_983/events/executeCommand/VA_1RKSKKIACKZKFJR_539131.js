//Entity: Entity17
//Entity17.attribute1 (FileUpload) View: PaymentApplication
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_1RKSKKIACKZKFJR_539131 = function (entities, executeCommandEventArgs) {    
    var fileUpload = executeCommandEventArgs.commons.api.fileUpload;    
    //fileUpload.setParameters(10, true, 'fileRepo');
    //entities.PaymentApplication;
    executeCommandEventArgs.commons.execServer = false;
};