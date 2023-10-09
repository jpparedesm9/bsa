//Evento changeGroup : Si desea cerrar una pestaña realizar: args.deferred.resolve(); para cancelar :args.deferred.reject().
    //ViewContainer: AmountForm
    task.changeGroup.VC_AMOUNTIRVT_828678 = function (entities, changeGroupEventArgs){
        changeGroupEventArgs.commons.execServer = false;     
        if(entities.Group.code === null){
			changeGroupEventArgs.commons.api.viewState.disable('VC_ZFXQOGVCIH_421740',true);
		}        
    };