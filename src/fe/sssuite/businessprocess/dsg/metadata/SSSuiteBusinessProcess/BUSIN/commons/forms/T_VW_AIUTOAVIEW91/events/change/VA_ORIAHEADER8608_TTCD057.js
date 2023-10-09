//Entity: Alicuota
    //Alicuota.CtaCertificada (ComboBox) View: T_alicutoaView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8608_TTCD057 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		
		var viewState = changedEventArgs.commons.api.viewState;		
		if(entities.Alicuota.Alicuota == "N" && entities.Alicuota.CtaCertificada !== null){
			viewState.enableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
			viewState.disableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
		}
    };