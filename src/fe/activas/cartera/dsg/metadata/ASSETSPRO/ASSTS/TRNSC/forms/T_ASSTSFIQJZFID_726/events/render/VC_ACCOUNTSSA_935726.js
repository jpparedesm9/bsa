//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: AccountStatusForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
        document.getElementById('VA_CLIENTNAMEEZJBH_766859').readOnly=true;
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSFI_AS9");
        renderEventArgs.commons.api.viewState.disable("CM_TASSTSFI_S64"); 
    };