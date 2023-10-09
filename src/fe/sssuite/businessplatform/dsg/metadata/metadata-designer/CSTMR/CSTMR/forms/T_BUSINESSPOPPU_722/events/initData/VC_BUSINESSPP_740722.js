//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: BusinessPopupForm
    task.initData.VC_BUSINESSPP_740722 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        if(entities.Business.numberOfBusiness == 0){
            entities.Business.numberOfBusiness = null;
        }
        if(entities.Business.timeActivity == 0){
            entities.Business.timeActivity = null;
        }
        if(entities.Business.timeBusinessAddress == 0){
            entities.Business.timeBusinessAddress = null;
        }
        if(entities.Business.mountlyIncomes == 0){
            entities.Business.mountlyIncomes = null;
        }
        if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){
            //entities.Business.country=484//MEXICO
            entities.Business.customerCode=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmpBusiness.code;
            
        }
        initDataEventArgs.commons.api.viewState.hide('VA_TURNAROUNDZKHZG_712246');
        initDataEventArgs.commons.api.viewState.hide('VA_MOUNTLYINCOMSEE_419246');
        initDataEventArgs.commons.api.viewState.disable('VA_WHICHRESOURCEEE_338246');
        entities.Business.turnaround='A';     
    };