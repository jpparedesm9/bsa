<!-- Designer Generator v 5.0.0.1515 - release SPR 2015-15 07/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.taskexecutivebonusinital;
	task.EtapaTramite = '';
	task.TipoTramite = '';
    //**********************************************************
    //  Eventos de VISUAL ATTRIBUTES
    //**********************************************************
    //Entity: ExecutiveBonusHeader
    //ExecutiveBonusHeader.dateProcess (ComboBox) View: viewExecutiveBonus
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_EXECEBONUS6997_TEOE131 = function(entities, changedEventArgs) {
    };

	task.changeCallback.VA_EXECEBONUS6997_TEOE131 = function(entities, changedEventArgs) {
		task.validateStatus(entities, changedEventArgs);
    };

    //Entity: ExecutiveBonusHeader
    //ExecutiveBonusHeader.dateProcess (ComboBox) View: viewExecutiveBonus
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_EXECEBONUS6997_TEOE131 = function(loadCatalogDataEventArgs) {
        //loadCatalogDataEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Process (Button)
    task.executeCommand.CM_XCUTL59OCS87 = function(entities, executeCommandEventArgs) {
    };

	task.executeCommandCallback.CM_XCUTL59OCS87 = function(entities, executeCommandEventArgs) {
        if(executeCommandEventArgs.success){
			task.validateStatus(entities, executeCommandEventArgs);
		}
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    //Update QueryView: GridExecutiveBonus
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowUpdating.QV_QRYXU8599_55 = function(entities, gridRowUpdatingEventArgs) {
        // gridRowUpdatingEventArgs.commons.execServer = false;
    };

    //SeletingRow QueryView: GridExecutiveBonus
    //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
    task.gridRowSelecting.QV_QRYXU8599_55 = function(entities, gridRowSelectingEventArgs) {
         gridRowSelectingEventArgs.commons.execServer = false;
    };

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_XCUTL59_FEUEU_964 = function(entities, initDataEventArgs) { //ViewContainer: formExecutiveBonus
        var viewState = initDataEventArgs.commons.api.viewState;
		entities.ExecutiveBonusHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		viewState.disable('CM_XCUTL59OCS87');
		task.EtapaTramite = BUSIN.SYSTEM.getParameterByName('Etapa');
		task.TipoTramite = BUSIN.SYSTEM.getParameterByName('Tramite');
    };

	task.initDataCallback.VC_XCUTL59_FEUEU_964 = function(entities, initDataEventArgs) {
		task.validateStatus(entities, initDataEventArgs);
	};

	task.validateStatus = function(entities, eventArgs) {
		if(entities.ExecutiveBonusHeader.status==='I'){
			eventArgs.commons.api.viewState.enable('CM_XCUTL59OCS87');
		}else{
			eventArgs.commons.api.viewState.disable('CM_XCUTL59OCS87');
			BUSIN.API.GRID.hideCommandColumns('QV_QRYXU8599_55',entities.ExecutiveBonusDetails.data(),eventArgs.commons.api,'edit');
		}
	}



}());