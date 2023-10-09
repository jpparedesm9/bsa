//gridInitDetailTemplate QueryView: QV_1763_79525
        //
        task.gridInitDetailTemplate.QV_1763_79525 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            var customerId = gridInitDetailTemplateEventArgs.modelRow.members;
			var asd = customerId.split("-");
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;
            
			nav.address = {
			moduleId: 'LOANS',
			subModuleId: 'GROUP',
			taskId: 'T_LOANSTIAEJUNH_604',
			taskVersion: '1.0.0',
			viewContainerId: 'VC_SCANNEDDAE_495604'
			};
			nav.queryParameters = {
			mode: 8 
			};
			nav.openDetailTemplate('QV_1763_79525', gridInitDetailTemplateEventArgs.modelRow);
        };