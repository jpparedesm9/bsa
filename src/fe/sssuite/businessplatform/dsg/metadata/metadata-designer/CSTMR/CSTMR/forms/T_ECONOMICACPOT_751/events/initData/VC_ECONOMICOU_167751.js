//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: EconomicActivityPopupForm
task.initData.VC_ECONOMICOU_167751 = function (entities, initDataEventArgs){
    initDataEventArgs.commons.execServer = false;
    
    if (initDataEventArgs.commons.api.vc.mode == 1) {
        entities.EconomicActivity.personSecuential = initDataEventArgs.commons.api.parentVc.model.NaturalPerson.personSecuential;
        task.calculateAntiquity(entities.EconomicActivity);
    }
    
    entities.EconomicActivity.authorized = 'S';
     if(entities.EconomicActivity.secuential==0)
    {
    entities.EconomicActivity.economicSector='III'
    entities.EconomicActivity.subSector='U'
    }
    initDataEventArgs.commons.api.viewState.disable('VA_ECONOMICSECTORO_655887');
    initDataEventArgs.commons.api.viewState.disable('VA_SUBSECTORFKJIRP_876887');
    initDataEventArgs.commons.api.viewState.hide('VA_PRINCIPALJAQWIU_928887');
    initDataEventArgs.commons.api.viewState.hide('VA_DESCRIPTIONGSVS_438887');
    initDataEventArgs.commons.api.viewState.hide('VA_NUMBEREMPLOYEEE_936887');
    
    entities.EconomicActivity.description='S';
    entities.EconomicActivity.numberEmployees=1;
    entities.EconomicActivity.principal='N'

};