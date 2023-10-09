// (Button) 
task.executeCommand.CM_ITCII49ITT66 = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = true;
    var executeExtendMedical=task.executeReportMedical(entities);
    var executeBasicReport = executeExtendMedical == true ? false : true;
    var isReportSecurity=false;
    var count = 0;
        for (var i = 0; i <= entities.DocumentProduct.data().length - 1; i++) {
            if(entities.DocumentProduct.data()[i].YesNot === true){
                
                if(entities.DocumentProduct.data()[i].Nemonic=='CERCON' || entities.DocumentProduct.data()[i].Nemonic=='CERCONIND'){
                isReportSecurity=true;
                 if(executeBasicReport){
                     count = count + 1;
                    //imprimo siempre reprote basico
                    var report=entities.DocumentProduct.data()[i].Template.split("-")[0];
                    var args = 
                        [['report.module', 'cartera'],
                         ['report.name', report],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];	                
                    BUSIN.REPORT.GenerarReporte(report,args);	
                }
                if(executeExtendMedical){//imprimo reporte extendido 
                    count = count + 1;
                    var reports=entities.DocumentProduct.data()[i].Template.split("-");
                    var args = 
                        [['report.module', 'cartera'],
                         ['report.name', reports[0]],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];		                    
                    BUSIN.REPORT.GenerarReporte(reports[0],args);	
                    
                    args = 
                        [['report.module', 'cartera'],
                         ['report.name', reports[1]],
                         ['idTramite',entities.OriginalHeader.IDRequested],
                         ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];	
                    BUSIN.REPORT.GenerarReporte(reports[1],args);	
                }
               
            } else if (entities.DocumentProduct.data()[i].Nemonic == 'SOPREREFI' || entities.DocumentProduct.data()[i].Nemonic == 'SOLPREGRU') {
                count = count + 1;
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite', entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic],
                            ['clientID', entities.DebtorGeneral.org_1.CustomerCode],
                            ['isGroup', 'S']];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template, args);
            } else {
                count = count + 1;
                var args = [['report.module', 'cartera'],
                            ['report.name', entities.DocumentProduct.data()[i].Template],
                            ['idTramite', entities.OriginalHeader.IDRequested],
                            ['nemonicoReporte', entities.DocumentProduct.data()[i].Nemonic]];
                BUSIN.REPORT.GenerarReporte(entities.DocumentProduct.data()[i].Template,args);
            }


        }

    }
    //muestro mensaje si no existe un cliente para imprimir reporte basico y extendido 
    //if((!executeBasicReport && !executeExtendMedical) && isReportSecurity){
    //    executeCommandEventArgs.commons.messageHandler.showMessagesInformation(cobis.translate("BUSIN.LBL_BUSIN_NOEXISTUG_89480"));
    //    executeCommandEventArgs.commons.execServer = false;
    //}    

    if (count === 0) {
        executeCommandEventArgs.commons.execServer = false;
    }
    
};
/**
*
*method for execute report medical
*/
task.executeReportMedical=function(entities){
    var medicalIsPrint=false;
    if(entities.PrintClientsTeam!=undefined && entities.PrintClientsTeam.length>0){
        entities.PrintClientsTeam.forEach(function(clientMedical){
            if(clientMedical.typeSecure!=undefined && clientMedical.typeSecure=='EXTENDIDO'){
                medicalIsPrint=true;
            }
        });
    }
    return medicalIsPrint;
};

/**
*
*method for execute report basic
*/
task.executeReportBasic=function(entities){
    var basicIsPrint=false;
    if(entities.PrintClientsTeam!=undefined && entities.PrintClientsTeam.length>0){
        entities.PrintClientsTeam.forEach(function(clientMedical){
            if(clientMedical.typeSecure!=undefined && clientMedical.typeSecure=='BASICO'){
                basicIsPrint=true;
            }
        });
    }
    return basicIsPrint;
};