//gridCommand (Button) QueryView: QV_3718_27394
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_3718_27394_509 = function (entities, gridExecuteCommandEventArgs) {
        		var reporte='advisorReportHist'
	        var args = [['report', 'cartera'],
                        ['title', 'ListaAsesoresExternos']					
					];				
                CLCOL.REPORT.GenerarReporte(reporte,args,'Reporte Asesores Externos');

    gridExecuteCommandEventArgs.commons.execServer = false;
    gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_3718_27394', 'CEQV_201QV_3718_27394_509');
        //gridExecuteCommandEventArgs.commons.serverParameters.CollectiveAdvisor = true;
    };