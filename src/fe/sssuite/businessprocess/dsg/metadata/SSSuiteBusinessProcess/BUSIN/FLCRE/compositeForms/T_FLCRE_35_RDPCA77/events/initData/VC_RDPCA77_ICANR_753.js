//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ApprovedApplication
    task.initData.VC_RDPCA77_ICANR_753 = function (entities, initDataEventArgs) {
        FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, true, false);

        var viewState = initDataEventArgs.commons.api.viewState;
        var userL = cobis.userContext.getValue(cobis.constant.USER_NAME);
        var parentParameters = initDataEventArgs.commons.api.parentVc.model; //OGU
        entities.OriginalHeader.UserL = userL;
        entities.generalData = {}; //entidad a mano -> para informacion
        entities.generalData.productTypeName = "";
        entities.generalData.paymentFrecuencyName = "";

        entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
        entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
        entities.OriginalHeader.ActivityNumber = parentParameters.Task.taskInstanceIdentifier;
        var client = initDataEventArgs.commons.api.parentVc.model.Task;
        initDataEventArgs.commons.execServer = true;
    };