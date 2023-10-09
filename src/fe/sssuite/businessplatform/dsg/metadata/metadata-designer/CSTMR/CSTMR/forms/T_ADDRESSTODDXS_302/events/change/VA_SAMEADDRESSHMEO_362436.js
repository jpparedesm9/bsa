//Entity: PhysicalAddress
    //PhysicalAddress.sameAddressHome (CheckBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SAMEADDRESSHMEO_362436 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
		var encontrado = false;
		if(entities.PhysicalAddress.sameAddressHome == true){
			if(entities.PhysicalAddress.addressType == dirNegocio){ //AE si es NEGOCIO
				
				var arreglo = changedEventArgs.commons.api.vc.parentVc.model.PhysicalAddress;
				var idActual = entities.PhysicalAddress.addressId;
				
				for(var i = 0; i <= arreglo.data().length - 1; i++){
					
					if( arreglo.data()[i].addressType == dirResidencia){ //RE si es residencia
						
						entities.PhysicalAddress = angular.copy(arreglo.data()[i]);
						entities.PhysicalAddress.addressType = dirNegocio;
						entities.PhysicalAddress.sameAddressHome = true;
						entities.PhysicalAddress.isMainAddress = false;
						entities.PhysicalAddress.isShippingAddress = false;
						
						if(changedEventArgs.commons.api.vc.mode===changedEventArgs.commons.constants.mode.Insert){
							entities.PhysicalAddress.addressId = 0;
						}else if(changedEventArgs.commons.api.vc.mode===changedEventArgs.commons.constants.mode.Update){
							entities.PhysicalAddress.addressId = idActual;
						}
						if(entities.PhysicalAddress.provinceCode!=''){
							mustRefreshCity=true;
							changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436'); 
						}
						if(entities.PhysicalAddress.cityCode!=''){
							mustRefreshParish=true;
							changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXPPK_701436');
						}
						encontrado = true;
						break;
					} else {
						encontrado = false;
					}
				}
				if(encontrado == false){
					changedEventArgs.commons.messageHandler.showMessagesInformation("Debe ingresar una direcci\u00f3nn de tipo Domicilio primero");
				}
				
			}
		}
    };