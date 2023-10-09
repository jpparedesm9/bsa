<!-- Development by Designer Generator v 1.7.0 - release ART 7.2 05/09/2014 -->
<!---->

//EJEMPLO 1

//designerEvents.api.amortizationtask.executeCommand.CM_GRIUO17AAR51 = function(entities, executeCommandEventArgs){
//	Para imprimir mensajes en consola 
//	console.log("executeCommand");

//	Para enviar mensaje use 
//	executeCommandEventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

//	Para evitar que se continue con la validación a nivel de servidor
//	executeCommandEventArgs.commons.execServer = false;
//}

//EJEMPLO 2

//designerEvents.api.amortizationtask.callTransaction.CM_GRIUO17AAR51 = function(transactionRequest, callTransactionEventArgs){
//	console.log("callTransaction");
//	Para enviar mensaje use 
//	callTransactionEventArgs.commons.messageHandler.showMessagesInformation('Variable recibida');
//}

    
designerEvents.api.amortizationtask.executeCommand.CM_IATSK55CAC94 = function(entities, validateTransactionEventArgs){
    //validateTransactionEventArgs.commons.execServer = false; //el mensaje de err no baja al svr
}


designerEvents.api.amortizationtask.executeCommandCallback.CM_IATSK55CAC94 = function(entities, validateCallBackEventArgs){
    //validateCallBackEventArgs.commons.messageHandler.showMessagesInformation('executeCommandCallback!!!');
    
    var row = entities.AmortizationTableEntity.data();
    var entry1 = row.aggregates().Entry1;
    if(entry1.sum > 0){
        validateCallBackEventArgs.commons.api.grid.showColumn('QV_OTAOA0659_11', 'Entry1');
    }
    
    /*var count = 0;
    for (var i = 0; i < entities.AmortizationTableEntity.data().length; i++) {
        var row = entities.AmortizationTableEntity.data()[i];
        var entry1 = row.aggregates().Entry1;
        if(entry1.sum > 0){
            validateCallBackEventArgs.commons.api.grid.showColumn('QV_OTAOA0659_11', 'Entry1');
        }
        if(row.Entry1 == 0){
            validateCallBackEventArgs.commons.api.grid.showColumn('QV_OTAOA0659_11', 'Entry1');
        }
    }*/
}

designerEvents.api.amortizationtask.change.VA_SALMORTZAN4702_ACON145 = function (entities, changeEventArgs)
{
    if(entities.DatosGeneralesOperacion.Operation == null || entities.DatosGeneralesOperacion.Operation == ""){
        changeEventArgs.commons.execServer = false; //el mensaje de err no baja al svr
    }
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry1');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry2');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry3');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry4');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry5');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry6');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry7');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry8');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry9');
    changeEventArgs.commons.api.grid.hideColumn('QV_OTAOA0659_11', 'Entry10');
    
}


