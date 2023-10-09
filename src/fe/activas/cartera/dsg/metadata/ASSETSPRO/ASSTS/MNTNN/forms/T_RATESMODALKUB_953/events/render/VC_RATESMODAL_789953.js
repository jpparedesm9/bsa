//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: RatesModal
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        if (closeModal) {
            var cancelButton = false;
            renderEventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_DEBESELRN_17291",true);
            renderEventArgs.commons.api.navigation.closeModal(cancelButton);
            return;
        }
        
        if (mode == 2) {
            entities.Rates.portfolioClass = portfolioClassAux;
            
            //Traer el valor referencial
            if (entities.Rates.clase == 'F') {
                if (entities.ServerParameter.refresGridFlag == false || entities.ServerParameter.refresGridFlag == null) {
                    entities.ServerParameter.refresGridFlag = true;
                } else {
                    entities.ServerParameter.refresGridFlag = false;
                }
            }
        }
        
    };