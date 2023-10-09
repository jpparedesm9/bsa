//gridInitDetailTemplate QueryView: GridPolicy
    //
    task.gridInitDetailTemplate.QV_QUERO4480_42 = function (entities, gridInitDetailTemplateEventArgs) {
        gridInitDetailTemplateEventArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
        nav.customDialogParameters = {
            Mnemonic: gridInitDetailTemplateEventArgs.modelRow.mnemonic,
            VariablePolicy: entities.VariablePolicy,
            seccion: 'P'
        };
        nav.openDetailTemplate('QV_QUERO4480_42', gridInitDetailTemplateEventArgs.modelRow);

    };