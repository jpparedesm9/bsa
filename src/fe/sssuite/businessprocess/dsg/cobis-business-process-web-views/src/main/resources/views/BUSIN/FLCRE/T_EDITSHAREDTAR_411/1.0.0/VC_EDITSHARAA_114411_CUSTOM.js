/*global designerEvents, console */
(function () {
    "use strict";

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

    var task = designerEvents.api.editentityinsharedwarranty;
    var porcentajeCorp = 0;
    var valueTmp = 0
    var fechaProceso = ""
//"TaskId": "T_EDITSHAREDTAR_411"

//Entity: SharedEntityWarranty
    //SharedEntityWarranty.sharedPercentage (TextInputBox) View: EditEntityInSharedWarranty
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_SHAREDPERCENEEA_182199 = function(  entities, changedEventArgs ) {     
    changedEventArgs.commons.execServer = false;
    var porcentaje = entities.SharedEntityWarranty.sharedPercentage;
    if ((porcentaje + porcentajeCorp) >= 100){
       changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62360', false);
    }else{
      var valorComercial = entities.SharedEntityWarranty.valueComercial;      
      var valor = entities.SharedEntityWarranty.value
      var valorContable = entities.SharedEntityWarranty.bookValue
      var porcentajeComp = entities.SharedEntityWarranty.corporation
      valor = ((valorComercial * porcentaje)/100);
      valorContable = valorComercial - valor - valueTmp;
      porcentajeComp = 100 - porcentajeCorp - porcentaje;    
      entities.SharedEntityWarranty.value = valor;
      entities.SharedEntityWarranty.bookValue = valorContable
      entities.SharedEntityWarranty.corporation = porcentajeComp   
    }
    
        
        
    };

//Entity: SharedEntityWarranty
    //SharedEntityWarranty.value (TextInputBox) View: EditEntityInSharedWarranty
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_VALUEZCYWAOSXSB_793199 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = false;
   var valorComercial = entities.SharedEntityWarranty.valueComercial;
    var porcentaje = entities.SharedEntityWarranty.sharedPercentage;
    var valor = entities.SharedEntityWarranty.value
    var valorContable = entities.SharedEntityWarranty.bookValue
    var porcentajeComp = entities.SharedEntityWarranty.corporation
    porcentaje = ((valor / valorComercial) * 100);
    if ((porcentaje + porcentajeCorp) >= 100){
       changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62360', false);
    }else{
      valorContable = valorComercial - valor - valueTmp;
      porcentajeComp = 100 - porcentajeCorp - porcentaje;    
      entities.SharedEntityWarranty.sharedPercentage = porcentaje;
      entities.SharedEntityWarranty.bookValue = valorContable
      entities.SharedEntityWarranty.corporation = porcentajeComp   
    }
    
        
    };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: EditEntityInSharedWarranty
    task.initData.VC_EDITSHARAA_114411 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        porcentajeCorp = 0;
        valueTmp = 0
        entities.SharedEntityWarranty.date = null;
        var api = initDataEventArgs.commons.api
        var valorComercial = initDataEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral.appraisalValue
        if ( valorComercial != null && valorComercial > 0){
            entities.SharedEntityWarranty.valueComercial = initDataEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral.appraisalValue
        }else{
           initDataEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62363', false);
           var response = {};
               api.vc.closeModal(response);
        }
        var rows = api.vc.parentVc.model.SharedEntityWarranty.data().length
        if (rows != null && rows > 0){
           for (var i = 0; i < rows; i++) {
              porcentajeCorp = porcentajeCorp + api.vc.parentVc.model.SharedEntityWarranty.data()[i].sharedPercentage;
              valueTmp = valueTmp + api.vc.parentVc.model.SharedEntityWarranty.data()[i].value;
           }
           if (porcentajeCorp >= 100){
              initDataEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62360', false);
               var response = {};
               api.vc.closeModal(response);                          
           }
        }
        
         angular.element(document).injector().get('container.containerInfoService').getProcessDate().then(function
         (processDate) {
           fechaProceso = processDate
         });
           
    };

    //task.initDataCallback.VC_EDITSHARAA_114411 = function(entities, initDataCallbackEventArgs) {
    //   var valorComercial = initDataCallbackEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral.appraisalValue
    //    if ( valorComercial != null && valorComercial > 0){
    //        entities.SharedEntityWarranty.valueComercial = initDataCallbackEventArgs.commons.api.vc.parentVc.model.WarrantyGeneral.appraisalValue
    //    }else{
    //       initDataCallbackEventArgs.commons.messageHandler.showTranslateMessagesError('Ingresar valor comercial', false);
    //       var response = {};
    //           api.vc.closeModal(response);
    //    }
    //}
//Entity: SharedEntityWarranty
    //SharedEntityWarranty.entity (ComboBox) View: EditEntityInSharedWarranty
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ABOWKFMPJZLZXXR_183199 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    var api = loadCatalogDataEventArgs.commons.api;
    api.vc.model.SharedEntityWarranty.valueComercial = api.parentVc.model.WarrantyGeneral.appraisalValue;
        //loadCatalogDataEventArgs.commons.serverParameters.SharedEntityWarranty = true;
    };

// (Button) 
    task.executeCommand.CM_TEDITSHA_1AA = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var api = executeCommandEventArgs.commons.api
       
       if (entities.SharedEntityWarranty.sharedPercentage >= 100){
         executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62360', false);
       }else{
          if (entities.SharedEntityWarranty.value > 0 && entities.SharedEntityWarranty.sharedPercentage > 0){
             var response = {entity: entities.SharedEntityWarranty.entity,
                    value: entities.SharedEntityWarranty.value,
                    bookValue: entities.SharedEntityWarranty.bookValue,
                    corporation: entities.SharedEntityWarranty.corporation,                    
                    date: entities.SharedEntityWarranty.date, 
                    sharedPercentage:entities.SharedEntityWarranty.sharedPercentage,
                    nameEntity : api.vc.catalogs.VA_ABOWKFMPJZLZXXR_183199.get(entities.SharedEntityWarranty.entity).value, 
                    compartida : 'S'
                    };
               api.vc.closeModal(response);    
          }else{
             executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62361', false);
          }                
       }
        
    };

// (Button) 
    task.executeCommand.CM_TEDITSHA__R_ = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = false;
        var api = executeCommandEventArgs.commons.api
        var response = { };
        api.vc.closeModal(response);  
    };
    
        //SharedEntityWarranty.date (DateField) View: EditEntityInSharedWarranty
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DATELLPDCWNLYFG_918199 = function(  entities, changedEventArgs ) {
    changedEventArgs.commons.execServer = false;    
    var fecha = entities.SharedEntityWarranty.date;
    if (fecha != null && fecha != ""){
         var fechaActual = BUSIN.CONVERT.NUMBER.Format((fecha.getMonth() + 1), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format(fecha.getDate(), "0", 2) + "/" + fecha.getFullYear();
          if(FLCRE.UTILS.validate_fechaMayorQue(fechaProceso,fechaActual)){
            changedEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.LBL_BUSIN_EJECUTIOO_62362', false);
            entities.SharedEntityWarranty.date = "";         
            FLCRE.UTILS.clearDateField("VA_DATELLPDCWNLYFG_918199");         
         }
      }
   
    };

    
    
}());