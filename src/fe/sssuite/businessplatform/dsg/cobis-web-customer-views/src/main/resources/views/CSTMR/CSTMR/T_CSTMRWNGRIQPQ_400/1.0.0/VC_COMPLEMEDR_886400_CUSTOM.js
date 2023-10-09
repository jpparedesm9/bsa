/* variables locales de T_CSTMRWNGRIQPQ_400*/
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

    
        var task = designerEvents.api.complementaryrequestdataform;
    

    //"TaskId": "T_CSTMRWNGRIQPQ_400"


    //Entity: ComplementaryRequestData
    //ComplementaryRequestData.electronicSignature (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ELECTRONICSIGGU_426642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: ComplementaryRequestData
    //ComplementaryRequestData.ifeNumber (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_IFENUMBERTXDDFK_481642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: ComplementaryRequestData
    //ComplementaryRequestData.passportNumber (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PASSPORTNUMBEER_566642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: ComplementaryRequestData
    //ComplementaryRequestData.phoneErrands (TextInputBox) View: ComplementaryRequestDataForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PHONEERRANDSTRD_116642 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
    
        
    };

//Entity: ComplementaryRequestData
//ComplementaryRequestData.personNameMessages (TextInputBox) View: ComplementaryRequestDataForm
    
task.customValidation.VA_PERSONNAMEMEAES_714642 = function( customValidationEventArgs ) {
	return task.validateOnlyLettersAndSpaces(customValidationEventArgs.character, 0, 20);            
};



}));