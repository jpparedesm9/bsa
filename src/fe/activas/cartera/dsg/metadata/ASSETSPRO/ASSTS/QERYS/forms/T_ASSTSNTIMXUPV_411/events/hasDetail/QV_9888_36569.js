//gridInitDetailTemplate QueryView: QV_9888_36569
        //
        task.gridInitDetailTemplate.QV_9888_36569 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            //gridInitDetailTemplate
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

            nav.address = {
            moduleId: 'ASSTS',
            subModuleId: 'QERYS',
            taskId: 'T_ASSTSDVYDGJCT_107',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_DOCUMENTDT_406107'
            };
            nav.queryParameters = {
            mode: 8
            };
            //nav.customDialogParameters = {
            //variable: value
            //};

            nav.openDetailTemplate("QV_9888_36569", gridInitDetailTemplateEventArgs.modelRow);
        };