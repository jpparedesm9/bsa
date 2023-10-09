//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryDocumentsCredit
    task.initData.VC_CREDITDOUE_237252 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.grid.hideColumn('QV_9834_40050','cmdEdition');
		var filtro = {
            processInstance: initDataEventArgs.commons.api.parentVc.customDialogParameters.processInstance,
            customerId: initDataEventArgs.commons.api.parentVc.customDialogParameters.customerId,
            groupId: initDataEventArgs.commons.api.parentVc.customDialogParameters.groupId,
            description: initDataEventArgs.commons.api.parentVc.customDialogParameters.description,
            documentId: initDataEventArgs.commons.api.parentVc.customDialogParameters.documentId,
            extension: initDataEventArgs.commons.api.parentVc.customDialogParameters.extension,
            folder: initDataEventArgs.commons.api.parentVc.customDialogParameters.folder
		}
		initDataEventArgs.commons.api.grid.fillFiltersQuery('Q_DOCUMEHR_9834', filtro);
    };