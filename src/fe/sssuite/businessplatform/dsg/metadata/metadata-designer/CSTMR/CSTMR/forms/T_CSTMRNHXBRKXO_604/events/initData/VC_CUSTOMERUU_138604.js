//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CustomerSpouseForm
    task.initData.VC_CUSTOMERUU_138604 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        initDataEventArgs.commons.api.vc.executeCommand('VA_VABUTTONSTVQSJN_350425','FindCustomer', undefined, true, false, 'VC_CUSTOMEROI_208680', false);
        
    };