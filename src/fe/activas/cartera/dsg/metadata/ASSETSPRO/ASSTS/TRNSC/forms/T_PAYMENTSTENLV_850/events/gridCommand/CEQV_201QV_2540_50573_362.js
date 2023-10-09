//gridCommand (Button) QueryView: QV_2540_50573
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_2540_50573_362 = function (entities, gridExecuteCommandEventArgs) {
        gridExecuteCommandEventArgs.commons.execServer = false;
        //gridExecuteCommandEventArgs.commons.serverParameters.QuoteDetails = true;
        //Open Modal
            var nav = gridExecuteCommandEventArgs.commons.api.navigation;

            nav.label = cobis.translate('ASSTS.LBL_ASSTS_DETALLEAG_48048'); //Detalle del Pago
            nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'TRNSC',
            taskId: 'T_QUOTADETAISOY_745',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_QUOTADETAA_445745'
            };
            nav.queryParameters = {
            mode: 1
            };
            nav.modalProperties = {
            size: 'md',
            callFromGrid: false
            };

            nav.openModalWindow("CEQV_201QV_2540_50573_362", gridExecuteCommandEventArgs.modelRow);
    };