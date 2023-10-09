//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestionsCompound
    task.initData.VC_DATAVERITO_790838 = function (entities, initDataEventArgs){   
        var viewState = initDataEventArgs.commons.api.viewState;
        var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
        var parentParameters = initDataEventArgs.commons.api.parentVc.model; // Recupero parametros de la ventana padre
        typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
        // Set de campos
		entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
		entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
		entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
		entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
		entities.OriginalHeader.OpNumberBank = parentParameters.Task.bussinessInformationStringOne;
		entities.GeneralData.type = parentParameters.Task.urlParams.TRAMITE;
        entities.Context.CustomerId = parentParameters.Task.clientId;       
        entities.Context.ApplicationSubject = parentParameters.Task.taskSubject;
        initDataEventArgs.commons.execServer = true;
        
    };