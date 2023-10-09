/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.taskconsultdisbursementforms;

//"TaskId": "T_FLCRE_53_TKCSO26"
var task = designerEvents.api.taskconsultdisbursementforms;
	var disbursementFormDialogParameters, productLast;

// (Button) 
    task.executeCommand.CM_TKCSO26COE67 = function(entities, executeCommandEventArgs) {
      executeCommandEventArgs.commons.execServer = false;
		var result = {parameterDisbursementForm: disbursementFormDialogParameters }
		executeCommandEventArgs.commons.api.vc.closeModal(result);
        
    };

//QueryConsultDisbursementForms Entity: ConsultationDisbursementForms
    task.executeQuery.Q_EULDBSTM_5756 = function(executeQueryEventArgs){
     executeQueryEventArgs.commons.execServer = true;
		executeQueryEventArgs.commons.api.grid.setAppendRecordsParams('QV_EULDB5756_37',['Product'],executeQueryEventArgs);
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: [object Object]
    task.initData.VC_TKCSO26_CRNTO_867 = function (entities, initDataEventArgs){
       var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters; 
		entities.DisbursementForms.Currency = parentParameters.currency;
		initDataEventArgs.commons.execServer = true;
        //TODO: para grupales
       initDataEventArgs.commons.api.viewState.hide('VA_UTDSRMNSVW7005_0000031')
    };

//gridRowSelecting QueryView: GridConsultDisbursementForms
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowSelecting.QV_EULDB5756_37 = function (entities, gridRowSelectingEventArgs) {
               gridRowSelectingEventArgs.commons.execServer = false;
		disbursementFormDialogParameters = gridRowSelectingEventArgs.rowData;

            
        };


}());