<!-- Designer Generator v 5.0.0.1519_2 - release SPR 2015-19_2 30/10/2015 -->
/*global designerEvents, console */ (function() {
    "use strict";

    var task = designerEvents.api.infocredentitymanagement;
	task.returnParameter = null;

    //**********************************************************
    //  Eventos de GRID
    //**********************************************************
	task.gridRowSelecting.QV_IRENT5951_45 = function(entities, gridRowSelectingEventArgs) {// Seleccionar grid no vaya al servidor, solo se pinte en el cliente
		gridRowSelectingEventArgs.commons.execServer = false;
	}

    task.gridRowCommand.VA_IFOCREEYEW0295_CETY643 = function(entities, gridRowCommandEventArgs) { //[Boton Registrar] QueryView: InfocredEntityGrid
	    task.returnParameter = gridRowCommandEventArgs.rowData;
    };
    task.gridRowCommandCallback.VA_IFOCREEYEW0295_CETY643 = function(entities, gridRowCommandEventArgs) {
		if(gridRowCommandEventArgs.success){
		    var result = {parameter: task.returnParameter }
			gridRowCommandEventArgs.commons.api.vc.closeModal(result);
		}
	};

    //**********************************************************
    //  Eventos para View Container
    //**********************************************************
    task.initData.VC_FOTYI44_RTTYV_089 = function(entities, initDataEventArgs) {
        initDataEventArgs.commons.execServer = false;
		var customDialogParameters = initDataEventArgs.commons.api.navigation.getCustomDialogParameters();
		//DESERIALIZA EL XML DE RESPUESTA QUE ENVIO INFOCRED
		var parser = new DOMParser();
		var xmlDoc = parser.parseFromString(customDialogParameters.SimilarList,"text/xml");
		var titulares = xmlDoc.getElementsByTagName("titulares")[0].childNodes;
		//RECORRE TODOS LOS TITULARES(COINCIDENCIAS) PARA POBLAR EL GRID
		for (var i = 0; i < titulares.length; i++) {
			 var entInfH = new task.getInfocredEntity(customDialogParameters , titulares[i].getAttribute('tipoDocumentoIdentidad'), titulares[i].getAttribute('nombreCompleto'));
			 initDataEventArgs.commons.api.grid.addRow('InfocredEntity', entInfH, false);
		}
    };

    task.render = function(entities, renderEventArgs) {
    };

    //**********************************************************
    //  FUNCIONES DE UTILERIA
    //**********************************************************
	task.getInfocredEntity = function(customDialogParameters, documentType, fullName){ //CREA UN OBJETO DEL TIPO InfocredEntity
		this.DocumentType = documentType;
		this.FullName = fullName;
		this.Source = customDialogParameters.Source;
		this.Role = customDialogParameters.Role;
		this.RequestIdLoanId = customDialogParameters.RequestIdLoanId;
		this.CustomerId = customDialogParameters.CustomerId;
	};

}());