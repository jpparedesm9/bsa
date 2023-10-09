//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: QueryDocumentsCycle
    task.initData.VC_DOCUMENTYL_319252 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXFVY_775645');
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXLVP_311645');
        initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXKOK_630645');
        
    };