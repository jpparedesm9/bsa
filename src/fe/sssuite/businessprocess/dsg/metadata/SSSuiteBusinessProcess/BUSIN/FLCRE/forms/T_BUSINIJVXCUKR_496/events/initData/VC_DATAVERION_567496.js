//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: DataVerificationQuestions
task.initData.VC_DATAVERION_567496 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = true;
    //initDataEventArgs.commons.serverParameters.entityName = true;

    var idMember=initDataEventArgs.commons.api.parentVc.customDialogParameters.idMember;
    var idTramite=initDataEventArgs.commons.api.parentVc.customDialogParameters.idTramite;
    var productType=initDataEventArgs.commons.api.parentVc.customDialogParameters.productType;
	var applicationSubject= initDataEventArgs.commons.api.parentVc.customDialogParameters.applicationSubject;
	var enable = initDataEventArgs.commons.api.parentVc.customDialogParameters.enable;
    entities.Context.CustomerId=idMember;
    entities.Context.RequestId=idTramite;
    entities.Context.Type = productType;
	entities.Context.ApplicationSubject = applicationSubject;
	entities.Context.enable = enable;

};