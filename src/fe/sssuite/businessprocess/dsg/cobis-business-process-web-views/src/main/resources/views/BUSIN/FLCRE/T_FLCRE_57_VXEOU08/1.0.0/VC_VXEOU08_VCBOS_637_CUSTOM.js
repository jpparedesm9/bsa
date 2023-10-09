<!-- Designer Generator v 5.0.0.1516 - release SPR 2015-16 21/08/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.executivebonusrisk;
	task.EtapaTramite = '';
	task.TipoTramite = '';

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    //Aprobar (Button)
    task.executeCommand.CM_VXEOU08OAR07 = function(entities, executeCommandEventArgs) {
        // executeCommandEventArgs.commons.execServer = false;
    };

	task.executeCommandCallback.CM_VXEOU08OAR07 = function(entities, executeCommandEventArgs) {
        if(executeCommandEventArgs.success){
			if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Aprobacion && task.TipoTramite === FLCRE.CONSTANTS.RequestName.Bonus){
				executeCommandEventArgs.commons.api.viewState.disable('CM_VXEOU08OAR07');
			}
		}
    };

    //**********************************************************
    //  Acciones de QUERY VIEW
    //**********************************************************
    task.gridRowUpdating.QV_QRYXU8599_55 = function(entities, gridRowUpdatingEventArgs) { //Update QueryView: GridExecutiveBonus
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Aprobacion && task.TipoTramite === FLCRE.CONSTANTS.RequestName.Bonus){
			gridRowUpdatingEventArgs.commons.execServer = false;
		}
    };

    task.gridRowSelecting.QV_QRYXU8599_55 = function(entities, gridRowSelectingEventArgs) { //SeletingRow QueryView: GridExecutiveBonus
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Aprobacion && task.TipoTramite === FLCRE.CONSTANTS.RequestName.Bonus){
			gridRowSelectingEventArgs.commons.execServer = false;
		}
    };
	task.gridRowSelecting.QV_CECVO1975_71 = function(entities, gridRowSelectingEventArgs) {
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Aprobacion && task.TipoTramite === FLCRE.CONSTANTS.RequestName.Bonus){
			gridRowSelectingEventArgs.commons.execServer = false;
		}
	}
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_VXEOU08_VCBOS_637 = function(entities, initDataEventArgs) { //ViewContainer: VExecutiveBonusRisk
		entities.ExecutiveBonusHeader.userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		initDataEventArgs.commons.api.viewState.disable('CM_VXEOU08OAR07');
		task.EtapaTramite = BUSIN.SYSTEM.getParameterByName('Etapa');
		task.TipoTramite = BUSIN.SYSTEM.getParameterByName('Tramite');
    };

    task.render = function(entities, renderEventArgs) { //ViewContainer: VExecutiveBonusRisk
		if(task.EtapaTramite === FLCRE.CONSTANTS.Stage.Aprobacion && task.TipoTramite === FLCRE.CONSTANTS.RequestName.Bonus){
			BUSIN.API.GRID.hideCommandColumns('QV_QRYXU8599_55',entities.ExecutiveBonusDetails.data(),renderEventArgs.commons.api,'edit');
			if(entities.ExecutiveBonusHeader.status==='I'){
				renderEventArgs.commons.api.viewState.enable('CM_VXEOU08OAR07');
			}
		}
    };

}());