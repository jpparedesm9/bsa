// (Button) 
    task.executeCommand.CM_PAYMENTS_T7N = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        //Open Modal
        var nav = executeCommandEventArgs.commons.api.navigation;

        nav.label = cobis.translate('ASSTS.LBL_ASSTS_NEGOCIANI_54038'); //Negociacion
        nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_NEGOTIATIOTML_700',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_NEGOTIATOO_775700'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'md',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            negotiation: entities.Negotiation
        };

        nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
        
    };