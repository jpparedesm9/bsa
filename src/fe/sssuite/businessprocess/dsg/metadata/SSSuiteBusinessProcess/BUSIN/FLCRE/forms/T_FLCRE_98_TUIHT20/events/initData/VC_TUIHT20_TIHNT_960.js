//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: TPunishment
    task.initData.VC_TUIHT20_TIHNT_960 = function (entities, initDataEventArgs){
        var viewState = initDataEventArgs.commons.api.viewState;
		BUSIN.API.disable(viewState,['CM_TFLCRE_9_342']);
        var user = cobis.userContext.getValue(cobis.constant.USER_NAME);
		initDataEventArgs.commons.execServer = true;
		entities.HeaderPunishment.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		//entidades manuales
		entities.generalData={};
		entities.generalData.parameterMassive = "";
		entities.generalData.rowData=2;
		entities.Operations=[{}];
    };