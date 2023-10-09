//Start signature to Callback event to VA_TEXTINPUTBOXTFB_124611
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(entities, gridRowCommandCallbackEventArgs) {
gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';

        var scannedDocumentsDetailList = entities.ScannedDocumentsDetail._data;
        if (screenMode != 'Q' && entities.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && entities.Context.roleEnabledDataModRequest == 'S') {
            entities.Context.addressState = 'N';
            entities.Context.mailState = 'N';
        }
	   }
};