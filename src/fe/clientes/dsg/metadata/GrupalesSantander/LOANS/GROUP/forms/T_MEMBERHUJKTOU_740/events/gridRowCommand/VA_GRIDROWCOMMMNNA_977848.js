//Entity: Member
//Member. (ImageButton) View: MemberForm

task.gridRowCommand.VA_GRIDROWCOMMMNNA_977848 = function (entities, gridRowCommandEventArgs) {

    gridRowCommandEventArgs.commons.execServer = false;

    var nav = gridRowCommandEventArgs.commons.api.navigation;
    //views/CSTMR/CSTMR/T_CUSTOMERCOETP_680/1.0.0/VC_CUSTOMEROI_208680_TASK.html
    nav.label = 'Mantenimiento de Personas Naturales';
    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CUSTOMERCOETP_680',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CUSTOMEROI_208680'
    };
    nav.queryParameters = {
        mode: 9
    };
    nav.modalProperties = {
        size: 'lg',
        height: 900,
        callFromGrid: true
    };
    nav.customDialogParameters = {
        clientId: gridRowCommandEventArgs.rowData.customerId
    };
    //   nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, null);  //Si la llamada es desde un evento de un control 
    nav.openModalWindow(gridRowCommandEventArgs.commons.controlId, gridRowCommandEventArgs.rowData);

};