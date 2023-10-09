// (Button) 
task.executeCommand.CM_RPUME79PRN97 = function (entities, executeCommandEventArgs) {
    //No se ejecuta en el servidor
    executeCommandEventArgs.commons.execServer = true;
    entities.OriginalHeader = {};
    entities.OriginalHeader.IDRequested = entities.SearchCriteriaPrintingDocuments.codeProcess;
    entities.OriginalHeader.TypeRequest = entities.SearchCriteriaPrintingDocuments.FlowType;
    entities.OriginalHeader.ApplicationNumber = selectedApplication[0].ApplicationCode;
    //validar si imprimo el seguro :basico o extendido
    var executeExtendMedical = task.executeReportMedical(entities);
    var executeBasicReport = executeExtendMedical == true ? false : true;
    var isReportSecurity = false;
    var count = 0;
    //entities.OriginalHeader.IDRequested = 1;
    for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
        if (entities.DocumentProduct.data()[i].YesNot === true) {

            if (entities.DocumentProduct.data()[i].Nemonic == 'CERCON'|| entities.DocumentProduct.data()[i].Nemonic == 'CERCONIND') {
                isReportSecurity = true;
                if (executeBasicReport) {
                    //imprimo siempre reprote basico
                    count = count + 1;
                    var report = entities.DocumentProduct.data()[i].Template.split("-")[0];
                    var args = [
                        ['report.module', 'cartera'],
                        ['report.name', report],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(report, args);
                }
                if (executeExtendMedical) { //imprimo reporte extendido 
                    count = count + 1;
                    var reports = entities.DocumentProduct.data()[i].Template.split("-");
                    var args = [
                        ['report.module', 'cartera'],
                        ['report.name', reports[0]],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(reports[0], args);

                    args = [
                        ['report.module', 'cartera'],
                        ['report.name', reports[1]],
                        ['idTramite', entities.OriginalHeader.IDRequested],
                        ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                    ];
                    BUSIN.REPORT.GenerarReporte(reports[1], args);
                }
            } else if (entities.DocumentProduct.data()[i].Nemonic == 'SOPREREFI' || entities.DocumentProduct.data()[i].Nemonic == 'SOLPREGRU') {
                count = count + 1;

                var clientId = 0;
                var group = 'N';

                if (entities.SearchCriteriaPrintingDocuments.CustomerId != null && entities.SearchCriteriaPrintingDocuments.group != null && entities.SearchCriteriaPrintingDocuments.CustomerId != '' && entities.SearchCriteriaPrintingDocuments.CustomerId != undefined) {
                    var customerId = entities.SearchCriteriaPrintingDocuments.CustomerId;
                    var split = customerId.split('-'); // [ 'codigo', 'nombre' ]
                    clientId = split[0]; // codigo

                    if (entities.SearchCriteriaPrintingDocuments.group) {
                        group = 'S';
                    }
                }
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite', entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic],
                            ['clientID', clientId],
                            ['isGroup', group]];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            } else {
                count = count + 1;
                var args = [
                    ['report.module', 'cartera'],
                    ['report.name', entities.DocumentProduct.data()[i].Template],
                    ['idTramite', entities.OriginalHeader.IDRequested],
                    ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]
                ];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            }
        }
    }
    //muestro mensaje si no existe un cliente para imprimir reporte basico y extendido 
    //if ((!executeBasicReport && !executeExtendMedical) && isReportSecurity) {
    //    executeCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate("BUSIN.LBL_BUSIN_NOEXISTUG_89480"));
    //}
    if (count === 0) {
        executeCommandEventArgs.commons.execServer = false;
    }
};

/**
 *
 *method for execute report medical
 */
task.executeReportMedical = function (entities) {
    var medicalIsPrint = false;
    if (entities.PrintClientsTeam != undefined && entities.PrintClientsTeam.length > 0) {
        entities.PrintClientsTeam.forEach(function (clientMedical) {
            if (clientMedical.typeSecure != undefined && clientMedical.typeSecure == 'EXTENDIDO') {
                medicalIsPrint = true;
            }
        });
    }
    return medicalIsPrint;
};


/**
 *
 *method for execute report basic
 */
task.executeReportBasic = function (entities) {
    var basicIsPrint = false;
    if (entities.PrintClientsTeam != undefined && entities.PrintClientsTeam.length > 0) {
        entities.PrintClientsTeam.forEach(function (clientMedical) {
            if (clientMedical.typeSecure != undefined && clientMedical.typeSecure == 'BASICO') {
                basicIsPrint = true;
            }
        });
    }
    return basicIsPrint;
};