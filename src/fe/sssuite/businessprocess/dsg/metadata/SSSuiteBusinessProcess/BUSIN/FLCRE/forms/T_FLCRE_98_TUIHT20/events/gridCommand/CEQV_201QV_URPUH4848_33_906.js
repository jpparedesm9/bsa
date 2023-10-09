//gridCommand (Button) QueryView: Operaciones Candidatas
    //Evento GridCommand: Sirve para personalizar la acciÃ³n que realizan los botones de Grilla.
    task.gridCommand.CEQV_201QV_URPUH4848_33_906 = function (entities, gridExecuteCommandEventArgs) {
        // Abro modal		
        var nav = BUSIN.API.getNavigationUploadDocument(gridExecuteCommandEventArgs.commons.api);
		nav.customDialogParameters = {
			//rowData : primer registro que toma la data en excel, luego de la cabecera inicia desde 1  en adelante siendo 1 la primera fila de cabecera
			rowData : entities.generalData.rowData,
			entityData : entities.HeaderPunishment
			};
			
		nav.openCustomModalWindow("uploadFile");		
		       
        gridExecuteCommandEventArgs.commons.execServer = false;
    };