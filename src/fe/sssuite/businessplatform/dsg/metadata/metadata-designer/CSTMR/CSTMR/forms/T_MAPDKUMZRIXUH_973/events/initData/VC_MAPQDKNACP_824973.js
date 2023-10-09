//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: MapForm
    task.initData.VC_MAPQDKNACP_824973 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        var nav = initDataEventArgs.commons.api.navigation;
        nav.customAddress = {
            id: "upload",
            url: "/CSTMR/CSTMR/T_MAPDKUMZRIXUH_973/1.0.0/consumo.html",
            useMinification: false
        };
        nav.registerCustomView('G_MAPJMEXDHW_492945');
    };