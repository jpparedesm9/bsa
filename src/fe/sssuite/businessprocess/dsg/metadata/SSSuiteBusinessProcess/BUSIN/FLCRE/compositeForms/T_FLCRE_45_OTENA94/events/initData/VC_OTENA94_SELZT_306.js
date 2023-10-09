//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TConsolidatePenalization
    task.initData.VC_OTENA94_SELZT_306 = function (entities, initDataEventArgs){
        var viewState = initDataEventArgs.commons.api.viewState;
		BUSIN.API.disable(viewState,['CM_OTENA94GAD25','CM_OTENA94COM63','CM_OTENA94IDE41']);
		BUSIN.API.hide(viewState,['CM_OTENA94AAI98','CM_OTENA94IDE41']);
		task.Type = BUSIN.SYSTEM.getParameterByName('Type');        
		if(task.Type === ''){
			if(initDataEventArgs.commons.api.parentVc!=undefined||initDataEventArgs.commons.api.parentVc!=null){
				var parentTask = initDataEventArgs.commons.api.parentVc.customDialogParameters.Task;
				task.CanEdit = parentTask.urlParams.Editable;
				task.Type = parentTask.urlParams.Type;
				entities.HeaderPunishment.Step = parentTask.urlParams.Etapa;
				entities.HeaderPunishment.ApplicationNumber = parentTask.processInstanceIdentifier;
				entities.HeaderPunishment.ParentGroupID = parentTask.bussinessInformationIntegerTwo;
				entities.HeaderPunishment.CourtDate = BUSIN.CONVERT.DATE.FromStringMDY(parentTask.bussinessInformationStringTwo);
			}else{
				task.Type = 'AC';
			}			
		}
		entities.HeaderPunishment.Type = task.Type;
    };