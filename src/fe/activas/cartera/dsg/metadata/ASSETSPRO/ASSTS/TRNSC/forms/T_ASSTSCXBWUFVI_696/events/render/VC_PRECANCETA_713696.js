//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: PreCancellationLoanReference
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        document.getElementById('VA_CLIENTNAMESZXPR_236796').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSCX__8X");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSCX_S1_"); 
        
    };