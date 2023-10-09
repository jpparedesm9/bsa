// (Button) Recomendation
    task.executeCommand.CM_OTENA94COM63 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;//JRU false
		if(!task.validateStatus(entities, executeCommandEventArgs,true)&&!task.validateObservations(entities, executeCommandEventArgs,true)){
			return;
		}
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_52_VREDE97','VC_VREDE97_EREMM_306');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_RECENDAON_73799');
		nav.modalProperties = { size: 'mg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Insert };
		nav.customDialogParameters = { Request: FLCRE.CONSTANTS.RequestName.Castigo, Type:task.Type, HeaderPunishment:entities.HeaderPunishment  };
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
    };