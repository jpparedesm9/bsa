// (Button) 
    task.executeCommand.CM_TASSTSNZ_39S = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        entities.ConciliationManualSearchFilter.conciliationType = "AC"; // APLICAR SIN ACCION

        var lengthConciliationManual = entities.ConciliationManualSearch.data().length;

        if (lengthConciliationManual > 0 ) {
            var listConciliationManual = entities.ConciliationManualSearch.data();
            var existSelected = false;

                listConciliationManual.forEach(function(row) {
                    if (row.isSelected) {
                        existSelected = true; // Existe un seleccionado
                    }
                });

            if (existSelected) {
                //Open Modal
                var nav = executeCommandEventArgs.commons.api.navigation;

                nav.address = {
                    moduleId: 'ASSTS',
                    subModuleId: 'CMMNS',
                    taskId: 'T_ASSTSTCQYYGZK_806',
                    taskVersion: '1.0.0',
                    viewContainerId: 'VC_CONCILIAAA_437806'
                };
                nav.queryParameters = {
                    mode: 1
                };
                nav.modalProperties = {
                    size: 'md',
                    height: 200,
                    callFromGrid: false
                };

                //Si la llamada es desde un evento de un control perteneciente a la cabecera de la página
                nav.openModalWindow(executeCommandEventArgs.commons.controlId, null);
                //Si la llamada es desde un evento de un control perteneciente a una grilla de la página
                //nav.openModalWindow(id, executeCommandEventArgs.modelRow);
            }
        }
    };