//gridInitDetailTemplate QueryView: QV_7029_28177
        //
        task.gridInitDetailTemplate.QV_7029_28177 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            gridInitDetailTemplateEventArgs.commons.execServer = false;
		    var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;
            var api = gridInitDetailTemplateEventArgs.commons.api;
            nav.customDialogParameters = {
				idMember: gridInitDetailTemplateEventArgs.modelRow.codeMember,
				idTramite: entities.OriginalHeader.IDRequested,
                productType: entities.OriginalHeader.ProductType,
				applicationSubject:entities.Context.ApplicationSubject,
				enable: entities.Context.enable
			};
            nav.address = {
               moduleId: 'BUSIN',
               subModuleId: 'FLCRE',
               taskId: 'T_BUSINIJVXCUKR_496',
               taskVersion: '1.0.0',
               viewContainerId: 'VC_DATAVERION_567496'
            };
            nav.openDetailTemplate('QV_7029_28177', gridInitDetailTemplateEventArgs.modelRow);            
        };