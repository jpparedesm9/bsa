//gridInitDetailTemplate QueryView: QV_9533_13855
        //
        task.gridInitDetailTemplate.QV_9533_13855 = function (entities,gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            //gridInitDetailTemplate
            var nav = gridInitDetailTemplateEventArgs.commons.api.navigation;

            nav.address = {
                moduleId: 'ASSTS',
                subModuleId: 'QERYS',
                taskId: 'T_ASSTSNTIMXUPV_411',
                taskVersion: '1.0.0',
                viewContainerId: 'VC_DOCUMENTSS_852411'
            };
            nav.queryParameters = {
                mode: 8
            };
            nav.customDialogParameters = {
                processInstance: gridInitDetailTemplateEventArgs.modelRow.processInstance,
                groupId: gridInitDetailTemplateEventArgs.modelRow.groupId,
                cycle: gridInitDetailTemplateEventArgs.modelRow.groupCycle,
                loan: gridInitDetailTemplateEventArgs.modelRow.loan
            };

            nav.openDetailTemplate('QV_9533_13855', gridInitDetailTemplateEventArgs.modelRow);
        };