/* variables locales de T_ADDRESSTODDXS_302*/
(function (root, factory) {

    factory();

}(this, function () {
    "use strict";

    /*global designerEvents, console */

        //*********** COMENTARIOS DE AYUDA **************
        //  Para imprimir mensajes en consola
        //  console.log("executeCommand");

        //  Para enviar mensaje use
        //  eventArgs.commons.messageHandler.showMessagesInformation('Ejecutando comando personalizado');

        //  Para evitar que se continue con la validación a nivel de servidor
        //  eventArgs.commons.execServer = false;

        //**********************************************************
        //  Eventos de VISUAL ATTRIBUTES
        //**********************************************************

    
        var task = designerEvents.api.addresspopupform;
    

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

    //Entity: PhysicalAddress
//PhysicalAddress.postalCode (TextInputBox) View: AddressPopupForm
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_POSTALCODERCKFJ_389436 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = true;
    changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
    changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
    entities.PhysicalAddress.sameAddressHome = false;
    if (entities.PhysicalAddress.postalCode == '') {
        changedEventArgs.commons.execServer = false;
    }
    entities.PhysicalAddress.latitude = 0;
    entities.PhysicalAddress.longitude = 0;
};

//Start signature to Callback event to VA_POSTALCODERCKFJ_389436
task.changeCallback.VA_POSTALCODERCKFJ_389436 = function (entities, changeCallbackEventArgs) {
    //here your code
    if (changeCallbackEventArgs.success == false) {
        entities.PhysicalAddress.provinceCode = '';
        entities.PhysicalAddress.cityCode = '';
        entities.PhysicalAddress.parishCode = '';
        entities.PhysicalAddress.latitude = 0;
        entities.PhysicalAddress.longitude = 0;
       
    }
    else {
        mustRefreshCity=true;
        mustRefreshParish=true;
        postalCodeChanged=true;
        changeCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXPPK_701436');
        changeCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436');
        
    }
};

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

//Entity: PhysicalAddress
    //PhysicalAddress.addressType (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXHGW_672436 = function(  entities, changedEventArgs ) {

        changedEventArgs.commons.execServer = false;
        
        task.validateBusiness(entities, changedEventArgs);
        
    };

//Entity: PhysicalAddress
    //PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXPPK_701436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = true;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        if(entities.PhysicalAddress.postalCode=='' && entities.PhysicalAddress.parishCode!='' ){
            //obtener el código postal
            changedEventArgs.commons.execServer = true;
        }else{
            changedEventArgs.commons.execServer = false;        
        }
    };

//Start signature to Callback event to VA_TEXTINPUTBOXPPK_701436
task.changeCallback.VA_TEXTINPUTBOXPPK_701436 = function(entities, changeCallbackEventArgs) {
//here your code
    changeCallbackEventArgs.commons.api.errors.validateInput('VA_POSTALCODERCKFJ_389436');
};

//Entity: PhysicalAddress
    //PhysicalAddress.cityCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXQVZ_987436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        mustRefreshParish=true;
        if(entities.PhysicalAddress.cityCode!=''){
            changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXPPK_701436');
        }
        if(!postalCodeChanged){
            entities.PhysicalAddress.parishCode='';
                  entities.PhysicalAddress.postalCode='';

        }else{
            postalCodeChanged=false;
        }
    };

//Entity: PhysicalAddress
    //PhysicalAddress.provinceCode (ComboBox) View: AddressPopupForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TEXTINPUTBOXTCU_205436 = function(  entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.api.viewState.hide('VA_SAMEADDRESSHMEO_362436');
        changedEventArgs.commons.api.viewState.disable('VA_SAMEADDRESSHMEO_362436');
        entities.PhysicalAddress.sameAddressHome = false;
        mustRefreshCity=true;
        if(entities.PhysicalAddress.provinceCode!=''){
            changedEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436'); 
        }
        if(!postalCodeChanged){
            entities.PhysicalAddress.postalCode='';
            entities.PhysicalAddress.cityCode='';
        }
    };

//Entity: Phone
    //Phone.phoneNumber (TextInputBox) View: AddressPopupForm
    
    task.customValidate.VA_TEXTINPUTBOXBZY_832436 = function(  entities, customValidateEventArgs ) {
        
        customValidateEventArgs.commons.execServer = false;
        LATFO.UTILS.validarTelefono(customValidateEventArgs);
    };

//Entity: PhysicalAddress
    //PhysicalAddress.street (TextInputBox) View: AddressPopupForm
    
    task.customValidation.VA_TEXTINPUTBOXSOQ_562436 = function( customValidationEventArgs ) {
      var regularExp = /[A-Za-z0-9\s]+$/g;
      return regularExp.test(customValidationEventArgs.character);
    };

// (Button) 
    task.executeCommand.CM_TADDRESS_5TD = function(entities, executeCommandEventArgs) {

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }

    var scannedDocumentsDetailList = executeCommandEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = executeCommandEventArgs.commons.api.vc.parentVc.model.Context;

    if (parameters != null && parameters.modo != 'Q' && executeCommandEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES' && posDataModRequest != null && scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && entities.PhysicalAddress.addressType == 'RE') {
        context.addressState = 'S';
        executeCommandEventArgs.commons.execServer = true;
    } else {
        executeCommandEventArgs.commons.execServer = false;
    }
        
        var catalogs=executeCommandEventArgs.commons.api.vc.catalogs;
		entities.PhysicalAddress.countryDescription=task.findValueInCatalog(entities.PhysicalAddress.countryCode,
                            catalogs.VA_TEXTINPUTBOXOJR_474436.data());
        entities.PhysicalAddress.provinceDescription=task.findValueInCatalog(entities.PhysicalAddress.provinceCode,
                            catalogs.VA_TEXTINPUTBOXTCU_205436.data());
        entities.PhysicalAddress.cityDescription=task.findValueInCatalog(entities.PhysicalAddress.cityCode,
                            catalogs.VA_TEXTINPUTBOXQVZ_987436.data());
        entities.PhysicalAddress.parishDescription=task.findValueInCatalog(entities.PhysicalAddress.parishCode,
                            catalogs.VA_TEXTINPUTBOXPPK_701436.data());
        entities.PhysicalAddress.addressTypeDescription=task.findValueInCatalog(entities.PhysicalAddress.addressType,
                            catalogs.VA_TEXTINPUTBOXHGW_672436.data());
  
        if(entities.Phone._data.length==0){
            executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_SEDEBERIE_44979');
            return ;
        }
        
        if(entities.PhysicalAddress.addressId!=0){
           executeCommandEventArgs.commons.api.vc.closeModal({
          
            resultArgs: {
                index: executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandEventArgs.commons.api.vc.mode,
                data: entities.PhysicalAddress
            }
        });
        }else{
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('CSTMR.MSG_CSTMR_DEBECRERN_11199');
        }
    };

// (Button) 
    task.executeCommand.CM_TADDRESS_DDD = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var catalogs=executeCommandEventArgs.commons.api.vc.catalogs;
		entities.PhysicalAddress.countryDescription=task.findValueInCatalog(entities.PhysicalAddress.countryCode,
                            catalogs.VA_TEXTINPUTBOXOJR_474436.data());
        entities.PhysicalAddress.provinceDescription=task.findValueInCatalog(entities.PhysicalAddress.provinceCode,
                            catalogs.VA_TEXTINPUTBOXTCU_205436.data());
        entities.PhysicalAddress.cityDescription=task.findValueInCatalog(entities.PhysicalAddress.cityCode,
                            catalogs.VA_TEXTINPUTBOXQVZ_987436.data());
        entities.PhysicalAddress.parishDescription=task.findValueInCatalog(entities.PhysicalAddress.parishCode,
                            catalogs.VA_TEXTINPUTBOXPPK_701436.data());
        entities.PhysicalAddress.addressTypeDescription=task.findValueInCatalog(entities.PhysicalAddress.addressType,
                            catalogs.VA_TEXTINPUTBOXHGW_672436.data());
		 if(entities.PhysicalAddress.addressId!=0){   
           executeCommandEventArgs.commons.api.vc.closeModal({
          
            resultArgs: {
                index: executeCommandEventArgs.commons.api.navigation.getCustomDialogParameters().rowIndex,
                mode: executeCommandEventArgs.commons.api.vc.mode,
                data: entities.PhysicalAddress
            }});
        }
		else{
		executeCommandEventArgs.commons.api.vc.closeModal({});
		}
    };

//Entity: PhysicalAddress
//PhysicalAddress. (Button) View: AddressPopupForm
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONCRFQENP_394436 = function (entities, executeCommandEventArgs) {

    if (entities.PhysicalAddress.directionNumberInternal === null) {
        entities.PhysicalAddress.directionNumberInternal = -1;
    }
    if (entities.PhysicalAddress.latitude === null ){
        entities.PhysicalAddress.latitude =0;
        
    }
    if (entities.PhysicalAddress.longitude === null ){
        entities.PhysicalAddress.longitude =0;
        
    }
    if(angular.isDefined(entities.PhysicalAddress) && angular.isDefined(entities.PhysicalAddress.street) && entities.PhysicalAddress.street!==null){
        entities.PhysicalAddress.street = entities.PhysicalAddress.street.trim();
    }
    executeCommandEventArgs.commons.execServer = true;
    executeCommandEventArgs.commons.serverParameters.PhysicalAddress = true;

};

//Start signature to callBack event to VA_VABUTTONCRFQENP_394436
task.executeCommandCallback.VA_VABUTTONCRFQENP_394436 = function (entities, executeCommandCallbackEventArgs) {
    //here your code
    if (executeCommandCallbackEventArgs.success) {
        if (executeCommandCallbackEventArgs.commons.api.vc.mode === executeCommandCallbackEventArgs.commons.constants.mode.Insert) {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTRAE_42576', '', 2000, false);
            executeCommandCallbackEventArgs.commons.api.viewState.enable('G_ADDRESSJWN_806436');
        } else if (executeCommandCallbackEventArgs.commons.api.vc.mode === executeCommandCallbackEventArgs.commons.constants.mode.Update) {
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('CSTMR.MSG_CSTMR_REGISTREE_31818', '', 2000, false);
        }

        if (entities.PhysicalAddress.directionNumberInternal === -1) {
            entities.PhysicalAddress.directionNumberInternal = null;
        }

    } else {
        entities.PhysicalAddress.isMainAddress = false;
    }
};

//Abre un modal con una página personalizada para pintar un mapa de google
    task.executeCommand.VA_VAIMAGEBUTTONNN_491436 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        var nav = executeCommandEventArgs.commons.api.navigation;
        var catalogs=executeCommandEventArgs.commons.api.vc.catalogs;
        
        //TODO: activar este botón solo cuando se haya seleccionado los obligatorios
        entities.PhysicalAddress.countryDescription=task.findValueInCatalog(entities.PhysicalAddress.countryCode,
                            catalogs.VA_TEXTINPUTBOXOJR_474436.data());
        entities.PhysicalAddress.provinceDescription=task.findValueInCatalog(entities.PhysicalAddress.provinceCode,
                            catalogs.VA_TEXTINPUTBOXTCU_205436.data());
        entities.PhysicalAddress.cityDescription=task.findValueInCatalog(entities.PhysicalAddress.cityCode,
                            catalogs.VA_TEXTINPUTBOXQVZ_987436.data());
        entities.PhysicalAddress.parishDescription=task.findValueInCatalog(entities.PhysicalAddress.parishCode,
                            catalogs.VA_TEXTINPUTBOXPPK_701436.data());
        entities.PhysicalAddress.addressTypeDescription=task.findValueInCatalog(entities.PhysicalAddress.addressTypeDescription,
                            catalogs.VA_TEXTINPUTBOXHGW_672436.data());
        
        //TODO: internacionalizacion
        nav.label = 'UBICACI&OacuteN';
        nav.customAddress = {
            //ESTE ID ES IMPORTANTE PARA PODER ACCEDER AL OBJETO nav DESDE LA PAGINA PERSONALIZADA
            id: "MapView",
            url: "maps/map.html",
            controller: "MapsController"
        };
        //TODO: ubicacion del archivo
        nav.scripts = [{module:"MapModule",files:["maps/map.js"]}];
        nav.modalProperties = {
         height: 500,
         callFromGrid: false
        };
        nav.queryParameters = {
            mode: 2
        };
        //PASO DE PARAMETROS A LA PAGINA PERSONALIZADA
        nav.customDialogParameters = {
            searchData:{
                country: entities.PhysicalAddress.countryDescription!=null?entities.PhysicalAddress.countryDescription:"",
                province: entities.PhysicalAddress.provinceDescription!=null?entities.PhysicalAddress.provinceDescription:"",
                city: entities.PhysicalAddress.cityDescription!=null?entities.PhysicalAddress.cityDescription:"",
				neighborhood:entities.PhysicalAddress.neighborhood!=null?entities.PhysicalAddress.neighborhood:"",
                street:entities.PhysicalAddress.street!=null?entities.PhysicalAddress.street:"",
                reference:entities.PhysicalAddress.reference!=null?entities.PhysicalAddress.reference:"",
                latitude:entities.PhysicalAddress.latitude!=null?entities.PhysicalAddress.latitude:"",
				longitude:entities.PhysicalAddress.longitude!=null?entities.PhysicalAddress.longitude:""
            }
        };
		executeCommandEventArgs.commons.api.vc.closeDialog("MapView");
        executeCommandEventArgs.commons.api.navigation.openCustomModalWindow(executeCommandEventArgs.commons.controlId, null);  
    };

//PhoneQuery Entity: 
    task.executeQuery.Q_PHONERJD_9891 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters. = true;
    };

//Entity: Phone
//Phone. (Button) View: AddressPopupForm

task.gridRowCommand.VA_GRIDROWCOMMMAAD_321436 = function(  entities, gridRowCommandEventArgs ) {
    gridRowCommandEventArgs.commons.execServer = false;
    
    var args = gridRowCommandEventArgs;
    
    if(args.rowData.isChecked == 'S'){
        //grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
        args.commons.messageHandler.showMessagesInformation('CSTMR.MSG_CSTMR_ELNMEROEE_39880');
    } else {

        var nav = args.commons.api.navigation;
        nav.label = args.commons.api.viewState.translate('CSTMR.LBL_CSTMR_CDIGODEIC_62610');
        nav.address = {
            moduleId: 'CSTMR',
            subModuleId: 'CSTMR',
            taskId: 'T_CSTMRGAPGAKXO_726',
            taskVersion: '1.0.0',
            viewContainerId: 'VC_CODEVERICU_522726'
        };
        nav.queryParameters = {
            mode: 1
        };
        nav.modalProperties = {
            size: 'sm',
            callFromGrid: false
        };
        nav.customDialogParameters = {
            cstmrCode: entities.PhysicalAddress.personSecuential,
            phoneNumber: args.rowData.phoneNumber,
            valType: 'SMS',
            addressId: entities.PhysicalAddress.addressId
        };
        nav.openModalWindow(args.commons.controlId, args.rowData);
    }
};

//gridRowRendering QueryView: QV_9891_52790
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_9891_52790 = function (entities, gridRowRenderingEventArgs) {

    gridRowRenderingEventArgs.commons.execServer = false;
    var scannedDocumentsDetailList = gridRowRenderingEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = gridRowRenderingEventArgs.commons.api.vc.parentVc.model.Context;

    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }

    if (parameters != null && parameters.modo != 'Q' && gridRowRenderingEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {
        gridRowRenderingEventArgs.commons.api.grid.hideToolBarButton('QV_9891_52790', 'create');
        gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'delete');

        if (posDataModRequest != null && entities.PhysicalAddress.addressType == 'RE') {
            if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || context.roleEnabledDataModRequest != 'S' || context.addressState != 'N') {
                gridRowRenderingEventArgs.commons.api.grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'edit');

            } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && context.addressState == 'N') {
                gridRowRenderingEventArgs.commons.api.grid.showGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'edit');
            }
        }
    }
    
    var grid = gridRowRenderingEventArgs.commons.api.grid;
    if(entities.PhysicalAddress.paramVASMS == 'S'){
        grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
        grid.removeCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);

    } else {
        grid.addCellStyle('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436', 'disabled', false);
    }
    
    if(gridRowRenderingEventArgs.rowData.phoneType != 'C'){
        grid.hideGridRowCommand('QV_9891_52790', gridRowRenderingEventArgs.rowData, 'VA_GRIDROWCOMMMAAD_321436');
    }

};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: AddressPopupForm
task.initData.VC_ADDRESSITS_306302 = function (entities, initDataEventArgs){    
    
    initDataEventArgs.commons.execServer = false;
    initDataEventArgs.commons.api.viewState.hide('VA_TEXTINPUTBOXSGN_115436');

    //Recuperacion de parametros de residencia, negocio y pais
    pais = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag1;
    dirResidencia = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag2;
    dirNegocio = initDataEventArgs.commons.api.vc.parentVc.model.Context.flag3;
    entities.PhysicalAddress.addressMessage = optionMessage;
    task.validateBusiness(entities, initDataEventArgs);
    if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Insert){

        entities.PhysicalAddress.countryCode=pais;//MEXICO
        entities.PhysicalAddress.provinceCode=undefined;
        entities.PhysicalAddress.cityCode=undefined;
        entities.PhysicalAddress.parishCode=undefined;
        entities.PhysicalAddress.personSecuential=initDataEventArgs.commons.api.vc.parentVc.model.CustomerTmp.code;
    
    }else if(initDataEventArgs.commons.api.vc.mode===initDataEventArgs.commons.constants.mode.Update){
        initDataEventArgs.commons.execServer = true;     
        initDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        initDataEventArgs.commons.serverParameters.Phone = true;
        mustRefreshCity=true;
        mustRefreshParish=true;
    }

    if (entities.PhysicalAddress.directionNumberInternal === -1) {
        entities.PhysicalAddress.directionNumberInternal = null;
    }
    
 
};

//Entity: PhysicalAddress
    //PhysicalAddress.addressType (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXHGW_672436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    };

//Entity: PhysicalAddress
    //PhysicalAddress.countryCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXOJR_474436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
    };

//Entity: PhysicalAddress
    //PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXPPK_701436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        if(mustRefreshParish){
            loadCatalogDataEventArgs.commons.execServer = true;
            mustRefreshParish=false;
        }else{
            loadCatalogDataEventArgs.commons.execServer = false;
        }
    };

//Entity: PhysicalAddress
//PhysicalAddress.parishCode (ComboBox) View: AddressPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalogCallback.VA_TEXTINPUTBOXPPK_701436 = function (entities, loadCatalogCallbackEventArgs) {
    loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_POSTALCODERCKFJ_389436');
    loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXTCU_205436');
	loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXQVZ_987436');
	loadCatalogCallbackEventArgs.commons.api.errors.validateInput('VA_TEXTINPUTBOXPPK_701436');
};

//Entity: PhysicalAddress
    //PhysicalAddress.cityCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXQVZ_987436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
        if(mustRefreshCity){
                loadCatalogDataEventArgs.commons.execServer = true;
            mustRefreshCity=false;
        }else{
                loadCatalogDataEventArgs.commons.execServer = false;        
        }
    };

//Entity: PhysicalAddress
//PhysicalAddress.cityCode (ComboBox) View: AddressPopupForm
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalogCallback.VA_TEXTINPUTBOXQVZ_987436 = function (entities, loadCatalogCallbackEventArgs) {
    loadCatalogCallbackEventArgs.commons.execServer = false;
};

//Entity: PhysicalAddress
    //PhysicalAddress.provinceCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TEXTINPUTBOXTCU_205436 = function( loadCatalogDataEventArgs ) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.PhysicalAddress = true;
   
    };

//Entity: PhysicalAddress
    //PhysicalAddress.provinceCode (ComboBox) View: AddressPopupForm
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalogCallback.VA_TEXTINPUTBOXTCU_205436 = function( entities, loadCatalogCallbackEventArgs ) {
        loadCatalogCallbackEventArgs.commons.execServer = false;
        if(loadCatalogCallbackEventArgs.commons.api.vc.mode!=loadCatalogCallbackEventArgs.commons.constants.mode.Update){
            loadCatalogCallbackEventArgs.commons.api.viewState.refreshData('VA_TEXTINPUTBOXQVZ_987436');
        }
    };

//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: AddressPopupForm
    task.onCloseModalEvent = function (entities, onCloseModalEventArgs){
        onCloseModalEventArgs.commons.execServer = false;
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: AddressPopupForm
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    var locationParameters = location.search.substr(1);
    var params = locationParameters == null || locationParameters == undefined ? null : locationParameters.split('=');
    var parameters = {};
    if (params != null && params.length > 0) {
        parameters[params[0]] = params[1];
    }


    if (renderEventArgs.commons.api.vc.mode === renderEventArgs.commons.constants.mode.Update) {
        renderEventArgs.commons.api.viewState.enable('G_ADDRESSJWN_806436');
    } else {
        renderEventArgs.commons.api.viewState.disable('G_ADDRESSJWN_806436');
    }

    if (entities.PhysicalAddress.directionNumberInternal === -1) {
        entities.PhysicalAddress.directionNumberInternal = null;
    }

    if (parameters != null && parameters.modo != null && parameters.modo != undefined && parameters.modo == 'Q') {
        var controls = ['VC_ADDRESSITS_306302', 'G_ADDRESSJWN_806436'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);
    }

    var scannedDocumentsDetailList = renderEventArgs.commons.api.vc.parentVc.model.ScannedDocumentsDetail._data;
    var context = renderEventArgs.commons.api.vc.parentVc.model.Context;

    if (parameters != null && parameters.modo != 'Q' && renderEventArgs.commons.api.vc.parentVc.model.Person.statusCode == 'A' && posDataModRequest != null && entities.PhysicalAddress.addressType == 'RE' && cobis.containerScope.userInfo.roleName != 'MESA DE OPERACIONES') {

        if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'N' || context.roleEnabledDataModRequest != 'S' || context.addressState != 'N') {
            var controls = ['VC_ADDRESSITS_306302'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, true);
            var controls2 = ['VA_REFERENCEDKFTKI_970436', 'VA_VABUTTONCRFQENP_394436'];
            LATFO.UTILS.disableFields(renderEventArgs, controls2, false);

        } else if (scannedDocumentsDetailList[posDataModRequest].uploaded == 'S' && context.roleEnabledDataModRequest == 'S' && context.addressState == 'N') {
            var controls = ['VC_ADDRESSITS_306302'];
        LATFO.UTILS.disableFields(renderEventArgs, controls, false);
    }
    }

};

//gridRowDeleting QueryView: QV_9891_52790
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_9891_52790 = function (entities, gridRowDeletingEventArgs) {
            if(!removedFromApi){
                gridRowDeletingEventArgs.commons.execServer = true;
                gridRowDeletingEventArgs.commons.serverParameters.Phone = true;
                gridRowDeletingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
                gridRowDeletingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
            }else{
                gridRowDeletingEventArgs.commons.execServer = false;
                removedFromApi=false;
            }
        };

//Start signature to callBack event to QV_9891_52790
    task.gridRowDeletingCallback.QV_9891_52790 = function(entities, gridRowDeletingEventArgs) {
        //here your code
        
        if(!gridRowDeletingEventArgs.success){
        gridRowDeletingEventArgs.commons.api.grid.addRow('Phone',gridRowDeletingEventArgs.rowData);
    }
        
    };

//gridRowInserting QueryView: QV_9891_52790
//Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
task.gridRowInserting.QV_9891_52790 = function (entities, gridRowInsertingEventArgs) {
    var api = gridRowInsertingEventArgs.commons.api;
    
    if(gridRowInsertingEventArgs.rowData.phoneType == ''){
    
    }
    if (gridRowInsertingEventArgs.rowData.phoneType == ''){
        gridRowInsertingEventArgs.commons.execServer = false;
        gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
        removedFromApi=true;
        gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_INGRESAOO_57765'));
    }
    if (gridRowInsertingEventArgs.rowData.phoneNumber == ''){
        gridRowInsertingEventArgs.commons.execServer = false;
        gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
        removedFromApi=true;
        gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_INGRESAEL_32500'));
    }
    else{
        
        if(entities.PhysicalAddress.addressId==0){
            gridRowInsertingEventArgs.commons.execServer = false;
            gridRowInsertingEventArgs.commons.messageHandler.showMessagesError(api.viewState.translate('CSTMR.MSG_CSTMR_PARAPODRR_49279'));
            gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
            removedFromApi=true;
        }else{
            gridRowInsertingEventArgs.commons.execServer = true;
            gridRowInsertingEventArgs.commons.serverParameters.Phone = true;
            gridRowInsertingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
            gridRowInsertingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
        }
    }
};

//Start signature to callBack event to QV_9891_52790
    task.gridRowInsertingCallback.QV_9891_52790 = function(entities, gridRowInsertingEventArgs) {
        if(!gridRowInsertingEventArgs.success){
            gridRowInsertingEventArgs.commons.api.grid.removeRow("Phone",0);
            removedFromApi=true;
        }
    };

//gridRowUpdating QueryView: QV_9891_52790
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_9891_52790 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = true;
            gridRowUpdatingEventArgs.commons.serverParameters.Phone = true;
            gridRowUpdatingEventArgs.rowData.addressId=entities.PhysicalAddress.addressId;
            gridRowUpdatingEventArgs.rowData.personSecuential=entities.PhysicalAddress.personSecuential;
        };

//Start signature to callBack event to QV_9891_52790
    task.gridRowUpdatingCallback.QV_9891_52790 = function(entities, gridRowUpdatingEventArgs) {
        //here your code
    };



}));