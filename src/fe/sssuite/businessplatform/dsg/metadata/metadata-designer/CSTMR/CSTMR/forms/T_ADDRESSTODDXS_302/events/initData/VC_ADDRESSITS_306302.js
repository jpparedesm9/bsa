//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: AddressPopupForm
task.initData.VC_ADDRESSITS_306302 = function (entities, initDataEventArgs){    
    
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXSGN_115436');

    //Recuperacion de parametros de residencia, negocio y pais
    pais = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag1;
    dirResidencia = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag2;
    dirNegocio = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag3;
    entities.PhysicalAddress.addressMessage = optionMessage;
    task.validateBusiness(entities, initDataEventArgs);
    if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){

        entities.PhysicalAddress.countryCode=pais;//MEXICO
        entities.PhysicalAddress.provinceCode=undefined;
        entities.PhysicalAddress.cityCode=undefined;
        entities.PhysicalAddress.parishCode=undefined;
        entities.PhysicalAddress.personSecuential=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmp.code;
    
    }else if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Update){
        initDataEventArgs.commons.execServer = true;     
        initDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        initDataEventArgs.commons.serverParameters.Phone = true;
        mustRefreshCity=true;
        mustRefreshParish=true;
    }

    if (entities.PhysicalAddress.directionNumberInternal === -1) {
        entities.PhysicalAddress.directionNumberInternal = null;
    }
    
 
};