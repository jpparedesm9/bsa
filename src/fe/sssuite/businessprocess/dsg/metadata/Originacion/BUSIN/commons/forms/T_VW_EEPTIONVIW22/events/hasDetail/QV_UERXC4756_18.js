//gridInitDetailTemplate QueryView: GridExceptions
        //
        task.gridInitDetailTemplate.QV_UERXC4756_18 = function (entities, gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateArgs.commons.execServer = false;
        var nav = gridInitDetailTemplateArgs.commons.api.navigation;

        nav.address = {
            moduleId: 'BUSIN',
            subModuleId: 'FLCRE',
            taskId: 'T_FLCRE_50_VPLIC33',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_VPLIC33_VAEPL_011'
        };
		nav.customDialogParameters = {
			Mnemonic:gridInitDetailTemplateArgs.modelRow.mnemonic,
		    VariableEx:entities.VariableExceptions,
			seccion:'E'
		};
        nav.openDetailTemplate('QV_UERXC4756_18', gridInitDetailTemplateArgs.modelRow);
            
        };