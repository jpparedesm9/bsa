var removedFromApi=false;
var mustRefreshCity=false;
var mustRefreshParish=false;
var sendPostalCode=false;
var postalCodeChanged=false;

var dirResidencia= null;
var dirNegocio= null;
var pais= 0;
var optionMessage =  "Front"

//"TaskId": "T_ADDRESSTODDXS_302"
//recupera la descripción en función del código
    //recibe el código que busca y la data del catálogo de donde va a sacar la información
    task.findValueInCatalog=function(code,data){
        if(code==null){
            return null;
        }else{
            code=code.toString();
        }
		for(var i=0;i<data.length;i++){
			if(data[i].code == code){
				return data[i].value;
			}		
		}
		return null;
	};


    task.closeModalEvent.MapView = function (args) {
        //recupera la longitud y latitud que se pasan al cerrar el modal del mapa
        var result = args.result;
        if (angular.isObject(result)) {
            args.model.PhysicalAddress.latitude=result.latitude;
            args.model.PhysicalAddress.longitude=result.longitude;
		}
    };
    
    task.validateBusiness = function (entities, args) {
        //Valida si mostrar o no el combo de negocios
        
        if(entities.PhysicalAddress.addressType == dirNegocio){ //si es NEGOCIO
            args.commons.api.viewState.show('VA_SAMEADDRESSHMEO_362436');
			//args.commons.api.viewState.show('VA_BUSINESSCODEWRI_405436');
            //Blanquear opciones
            //entities.PhysicalAddress.sameAddressHome = false;
		} else if(entities.PhysicalAddress.addressType == dirResidencia){
            args.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
			//args.commons.api.viewState.hide('VA_BUSINESSCODEWRI_405436');
            
            /*if(entities.PhysicalAddress.sameAddressHome == true){
                args.commons.api.viewState.show('VA_BUSINESSCODEWRI_405436');
            } else {
                args.commons.api.viewState.hide('VA_BUSINESSCODEWRI_405436');
                entities.PhysicalAddress.businessCode = null;
            }*/
		}
    };