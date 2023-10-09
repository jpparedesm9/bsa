/* variables locales de T_CSTMRZIMDHJYH_829*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.addalertsform;
    

    //"TaskId": "T_CSTMRZIMDHJYH_829"
task.validateOnlyLettersAndSpaces = function (text) {
    var expreg = new RegExp("^[a-zA-ZÑñáéíóúÁÉÍÓÚ ]{1,20}$");
    if (expreg.test(text)) {
        return true;
    }
    return false;
};

    //Entity: UnusualOperations
    //UnusualOperations.customerSecondName (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSECOMEE_535527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };

//Entity: UnusualOperations
    //UnusualOperations.customerSecondSurname (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSECONNN_410527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };

//Entity: UnusualOperations
    //UnusualOperations.customerSurname (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_CUSTOMERSURNMEA_528527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };

//Entity: UnusualOperations
    //UnusualOperations.customerName (TextInputBox) View: AddAlertsForm
    
    task.customValidation.VA_TEXTINPUTBOXTVB_163527 = function( customValidationEventArgs ) {
        
        return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character);
        
    };

//Entity: UnusualOperations
    //UnusualOperations. (Button) View: AddAlertsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONOGPGXMU_783527 = function(  entities, executeCommandEventArgs ) {

    executeCommandEventArgs.commons.execServer = true;
    
        //executeCommandEventArgs.commons.serverParameters.UnusualOperations = true;
    };

//Entity: UnusualOperations
    //UnusualOperations. (Button) View: AddAlertsForm
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommandCallback.VA_VABUTTONOGPGXMU_783527 = function(  entities, executeCommandCallbackEventArgs ) {
        executeCommandCallbackEventArgs.commons.execServer = false;
        if(executeCommandCallbackEventArgs.success){
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576','', 2000,false);
            entities.UnusualOperations.typeOperation = null;
            entities.UnusualOperations.highDate = null;
            entities.UnusualOperations.reportDate = null;
            entities.UnusualOperations.customerName = null;
            entities.UnusualOperations.commentary = null;
            entities.UnusualOperations.customerSecondName = null;
            entities.UnusualOperations.customerSurname = null;
            entities.UnusualOperations.customerSecondSurname = null;
            var grid = executeCommandCallbackEventArgs.commons.api.grid;
            grid.refresh('QV_1129_31576');
        }
    };

//UnusualOperationsViewQuery Entity: 
    task.executeQuery.Q_UNUSUAPO_1129 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//gridRowRendering QueryView: QV_1129_31576
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_1129_31576 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            
        };

//gridRowDeleting QueryView: QV_1129_31576
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_1129_31576 = function (entities,gridRowDeletingEventArgs) {
            gridRowDeletingEventArgs.commons.execServer = true;
            //gridRowDeletingEventArgs.commons.serverParameters.UnusualOperationsView = true;
        };

//gridRowDeleting QueryView: QV_1129_31576
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeletingCallback.QV_1129_31576 = function (entities,gridRowDeletingCallbackEventArgs) {
            gridRowDeletingCallbackEventArgs.commons.execServer = false;
            
        };



}));