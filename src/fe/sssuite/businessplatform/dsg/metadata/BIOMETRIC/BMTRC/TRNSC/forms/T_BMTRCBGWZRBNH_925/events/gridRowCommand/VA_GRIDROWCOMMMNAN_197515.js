//Entity: Customer
//Customer. (Button) View: BiometricValidation

task.gridRowCommand.VA_GRIDROWCOMMMNAN_197515 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;

    //Open Modal
    var nav = gridRowCommandEventArgs.commons.api.navigation;

    nav.label = cobis.translate('BMTRC.LBL_BMTRC_DOCUMENOO_55979');
    nav.address = {
        moduleId: 'BMTRC',
        subModuleId: 'TRNSC',
        taskId: 'T_BMTRCNYSSKGHD_541',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_DOCUMENTDD_249541'
    };
    nav.queryParameters = {
        mode: 8
    };
    nav.modalProperties = {
        size: 'md',
        callFromGrid: false
    };
    nav.customDialogParameters = {
        customerId: gridRowCommandEventArgs.rowData.idCustomer
    };
    nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, gridRowCommandEventArgs.modelRow);

};