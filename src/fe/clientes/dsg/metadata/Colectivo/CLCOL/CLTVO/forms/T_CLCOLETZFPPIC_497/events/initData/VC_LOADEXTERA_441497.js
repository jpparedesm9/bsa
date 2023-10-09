//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: LoadExternalAdvisor
    task.initData.VC_LOADEXTERA_441497 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.viewState.disable('VA_VABUTTONXICAMDT_820757');
        initDataEventArgs.commons.api.viewState.hide('VA_4140WTEPCJSGRJB_313757');
        
        initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_604757');
        initDataEventArgs.commons.api.viewState.hide('VA_VASIMPLELABELLL_164757');
        CLCOL.hideOrShowDSGGridButtonByClass('cb-btn-export','hide');

       /* initDataEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394','create')
        initDataEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394','CEQV_201QV_3718_27394_509')*/
        //initDataEventArgs.commons.serverParameters.entityName = true;
    };