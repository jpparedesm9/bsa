//"TaskId": "T_CSTMRAUGMCYDF_966"
task.gridRowCommandCallback.VA_TEXTINPUTBOXTFB_124611 = function(  entities, gridRowCommandCallbackEventArgs ) {
       gridRowCommandCallbackEventArgs.commons.execServer = false;
	   if(gridRowCommandCallbackEventArgs.success){
	       gridRowCommandCallbackEventArgs.commons.api.grid.hideColumn('QV_7463_28553', 'file');
		   gridRowCommandCallbackEventArgs.rowData.uploaded = 'S';
	   }
    };
