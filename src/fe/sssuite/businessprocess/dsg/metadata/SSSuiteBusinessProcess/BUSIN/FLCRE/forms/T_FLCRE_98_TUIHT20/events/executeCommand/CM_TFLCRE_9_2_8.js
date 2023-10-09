// (Button) 
    task.executeCommand.CM_TFLCRE_9_2_8 = function(entities, executeCommandEventArgs) {
        //MGU Llamada al servicio para generar el reporte
        if(entities.HeaderPunishment.CourtDate != null){
        var reportName = 'CandidatasCastigo'
        var fechaCorte = BUSIN.CONVERT.NUMBER.Format(entities.HeaderPunishment.CourtDate.getMonth() + 1,"0",2)+"/"+ 
                         BUSIN.CONVERT.NUMBER.Format(entities.HeaderPunishment.CourtDate.getDate(),"0",2)+"/"+
                         BUSIN.CONVERT.NUMBER.Format(entities.HeaderPunishment.CourtDate.getFullYear());

        var args = [['report.module', 'credito'], ['report.name', reportName], ['type', 'PDF'],['fechaCorte',fechaCorte],['idProcess', '1']];//,['instProc',inst_proc]];
         if (reportName != '') {
                    BUSIN.REPORT.GenerarReporte(reportName, args);
          }
        }
        executeCommandEventArgs.commons.execServer = false;
    };