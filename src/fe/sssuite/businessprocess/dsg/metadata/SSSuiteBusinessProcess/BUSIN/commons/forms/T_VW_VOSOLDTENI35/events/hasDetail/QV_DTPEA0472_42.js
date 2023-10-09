//gridInitDetailTemplate QueryView: Solicitudes de Castigo
        //
        task.gridInitDetailTemplate.QV_DTPEA0472_42 = function (entities, gridInitDetailTemplateEventArgs) {
            gridInitDetailTemplateEventArgs.commons.execServer = false;
            var nav = FLCRE.API.getApiNavigation(gridInitDetailTemplateEventArgs,'T_FLCRE_58_ETLLN40','VC_ETLLN40_LENTI_976');
            nav.customDialogParameters = {        };
            nav.openDetailTemplate('QV_DTPEA0472_42', gridInitDetailTemplateEventArgs.modelRow);
        };