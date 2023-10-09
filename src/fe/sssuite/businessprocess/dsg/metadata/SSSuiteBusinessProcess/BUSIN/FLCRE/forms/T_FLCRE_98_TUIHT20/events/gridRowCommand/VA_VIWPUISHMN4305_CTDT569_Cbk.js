//Entity: Punishment
    //Punishment. (ImageButton) View: [object Object]
    
    task.gridRowCommandCallback.VA_VIWPUISHMN4305_CTDT569 = function( entities, gridRowCommandEventArgs ) {        
         if(gridRowCommandEventArgs.success){
			gridRowCommandEventArgs.commons.api.grid.hideGridRowCommand('QV_URPUH4848_33', gridRowCommandEventArgs.rowData, 'VA_VIWPUISHMN4305_CTDT569');
			//Se abre la pantalla del inbox
			var menu = cobis.translate('COMMONS.MENU.MNU_REQUEST_PUNISHMENT');
			BUSIN.INBOX.STATUS.openNewTab(entities.HeaderPunishment.ApplicationNumber,menu);
		}
    };