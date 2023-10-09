//Entity: Alicuota
    //Alicuota.Alicuota (RadioButtonList) View: T_alicutoaView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8608_ALTA466 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        //changedEventArgs.commons.api.vc.serverParameters.Alicuota = true;
		
		var ctrs1=[],ctrs=[];	
		var viewState = changedEventArgs.commons.api.viewState;		
		ctrs = ['VA_ORIAHEADER8608_TAOR020','VA_ORIAHEADER8608_TCTC534','VA_ORIAHEADER8608_TTCD057','VA_ORIAHEADER8608_CCAA829'];
		BUSIN.API.hide(viewState,ctrs);

		if(changedEventArgs.newValue !== undefined){
			entities.Alicuota.AlicuotaAhorro = null;
			entities.Alicuota.AlicuotaCertificada = null;
			entities.Alicuota.CtaCertificada = null;
			entities.Alicuota.CtaAhorros = null;
		}

		if(changedEventArgs.newValue==='S'){
			viewState.label("VA_ORIAHEADER8608_CCAA829",'BUSIN.DLB_BUSIN_AERTIICBL_89553'); // cambio de etiqueta 	
			ctrs1 = ['VA_ORIAHEADER8608_TAOR020','VA_ORIAHEADER8608_TCTC534','VA_ORIAHEADER8608_TTCD057','VA_ORIAHEADER8608_CCAA829'];
			BUSIN.API.show(viewState,ctrs1);
			viewState.enableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
			viewState.enableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
		}else if(changedEventArgs.newValue==='N'){
			viewState.label("VA_ORIAHEADER8608_CCAA829",'BUSIN.DLB_BUSIN_ALICUOTAI_84613'); // cambio de etiqueta
			ctrs1 = ['VA_ORIAHEADER8608_TAOR020','VA_ORIAHEADER8608_TTCD057','VA_ORIAHEADER8608_CCAA829'];
			BUSIN.API.show(viewState,ctrs1);
			viewState.disableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
		}else{		
			BUSIN.API.hide(viewState,ctrs);
		}				
    };