//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BioValidationComposite
    task.initData.VC_BIOVALIDSA_412339 = function (entities, initDataEventArgs){
       initDataEventArgs.commons.execServer = true;
        var parentVc = initDataEventArgs.commons.api.vc.parentVc;
        var parentParameters = parentVc == undefined || parentVc == null ? {} : parentVc.model;
        var task = parentParameters.Task;
        if (task != null) {
            entities.ValidationData.customerId = task.clientId;
            entities.Credit.office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
            entities.Credit.applicationNumber = task.processInstanceIdentifier;
            entities.Credit.productType = task.bussinessInformationStringTwo;
            entities.Credit.creditCode = task.bussinessInformationIntegerTwo;
            entities.ValidationData.processInstance = task.processInstanceIdentifier;
            
            if (entities.Credit.productType == 'REVOLVENTE'){
                initDataEventArgs.commons.api.viewState.hide('VA_RESULTVALIDAIOT_362515');
                initDataEventArgs.commons.api.viewState.hide('CM_TBMTRCXB_T69');
            }
        }
    };