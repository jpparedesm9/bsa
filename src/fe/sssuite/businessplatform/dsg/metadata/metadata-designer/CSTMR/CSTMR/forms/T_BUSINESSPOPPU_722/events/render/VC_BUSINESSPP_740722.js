//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: BusinessPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;
    
    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null:locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0){
        parameters[params[0]] = params[1];
    }
    
    if (parameters != null && parameters.modo != null && parameters.modo != undefined  && parameters.modo == 'Q'){
        var controls = ['VC_BUSINESSPP_740722'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);        
    }
    
    
    
    if(entities.Business.resources == 'OT'){
        renderEventArgs.commons.api.viewState.enable('VA_WHICHRESOURCEEE_338246');
    }

};