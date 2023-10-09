//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: CallCenterPopupQuestions
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    
   renderEventArgs.commons.api.viewState.readOnly('VA_7904MAZZXVKTTBR_383912', true);


};