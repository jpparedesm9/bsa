//gridInitDetailTemplate QueryView: QV_8174_44016
task.gridInitDetailTemplate.QV_8174_44016 = function (entities,gridInitDetailTemplateEventArgs) {
    gridInitDetailTemplateEventArgs.commons.execServer = false;
    //gridInitDetailTemplate
    var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

    nav.address = {
        moduleId: 'CSTMR',
        subModuleId: 'CSTMR',
        taskId: 'T_CSTMRHRTWSVMF_499',
        taskVersion: '1.0.0',
        viewContainerId: 'VC_AUTHORIZEN_812499'
    };
    nav.queryParameters = {
        mode: 8
    };
    nav.customDialogParameters = {
        idRequest: gridInitDetailTemplateEventArgs.modelRow.idRequest
    };

    nav.openDetailTemplate('QV_8174_44016', gridInitDetailTemplateEventArgs.modelRow);
};