//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: OtherCharges
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
		var  api = renderEventArgs.commons.api;
        try{
			ASSETS.Header.setDataStyle ("VC_PROJECTIAA_407344", "VC_UJNNOFLWUJ_608344", entities, renderEventArgs);
		}
        catch(err){
            renderEventArgs.commons.messageHandler.showMessagesError(err.message,true);
        }
        
    };