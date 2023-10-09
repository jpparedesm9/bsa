//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TConsolidatePenalization
    task.initDataCallback.VC_OTENA94_SELZT_306 = function (entities, initDataEventArgs){
        task.setSecurity(entities, initDataEventArgs , 'INIT');
		if((task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='NO') 
			|| (task.Type===FLCRE.CONSTANTS.OfficerType.Inbox && task.CanEdit==='YES' 
				&& entities.HeaderPunishment.Status === FLCRE.CONSTANTS.StatusPenalization.Processed)
		){
			//BUSIN.INBOX.STATUS.nextStep(initDataEventArgs.success,initDataEventArgs.commons.api);
			BUSIN.API.hide(initDataEventArgs.commons.api.viewState,['CM_OTENA94COM63']);
			BUSIN.API.enable(initDataEventArgs.commons.api.viewState,['CM_OTENA94GAD25']);
		}
    };