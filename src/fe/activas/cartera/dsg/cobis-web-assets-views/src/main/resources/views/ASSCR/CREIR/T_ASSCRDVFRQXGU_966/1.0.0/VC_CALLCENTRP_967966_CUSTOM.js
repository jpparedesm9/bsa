/* variables locales de T_ASSCRDVFRQXGU_966*/
var clienteId=0;
var filtro = {};
var customerName = "";
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

    
        var task = designerEvents.api.callcenterpopupquestions;
    

    //"TaskId": "T_ASSCRDVFRQXGU_966"
task.closeModalEvent.findCustomer = function (args) {
  var resp = args.commons.api.vc.dialogParameters;
  var customerCode = resp.CodeReceive;
  customerName = resp.name;
  // args.model.LoginCallCenter.idClient = customerCode + " - " + CustomerName;
  args.model.LoginCallCenter.idCliente = customerCode;


};



    //Entity: LoginCallCenter
//LoginCallCenter. (Button) View: CallCenterPopupQuestions
//Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
task.executeCommand.VA_VABUTTONMLAQDME_803912 = function (entities, executeCommandEventArgs) {

    if (entities.LoginCallCenter.idCliente == null || entities.LoginCallCenter.idCliente === '' || entities.LoginCallCenter.idCliente == undefined) {
        executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_ELCDIGOOO_78756', true)
        executeCommandEventArgs.commons.execServer = false;

    } else {
        executeCommandEventArgs.commons.execServer = true;
    }

    //executeCommandEventArgs.commons.serverParameters.LoginCallCenter = true;
};

//Start signature to Callback event to VA_VABUTTONMLAQDME_803912
task.executeCommandCallback.VA_VABUTTONMLAQDME_803912 = function (entities, executeCommandCallbackEventArgs) {

    clienteId = entities.LoginCallCenter.idCliente;

    if (executeCommandCallbackEventArgs.succes == false) {
        clienteId = 0;
        executeCommandCallbackEventArgs.commons.api.viewState.hide('VA_VABUTTONPDDCALJ_814912');

    }
    if (executeCommandCallbackEventArgs.succes == true) {
        executeCommandCallbackEventArgs.commons.api.viewState.enable('VA_VABUTTONPDDCALJ_814912');


    }

    if (clienteId != null) {
        filtro = {
            clientCode: clienteId
        };


        // Se envia el filtro dentro al refrescar el grid
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056', filtro);
        //executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056');

    }




};


// (Button) 
task.executeCommand.VA_VABUTTONPDDCALJ_814912 = function (entities, executeCommandEventArgs) {

    var ejecuta = 0;
    var i = 0;
    var PalabraValidar = 'NO TENGO';
    var day;
    var mounth;
    var year;
    var j = 0;

    for (i = 0; i < entities.CallCenterQuestion._data.length; i++) {
        if (entities.CallCenterQuestion._data[i].noTengo === 'S') {
            if (entities.CallCenterQuestion._data[i].answer == undefined) {
                entities.CallCenterQuestion._data[i].answer = '';
            }
            if (((entities.CallCenterQuestion._data[i].answer.toUpperCase().replace(' ', '')).localeCompare(PalabraValidar.toUpperCase().replace(' ', ''))) == 0) {
                entities.CallCenterQuestion._data[i].answer = '';
            }
        }
    }

    for (i = 0; i < entities.CallCenterQuestion._data.length; i++) {
        if (entities.CallCenterQuestion._data[i].answer === null || entities.CallCenterQuestion._data[i].answer === undefined) {
            executeCommandEventArgs.commons.messageHandler.showMessagesError('ASSCR.MSG_ASSCR_LARESPUAA_62535' + '', true);
            ejecuta = 1
        }
        if (ejecuta == 1) {
            break;
        }
    }

    for (i = 0; i < entities.CallCenterQuestion._data.length; i++) {
        if (entities.CallCenterQuestion._data[i].typeAnswer === 'F' && entities.CallCenterQuestion._data[i].answer != undefined) {
            var dateBirth
            var date = entities.CallCenterQuestion._data[i].answer;
            var separador = "/";
            var arregloDeSubCadenas = date.split(separador);
            day = arregloDeSubCadenas[0];
            mounth = arregloDeSubCadenas[1];
            year = arregloDeSubCadenas[2];

            dateBirth = mounth + "/" + day + "/" + year;
            entities.CallCenterQuestion._data[i].answer = dateBirth;

        }
    }



    if (ejecuta == 1) {
        executeCommandEventArgs.commons.execServer = false;
    }
    else {
        executeCommandEventArgs.commons.execServer = true;
    }

    //executeCommandEventArgs.commons.serverParameters. = true;
};

//Start signature to Callback event to VA_VABUTTONPDDCALJ_814912
task.executeCommandCallback.VA_VABUTTONPDDCALJ_814912 = function (entities, executeCommandCallbackEventArgs) {
    //here your code


    if (entities.QuestionValidation.corretValidation === 'S') {
        executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('ASSCR.MSG_ASSCR_RESPUESTT_28632', '', 3000, false);
        console.log('Se verifico con sin exito si es S');

        // Se envía la información a la página padre.
        var result = { codigoCliente: entities.LoginCallCenter.idCliente,
                       nameClient: customerName};
        executeCommandCallbackEventArgs.commons.api.vc.closeModal(result);
    }


    if (entities.QuestionValidation.msmValidation != '--') {
        var msnValidation = entities.QuestionValidation.msmValidation;
        executeCommandCallbackEventArgs.commons.messageHandler.showMessagesError(msnValidation + '', true);
        //executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess(msnValidation, '', 20000, false);
        executeCommandCallbackEventArgs.commons.api.grid.refresh('QV_7316_54056', filtro);

    }

};

//undefined Entity: 
task.executeQuery.Q_CALLCEII_7316 = function (executeQueryEventArgs) {

    executeQueryEventArgs.commons.execServer = true;
    //executeQueryEventArgs.commons.serverParameters. = true;

    /*filtro = {
        clientCode: clienteId
    };*/

};

task.gridInitColumnTemplate.QV_7316_54056 = function (idColumn) {
	if (idColumn === 'answer') {
		return "<div class='cb-indicator cb-flex cb-column'>" +
			"<div ng-show='{{dataItem.typeAnswer == \"F\"}}'>" + "<input name='answer#: idQuestion #' placeholder=\"dd/mm/aaaa\" kendo-ext-date-picker=\"\" ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"S\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" class=\"k-textbox text-uppercase\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"N\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" class=\"k-textbox text-uppercase\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"N\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" designer-restrict-input=\"numbers\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"S\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" designer-restrict-input=\"numbers\"></div>" +
			"</div>";
	}


};

task.gridInitEditColumnTemplate.QV_7316_54056 = function (idColumn) {
	if (idColumn === 'answer') {
		return "<div class='cb-indicator cb-flex cb-column'>" +
			"<div ng-show='{{dataItem.typeAnswer == \"F\"}}'>" + "<input name='answer#: idQuestion #' placeholder=\"dd/mm/aaaa\" kendo-ext-date-picker=\"\" ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"S\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" class=\"k-textbox text-uppercase\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"A\" && dataItem.noTengo == \"N\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" class=\"k-textbox text-uppercase\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"N\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" dsgrequired=\"\" data-dsgrequired-msg=\"La Respuesta a la Pregunta es Obligatoria\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" designer-restrict-input=\"numbers\">" + "</div>" +
			"<div ng-show='{{dataItem.typeAnswer == \"N\" && dataItem.noTengo == \"S\"}}'>" + "<input name='answer#: idQuestion #' ng-model='dataItem.answer' ng-disabled=\"!vc.viewState.QV_7316_54056.column.answer.enabled\" ng-readonly=\"designer.enums.hasFlag(designer.constants.mode.Query,vc.mode)\" ng-show=\"designer.enums.hasFlag(designer.constants.mode.All,vc.mode)\" id=\"VA_TEXTINPUTBOXJFI_818912\" data-validation-code=\"32\" type=\"text\" class=\"k-textbox\" ng-model-onblur=\"\" ng-class=\"vc.viewState.QV_7316_54056.column.answer.style\" designer-restrict-input=\"numbers\"></div>" +
			"</div>";
	}
};

//gridRowRendering QueryView: QV_7316_54056
//Se ejecuta en el evento dataBound de una grilla con los registros visibles, dataview.
task.gridRowRendering.QV_7316_54056 = function (entities, gridRowRenderingEventArgs) {
    gridRowRenderingEventArgs.commons.execServer = false;

    if (clienteId == 0) {
        entities.CallCenterQuestion._data = null;
    }
    else {
        if (entities.CallCenterQuestion._data.length > 0) {
            gridRowRenderingEventArgs.commons.api.viewState.show('VA_VABUTTONPDDCALJ_814912');
        }
    }

};

//Evento initData : Inicialización de datos del formulario, después de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: CallCenterPopupQuestions
task.initData.VC_CALLCENTRP_967966 = function (entities, initDataEventArgs) {
    initDataEventArgs.commons.execServer = false;

    initDataEventArgs.commons.api.viewState.hide('VA_VABUTTONPDDCALJ_814912');
    initDataEventArgs.commons.api.viewState.hide('VA_CORRETVALIDAIII_240912');
    initDataEventArgs.commons.api.viewState.hide('VA_MSMVALIDATIONNN_838912');
    initDataEventArgs.commons.api.viewState.format('VA_7904MAZZXVKTTBR_383912', '###.###');
    
    


};

//Entity: LoginCallCenter
//LoginCallCenter.idCliente (TextInputButton) View: CallCenterPopupQuestions

task.textInputButtonEvent.VA_7904MAZZXVKTTBR_383912 = function (textInputButtonEventArgs) {

    textInputButtonEventArgs.commons.execServer = false;

    var nav = textInputButtonEventArgs.commons.api.navigation;
    nav.label = cobis.translate('ASSCR.LBL_ASSCR_BSQUEDAIE_90412');
    nav.customAddress = {
        id: "findCustomer",
        url: "customer/templates/find-customers-tpl.html"
    };
    nav.modalProperties = {
        size: 'lg'
    };
    nav.scripts = [{
        module: cobis.modules.CUSTOMER,
        files: ["/customer/services/find-customers-srv.js"
            , "/customer/controllers/find-customers-ctrl.js"]
    }];
    nav.customDialogParameters = {};


};

//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: CallCenterPopupQuestions
task.render = function (entities, renderEventArgs) {
    renderEventArgs.commons.execServer = false;
    
   renderEventArgs.commons.api.viewState.readOnly('VA_7904MAZZXVKTTBR_383912', true);


};



}));