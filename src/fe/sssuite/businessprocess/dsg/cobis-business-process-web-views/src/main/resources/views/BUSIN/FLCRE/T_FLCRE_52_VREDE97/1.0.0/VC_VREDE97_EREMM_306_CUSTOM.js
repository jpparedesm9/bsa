<!-- Designer Generator v 5.0.0.1514 - release SPR 2015-14 24/07/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.tsendrecommended;
	task.Type = '';
	task.Request = '';

    //**********************************************************
    //  Eventos para COMANDOS DE TAREA
    //**********************************************************
    task.executeCommand.CM_VREDE97AER98 = function(entities, executeCommandEventArgs) { //Cancelar (Button)
        executeCommandEventArgs.commons.execServer = false;
		var result = [task.Request,task.Type,'NO'];
		executeCommandEventArgs.commons.api.vc.closeModal(result);
    };
    
    task.executeCommand.CM_VREDE97PCE89 = function(entities, executeCommandEventArgs) { //Procesar (Button)
		var entity = entities.HeaderPunishment;
		if(entity.Status != FLCRE.CONSTANTS.StatusPenalization.Entered){
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_STORIOEAA_96312',null,6000);
			executeCommandEventArgs.commons.execServer = false;
			return;
		}
		if (entity.Observation === null || entity.Observation.trim() === '' || entity.ConsistencyApplication === null || entity.ConsistencyApplication.trim() === '' ){
			executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('DSGNR.SYS_DSGNR_LBLERRCNS_00025',null,6000);
			executeCommandEventArgs.commons.execServer = false;
			return;
		}
    };
	task.executeCommandCallback.CM_VREDE97PCE89 = function(entities, executeCommandEventArgs) { //Procesar (Button)
		if(executeCommandEventArgs.success===true){
			var result = [task.Request,task.Type,'YES',entities.HeaderPunishment.ApplicationNumber];
			executeCommandEventArgs.commons.api.vc.closeModal(result);
		}
    };
    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_VREDE97_EREMM_306 = function(entities, initDataEventArgs) { //ViewContainer: VCSendRecommended
        initDataEventArgs.commons.execServer = false;
		var viewState = initDataEventArgs.commons.api.viewState;
		var parameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		task.Request = parameters.Request;
		if(task.Request === FLCRE.CONSTANTS.RequestName.Castigo){
			task.Type = parameters.Type;
			if(parameters.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed){
				viewState.hide('CM_VREDE97PCE89');
				BUSIN.API.disable(viewState,['CM_VREDE97PCE89','VA_SEDCMMENED3085_DTIN057','VA_SEDCMMENED3085_BRTO876']);
			}else{
				entities.HeaderPunishment.Type = task.Type;
				entities.HeaderPunishment.CourtDate = parameters.HeaderPunishment.CourtDate;
				entities.HeaderPunishment.GroupID = parameters.HeaderPunishment.GroupID;
				entities.HeaderPunishment.Status = parameters.HeaderPunishment.Status;
			}
		}
    };


    task.render = function(entities, renderEventArgs) { //ViewContainer: VCSendRecommended
		renderEventArgs.commons.api.viewState.enableValidation('VA_SEDCMMENED3085_DTIN057',VisualValidationTypeEnum.Required);
    };

}());