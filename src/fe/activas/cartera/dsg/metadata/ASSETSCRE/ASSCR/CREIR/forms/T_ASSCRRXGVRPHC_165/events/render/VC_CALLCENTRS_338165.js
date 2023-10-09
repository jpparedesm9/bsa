//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CallCenterQuestions
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.viewState.readOnly('VA_1194BQLISALGYQY_683769', true);
        
    };