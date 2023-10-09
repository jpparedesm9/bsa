//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: ReferencesPopupForm
task.initData.VC_REFERENCPP_688957 = function (entities, initDataEventArgs){
    
    initDataEventArgs.commons.execServer = false;
	initDataEventArgs.commons.api.viewState.hide('VA_SECONDLASTNAEEE_703331');
    initDataEventArgs.commons.api.viewState.hide('VA_RELATIONSHIPOYM_385331');
    
    if(entities.References.numberOfReferences == 0){
        entities.References.numberOfReferences = null;
    }
    if(entities.References.knownTime == 0){
        entities.References.knownTime = null;
    }
        

    if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){
        entities.References.country=484//MEXICO
        entities.References.customerCode=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmpReferences.code;
    }
    
};