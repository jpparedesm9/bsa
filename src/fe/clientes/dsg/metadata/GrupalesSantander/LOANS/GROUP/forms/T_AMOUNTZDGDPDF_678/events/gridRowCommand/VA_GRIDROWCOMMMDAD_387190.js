//Entity: Amount
    //Amount. (Button) View: AmountForm
    
    task.gridRowCommand.VA_GRIDROWCOMMMDAD_387190 = function(  entities, gridRowCommandEventArgs ) {

    gridRowCommandEventArgs.commons.execServer = false;
    
        //Open Modal
        var nav = gridRowCommandEventArgs.commons.api.navigation;

        nav.label = 'Tabla de Amortizacion';
        nav.address = {
        moduleId: 'LOANS',
        subModuleId: 'GROUP',
        taskId: 'T_LOANSKVAEOTPS_336',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_AMORTIZAAT_297336'
        };
        nav.queryParameters = {
        mode: 1
        };
        nav.modalProperties = {
        size: 'md',
        height: 450,
        callFromGrid: false
        };
        nav.customDialogParameters = {
            operation: gridRowCommandEventArgs.rowData.oldOperation
        };

        //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
        //nav.openModalWindow(args.commons.controlId, null);
        //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
        nav.openModalWindow('VA_GRIDROWCOMMMDAD_387190', gridRowCommandEventArgs.rowData);

    };