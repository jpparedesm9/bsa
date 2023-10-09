//Command4 (Button) 
task.executeCommand.CM_TCUSTOME_T01 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    let confirmMsg = '';
    let collectives = executeCommandEventArgs.commons.api.vc.catalogs.VA_COLECTIVOXQJYTJ_296213.data();

    for (let i = 0; i < collectives.length; i++) {
        if (collectives[i].code === entities.NaturalPerson.colectivo) {
            confirmMsg = 'Tipo de Mercado ' + collectives[i].value + ', \u00bfest\u00e1 seguro de su selecci\u00f3n?';
            break;
        }
    }

    var nav = executeCommandEventArgs.commons.api.navigation;
    nav.label = 'Advertencia';
    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CSTMRRJEZNQUS_394',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_CONFIRMMGG_786394'
    };
    nav.queryParameters = {
        mode: 2
    };
    nav.modalProperties = {
        size: "sm"
    };
    nav.customDialogParameters = {
        mMessage: confirmMsg
    }
    nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);

};