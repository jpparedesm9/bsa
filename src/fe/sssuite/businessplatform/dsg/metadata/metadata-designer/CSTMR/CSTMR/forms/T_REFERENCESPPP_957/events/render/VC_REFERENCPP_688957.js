//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: ReferencesPopupForm
task.render = function (entities, renderEventArgs){
    renderEventArgs.commons.execServer = false;

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null:locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0){
        parameters[params[0]] = params[1];
    }
    
    if (parameters != null && parameters.modo != null && parameters.modo != undefined  && parameters.modo == 'Q'){
        var controls = ['VC_REFERENCPP_688957'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);        
    }
    
};