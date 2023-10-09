<!-- Designer Generator v 6.0.0 - release SPR 2016-13 08/07/2016 -->
/* global designerEvents, console */
(function () {
    "use strict";

    // *********** COMENTARIOS DE AYUDA **************
    // Para imprimir mensajes en consola
    // console.log("executeCommand");

    // Para enviar mensaje use
    // eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando
    // comando personalizado');

    // Para evitar que se continue con la validación a nivel de servidor
    // eventArgs.commons.execServer = false;

    var task = designerEvents.api.policywarrantycreation;

    // descomentar la siguiente linea para que siempre se ejecute el evento
    // change en todos los controles de cabecera.
    // task.changeWithError.allGroup = true;

    // descomentar la siguiente linea para que siempre se ejecute el evento
    // change en todos los controles de grilla.
    // task.changeWithError.allGrid = true;

    // **********************************************************
    // Eventos para COMANDOS DE TAREA
    // **********************************************************
    // Cancelar (Button)
    task.executeCommand.CM_CRNTO32CAL78 = function (entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.vc.closeModal("");
    };

    // Guardar (Button)
    task.executeCommand.CM_CRNTO32ARA57 = function (entities, executeCommandEventArgs) {
    
    	if(task.validateBeforeSave(entities, executeCommandEventArgs)){
    		entities.WarrantyPoliciy.isNew = entities.generalData.isNew;          
            var insurance = entities.WarrantyPoliciy.insurance;
			entities.WarrantyPoliciy.insuranceDescription = executeCommandEventArgs.commons.api.viewState.selectedText('VA_WARNTYPOIY7706_NSNE946', insurance);
			
			executeCommandEventArgs.commons.execServer = true;	
    	}else {
            executeCommandEventArgs.commons.execServer = false;
        }
        
    };
    
    
    task.validateBeforeSave = function (entities, args){
		
		var savePolicy = true;
		var api = args.commons.api;
		var customParameters=api.parentVc.customDialogParameters;
		var customDialogParameters = api.parentVc.customDialogParameters.isNew == true?api.parentVc.parentVc.parentVc.customDialogParameters:api.parentVc.parentVc.customDialogParameters;
		var showMessageErrorPage = false;
		var processDate = api.parentVc.customDialogParameters.processDate;
		
		
		var numErrors = args.commons.api.errors.getErrorsGroup('GR_WARNTYPOIY77_04',false);
		if(numErrors > 0){
			args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ESICINSPG_05163', true);
			return false;
		}else{
			return true;
		}
		
	};

    task.executeCommandCallback.CM_CRNTO32ARA57 = function (entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;

        if (executeCommandEventArgs.success == true) {
            //removemos campo isNew
            if (entities.WarrantyPoliciy.isNew) {
                delete entities.WarrantyPoliciy.isNew;
                executeCommandEventArgs.commons.api.parentApi().grid.addRow("WarrantyPoliciy", entities.WarrantyPoliciy);
            }
            executeCommandEventArgs.commons.api.vc.closeModal(entities.WarrantyPoliciy);
        }
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

    // **********************************************************
    // Eventos para View Container
    // **********************************************************
    // Evento InitData: Inicialización de datos del formulario, después de este
    // evento se realiza el seguimiento de cambios en los datos.
    // ViewContainer: WarrrantyPolicyModal
    task.initData.VC_CRNTO32_RRNYM_717 = function (entities, initDataEventArgs) {

        var warrantyGeneral = initDataEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral;

        entities.WarrantyPoliciy.branchOffice = warrantyGeneral.branchOffice;
        entities.WarrantyPoliciy.custodyType = warrantyGeneral.warrantyType;
        entities.WarrantyPoliciy.custody = warrantyGeneral.code;
        entities.WarrantyPoliciy.externalCode = warrantyGeneral.externalCode;

        entities.generalData = {}; // entidad temporal
        if (initDataEventArgs.commons.api.parentVc.customDialogParameters.currentRow !== null) {
            initDataEventArgs.commons.execServer = true;
            entities.generalData.isNew = false;
        } else {
            initDataEventArgs.commons.execServer = false;
            entities.generalData.isNew = true;
        }
    };

	task.initDataCallback.VC_CRNTO32_RRNYM_717 = function (entities, initDataEventArgs) {
		var api = initDataEventArgs.commons.api;
		api.viewState.disable('VA_WARNTYPOIY7706_UEIC804', true);
		api.viewState.disable('VA_WARNTYPOIY7706_NSNE946', true);
    };
	
    // Evento Render: Se ejecuta antes de renderizar un control, permite
    // realizar personalizaciones visuales.
    // ViewContainer: WarrrantyPolicyModal
    task.render = function (entities, renderEventArgs) {
        renderEventArgs.commons.execServer = false;
    };

    // **********************************************************
    // validaciones personalizados de visual attributes
    // **********************************************************
}());