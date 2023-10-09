/* variables locales de T_ASSCRRXGVRPHC_165*/
var clienteId=0;
var filtro = {};
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

    
        var task = designerEvents.api.callcenterquestions;
    

    //"TaskId": "T_ASSCRRXGVRPHC_165"


task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    var customerCode = resp.CodeReceive;
    var CustomerName = resp.name;
   // args.model.LoginCallCenter.idClient = customerCode + " - " + CustomerName;
     args.model.LoginCallCenter.idCliente= customerCode;
    
    
};


    //Entity: LoginCallCenter
    //LoginCallCenter. (Button) View: CallCenterQuestions
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONEAKDTLW_523769 = function(  entities, executeCommandEventArgs ) {
        if(entities.LoginCallCenter.idCliente==null || entities.LoginCallCenter.idCliente==='' ||        entities.LoginCallCenter.idCliente==undefined)
            {
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELCDIGOTO_45403', true)
                executeCommandEventArgs.commons.execServer = false;
                
            }
        else{
            executeCommandEventArgs.commons.execServer = true;
            }
        
    
        //executeCommandEventArgs.commons.serverParameters.LoginCallCenter = true;
    };

//Start signature to Callback event to VA_VABUTTONEAKDTLW_523769
task.executeCommandCallback.VA_VABUTTONEAKDTLW_523769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    console.log('Ingresa VA_VABUTTONEAKDTLW_523769');
    clienteId=entities.LoginCallCenter.idCliente;
    if(executeCommandCallbackEventArgs.success==false)
        {
            clienteId=0;
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_9614ZTSONZLMVRK_410769');
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONTOSIJNF_422769');
        }
    if(executeCommandCallbackEventArgs.success==true)
        {
			entities.Amount.amountApproved='';
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
            executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_9614ZTSONZLMVRK_410769');
			executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONTOSIJNF_422769');
        }
     filtro = {
            clientCode: clienteId
        };
    executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692', filtro);
    
};

// (Button) 
    task.executeCommand.VA_VABUTTONTOSIJNF_422769 = function(  entities, executeCommandEventArgs ) {
        
        var ejecuta = 0;
        var i=0;
        var PalabraValidar='NO TENGO';
        var day;
        var mounth;
        var year;
        var j=0;
        
        if(entities.Amount.amountApproved===null || entities.Amount.amountApproved===undefined)
            {
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELMONTOTR_31505', true);
                ejecuta=1
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
				if(entities.CallCenterQuestion._data[i].noTengo==='S')
				{
                    if(entities.CallCenterQuestion._data[i].answer==undefined)
                        {
                          entities.CallCenterQuestion._data[i].answer='';  
                        }
                if(((entities.CallCenterQuestion._data[i].answer.toUpperCase().replace(' ','')).localeCompare(PalabraValidar.toUpperCase().replace(' ','') ))==0)
                    {
                       entities.CallCenterQuestion._data[i].answer='';
                    }
				}
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
                if(entities.CallCenterQuestion._data[i].answer===null ||entities.CallCenterQuestion._data[i].answer===undefined)
                    {
                      executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_LARESPUAA_62535'+'', true); 
                        ejecuta=1
                    }
                if(ejecuta==1)
                    {
                      break;  
                    }
            }
        
        for( i=0; i<entities.CallCenterQuestion._data.length;i++)
            {
                if(entities.CallCenterQuestion._data[i].typeAnswer==='F' &&    entities.CallCenterQuestion._data[i].answer!=undefined )
                    {
                        var dateBirth
                        var date = entities.CallCenterQuestion._data[i].answer;
                        var separador = "/";
                        var arregloDeSubCadenas = date.split(separador);
                        day    =arregloDeSubCadenas[0];
                        mounth =arregloDeSubCadenas[1];
                        year   =arregloDeSubCadenas[2];
                        
                        dateBirth=mounth+"/"+day+"/"+year;
                        entities.CallCenterQuestion._data[i].answer=dateBirth;

                    }
            }        
        
        

        
        if(ejecuta==1)
            {
               executeCommandEventArgs.commons.execServer = false; 
            }
        else
            {
                   executeCommandEventArgs.commons.execServer = true;
            }

 
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };

//Start signature to Callback event to VA_VABUTTONTOSIJNF_422769
task.executeCommandCallback.VA_VABUTTONTOSIJNF_422769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    
    console.log('Ingresa a callback boton VA_VABUTTONTOSIJNF_422769')
    if(entities.QuestionValidation.corretValidation==='S')
        {
            executeCommandCallbackEventArgs.commons.api.viewState.show('VA_VABUTTONUWUXNHE_853769');
            executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESPUESTT_28632', '', 3000, false);
        }
    else
        {
            executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
        }
    
     if(entities.QuestionValidation.msmValidation!='--')
        {
            var msnValidation=entities.QuestionValidation.msmValidation;
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnValidation+'', true);
            //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnValidation, '', 20000, false);
            executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692');
        }
    
};

// (Button) 
    task.executeCommand.VA_VABUTTONUWUXNHE_853769 = function(  entities, executeCommandEventArgs ) {
        entities.Amount.operation=entities.LoginCallCenter.opration
        
        if(entities.Amount.amountApproved==undefined ||entities.Amount.amountApproved==null || entities.Amount.amountApproved==='')
            {
                executeCommandEventArgs.commons.execServer = false;
                executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELMONTOTR_31505', true)
            }
        else{
            executeCommandEventArgs.commons.execServer = true;
        }
    
    
        //executeCommandEventArgs.commons.serverParameters. = true;
    };

//Start signature to Callback event to VA_VABUTTONUWUXNHE_853769
task.executeCommandCallback.VA_VABUTTONUWUXNHE_853769 = function(entities, executeCommandCallbackEventArgs) {
//here your code
if(entities.Amount.msmDesembolsar!='--')
        {
            var msnDesm=entities.Amount.msmDesembolsar;
            executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnDesm+'', true);
            //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnDesm, '', 20000, false);
        }
    else
        {
         executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_LATRANSLO_93204', '', 6000, false);   
        }
    
if(executeCommandCallbackEventArgs.success==true)
    {
       clienteId=0;
       entities.LoginCallCenter.idCodRegister='';
       entities.Amount.amountApproved='';
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONTOSIJNF_422769');
       executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_9614ZTSONZLMVRK_410769');
       executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_82692');
            	
    }
        
    

};

//CallCenterQuestionQuery_7316 Entity: 
    task.executeQuery.Q_CALLCEII_7316 = function(executeQueryEventArgs){
        console.log('Ingresa');
         executeQueryEventArgs.commons.execServer = true;
        //executeQueryEventArgs.commons.serverParameters. = true;
        
       /* var filtro = {
            clientCode: clienteId
        };
        executeQueryEventArgs.commons.api.vc.parentVc = {};
        executeQueryEventArgs.commons.api.vc.parentVc.customDialogParameters = filtro;*/
    };

task.gridInitColumnTemplate.QV_7316_82692 = function (idColumn) {
    		    	if(idColumn === 'answer'){
		return  "<div class='cb-indicator cb-flex cb-column'>"+
                        "<div ng-show='{{dataItem.typeAnswer == \"F\"}}'>"+"<input name='answer#: idQuestion #' placeholder=\"dd/mm/aaaa\" kendo-ext-date-picker=\"\" ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\">"+"</div>"+  						
                        "<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\"></div>"+
						"</div>";
				}

    };

task.gridInitEditColumnTemplate.QV_7316_82692 = function (idColumn) {
    		    	if(idColumn === 'answer'){
		return  "<div class='cb-indicator cb-flex cb-column'>"+
                        "<div ng-show='{{dataItem.typeAnswer == \"F\"}}'>"+"<input name='answer#: idQuestion #' placeholder=\"dd/mm/aaaa\" kendo-ext-date-picker=\"\" ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\">"+"</div>"+  						
                        "<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" class=\"k-textbox text-uppercase\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"N\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\">"+"</div>"+
						"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"S\"}}'>"+"<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_82692.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXNKM_555769\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_82692.column.answer.style\" designer-restrict-input=\"numbers\"></div>"+
						"</div>";
				}

    };

//gridRowRendering QueryView: QV_7316_82692
        //Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
        task.gridRowRendering.QV_7316_82692 = function (entities,gridRowRenderingEventArgs) {
            gridRowRenderingEventArgs.commons.execServer = false;
            if(clienteId==0)
			 {
				entities.CallCenterQuestion._data=null;
			 }
            else
             {
                   if (entities.CallCenterQuestion._data.length>0)
                       {
                           gridRowRenderingEventArgs.commons.api.viewState.show('VA_9614ZTSONZLMVRK_410769');
                           gridRowRenderingEventArgs.commons.api.viewState.show('VA_VABUTTONTOSIJNF_422769');
                       } 
             }
            
        };

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
    //ViewContainer: CallCenterQuestions
    task.initData.VC_CALLCENTRS_338165 = function (entities, initDataEventArgs){
        initDataEventArgs.commons.execServer = false;
        
        initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONUWUXNHE_853769');
        initDataEventArgs.commons.api.viewState.hide('VA_1OCJFHZIFBDTGEC_461769');
        initDataEventArgs.commons.api.viewState.hide('VA_5925IGVYVNMPHPD_149769');
        initDataEventArgs.commons.api.viewState.hide('VA_9614ZTSONZLMVRK_410769');
        initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONTOSIJNF_422769');
        initDataEventArgs.commons.api.viewState.hide('VA_1QSHTYXNJBZHEWZ_632769');
        initDataEventArgs.commons.api.viewState.format('VA_1194BQLISALGYQY_683769', '###.###');
        

    };

//Entity: LoginCallCenter
    //LoginCallCenter.idCliente (TextInputButton) View: CallCenterQuestions
    
    task.textInputButtonEvent.VA_1194BQLISALGYQY_683769 = function( textInputButtonEventArgs ) {

    textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_BSQUEDAIE_90412');
    nav.customAddress = {
        id: "findCustomer"
        , url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER
        , files: ["/customer/services/find-customers-srv.js"
             , "/customer/controllers/find-customers-ctrl.js"]
      }];
    nav.customDialogParameters = {};   
        
    };

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
    //ViewContainer: CallCenterQuestions
    task.render = function (entities, renderEventArgs){
        renderEventArgs.commons.execServer = false;
        renderEventArgs.commons.api.viewState.readOnly('VA_1194BQLISALGYQY_683769', true);
        
    };

//gridRowUpdating QueryView: QV_7316_82692
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_7316_82692 = function (entities,gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            
        };



}));