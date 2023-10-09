//gridInitDetailTemplate QueryView: GridExceptions
    //
    task.gridInitDetailTemplate.QV_UERXC4756_18 = function (entities, gridInitDetailTemplateEventArgs) {
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
            VariableEx: entities.VariableExceptions,
            seccion: 'E'
        };
        nav.openDetailTemplate('QV_UERXC4756_18', gridInitDetailTemplateEventArgs.modelRow);
    };