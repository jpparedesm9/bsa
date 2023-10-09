//Entity: GuaranteesBtn
    //GuaranteesBtn. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_UARNTEESEW9610_HBTN418 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
		var nav = FLCRE.API.getApiNavigation(executeCommandEventArgs,'T_FLCRE_24_GURNH31','VC_GURNH31_OMREA_904');
		nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
		nav.modalProperties = { size: 'lg' };
		nav.queryParameters = { mode: executeCommandEventArgs.commons.constants.mode.Update };
		nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};
		nav.openModalWindow(executeCommandEventArgs.commons.controlId);
        
    };

task.closeModalEvent.VC_GURNH31_OMREA_904 = function(eventArgs){
		FLCRE.UTILS.GUARANTEE.addFromSearch(eventArgs);
		if (eventArgs.result.parameterGuarantee != null && eventArgs.result.parameterGuarantee != undefined){
			//Set del campo HiddenInCompleted para poder continuar la tarea
			eventArgs.commons.api.parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
		}
    };    