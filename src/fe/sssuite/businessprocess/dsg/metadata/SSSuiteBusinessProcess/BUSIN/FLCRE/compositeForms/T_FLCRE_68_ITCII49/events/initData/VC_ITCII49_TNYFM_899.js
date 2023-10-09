//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: PrintingActivity
    task.initData.VC_ITCII49_TNYFM_899 = function (entities, initDataEventArgs) {
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        if (parentParameters.Task.urlParams.TRAMITE != null && parentParameters.Task.urlParams.TRAMITE !== undefined) {
            task.EtapaTramite = parentParameters.Task.urlParams.TRAMITE;
        }
        if (parentParameters.Task.urlParams.ETAPA != null && parentParameters.Task.urlParams.ETAPA !== undefined) {
            task.Etapa = parentParameters.Task.urlParams.ETAPA;
        }
        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;

        var office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
        entities.OriginalHeader.Office = office;
        entities.OriginalHeader.NumberLine = initDataEventArgs.commons.api.parentVc.model.Task.bussinessInformationStringOne;
        entities.generalData = {}; //entidad a mano -> para informacion
        entities.generalData.productTypeName = "";
        entities.generalData.paymentFrecuencyName = "";
        entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
        if (parentParameters.Task.urlParams.MODE == FLCRE.CONSTANTS.Mode.NoHeader) { //en el caso que venga generico
            entities.generalData.Mode = "NH";
        } else {
            entities.generalData.Mode = "";
        }
        initDataEventArgs.commons.execServer = true;
    };