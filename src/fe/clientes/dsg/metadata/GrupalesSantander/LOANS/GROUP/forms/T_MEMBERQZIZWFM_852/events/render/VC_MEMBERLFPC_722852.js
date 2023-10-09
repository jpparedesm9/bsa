//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: MemberPopPupForm
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        var viewState = renderEventArgs.commons.api.viewState;
        if(mode===renderEventArgs.commons.constants.mode.Insert){
            viewState.disable('VA_TEXTINPUTBOXAIN_291132',true);			
        }else if(mode===renderEventArgs.commons.constants.mode.Update){
			viewState.disable('VA_TEXTINPUTBOXOKY_519132',true);
		}
        
        
    };