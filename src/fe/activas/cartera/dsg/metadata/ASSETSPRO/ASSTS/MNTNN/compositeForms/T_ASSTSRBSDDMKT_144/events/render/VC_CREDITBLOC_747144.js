//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CreditBlockComposite
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        
         ASSETS.Header.setDataStyle("VC_CREDITBLOC_747144","VC_EXWPOQOCGB_614144",entities, renderEventArgs); 
              
    };