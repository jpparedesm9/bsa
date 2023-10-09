//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoanSearchForm
    task.initData.VC_LOANSEARHC_144959 = function (entities, initDataEventArgs){
        queryString = ASSETS.Utils.getQueryStrings();
        

 var viewState = initDataEventArgs.commons.api.viewState;

        
        entities.LoanInstancia.idOptionMenu = queryString.menu;
        entities.LoanInstancia.tipo = queryString.type;
        initDataEventArgs.commons.execServer = true;
        if(queryString.menu == ASSETS.Constants.MENU_QUERYSGENERAL || queryString.menu == ASSETS.Constants.MENU_IMPRESIONDOC){
            viewState.enable('Spacer1633');
            viewState.show('Spacer1633');
        }else{
            viewState.disable('Spacer1633');
            viewState.hide('Spacer1633');
        }
    };