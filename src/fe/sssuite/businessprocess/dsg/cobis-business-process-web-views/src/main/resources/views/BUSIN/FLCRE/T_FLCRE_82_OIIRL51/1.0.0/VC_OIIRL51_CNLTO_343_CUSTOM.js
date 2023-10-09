
/* variables locales de T_FLCRE_82_OIIRL51*/

/* variables locales de T_VW_WTTTEPRCES08*/

/* variables locales de T_VW_ORIAHEADER86*/

/* variables locales de T_VW_AIUTOAVIEW91*/

/* variables locales de T_VW_BORRWRVIEW27*/

/* variables locales de T_BUSINCJOWVKJI_224*/

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

    
        var task = designerEvents.api.genericapplication;
    

      //"TaskId": "T_FLCRE_82_OIIRL51"
  var task = designerEvents.api.genericapplication;

  //"TaskId": "T_FLCRE_82_OIIRL51"

  var listCustomer = [];
  var taskHeader = {};
  var renderSection = 'N';
  var modeView = '';
  var modeRequest = '';
  var passInitData = false;
  var modeType = null;
  var channel = 4; // tabla cl_canal caso203112
  //SMO se agrega de grupales
  var typeRequest = ''; // Tipo de solicitud Grupal, Interciclos, Normal
  //var treeSelected = false; SMO no existe en grupales  

  //var DebtorGeneral = function (idClient, name, role, idType, idNumber, clientType) { SMO en grupales no existe clientType
  var DebtorGeneral = function(idClient, name, role, idType, idNumber) {
      this.CustomerCode = idClient;
      this.CustomerName = name;
      this.Role = role;
      this.TypeDocumentId = idType;
      this.Identification = idNumber;
      //this.customerType = clientType; SMO no existe en grupales
  };

  // **********************************************************
  // Funciones Adicionales
  // **********************************************************

  task.closeModalEvent.findCustomer = function(args) {
      var resp = args.commons.api.vc.dialogParameters;
      if (args.result.params.isAval === 'S') {
          args.model.Aval.idCustomer = resp.CodeReceive;
          args.model.Aval.customerName = resp.CodeReceive + "-" + resp.name;
          args.model.Aval.bcBlacklists = "";
          args.commons.api.vc.executeCommand('VA_VABUTTONFUIXKXW_718576', 'FindCustomer', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
      } else {
          var row = args.model.DebtorGeneral.data()[0];
          row.set('CustomerCode', args.commons.api.vc.dialogParameters.CodeReceive);
          if (args.commons.api.vc.dialogParameters.commercialName !== '') {
              row.set('CustomerName', args.commons.api.vc.dialogParameters.commercialName);
          } else {
              row.set('CustomerName', args.commons.api.vc.dialogParameters.name);
          }

          row.set('Role', 'C');
          row.set('Identification', args.commons.api.vc.dialogParameters.documentId);
          row.set('Qualification', args.commons.api.vc.dialogParameters.califCartera);
          row.set('TypeDocumentId', "03");
          if (args.commons.api.vc.dialogParameters.documentId != null) {
              if (args.commons.api.vc.dialogParameters.documentId.length == 10) {
                  row.set('TypeDocumentId', "01");
              } else if (args.commons.api.vc.dialogParameters.documentId.length == 13) {
                  row.set('TypeDocumentId', "02");
              }
          }
      }
      // row.set('customerType', args.commons.api.vc.dialogParameters.customerType); SMO no existe en grupales
  };

  // RESULTADO DE BUSQUEDA DE OPERACIONES
  task.closeModalEvent.VC_OSRCH32_AOEAR_233 = function(args) {

      //SMO validar, en grupales está descomentado ---inicio comentario
      var debtors = angular.copy(args.commons.api.vc.model.DebtorGeneral.data());
      var band = false;
      // Recupero el resultado
      var result = args.result;

      // AÃ±ado los registros a la grilla de deudores
      for (var i = 0; i < result.debtors.length; i++) {
          for (var j = 0; j < debtors.length; j++) {
              if (debtors[j].CustomerCode == result.debtors[i].CustomerCode) {
                  band = true;
                  break;
              } else {
                  band = false;
              }
          }
          if (!band) {
              args.commons.api.grid.addRow('DebtorGeneral', result.debtors[i], false);
          }
      }

      args.commons.api.grid.addAllRows('RefinancingOperations', result.operations, false);

      ///---SMO fin comentario
      // var criteria = { field: "IsBase", operator:"eq" ,value: true} ;
      // var selectedRow =
      // args.commons.api.grid.selectRow("QV_ITRIC1523_63",criteria);
  };

  task.loadTaskHeader = function(entities, eventArgs) {

      var client = eventArgs.commons.api.parentVc.model.Task;
      var originalh = entities.OriginalHeader;

      // Titulo de la cabecera (title)
      if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientId + " - " + client.clientName);
      } else {
          LATFO.INBOX.addTaskHeader(taskHeader, 'title', client.clientId + " - " + client.clientName);
      }

      // Subtitulos de la cabecera       
      LATFO.INBOX.addTaskHeader(taskHeader, 'Tr\u00e1mite', (originalh.IDRequested == null || originalh.IDRequested == '0' ? '--' : originalh.IDRequested), 0);
      //LATFO.INBOX.addTaskHeader(taskHeader, 'Categor\u00eda', (entities.OriginalHeader.category == null ? ' ': entities.OriginalHeader.category), 0)//SMO se agrega en grupales
      if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Solicitado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountRequested == null || originalh.AmountRequested == 'null' ? 0 : originalh.AmountRequested), 2), 0);
          LATFO.INBOX.addTaskHeader(taskHeader, 'Monto Autorizado', BUSIN.CONVERT.CURRENCY.Format((originalh.AmountAprobed == null || originalh.AmountAprobed == 'null' ? 0 : originalh.AmountAprobed), 2), 0); //ACHP
          //SMO cambia en grupales  LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.symbolCurrency, 0);
          LATFO.INBOX.addTaskHeader(taskHeader, 'Moneda', entities.generalData.mnemonicCurrency, 0);
      }
      if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.termInd == null ? '--' : entities.OriginalHeader.termInd), 0);
      } else if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.Term == null ? '--' : entities.OriginalHeader.Term), 0);
      }
      if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);
      }

      LATFO.INBOX.addTaskHeader(taskHeader, 'Oficina', (entities.Context.officeName == null ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).value : entities.Context.officeName), 1);
      //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Oficial', ((entities.OfficerAnalysis.OfficierName != null) ? entities.OfficerAnalysis.OfficierName.OfficerName : cobis.userContext.getValue(cobis.constant.USER_FULLNAME)), 1);
      //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Fecha Inicio', BUSIN.CONVERT.NUMBER.Format(originalh.InitialDate.getDate(), "0", 2) + "/" + BUSIN.CONVERT.NUMBER.Format((originalh.InitialDate.getMonth() + 1), "0", 2) + "/" + originalh.InitialDate.getFullYear(), 1);
      //SMO no existe en grupales LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo Cartera', entities.generalData.loanType, 1);
      //LATFO.INBOX.addTaskHeader(taskHeader, 'Subtipo', (entities.OriginalHeader.Type == null ? ' ' : entities.OriginalHeader.Type) + " " + (entities.OriginalHeader.subType == null ? ' ' : entities.OriginalHeader.subType), 1);//SMO se agrega en grupales
      //LATFO.INBOX.addTaskHeader(taskHeader, 'Vinculado', entities.generalData.vinculado, 1);
      LATFO.INBOX.addTaskHeader(taskHeader, 'Sector', entities.generalData.sectorNeg, 1);
      if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', (entities.Context.Flag1 == null ? '--' : entities.Context.Flag1), 1);
      } else if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
          LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (entities.Context.Flag1 == null ? '--' : entities.Context.Flag1), 1);
      }
      // Actualizo el grupo de designer
      LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'GR_WTTTEPRCES08_02');
      entities.NewAliquot.ejecutivo = cobis.userContext.getValue(cobis.constant.USER_FULLNAME);
  };

  task.showButtons = function(args) {
      var api = args.commons.api;
      var parentParameters = args.commons.api.parentVc.customDialogParameters;
      // Boton Principal (Wizard)
      // initDataEventArgs.commons.api.vc.parentVc.executeSaveTask =
      // function(){
      // initDataEventArgs.commons.api.vc.executeCommand('CM_OIIRL51SVE80','Save',
      // undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
      // }

      // Boton Secundario 1 (Wizard)
      // (Para aumentar un boton adicional copiar y pegar el bloque de codigo
      // debajo de estos comentarios)
      // (Posteriormente cambiar el numero de terminacion de la etiqueta Ej.
      // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand1 =>
      // initDataEventArgs.commons.api.vc.parentVc.labelExecuteCommand2 )
      // (Posteriormente cambiar el numero de terminacion del metodo Ej.
      // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
      // function() =>
      // initDataEventArgs.commons.api.vc.parentVc.executeCommand2 =
      // function())
      // (Tiene una limitacion de 5 axecute commands)

      if ((parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") || (parentParameters.Task.urlParams.TIPO === "C")) {
          args.commons.api.vc.parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
      } else {
          if (parentParameters.Task.urlParams.SOLICITUD === 'LCR') {
              args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
              args.commons.api.vc.parentVc.executeCommand1 = function() {
                  args.commons.api.vc.executeCommand('CM_TFLCRE_8_IO1', 'Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
              }
          } else if (parentParameters.Task.urlParams.SOLICITUD === 'NORMAL' && parentParameters.Task.urlParams.MODE === 'AP') {
              args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar Seguro";
              args.commons.api.vc.parentVc.executeCommand1 = function() {
                  args.commons.api.vc.executeCommand('CM_TFLCRE_8_925', 'Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
              }

          } else {
              args.commons.api.vc.parentVc.labelExecuteCommand1 = "Guardar";
              args.commons.api.vc.parentVc.executeCommand1 = function() {
                  args.commons.api.vc.executeCommand('CM_OIIRL51SVE80', 'Save', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
              }
          }

          /*
           args.commons.api.vc.parentVc.labelExecuteCommand2 = "Imprimir";
           args.commons.api.vc.parentVc.executeCommand2 = function () {
               args.commons.api.vc.executeCommand('CM_OIIRL51INT80', 'Print', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
           }
           
           args.commons.api.vc.parentVc.labelExecuteCommand3 = "Sincronizar M\u00f3vil";
           args.commons.api.vc.parentVc.executeCommand3 = function () {
               args.commons.api.vc.executeCommand('CM_TFLCRE_8_TCR', 'Sincronizar', undefined, true, false, 'VC_OIIRL51_CNLTO_343', false);
          }*/ //MTA
      }
  };

  // **********************************************************
  // validaciones personalizados de visual attributes
  // **********************************************************
  //Abrir arbol de actividades economicas
  task.openFindProgram = function(argsI) {
      var nav = argsI.commons.api.navigation;
      nav.label = cobis.translate("BUSIN.DLB_BUSIN_OOMICPRPE_26369");
      nav.customAddress = {
          id: 'process',
          url: 'businessprocess/busin-tree-economicActivity-page.html',
          useMinification: false
      };
      nav.scripts = {
          module: 'businessprocess',
          files: ["/businessprocess/services/busin-tree-economicActivity-srv.js",
              "/businessprocess/controllers/busin-tree-economicActivity-ctrl.js",
              "/businessprocess/busin-tree-economicActivity.js"
          ]
      };
      nav.modalProperties = {
          size: 'lg'
      };

      //nav.openCustomModalWindow(""); SMO no está en grupales
  };

  //Se cierra arbol de actividades economicas
  task.closeModalEvent.process = function(args) {
      if (args.result != "") {
          args.model.EntidadInfo.destinoEconomico = args.result.itemCode;
          args.model.EntidadInfo.destEconomicoDescription = args.result.itemName; //SMO se agrega de grupales
          /*SMO no existe en grupales
args.model.EntidadInfo.destEconomicoBusqueda = args.result.itemName + " " + "(" + args.result.itemCode + ")";
           treeSelected = true;
           args.config = {};
           args.config.filterType = "contains";
           args.config.maxRecords = 20;
           var fil = [];
           fil.push({
               value: args.model.EntidadInfo.destinoEconomico
           });
           args.filters = {
               filters: fil
           };
           args.commons.api.vc.loadCatalog("VA_ORIAHEADER8605_MIUS039", false, args.filters, args.config, 0);*/
      }
  };

  task.validateEntities = function(entities) {
      var band = false;
      var originalh = entities.OriginalHeader;
      var officerAnalisis = entities.OfficerAnalysis;
      //var destinoEconomico = "" == entities.EntidadInfo.destinoEconomico ? null : entities.EntidadInfo.destinoEconomico;//no existe en grupales
      // if (originalh.AmountRequested !== null && originalh.PaymentFrequency !== null && originalh.Term !== null && officerAnalisis.City !== null && officerAnalisis.Province !== null && destinoEconomico !== null) { SMO cambia en grupales
      if (originalh.AmountRequested !== null
          // &&originalh.Quota!==null
          &&
          originalh.PaymentFrequency !== null && originalh.Term !== null) {
          band = true;
      }
      return band;
  };

  /* task.validateAliquotEntities = function (entities) {
       var band = false;

       var alicuotaCertificada = (entities.Alicuota.AlicuotaCertificada == null) ? undefined : entities.Alicuota.AlicuotaCertificada;
       var alicuotaAhorros = (entities.Alicuota.AlicuotaAhorro == null) ? undefined : entities.Alicuota.AlicuotaAhorro;
       var cuentaCertificada = (entities.Alicuota.CtaCertificada === null) ? undefined : entities.Alicuota.CtaCertificada;
       var cuentaAhorros = (entities.Alicuota.CtaAhorros === null) ? undefined : entities.Alicuota.CtaAhorros;

       if (entities.Alicuota.Alicuota == "N-A") {
           band = true;
       } else if (entities.Alicuota.Alicuota == "S") {
           if (alicuotaCertificada !== undefined && alicuotaAhorros !== undefined && cuentaCertificada !== undefined && cuentaAhorros !== undefined) {
               band = true;
           }
       } else if (entities.Alicuota.Alicuota == "N") {
           if (alicuotaCertificada !== undefined && (cuentaCertificada !== undefined || cuentaAhorros !== undefined)) {
               band = true;
           }
       }
       return band;
   };*/ //SMO no existe en grupales

  /*task.renderConfigurationFieldByProduct = function (entities, args) {
       //Llamada a la configuraciÃ³n adicional por producto bancario
       var viewState = args.commons.api.viewState;
       var api = args.commons.api;
       var nav = args.commons.api.navigation;
       var viewState = args.commons.api.viewState;
       var parentParameters = args.commons.api.parentVc.customDialogParameters;
       var mode = '';
       // GR_AIUTOAVIEW91_04 - Es el grupo donde se va a mostrar los datos renderizados
       var ctrsToShow = ['GR_AIUTOAVIEW91_04'];
       BUSIN.API.show(viewState, ctrsToShow);
       //Si es modo consulta solo se debe mostrar los campos sin permitir ingresar o modificar datos
       if (parentParameters.Task.urlParams.MODE != undefined && parentParameters.Task.urlParams.MODE != null && parentParameters.Task.urlParams.MODE == "Q") {
           modeView = parentParameters.Task.urlParams.MODE;
       }
       //se necesita por problemas con el scope
       api.vc.removeChildVc('FINPMITEMRENDER');
       nav.label = "RENDER";
       nav.customAddress = {
           id: 'FINPMITEMRENDER',
           url: 'fpm/templates/render-items-values.html', //no head
           useMinification: false
       };
       nav.scripts = [{
           module: cobis.modules.FPM,
           files: ['fpm/fpm-tree-process.js', 'fpm/services/fpm-tree-process-srv.js', 'fpm/controllers/fpm-tree-process-ctrl.js', '/fpm/services/render-items-values-srv.js', '/fpm/controllers/render-items-values-ctrl.js']
			}];
       nav.customDialogParameters = api.vc.customDialogParameters;
       nav.customDialogParameters.Type = "SECCION_RENDERIZADA";
       nav.customDialogParameters.BankignProductId = entities.OriginalHeader.ProductType;
       nav.customDialogParameters.Request = entities.OriginalHeader.IDRequested
       nav.customDialogParameters.BankingProductName = entities.generalData.productTypeName;
       nav.customDialogParameters.ModeView = modeView;
       nav.registerCustomView('GR_AIUTOAVIEW91_04');
   }*/ //SMO no existe en grupales

  task.validateproduct = function(entities, args) {
      var band = true;
      var originalh = entities.OriginalHeader;
      var dataProduct = entities.generalData;
      if (parseInt(originalh.Term) > parseInt(originalh.termLimit)) {
          args.commons.messageHandler.showMessagesError('El Plazo permitido por el producto es de hasta ' + originalh.termLimit);
          band = false;
      }
      return band;
  };
  task.validateRenderSection = function(entities, args) {
      var dicCompanyProductType = {};
      if (entities.dicCompanyProductType) {
          dicCompanyProductType = entities.dicCompanyProductType;
      }
      entities.Values = [];
      var errors = [];
      var validation = true;
      /*Check validation field by field*/
      angular.forEach(dicCompanyProductType.dictFunctionalityGroups, function(dicFuncGroup) {
          angular.forEach(dicFuncGroup.dictionaryFields, function(field) {
              if (validation) {
                  if (!angular.element("#RFIELD" + field.id).data("kendoValidator").validate() && validation) {
                      validation = false;
                      errors.push(angular.element("#RFIELD" + field.id).data("kendoValidator").errors()[0]);
                  }
                  if (field.fieldvalues != null && field.fieldvalues.length == 1 && field.fieldvalues[0].valueSourceId == 'P') {
                      if (angular.isDefined(field.value)) {
                          var content = field.value.split("-");
                          if (content.length > 1) {
                              entities.FieldByProductValues = {
                                  requestId: entities.OriginalHeader.IDRequested,
                                  productId: entities.OriginalHeader.ProductType,
                                  fieldId: field.id,
                                  value: field.value
                              };
                          }
                      }
                  } else {
                      entities.FieldByProductValues = {
                          requestId: entities.OriginalHeader.IDRequested,
                          productId: entities.OriginalHeader.ProductType,
                          fieldId: field.id,
                          value: field.value
                      };
                  }
                  entities.Values.push(entities.FieldByProductValues);
              }
          });
      });

      if (validation) {
          return true;
      } else {
          args.commons.messageHandler.showMessagesError(errors[0]);
          return false;
      }
  };

  /*  function round(value, decimals) {
        return Number(Math.round(value + 'e' + decimals) + 'e-' + decimals);
    };*/ //SMO no existe round en grupales

  /*task.validateDebtor = function (entities, args) {
		//Valida si se modificÃ³ el deudor principal y obtiene el campo vinculado
		if (args.rowData.Role == 'D' && args.commons.api.parentVc.model.Task.clientId != args.rowData.CustomerCode){
			for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
				if (entities.DebtorGeneral.data()[i].Role == 'D') {				
					entities.DebtorGeneral.data()[i].Role = 'C';
				}
			}			
			args.commons.execServer = true;
			args.commons.serverParameters.generalData = true;
		 }
	};*/ //SMO no existe en grupales

  /*	task.setDebtor = function(entities, args){
  	    //Actualiza los datos del deudor principal en la cabecera
  		if (args.rowData.Role == 'D' && args.commons.api.parentVc.model.Task.clientId != args.rowData.CustomerCode){
  			args.commons.api.parentVc.model.Task.clientId = args.rowData.CustomerCode;
  			args.commons.api.parentVc.model.Task.clientName = args.rowData.CustomerName;
  			args.commons.api.parentVc.model.Task.clientType = args.rowData.customerType;
  			//Se recarga los datos del deudor en la cabecera
  			task.loadTaskHeader(entities, args);
  		}
        
  	};*/ //SMO no existe en gruples

  /*	task.hideButtonGridDebtors = function(args){
          var ds = args.commons.api.vc.model['DebtorGeneral'];
          var dsData = ds.data();
          for (var i = 0; i < dsData.length; i ++) {
              var dsRow = dsData[i];
              args.commons.api.grid.hideGridRowCommand('QV_BOREG0798_55', dsRow, 'edit');
          }
      };*/ //SMO no existe en grupales


  //cambios subir porque no vale generar
  task.textInputButtonEvent.VA_TEXTINPUTBOXGRN_916576 = function(textInputButtonEventArgs) {
      textInputButtonEventArgs.commons.execServer = false;
      var nav = textInputButtonEventArgs.commons.api.navigation;
      nav.label = 'B\u00FAsqueda de Clientes';
      nav.customAddress = {
          id: "findCustomer",
          url: "customer/templates/find-customers-tpl.html"
      };
      nav.modalProperties = {
          size: 'lg'
      };
      nav.scripts = [{
          module: cobis.modules.CUSTOMER,
          files: ["/customer/services/find-customers-srv.js",
              //"/customer/services/find-program-srv.js",
              "/customer/controllers/find-customers-ctrl.js"
          ]
      }];

      nav.customDialogParameters = {
          isAval: 'S'
      };
  };

    	// Imprimir (Button)
	task.executeCommand.CM_OIIRL51INT80 = function(entities, executeCommandEventArgs){
		executeCommandEventArgs.commons.execServer = false;//SMO validar estaba true en el servidor
		var debtor = FLCRE.UTILS.CUSTOMER.getDebtor(entities.DebtorGeneral.data());
		if(debtor!=null){
		   if(entities.OriginalHeader.IDRequested!=null){
					var args = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstDebtor',debtor.CustomerCode],['cstName',debtor.CustomerName],['cstId',debtor.Identification],['cstTrId',entities.OriginalHeader.IDRequested],['cstAplId',entities.OriginalHeader.ApplicationNumber]];
					var debtors = entities.DebtorGeneral.data();
					var count = 0;
					for (var i = 0; i < debtors.length; i++) {
						if(debtors[i].Role == 'C'){
							count = count + 1;
							args.push(['cstCodeu'+count, debtors[i].CustomerCode]);
						}
					}
					BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.LoanApplication,args);
				} else {
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532');
		   }
		}else {
			executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_SAOUCENTD_07389');
		}
                    
         
        
	};

	// Save (Button)
   task.executeCommand.CM_OIIRL51SVE80 = function(entities, executeCommandEventArgs) {
       if(entities.OriginalHeader.ProductType === "INDIVIDUAL"){
           if((entities.Aval.idCustomer === undefined) || (entities.Aval.idCustomer === null)){
               executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ELAVALEOB_47675');
               executeCommandEventArgs.commons.execServer = false;
               return;
           }
   	   }
       if(entities.OriginalHeader.CurrencyRequested === undefined){ // ACHP
	       executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('Ingrese la Moneda Solicitada', '', 3000, true);//No olvidar cambiar a etiqueta
		   executeCommandEventArgs.commons.execServer = false;
	   } else if(entities.ApplicationInfoAux.percentageGuarantee > 100 || entities.ApplicationInfoAux.percentageGuarantee < 0 ){ // ACHP
	       executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_VRPOSEY10_55418'); //Valor del Porcentaje debe ser entre 0 y 100
		   executeCommandEventArgs.commons.execServer = false;
	   }else {
	       if(task.validateRenderSection(entities, executeCommandEventArgs)){
		    /*if(task.validateEntities(entities) && task.validateAliquotEntities(entities)) {
		    	executeCommandEventArgs.commons.execServer = true;
		    } else {
		    	executeCommandEventArgs.commons.execServer = false;		
		    	executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795','',3000,true);
		    }*/
                if (task.validateEntities(entities)) {
                    if (entities.Alicuota.Alicuota === "N" && entities.Alicuota.CtaAhorros !== undefined && entities.Alicuota.CtaCertificada !== undefined) {
                    executeCommandEventArgs.commons.execServer = true;
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_AUOBLNOON_98811', '', 3000, true);
                    } else {
                    executeCommandEventArgs.commons.execServer = true;
                    }
                } else {
                    executeCommandEventArgs.commons.execServer = false;
                    executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_MSNCAYDTA_60795', '', 3000, true);
                }
	       }else{
	           executeCommandEventArgs.commons.execServer = false;
		       executeCommandEventArgs.commons.messageHandler.showTranslateMessagesError('FINPM.DLB_FINPM_AILALIDIM_74169');
	       }
	   }
       if(modeType!= null){
           entities.Context.Type=modeType;
       }
   };

	//Start signature to callBack event to CM_OIIRL51SVE80
   task.executeCommandCallback.CM_OIIRL51SVE80 = function(entities, executeCommandCallbackEventArgs) {
		var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
       
        var parameter = executeCommandCallbackEventArgs.commons.api.parentVc.customDialogParameters;
	    parameter.Task.porcentaje = entities.ApplicationInfoAux.percentageGuarantee;
       
        if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
			var parentVc = parentApi.vc;
			parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
			executeCommandCallbackEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625');
			LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
			if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
				LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo Grupal', (entities.Context.Flag1 == null? '--' : entities.Context.Flag1), 1);
			}
	        if(typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL){
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.termInd == null ? '--' : entities.OriginalHeader.termInd), 0);
				LATFO.INBOX.addTaskHeader(taskHeader, 'Ciclo', (entities.Context.Flag1 == null ? '--' : entities.Context.Flag1), 1);
			}else{
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.Term == null ? '--' : entities.OriginalHeader.Term), 0);
	        }
			
			//Caso REQ#162288 Cambios Simple F1
            if(typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL){
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_PAYMENTFREQUECN_439R86',entities.OriginalHeader.PaymentFrequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);				
            } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYLTUZDL_595R86',entities.OriginalHeader.frequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);			
            } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_7694PEJSETHIYUL_239R86',entities.OriginalHeader.frequencyRevolving);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);			
            } else {
            	entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYCNYXFV_220R86',entities.OriginalHeader.frequency);
            	LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);
            }			
			LATFO.INBOX.updateTaskHeader(taskHeader, executeCommandCallbackEventArgs, 'GR_WTTTEPRCES08_02');
        }


		
       if(!executeCommandCallbackEventArgs.success)
		{
			
			if(typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL){
				LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
				LATFO.INBOX.addTaskHeader(taskHeader, 'Plazo', (entities.OriginalHeader.termInd == null ? '--' : entities.OriginalHeader.termInd), 0);
				entities.generalData.paymentFrecuencyName = executeCommandCallbackEventArgs.commons.api.viewState.selectedText('VA_FREQUENCYCNYXFV_220R86',entities.OriginalHeader.frequency);				
				LATFO.INBOX.addTaskHeader(taskHeader, 'Frecuencia', (entities.generalData.paymentFrecuencyName == null ? '--' : entities.generalData.paymentFrecuencyName), 0);
			}
			
		}
        executeCommandCallbackEventArgs.commons.execServer = false;
	};

	// (Button) 
    task.executeCommand.CM_TFLCRE_8_925 = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_TFLCRE_8_925
task.executeCommandCallback.CM_TFLCRE_8_925 = function(entities, executeCommandCallbackEventArgs) {
//here your code
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var parentVc = parentApi.vc;
    
    if(executeCommandCallbackEventArgs.success){
        parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
    }
};

	// (Button) 
task.executeCommand.CM_TFLCRE_8_IO1 = function(entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.execServer = false;
    let flag = true;

    if (entities.ApplicationInfoAux.nivelColectivo == undefined || entities.ApplicationInfoAux.nivelColectivo == null || "" == entities.ApplicationInfoAux.nivelColectivo.trim()){
        flag = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.LBL_BUSIN_ELCAMPOIU_45642');
    } 
    
    if(entities.ApplicationInfoAux.ingresosMensuales == undefined || entities.ApplicationInfoAux.ingresosMensuales == null || entities.ApplicationInfoAux.ingresosMensuales == 0) {
        flag = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.LBL_BUSIN_ELCAMPOIA_57961');
    } 
    
    if (flag){
         executeCommandEventArgs.commons.execServer = true;
    }
    
    
    
};

	//Start signature to Callback event to CM_TFLCRE_8_IO1
task.executeCommandCallback.CM_TFLCRE_8_IO1 = function(entities, executeCommandCallbackEventArgs) {
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var parentVc = parentApi.vc;
    if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
        LATFO.INBOX.addTaskHeader(taskHeader,'Tr\u00e1mite',(entities.OriginalHeader.IDRequested==null||entities.OriginalHeader.IDRequested=='0' ? '--':entities.OriginalHeader.IDRequested));		
        
        var ctrsShow = ['CM_TFLCRE_8__II'];
        BUSIN.API.show(viewState, ctrsShow);
        parentVc.model.InboxContainerPage.HiddenInCompleted = "EJE";
    }
};

	// (Button) 
task.executeCommand.CM_TFLCRE_8_TCR = function (entities, executeCommandEventArgs) {
    executeCommandEventArgs.commons.serverParameters.Context = true;
    executeCommandEventArgs.commons.serverParameters.OriginalHeader = true;
    if (entities.OriginalHeader.IDRequested > 0) { //si existe tramite envia a Sincronizar con el movil
        executeCommandEventArgs.commons.execServer = true;
    }
    else {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.messageHandler.showMessagesError("BUSIN.LBL_BUSIN_NOSEPUEDEEI_81326")
    }
};

	// (Button) 
task.executeCommandCallback.CM_TFLCRE_8_TCR = function (entities, executeCommandCallbackEventArgs) {
    executeCommandCallbackEventArgs.commons.execServer = false;
    //Se deshabilita la pantalla de ingresos si el móvil está usando
    var viewState = executeCommandCallbackEventArgs.commons.api.viewState;
    var hideIngreso = ['VC_OIIRL51_SNNMB_699'] //grid vertical    
    BUSIN.API.disable(viewState, hideIngreso);
};

	// (Button) 
    task.executeCommand.CM_TFLCRE_8__II = function(entities, executeCommandEventArgs) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.entityName = true;
    };

	//Start signature to Callback event to CM_TFLCRE_8__II
task.executeCommandCallback.CM_TFLCRE_8__II = function(entities, executeCommandCallbackEventArgs) {
    var parentApi = executeCommandCallbackEventArgs.commons.api.parentApi();
    var parentVc = parentApi.vc;
    if(parentApi != undefined && executeCommandCallbackEventArgs.success) {
        if(parentVc.model.InboxContainerPage.HiddenInCompleted === "EJE"){
            parentVc.model.InboxContainerPage.HiddenInCompleted = "YES";
        }
    } else {
        parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
    }
};

	//Evento initData : Inicializaci�n de datos del formulario, despu�s de este evento se realiza el seguimiento de cambios en los datos
//ViewContainer: GenericApplication
task.initData.VC_OIIRL51_CNLTO_343 = function (entities, initDataEventArgs) {
    passInitData = true;
    FLCRE.UTILS.APPLICATION.setContext(entities, initDataEventArgs, true, false);
    initDataEventArgs.commons.api.viewState.disable('VA_TEXTINPUTBOXLZA_843R86');

    //SMO se agrega de Grupales
    //Bloqueo de campos
    var viewState = initDataEventArgs.commons.api.viewState;
    // Tipo de solicitud
    var customDialogParameters = initDataEventArgs.commons.api.vc.parentVc.customDialogParameters;
    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD; // -- ACHP
    modeRequest = customDialogParameters.Task.urlParams.MODE; //PXSG
    if(customDialogParameters.Task.urlParams.Tipo!=undefined){
		modeType = customDialogParameters.Task.urlParams.Tipo;
	}
    var ctrs = ['VA_ORIAHEADER8602_TERM237',
              'VA_ORIAHEADER8602_NQUE773', //Se deshabilita plazo y frequencia
			  'VA_REFERENCIASNASR_958W91'] //Se deshabilita campo Referencia
    BUSIN.API.disable(viewState, ctrs);
    BUSIN.API.hide(viewState, ['VA_ORIAHEADER8605_ERTO640', 'CM_TFLCRE_8_TCR']); //Se oculta lÃ­nea de creditoinitda
    //SMO fin grupales

    // Estilos
    var viewState = initDataEventArgs.commons.api.viewState;
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'CustomerCode', 'code-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Role', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'TypeDocumentId', 'generic-column-style-busin');
    initDataEventArgs.commons.api.grid.addColumnStyle('QV_BOREG0798_55', 'Identification', 'generic-column-style-busin');

    //SMO se agrega de grupales
    //Se habilita validaciÃ³n para combo de ejecutivo
    viewState.disableValidation('VA_EJECUTIVOZUEHTQ_752W91', VisualValidationTypeEnum.Required);
    viewState.enableValidation('VA_EJECUTIVOZUEHTQ_752W91', VisualValidationTypeEnum.Required);



    // Entidades Temporal
    entities.generalData = {};
    entities.generalData.productTypeName = "";
    entities.generalData.paymentFrecuencyName = "";
    entities.generalData.vinculado = "";
    entities.generalData.labelOtroDestino = "";
    entities.generalData.segment = "";
    entities.generalData.type = "";

    entities.OriginalHeader2 = {};
    entities.OriginalHeader2.idOriginalHeader2 = null;

    // Recupero parametros de la ventana padre
    var parentParameters = initDataEventArgs.commons.api.parentVc.model;

    // Set de campos
    entities.OriginalHeader.UserL = cobis.userContext.getValue(cobis.constant.USER_NAME);
    entities.OriginalHeader.Office = cobis.userContext.getValue(cobis.constant.USER_OFFICE).code;
    entities.OriginalHeader.ApplicationNumber = parentParameters.Task.processInstanceIdentifier;
    entities.OriginalHeader.ProductType = parentParameters.Task.bussinessInformationStringTwo;
    entities.OriginalHeader.OpNumberBank = parentParameters.Task.bussinessInformationStringOne;
    entities.generalData.type = parentParameters.Task.urlParams.TRAMITE;
    entities.Context.CustomerId = parentParameters.Task.clientId;
    entities.Context.channel = channel; // caso203112
    // entities.OriginalHeader.OpNumberBank = "";
    //entities.OriginalHeader.AmountCalculated = 0;SMO no existe en grupales

    // Campos del Cliente
    entities.NewAliquot.referencia = "Operacion creada desde Workflow"; //SMO se agrega de grupales

    // Campos del Cliente
    var client = initDataEventArgs.commons.api.parentVc.model.Task;

    /*entities.generalData.clientId = ((client != null && client != undefined) ? client.clientId : 0);
    if (typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== ''){
    	var cust = new DebtorGeneral(client.clientId,client.clientName, 'D', '', '',client.clientType);
    	listCustomer.push(cust);
    	initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
    }*/
    //Diferente en grupales
    entities.generalData.clientId = ((client != null && client != undefined) ? client.clientId : 0);

    if (typeof client.clientId !== 'undefined' && client.clientId !== '0' && client.clientId !== '') { // -- ACHP
        var cust = '';
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
            cust = new DebtorGeneral(client.clientId, client.clientName, 'G', '', '');
        } else {
            cust = new DebtorGeneral(client.clientId, client.clientName, 'D', '', '');
        }
        listCustomer.push(cust);
        initDataEventArgs.commons.api.grid.addAllRows('DebtorGeneral', listCustomer, true);
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        entities.NewAliquot.grupal = 'S';
    }

    // Cambio de etiqueta
    if (typeRequest != FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        initDataEventArgs.commons.api.viewState.label("VA_COMBOBOXGTFCJFR_317R86", "BUSIN.LBL_BUSIN_ACEPTARVN_91496");
    }
    
  
    initDataEventArgs.commons.execServer = true;
};

	    //Start signature to callBack event to VC_OIIRL51_CNLTO_343
    task.initDataCallback.VC_OIIRL51_CNLTO_343 = function(entities, initDataEventArgs) {
        entities.EntidadInfo.oficina = entities.EntidadInfo.oficina == null || entities.EntidadInfo.oficina == '' || entities.EntidadInfo.oficina == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code + "" : entities.EntidadInfo.oficina;
        task.loadTaskHeader(entities, initDataEventArgs);
        /*var parentParameters = initDataEventArgs.commons.api.parentVc.model;*/
        var parentParameters = initDataEventArgs.commons.api.parentVc.customDialogParameters;
        var sectionrender = parentParameters.Task.urlParams.RENDER_SECTION;
        /* if (sectionrender == 'S') {
             task.renderConfigurationFieldByProduct(entities, initDataEventArgs);
         }
         if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration) {
             if (entities.generalData.productReest != undefined && entities.generalData.productReest != null && entities.generalData.productReest == entities.OriginalHeader.ProductType) {
                 initDataEventArgs.commons.api.vc.loadCatalog('VA_ORIAHEADER8602_URQT595', false, false, true, null);
             }
         }*/ //SMO no existe en grupales
        var viewState = initDataEventArgs.commons.api.viewState; //SMO se agrega de grupales
        task.change.VA_ORIAHEADER8608_ALTA466(entities, initDataEventArgs);
        entities.OriginalHeader.CurrencyRequested="0";
        /* // lanzar loadCatalog en destinoEconomico
         if (entities.EntidadInfo.destinoEconomico !== 'N00000000' && entities.EntidadInfo.destinoEconomico !== null) {
             initDataEventArgs.config = {};
             initDataEventArgs.config.filterType = "contains";
             initDataEventArgs.config.maxRecords = 20;
             var fil = [];
             fil.push({
                 value: entities.EntidadInfo.destinoEconomico
             });
             initDataEventArgs.filters = {
                 filters: fil
             };

             initDataEventArgs.commons.api.vc.loadCatalog("VA_ORIAHEADER8605_MIUS039", false, initDataEventArgs.filters, initDataEventArgs.config, 0);
         }*/ //SMO no existe en grupales
        //SMO se agrega de grupales
        //validaciÃ³n para mostrar el combo grupal en caso de que el prodcuto sea microcrÃ©dito
        /*if(entities.OriginalHeader.subTypeId != entities.generalData.subtypeProductId){
        	BUSIN.API.hide(viewState,['VA_GRUPALKFSXRLTTA_514W91']);
        }*/
        //Se cambia el sufijo de la moneda de acuerdo a la ingresada por el usuario
        viewState.suffix('VA_ORIAHEADER8602_OQUE134', entities.generalData.symbolCurrency);
        viewState.suffix('VA_ORIAHEADER8602_MICI826', entities.generalData.symbolCurrency);
        //Para que el campo tenga un valor
        if (entities.OriginalHeader.AmountRequested == null || entities.OriginalHeader.AmountRequested == 0 || entities.OriginalHeader.AmountRequested == 'undefined') {
            entities.OriginalHeader.AmountRequested = 0 //entities.OriginalHeader.AmountAprobed;
        }
        //Se oculta la pestaña de aval 
        var hideAux = ['VC_ZVXQIUJDIP_665L51']
        BUSIN.API.hide(viewState, hideAux);
        
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
            //Campos que se visualizan para tramite individual
            //'Plazo compuesto','plazo numero','plazo descripcion'
            var ctrsIndiHide = ['VA_ORIAHEADER8602_FICE546', 'VA_TERMLJXTQBYRQKU_619R86', 'VA_GRACESXJNMOZNOH_634R86',
                'VA_GRACESXJNMOZNOH_634R86', 'VA_TEXTINPUTBOXLZA_843R86', 'VA_7694PEJSETHIYUL_239R86',
                'VA_PAYMENTFREQUECN_439R86', 'CM_TFLCRE_8_TCR'];
            var ctrsIndiShow = ['VA_VACOMPOSITEMXIH_497R86', 'VA_TERMINDTMTELITU_695R86',       'VA_FREQUENCYLTUZDL_595R86',
                'VA_ISPARTNERZBPHXB_883R86', 'VC_ZVXQIUJDIP_665L51', 'VC_OIIRL51_TBRMT_122',
                'VA_PREVIOUSCREDUOT_690R86', 'VA_INSURANCEPACKEG_674R86','VA_TERMMEDICALAISS_991R86'];
            // se añade el control (VC_OIIRL51_TBRMT_122) porque se pierde el foco  y esto da como resultado que al iniciar la pagina se muestre primero la del aval
            var ctrsIndiDisable = ['VA_EJECUTIVOZUEHTQ_752W91', 'VA_ISPARTNERZBPHXB_883R86']
            BUSIN.API.hide(viewState, ctrsIndiHide);
            BUSIN.API.show(viewState, ctrsIndiShow);
			
			// Se agrega porque como resultado del caso 185234, se direccionaba a la pestaña de AVAL, ya que en el show cambia a la pestaña del aval
             initDataEventArgs.commons.api.vc.clickTab(initDataEventArgs, 'VC_OIIRL51_SNNMB_699', 'VC_OIIRL51_TBRMT_122', false);
            $("#VC_OIIRL51_TBRMT_122_tab").prop("class","active");
            $("#VC_ZVXQIUJDIP_665L51_tab").removeClass("active");
			
            BUSIN.API.disable(viewState, ctrsIndiDisable);
        } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
            var ctrsIndiDisable = ['VA_PAYMENTFREQUECN_439R86']
            var ctrsGrpHide =['VA_TERMINDTMTELITU_695R86','VA_FREQUENCYLTUZDL_595R86'];
            var ctrsGrpShow = ['VA_TERMLJXTQBYRQKU_619R86','VA_GRACESXJNMOZNOH_634R86','VA_PAYMENTFREQUECN_439R86'];
            BUSIN.API.hide(viewState, ctrsGrpHide);
            BUSIN.API.show(viewState, ctrsGrpShow);
            BUSIN.API.disable(viewState, ctrsIndiDisable);
        } else if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
            var ctrsRevHide =['VA_TERMINDTMTELITU_695R86','VA_FREQUENCYLTUZDL_595R86','VA_TERMLJXTQBYRQKU_619R86',
                              'VA_GRACESXJNMOZNOH_634R86', 'VA_PAYMENTFREQUECN_439R86'];
            var ctrsRevShow = ['VA_7694PEJSETHIYUL_239R86'];
            BUSIN.API.hide(viewState, ctrsRevHide);
            BUSIN.API.show(viewState, ctrsRevShow);
        }
        
        //SRO. Se comenta 147999
        //MTA Se deshabilita la pantalla de ingresos si el móvil está usando
        /*if (entities.Context.TaskSubject == 'INGRESAR SOLICITUD') { // VALIDACION SOLO PARA LA ETAPA DE INGRESO DE SOLICITUD
            var botonSincronizar = ['CM_TFLCRE_8_TCR']
            if (entities.Context.enable == "N") { //SE DESHABILITA LA PANTALLA PORQUE ESTAN UTILIZANDO EL MÓVIL
                var hideIngreso = ['VC_OIIRL51_SNNMB_699'] //grid vertical    
                BUSIN.API.disable(viewState, hideIngreso);
                BUSIN.API.hide(viewState, botonSincronizar);
            } else { //SE HABILITA LA PANTALLA
                BUSIN.API.enable(viewState, hideIngreso);
                BUSIN.API.hide(viewState, botonSincronizar); //PARA GRUPALES EL BOTON NO ESTA VISIBLE
                if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) { //SOLO PARA INDIVIDUALES EL BOTON SE MUESTRA
                    BUSIN.API.show(viewState, botonSincronizar);
                }
            }
        }*/ 
        
        var botonSincronizar = ['CM_TFLCRE_8_TCR']
        if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) { //SOLO PARA INDIVIDUALES EL BOTON SE MUESTRA
                    BUSIN.API.show(viewState, botonSincronizar);
        }
        if (entities.OriginalHeader.previousCreditAmount == null) {
            entities.OriginalHeader.previousCreditAmount = 0;
        }

        if (entities.ApplicationInfoAux.colectivo == undefined || entities.ApplicationInfoAux.colectivo == null || "" == entities.ApplicationInfoAux.colectivo.trim()) {
            var disableCollective = ['VA_NIVELCOLECTIOVO_641R86','VA_INGRESOSMENSUUE_680R86'];   
            BUSIN.API.disable(viewState, disableCollective);
        }
    };

	//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
    //ViewContainer: GenericApplication
    task.onCloseModalEvent = function(entities, onCloseModalEventArgs) {
        onCloseModalEventArgs.commons.execServer = false;
		/*var parentParameters = onCloseModalEventArgs.commons.api.parentVc.customDialogParameters;
        if(onCloseModalEventArgs.closedViewContainerId=='VC_OSRCH32_AOEAR_233'
			&&onCloseModalEventArgs.dialogCloseType!=1//envia a cerrar por X
			){
			console.log("cerrado el evento VC_OSRCH32_AOEAR_233");
			var debtors = angular.copy(onCloseModalEventArgs.commons.api.vc.model.DebtorGeneral.data());
			var band=false;
			// Recupero el resultado
			var result =  onCloseModalEventArgs.result;
			
			// Añado los registros a la grilla de deudores
			if(result.debtors!=null&&result.debtors!=undefined){
				for (var i = 0; i < result.debtors.length; i++) {
				for (var j = 0; j < debtors.length; j++) {
					if (debtors[j].CustomerCode == result.debtors[i].CustomerCode) {
						band=true;			        
						break;
					}else{
						band=false;
					}
				}
				if(!band){
                        result.debtors[i].Role = 'C';
						onCloseModalEventArgs.commons.api.grid.addRow('DebtorGeneral', result.debtors[i], false);
					}
				}	
			}
			
			if(result.operations!=null&&result.operations!=undefined){
				onCloseModalEventArgs.commons.api.grid.addAllRows('RefinancingOperations', result.operations, false);
			}
			if(parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Reestructuration){
				onCloseModalEventArgs.commons.execServer = true;
			}else{
				onCloseModalEventArgs.commons.execServer = false;
			}
			
		}else{
			onCloseModalEventArgs.commons.execServer = false;
		}
		//envio de entidades
		onCloseModalEventArgs.commons.serverParameters.OriginalHeader = true;
        onCloseModalEventArgs.commons.serverParameters.RefinancingOperations = true;*/
        //SMO no existe el método completo en Grupales
    };

	//Start signature to callBack event to VC_OIIRL51_CNLTO_343
	task.onCloseModalEventCallbak = function(entities, args) {
		/*args.newValue=entities.OriginalHeader.AmountRequested;
		task.change.VA_ORIAHEADER8602_OQUE134(entities, args);
		args.commons.execServer = false;*/ //SMO-no está en grupales
	};


	//Evento render : Se ejecuta antes de renderizar un control, permite realizar personalizaciones visuales
//ViewContainer: GenericApplication
task.render = function (entities, renderEventArgs) {
    document.getElementById('VA_TEXTINPUTBOXGRN_916576').readOnly = true;
    var parentParameters = renderEventArgs.commons.api.parentVc.customDialogParameters;
    var viewState = renderEventArgs.commons.api.viewState;
    var parentApi = renderEventArgs.commons.api.parentApi();
    var parentVc = parentApi.vc;
    //SMO se agrega en grupales
    var api = renderEventArgs.commons.api;
    var customDialogParameters = renderEventArgs.commons.api.vc.parentVc.customDialogParameters; //--ACHP
    typeRequest = customDialogParameters.Task.urlParams.SOLICITUD;
    modeRequest = customDialogParameters.Task.urlParams.MODE; //PXSG    

    /*var ctrs = ['VA_ORIAHEADER8608_TAOR020',
		            'VA_ORIAHEADER8608_TCTC534',
		            'VA_ORIAHEADER8608_TTCD057',
		            'VA_ORIAHEADER8608_CCAA829', // seccion de alicuota
		            'VC_OIIRL51_RUPNR_606',	     // seccion, operaciones,spacerCreditLine
		            'VA_ORIAHEADER8605_TIRC927', // tipoProduto
		            'VA_ORIAHEADER8605_ERTO640'];// Linea de Credito
                    'CM_TFLCRE_8__II' // Botón Validar LCR*/

    var ctrs = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TCTC534', 'VA_ORIAHEADER8608_TTCD057',
        'VA_ORIAHEADER8608_CCAA829', 'VA_ORIAHEADER8605_ERTO640', 'VA_AMOUNTDISBURSEE_600R86',
        'VA_COMBOBOXAURNLPO_247R86', 'VA_INSURANCEPACKEG_674R86', 'VA_TERMMEDICALAISS_991R86', 'CM_OIIRL51INT80', 'CM_TFLCRE_8__II', 'CM_TFLCRE_8_925'
    ]

    BUSIN.API.hide(viewState, ctrs);

    // Template para combo Linea de credito
    var viewState = renderEventArgs.commons.api.viewState;
    var template = '<span><h4>#: value#</h4></span>' + '<span><b>Monto:</b> #: attributes[0] #</span> - ' + '<span><b>Disponible:</b> #: attributes[1] #</span> - ' + '<span><b>Moneda:</b> #: attributes[2] #</span>';
    viewState.template('VA_ORIAHEADER8605_ERTO640', template);

    // Realizo el change para que cambie el segmento
    entities.EntidadInfo.sector = entities.generalData.segment;

    var template2 = '<span><h4>#: code#</h4></span>' + '<span>#: attributes[0]#</span><br>' + '<span>#: attributes[1]#</span><br>' + '<span>#: attributes[2]#</span><br>';
    viewState.template('VA_ORIAHEADER8608_TTCD057', template2);
    viewState.template('VA_ORIAHEADER8608_TAOR020', template2);


    // Alicuota
    var ctrs1Alicuota = [];
    entities.Alicuota.Alicuota = (entities.Alicuota.Alicuota !== null) ? entities.Alicuota.Alicuota : "N-A";
    var alicuotaValue = entities.Alicuota.Alicuota;
    if (alicuotaValue === 'S') {
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TCTC534', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
    } else if (alicuotaValue === 'N') {
        viewState.label("VA_ORIAHEADER8608_CCAA829", 'BUSIN.DLB_BUSIN_ALICUOTAI_84613'); // cambio de etiqueta
        ctrs1Alicuota = ['VA_ORIAHEADER8608_TAOR020', 'VA_ORIAHEADER8608_TTCD057', 'VA_ORIAHEADER8608_CCAA829'];
        BUSIN.API.show(viewState, ctrs1Alicuota);
        if (entities.Alicuota.CtaCertificada !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
        }
        if (entities.Alicuota.CtaAhorros !== undefined) {
            viewState.disableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
        }
    }

    // Modo Consulta
    task.showButtons(renderEventArgs);
    if ((parentParameters.Task.urlParams.MODE === "Q") || (parentParameters.Task.urlParams.MODE === "A")) { // en el caso de que la
        // tarea se utilice con
        // todos los campos
        // deshabilitados
        /*var ctrsToDisable = ['VC_OIIRL51_TBRMT_122',
                             'VC_OIIRL51_PTONI_284',
                             'VC_OIIRL51_GTDOS_515',
                             'VC_OIIRL51_RUPNR_606',
                             'CM_OIIRL51SVE80',
                             'CM_OIIRL51INT80'];// btn guardar, btn imprimir*/

        var ctrsToDisable = ['VC_OIIRL51_TBRMT_122', 'VC_OIIRL51_PTONI_284', 'VC_OIIRL51_GTDOS_515',
            'CM_OIIRL51SVE80'
        ];
        BUSIN.API.disable(viewState, ctrsToDisable);
        if (parentParameters.Task.urlParams.MODE === "A") {
            var ctrsToDisableAutomatic = ['VA_TEXTINPUTBOXGRN_916576',
                'VA_VABUTTONFUIXKXW_718576',
                'VA_CUSTOMEREXPEIII_577R86',
                'VA_COMBOBOXGTFCJFR_317R86'
            ];
            BUSIN.API.disable(viewState, ctrsToDisableAutomatic);
        }
        if (parentParameters.Task.urlParams.TIPO === "C") {
            if (typeRequest != FLCRE.CONSTANTS.TypeRequest.REVOLVENTE) {
                renderEventArgs.commons.messageHandler.showMessagesInformation('Tiene un credito Activo, espere a su cancelaci\u00f3n.');
            }
        }
        /*renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create');// boton
        																				// nuevo
        																				// deudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719');// boton
        																										// eliminar
        																										// deudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
        																										// nuevo
        																										// operaciones
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
        																										// eliminar
        																										// operaciones*/
        //cambio en grupales
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores

        //Ocultar el boton edit del grid de deudores
        //task.hideButtonGridDebtors(renderEventArgs);//no existe en grupales

        //Recupera % de la garantia cuando no hay el boton Guardar en las diferentes Etapas
        var parameterRender = renderEventArgs.commons.api.parentVc.customDialogParameters;
        parameterRender.Task.porcentaje = entities.ApplicationInfoAux.percentageGuarantee;
    }

    /*//Ocultar el boton edit del grid de deudores
    if (parentParameters.Task.urlParams.TRAMITE !== FLCRE.CONSTANTS.RequestName.Renovation &&
        parentParameters.Task.urlParams.TRAMITE !== FLCRE.CONSTANTS.RequestName.Reestructuration){
    	task.hideButtonGridDebtors(renderEventArgs);
    }*/ //SMO no existe en grupales

    // Etapas Tramite
    // Refinanciamiento, Reestructuracion, Renovacion
    if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Refinancing ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation ||
        parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration) {

        // Grilla de operaciones y tipo de producto en los flujos
        // especificos
        //var ctrsToShow = ['VC_OIIRL51_RUPNR_606', 'VA_ORIAHEADER8605_TIRC927'];
        //cambio grupales
        var ctrsToShow = [ //'VC_OIIRL51_RUPNR_606', 
            'VA_ORIAHEADER8605_TIRC927'
        ];
        BUSIN.API.show(viewState, ctrsToShow);

        // spacerTypeProduct
        var ctrsToHide = ['VA_ORIAHEADER8605_0000029'];
        BUSIN.API.hide(viewState, ctrsToHide);
        /*NO existe en grupales
		    // Oculta columnas
		    var columnsRefinancingOperations = ['RefinancingOption', 'InternalCustomerClassification', 'Rate', 'CreditType'];
		    BUSIN.API.GRID.hideColumns('QV_ITRIC1523_63', columnsRefinancingOperations, renderEventArgs.commons.api);

		    //Ajusta el tamaño de las cabeceras al campo de la grilla
		    var columns = ['OperationBank', 'CurrencyOperation', 'Balance', 'LocalCurrencyBalance', 'OriginalAmount', 'LocalCurrencyAmount', 'CreditType',
							'InternalCustomerClassification', 'DateGranting', 'IdOperation', 'RefinancingOption', 'IsBase', 'Rate', 'ExpirationDate', 'State',
							'TypeOperation', 'interestBalance', 'otherItemsBalance', 'totalCapitalization'];
		    BUSIN.API.GRID.addColumnsStyle('QV_ITRIC1523_63', 'Grid-Column-Header', renderEventArgs.commons.api, columns);

		    //Disable de columnas de la grilla
		    var grid = renderEventArgs.commons.api.grid;
        grid.disabledColumn('QV_ITRIC1523_63','IsBase');
		    grid.disabledColumn('QV_ITRIC1523_63', 'OperationBank');
		    grid.disabledColumn('QV_ITRIC1523_63', 'TypeOperation');
		    grid.disabledColumn('QV_ITRIC1523_63', 'ExpirationDate');
		    grid.disabledColumn('QV_ITRIC1523_63', 'State');
		    grid.disabledColumn('QV_ITRIC1523_63', 'DateGranting');

		    var columnsOperationsHide = ['LocalCurrencyBalance', 'LocalCurrencyAmount', 'DateGranting', 'PayoutPercentage', 'OperationQualification', 'oficialOperation'];
		    BUSIN.API.GRID.hideColumns('QV_ITRIC1523_63', columnsOperationsHide, renderEventArgs.commons.api);*/
    }
    /* No existe en grupales
		if(parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Reestructuration) {			
			//configuracion especifica para Reestructuracion
			var ctrsToHide=['VA_ORIAHEADER8605_TIRC927'];
			BUSIN.API.hide(viewState,ctrsToHide);
			// spacerTypeProduct
			var ctrsToShow=['VA_ORIAHEADER8605_0000029'];
			BUSIN.API.show(viewState,ctrsToShow);
			var ctrsToDisable = ['VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826'];// monto solicitado y monto aprobado
			BUSIN.API.disable(viewState,ctrsToDisable);	
		
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
																													// nuevo
																													// operaciones
			renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
																													// eliminar
																													// operaciones
		}*/

    //Bloquea el tipo de producto en base al parametro que llega del an_component DISABLE_PRODUCT_TYPE
    /*if(parentParameters.Task.urlParams.DISABLE_PRODUCT_TYPE == "S") {
    	var ctrsToDisable = ['VA_ORIAHEADER8605_TIRC927'];
    	BUSIN.API.disable(viewState,ctrsToDisable);
     }*/ //MTA se quita validacion y para todos los casos siempre debe estar bloqueado la oficina y tipo de producto
    var ctrsToDisable = ['VA_ORIAHEADER8605_ORTR915', 'VA_ORIAHEADER8605_TIRC927', 'VA_ORIAHEADER8602_URQT595', 'VA_EJECUTIVOZUEHTQ_752W91'];
    BUSIN.API.disable(viewState, ctrsToDisable);


    /* No existe en grupales
		//habilita la edicion de las operaciones
		if(parentParameters.Task.urlParams.EDIT_OPERATION == FLCRE.CONSTANTS.Mode.Editable){
			renderEventArgs.commons.api.grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_992');// boton
																													// nuevo
																													// operaciones
			renderEventArgs.commons.api.grid.showToolBarButton('QV_ITRIC1523_63', 'CEQV_201_QV_ITRIC1523_63_978');// boton
																													// eliminar
																													// operaciones
		}
		renderEventArgs.commons.api.grid.hideToolBarButton('QV_ITRIC1523_63', 'create');// boton
																						// de
																						// la
																						// grilla
																						// de
																						// operaciones
		*/
    //Se agrega de grupales
    //Tramite grupal	
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL) {
        // var ctrsToDisable = ['VA_GRUPALKFSXRLTTA_514W91']; // NewAliquot.grupal
        var ctrsToHide = [
            'VA_NIVELCOLECTIOVO_641R86',
            'VA_INGRESOSMENSUUE_680R86'];
        BUSIN.API.hide(viewState, ctrsToHide);
        BUSIN.API.GRID.hideColumns('QV_BOREG0798_55', ['creditBureau'], api);
        var ctrsAux = ['VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826']
        BUSIN.API.disable(viewState, ctrsAux);
        if (entities.OriginalHeader.IDRequested == 0) {
            entities.OriginalHeader.AmountRequested = 0.0;
            entities.OriginalHeader.AmountAprobed = 0.0;
        }
        var ctrsAuxRen = ['VA_COMBOBOXGTFCJFR_317R86', 'VA_TEXTINPUTBOXRXU_762R86']
        if (entities.Context.Flag1 > 1) {
            BUSIN.API.enable(viewState, ctrsAuxRen);
        } else {
            BUSIN.API.disable(viewState, ctrsAuxRen);
        }
        viewState.label("VC_OIIRL51_GTDOS_515", 'BUSIN.LBL_BUSIN_CLIENTESS_18177'); //Caso Incidencia #85832-cambio de etiqueta
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var ctrsAuxHide = ['VA_TEXTINPUTBOXRXU_762R86', 'VA_CUSTOMEREXPEIII_577R86', 'VA_NIVELCOLECTIOVO_641R86', 'VA_INGRESOSMENSUUE_680R86', 'CM_TFLCRE_8_IO1']; //mta
        var ctrsAuxShow = ['VA_MAXIMUMAMOUNTTT_215R86']; //mta
        var ctrsAuxDisable = [];

        if (modeRequest === 'AP') {
            ctrsAuxDisable = ['VA_NUEVODESTINOIJR_765R86', 'VA_COMBOBOXGTFCJFR_317R86', 'VA_COMBOBOXTQEDQWM_929R86', 'VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826', 'VA_FREQUENCYLTUZDL_595R86', 'VA_TERMINDTMTELITU_695R86'];
            ctrsAuxShow.push('VA_INSURANCEPACKEG_674R86');
            ctrsAuxShow.push('VA_TERMMEDICALAISS_991R86');
        } else if (modeRequest === 'APR') {
            ctrsAuxDisable = ['VA_NUEVODESTINOIJR_765R86', 'VA_COMBOBOXGTFCJFR_317R86', 'VA_COMBOBOXTQEDQWM_929R86', 'VA_ORIAHEADER8602_OQUE134', 'VA_ORIAHEADER8602_MICI826', 'VA_FREQUENCYLTUZDL_595R86', 'VA_TERMINDTMTELITU_695R86', 'VA_INSURANCEPACKEG_674R86', 'VA_TERMMEDICALAISS_991R86'];
            ctrsAuxShow.push('VA_INSURANCEPACKEG_674R86');
            ctrsAuxShow.push('VA_TERMMEDICALAISS_991R86');
        }

        BUSIN.API.hide(viewState, ctrsAuxHide);
        BUSIN.API.show(viewState, ctrsAuxShow);
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        viewState.label("VC_OIIRL51_GTDOS_515", 'BUSIN.LBL_BUSIN_CLIENTEPK_21523'); //Caso Incidencia #85832-cambio de etiqueta

        var ctrsAuxFlag = ['VA_COMBOBOXGTFCJFR_317R86']
        if (entities.Context.Flag1 >= 1) {
            BUSIN.API.show(viewState, ctrsAuxFlag);
        } else {
            BUSIN.API.hide(viewState, ctrsAuxFlag);
        }
    }

    if (modeRequest === 'Q') {
        var ctrsAuxDisable = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_RCUOA_445', 'VC_OIIRL51_GPOOG_815', 'VC_ZVXQIUJDIP_665L51']
        BUSIN.API.disable(viewState, ctrsAuxDisable);
    }

    //habilitar campo es promocion en el render
    if (modeRequest === undefined) {
        var ctrsAuxVarPromo = ['VA_COMBOBOXTQEDQWM_929R86']
        BUSIN.API.enable(viewState, ctrsAuxVarPromo);
    }
    //Caso Incidencia #85830
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.GRUPAL || typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var ctrsAuxDisable = ['VA_ORIAHEADER8605_TIRC927', 'VA_BANCAEQGJPXCNHY_767R86', 'VA_GEOGRAPHICALSIS_291R86']
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        //Incidencia #85832
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'create'); //boton nuevodeudores
        renderEventArgs.commons.api.grid.hideToolBarButton('QV_BOREG0798_55', 'CEQV_201_QV_BOREG0798_55_719'); //boton eliminar deudores

    }
    //Requerimiento 103753 campos bloqueados para LCR
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE || typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) {
        //VA_BANCAEQGJPXCNHY_767R86, VA_GEOGRAPHICALSIS_291R86, VA_NUEVODESTINOIJR_765R86, VA_ORIAHEADER8602_OQUE134, VA_ORIAHEADER8602_MICI826, VA_COMBOBOXTQEDQWM_929R86, VA_COMBOBOXGTFCJFR_317R86, VA_TEXTINPUTBOXRXU_762R86, 
        //Campo Priodicidad VA_ORIAHEADER8602_NQUE773
        var ctrsAuxDisable = [
            'VA_BANCAEQGJPXCNHY_767R86',
            'VA_GEOGRAPHICALSIS_291R86',
            'VA_NUEVODESTINOIJR_765R86',
            'VA_ORIAHEADER8602_OQUE134',
            'VA_ORIAHEADER8602_MICI826',
            'VA_COMBOBOXTQEDQWM_929R86',
            'VA_COMBOBOXGTFCJFR_317R86',
            'VA_TEXTINPUTBOXRXU_762R86',
            'VC_OIIRL51_GPOOG_815',
            'VA_NIVELCOLECTIOVO_641R86',
            'VA_INGRESOSMENSUUE_680R86'
        ];
        var ctrsHide = [
            'VA_ORIAHEADER8602_MICI826',
            'VA_ORIAHEADER8602_FICE546',
            'VA_VACOMPOSITEMXIH_497R86',
            'VA_BCBLACKLISTSCLL_583R86',
            'VA_ORIAHEADER8602_MNLA393',
            'CM_OIIRL51SVE80',
            'VA_COMBOBOXTQEDQWM_929R86',
            'VA_COMBOBOXAURNLPO_247R86',
            'VA_TEXTINPUTBOXLZA_843R86',
            'VA_COMBOBOXGTFCJFR_317R86',
            'VA_ISPARTNERZBPHXB_883R86',
            'VA_TEXTINPUTBOXRXU_762R86',
            'VA_CUSTOMEREXPEIII_577R86',
            'VA_GEOGRAPHICALSIS_291R86',
            'VA_ORIAHEADER8602_OQUE134',
            'VA_ORIAHEADER8602_URQT595'
        ];
        var ctrsAuxEnable = ['VA_ORIAHEADER8602_NQUE773'];
        var ctrsShow = ['CM_TFLCRE_8_IO1', 'VA_7694PEJSETHIYUL_239R86'];
        BUSIN.API.disable(viewState, ctrsAuxDisable);
        BUSIN.API.enable(viewState, ctrsAuxEnable);
        BUSIN.API.show(viewState, ctrsShow);
        BUSIN.API.hide(viewState, ctrsHide);
    }

    if ((typeRequest == FLCRE.CONSTANTS.TypeRequest.REVOLVENTE ||
            typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) && modeRequest == FLCRE.CONSTANTS.Mode.Query) {
        var disabledCreditRevolvente = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_GPOOG_815', 'CM_TFLCRE_8_IO1']
        BUSIN.API.disable(viewState, disabledCreditRevolvente);
    }
    if ((typeRequest == FLCRE.CONSTANTS.TypeRequest.REVOLVENTE ||
            typeRequest === FLCRE.CONSTANTS.TypeRequest.COLECTIVOS) && modeRequest == 'A') {
        var disabledCreditRevolvente = ['VC_OIIRL51_GREEG_881', 'VC_OIIRL51_GPOOG_815', 'CM_TFLCRE_8_IO1']
        BUSIN.API.disable(viewState, disabledCreditRevolvente);
        parentVc.model.InboxContainerPage.HiddenInCompleted = "NO";
    }
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.REVOLVENTE && entities.OriginalHeader.isCandidate == "S") {
        var ctrsAuxDisable = ['VA_7694PEJSETHIYUL_239R86'];
        BUSIN.API.disable(viewState, ctrsAuxDisable);
    }

    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        if (entities.EntidadInfo.insurancePackage == 'EXTENDIDO') {
            renderEventArgs.commons.api.viewState.enable('VA_TERMMEDICALAISS_991R86');
        } else {
            renderEventArgs.commons.api.viewState.disable('VA_TERMMEDICALAISS_991R86');
        }
    }
    
    if (entities.EntidadInfo.insurancePackage == null || entities.EntidadInfo.insurancePackage == '' || entities.EntidadInfo.insurancePackage == undefined) {
        entities.EntidadInfo.insurancePackage = "BASICO";
    }

};

	//Entity: EntidadInfo
//EntidadInfo.insurancePackage (ComboBox) View: T_HeaderView
//Evento Change: Se ejecuta al cambiar el valor de un InputControl.
task.change.VA_INSURANCEPACKEG_674R86 = function (entities, changedEventArgs) {
    changedEventArgs.commons.execServer = false;

    if (changedEventArgs.newValue == 'EXTENDIDO') {
        changedEventArgs.commons.api.viewState.enable('VA_TERMMEDICALAISS_991R86');
    } else {
        changedEventArgs.commons.api.viewState.disable('VA_TERMMEDICALAISS_991R86');
        entities.EntidadInfo.termMedicalAssistance = null;
    }
};

	//Entity: OriginalHeader
    //OriginalHeader.AmountRequested (TextInputBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8602_OQUE134 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
		entities.OriginalHeader.AmountAprobed=changedEventArgs.newValue;
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Solicitado',BUSIN.CONVERT.CURRENCY.Format((changedEventArgs.newValue ==null||changedEventArgs.newValue =='null' ? 0:changedEventArgs.newValue ),2),0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Monto Autorizado',BUSIN.CONVERT.CURRENCY.Format((changedEventArgs.newValue ==null||changedEventArgs.newValue =='null' ? 0:changedEventArgs.newValue ),2),0);//--**ACHP
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };

	//Entity: OriginalHeader
    //OriginalHeader.CurrencyRequested (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8602_URQT595 = function(entities, changedEventArgs) {
        /*SMO-validar en el server está execServer true
        
        /*changedEventArgs.commons.execServer = false;
        // changedEventArgs.commons.api.vc.serverParameters.OriginalHeader =
		// true;
		var val="USD";
		var vs = changedEventArgs.commons.api.viewState;
		vs.suffix('VA_ORIAHEADER8602_OQUE134', val);
		vs.suffix('VA_ORIAHEADER8602_MICI826', val);
		
		LATFO.INBOX.addTaskHeader(taskHeader,'Moneda',val,0);
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');	*/
    };

	//Entity: EntidadInfo
    //EntidadInfo.destEconomicoBusqueda (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_MIUS039 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
		/* if(changedEventArgs.newValue != undefined && treeSelected == false){
			changedEventArgs.commons.api.vc.model.EntidadInfo.destinoEconomico = changedEventArgs.newValue;
	   }*/
        //SMO NO existe este evento en el server
    };

	//Entity: EntidadInfo
    //EntidadInfo.oficina (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_ORTR915 = function(entities, changedEventArgs) {
        //changedEventArgs.commons.execServer = false;       
        //SMO validar en el servidor está execServer=true
        changedEventArgs.commons.execServer = true;
        entities.EntidadInfo.oficina = entities.EntidadInfo.oficina == null || entities.EntidadInfo.oficina == '' || entities.EntidadInfo.oficina == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code +"" : entities.EntidadInfo.oficina;
        changedEventArgs.newValue = changedEventArgs.newValue == null || changedEventArgs.newValue == '' || changedEventArgs.newValue == '0' ? cobis.userContext.getValue(cobis.constant.USER_OFFICE).code +"" : changedEventArgs.newValue;
		LATFO.INBOX.addTaskHeader(taskHeader,'Oficina',changedEventArgs.commons.api.vc.catalogs.VA_ORIAHEADER8605_ORTR915.get(changedEventArgs.newValue).value,1);
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };

	//Entity: EntidadInfo
    //EntidadInfo.sector (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_SETO998 = function(entities, changedEventArgs) {
        //SMO validar el if no existe en el servidor
		if (changedEventArgs.newValue !== undefined && changedEventArgs.newValue != entities.EntidadInfo.sector){
		entities.EntidadInfo.destinoEconomico="";
		entities.EntidadInfo.destinoFinanciero="";
		entities.EntidadInfo.otroDestino="";
        changedEventArgs.commons.execServer = false;
        changedEventArgs.commons.serverParameters.EntidadInfo = true;
        changedEventArgs.commons.serverParameters.generalData = true;
		}
    };

	//Entity: EntidadInfo
    //EntidadInfo.tipoProducto (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8605_TIRC927 = function(entities, changedEventArgs) {
    	
    	changedEventArgs.commons.serverParameters.EntidadInfo = true;
    	changedEventArgs.commons.serverParameters.OriginalHeader = true;
    	changedEventArgs.commons.serverParameters.generalData = true;
    
		// Reinicio los valores del combo
		entities.OriginalHeader.CurrencyRequested="0";
		entities.EntidadInfo.destinoEconomico="";
		entities.EntidadInfo.destinoFinanciero="";
		entities.EntidadInfo.sector="";
    	
		changedEventArgs.commons.execServer = true;

    };

		//Start signature to callBack event to VA_ORIAHEADER8605_TIRC927
	task.changeCallback.VA_ORIAHEADER8605_TIRC927 = function(entities, changedEventArgs) {	
		$("#VA_ORIAHEADER8605_SETO998").data("kendoExtComboBox").dataSource.read(); // Sector
																					// del
																					// credito
		$("#VA_ORIAHEADER8605_OCRI261").data("kendoExtComboBox").dataSource.read(); // Destino
																					// Financiero
		$("#VA_ORIAHEADER8602_URQT595").data("kendoExtComboBox").dataSource.read(); // Moneda
																					// Solicitada
		
		// Actrulizo la cabecera con los nuevos campos
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Producto',entities.generalData.productTypeName,0);
		LATFO.INBOX.addTaskHeader(taskHeader,'Tipo Cartera',entities.generalData.loanType,1);
		LATFO.INBOX.updateTaskHeader(taskHeader, changedEventArgs, 'GR_WTTTEPRCES08_02');
    };

	//Entity: OriginalHeader
    //OriginalHeader.PaymentFrequency (ComboBox) View: T_HeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_PAYMENTFREQUECN_439R86 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    
        //changedEventArgs.commons.serverParameters.OriginalHeader = true;
    };

	//Entity: OriginalHeader
    //OriginalHeader.Term (ComboBox) View: T_HeaderView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_TERMLJXTQBYRQKU_619R86 = function(  entities, changedEventArgs ) {

    changedEventArgs.commons.execServer = true;
    
        //changedEventArgs.commons.serverParameters.OriginalHeader = true;
    };

	//Entity: OriginalHeader
    //OriginalHeader.AmountAprobed (TextInputBox) View: T_HeaderView
    
    task.customValidate.VA_ORIAHEADER8602_MICI826 = function(entities, customValidateEventArgs) {
    	
    	var parentParameters = customValidateEventArgs.commons.api.parentVc.customDialogParameters;
    	customValidateEventArgs.isValid = true;
    	
    	// Valida que la suma de los saldos de las operaciones sean mayores al
		// nuevo valor de la renovacion
    	/*if (parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Renovation) {
        	if (entities.OriginalHeader.AmountAprobed < entities.OriginalHeader.AmountCalculated) {
        		customValidateEventArgs.errorMessage='El valor de renovacion debe ser mayor o igual a ' + entities.OriginalHeader.AmountCalculated;
                customValidateEventArgs.isValid = false;
			}
		}*/
        //SMO modificado en grupales
        if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation) {

        var sumSaldo = 0;

        for (var i = 0; i < entities.RefinancingOperations.data().length; i++) {
            sumSaldo = sumSaldo + entities.RefinancingOperations.data()[i].Balance;
        }
        if (entities.OriginalHeader.AmountAprobed < sumSaldo) {
            customValidateEventArgs.errorMessage = 'El valor de renovacion debe ser mayor o igual a ' + sumSaldo;
            customValidateEventArgs.isValid = false;
        }
    }
        
    };

	//Entity: OriginalHeader
    //OriginalHeader.AmountRequested (TextInputBox) View: T_HeaderView
    
    task.customValidate.VA_ORIAHEADER8602_OQUE134 = function(entities, customValidateEventArgs) {
    	
    	var parentParameters = customValidateEventArgs.commons.api.parentVc.customDialogParameters;
    	customValidateEventArgs.isValid = true;
    	
    	// Valida que la suma de los saldos de las operaciones sean mayores al
		// nuevo valor de la renovacion
    	/*if (parentParameters.Task.urlParams.TRAMITE==FLCRE.CONSTANTS.RequestName.Renovation) {
        	if (entities.OriginalHeader.AmountRequested < entities.OriginalHeader.AmountCalculated) {        		
				customValidateEventArgs.errorMessage='El valor de renovacion debe ser mayor o igual a ' + entities.OriginalHeader.AmountCalculated;
                customValidateEventArgs.isValid = false;
			}
		}*/ //SMO - cambiado en grupales
        
         if (parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation) {

        var sumSaldo = 0;

        for (var i = 0; i < entities.RefinancingOperations.data().length; i++) {
            sumSaldo = sumSaldo + entities.RefinancingOperations.data()[i].Balance;
        }
        if (entities.OriginalHeader.AmountRequested < sumSaldo) {
            customValidateEventArgs.errorMessage = 'El valor de renovacion debe ser mayor o igual a ' + sumSaldo;
            customValidateEventArgs.isValid = false;
        }
    }
    };

	//Entity: EntidadInfo
    //EntidadInfo. (Button) View: [object Object]
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_ORIAHEADER8605_EIIR755 = function(entities, executeCommandEventArgs) {
         executeCommandEventArgs.commons.execServer = false;
		 task.openFindProgram(executeCommandEventArgs);
    };

	//Entity: EntidadInfo
    //EntidadInfo.insurancePackage (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_INSURANCEPACKEG_674R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };

	//Entity: OriginalHeader
    //OriginalHeader.CurrencyRequested (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8602_URQT595 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
    };

	//Entity: EntidadInfo
    //EntidadInfo.lineaCredito (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_ERTO640 = function(loadCatalogDataEventArgs) {
       loadCatalogDataEventArgs.commons.execServer = false; //false en grupales
        // loadCatalogDataEventArgs.commons.execServer = true;
		loadCatalogDataEventArgs.commons.api.vc.serverParameters.DebtorGeneral = true;
    };

	//Entity: EntidadInfo
    //EntidadInfo.destEconomicoBusqueda (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_MIUS039 = function (loadCatalogDataEventArgs) {
        /*var loadEconomicDestination = false;
        if (loadCatalogDataEventArgs.config != null) {
            loadEconomicDestination = true;
            treeSelected = false;
        }
        if (loadEconomicDestination) {
            loadCatalogDataEventArgs.commons.execServer = true;
            loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
        } else {
            loadCatalogDataEventArgs.commons.execServer = false;
        }*/
        //SMO No existe en grupales
        loadCatalogDataEventArgs.commons.execServer = false;
        
    };

	//Entity: EntidadInfo
    //EntidadInfo.destinoFinanciero (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_OCRI261 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;        
		loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
		loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };

	//Entity: EntidadInfo
    //EntidadInfo.otroDestino (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_OEIO709 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;
        loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };

	//Entity: EntidadInfo
    //EntidadInfo.sector (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_SETO998 = function(loadCatalogDataEventArgs) {// JRU//campos
																						// a
																						// definir
       loadCatalogDataEventArgs.commons.execServer = false;
       loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
       loadCatalogDataEventArgs.commons.serverParameters.generalData = true;
    };

	//Entity: EntidadInfo
    //EntidadInfo.tipoProducto (ComboBox) View: [object Object]
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8605_TIRC927 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
        loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
        loadCatalogDataEventArgs.commons.serverParameters.generalData = true;
    };

	//Entity: OriginalHeader
    //OriginalHeader.PaymentFrequency (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_PAYMENTFREQUECN_439R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
    };

	//Entity: OriginalHeader
    //OriginalHeader.termInd (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_TERMINDTMTELITU_695R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
    };

	//Entity: EntidadInfo
//EntidadInfo.termMedicalAssistance (ComboBox) View: T_HeaderView
//Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
task.loadCatalog.VA_TERMMEDICALAISS_991R86 = function (loadCatalogDataEventArgs) {
    loadCatalogDataEventArgs.commons.execServer = true;
    loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    loadCatalogDataEventArgs.commons.serverParameters.OriginalHeader = true;
};

	//Start signature to Callback event to VA_TERMMEDICALAISS_991R86
task.loadCatalogCallback.VA_TERMMEDICALAISS_991R86 = function (entities, loadCatalogCallbackEventArgs) {
    if (entities.EntidadInfo.insurancePackage == 'EXTENDIDO') {
        if (entities.EntidadInfo.termMedicalAssistance == null) {
            entities.EntidadInfo.termMedicalAssistance = "";
        }
    } else {
        entities.EntidadInfo.termMedicalAssistance = null;
    }
};


	//Entity: EntidadInfo
    //EntidadInfo.ubicacion (ComboBox) View: T_HeaderView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_UBICACIONCNXOET_652R86 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.EntidadInfo = true;
    };

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

	//Entity: Alicuota
    //Alicuota.CtaAhorros (ComboBox) View: T_alicutoaView
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_ORIAHEADER8608_TAOR020 = function(entities, changedEventArgs) {
        changedEventArgs.commons.execServer = false;
        var viewState = changedEventArgs.commons.api.viewState;
		if(entities.Alicuota.Alicuota == "N" && entities.Alicuota.CtaAhorros !== null){
			viewState.enableValidation('VA_ORIAHEADER8608_TAOR020', VisualValidationTypeEnum.Required);
			viewState.disableValidation('VA_ORIAHEADER8608_TTCD057', VisualValidationTypeEnum.Required);
		}
    };

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

	//Entity: NewAliquot
    //NewAliquot.ejecutivo (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_EJECUTIVOZUEHTQ_752W91 = function( loadCatalogDataEventArgs ) {

    loadCatalogDataEventArgs.commons.execServer = true;
    
        //loadCatalogDataEventArgs.commons.serverParameters.NewAliquot = true;
    };

	//Entity: Alicuota
    //Alicuota.Alicuota (RadioButtonList) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_ALTA466 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;        
		return [{code:'N-A',value:"No Aplica"},{code:'S',value:"Si"},{code:'N',value:"No"}];
    };

	//Entity: Alicuota
    //Alicuota.AlicuotaCertificada (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_CCAA829 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;//SMO no se usa en grupales
       /* loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Alicuota = true;*/
    };

	//Entity: Alicuota
    //Alicuota.CtaAhorros (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_TAOR020 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;//SMO no se usa en grupales
        /*loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Alicuota = true
		loadCatalogDataEventArgs.commons.api.vc.serverParameters.generalData = true*/
    };

	//Entity: Alicuota
    //Alicuota.AlicuotaAhorro (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_TCTC534 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;//SMO no se usa en grupales
       /* loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Alicuota = true;*/
    };

	//Entity: Alicuota
    //Alicuota.CtaCertificada (ComboBox) View: T_alicutoaView
    //Evento LoadCatalogData: Sobreescribe la forma de cargar datos en un catálogo.
    task.loadCatalog.VA_ORIAHEADER8608_TTCD057 = function(loadCatalogDataEventArgs) {
        loadCatalogDataEventArgs.commons.execServer = false;//SMO no se usa en grupales
       /* loadCatalogDataEventArgs.commons.execServer = true;
        loadCatalogDataEventArgs.commons.api.vc.serverParameters.Alicuota = true;
		loadCatalogDataEventArgs.commons.api.vc.serverParameters.generalData = true;*/
    };

	//gridBeforeEnterInLineRow QueryView: Borrowers
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
    task.gridBeforeEnterInLineRow.QV_BOREG0798_55 = function(entities, gridABeforeEnterInLineRowEventArgs) { // BeforeEnterLine
																												// QueryView:
																												// Borrowers
        var parentParameters = gridABeforeEnterInLineRowEventArgs.commons.api.parentVc.customDialogParameters;
		//Habilitar el campo rol para permitir seleccionar el deudor principal de la operacion
		if (entities.generalData.enableDebtorRole && ( parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Renovation ||
		    parentParameters.Task.urlParams.TRAMITE == FLCRE.CONSTANTS.RequestName.Reestructuration)){
			gridABeforeEnterInLineRowEventArgs.commons.api.grid.enabledColumn('QV_BOREG0798_55', 'Role');
		} else {
			gridABeforeEnterInLineRowEventArgs.commons.api.grid.disabledColumn('QV_BOREG0798_55', 'Role');
		}
        gridABeforeEnterInLineRowEventArgs.commons.execServer = false;
        FLCRE.VARIABLES.Debtor.Role = gridABeforeEnterInLineRowEventArgs.rowData.Role;
        var deleteNewRow =false;
        if (gridABeforeEnterInLineRowEventArgs.rowData.CustomerCode == 0){
        	FLCRE.UTILS.CUSTOMER.openFindCustomer(entities,gridABeforeEnterInLineRowEventArgs,{},deleteNewRow);
        }
    };

	//beforeOpenGridDialog QueryView: Borrowers
        //Evento que se ejecuta antes que una pantalla de inserción o edición de registros aparezca en un contenedor diferente.
    task.beforeOpenGridDialog.QV_BOREG0798_55 = function(entities, beforeOpenGridDialogEventArgs) { // BeforeViewCreationCl
																									// QueryView:
																									// Borrowers
        //beforeOpenGridDialogEventArgs.commons.execServer = true;
        //SMO Cambio en grupales
        beforeOpenGridDialogEventArgs.commons.execServer = false;
    };

	//Entity: DebtorGeneral
    //DebtorGeneral.TypeDocumentId (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_DOTD256 = function(entities, changedEventArgs) {
         changedEventArgs.commons.execServer = false;
    };

	//Entity: DebtorGeneral
    //DebtorGeneral.Role (ComboBox) View: [object Object]
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_BORRWRVIEW2783_ROLE954 = function( entities, changedEventArgs ) {
        changedEventArgs.commons.execServer = false;
        
    };

	//BorrowerGeneral Entity: DebtorGeneral
    task.executeQuery.Q_BOREGEEL_0798 = function(executeQueryEventArgs){
         executeQueryEventArgs.commons.execServer = false;
        //executeQueryEventArgs.commons.serverParameters.DebtorGeneral = true;
    };

	//gridCommand (Button) QueryView: Borrowers
    //Evento GridCommand: Sirve para personalizar la acción que realizan los botones de Grilla.
	task.gridCommand.CEQV_201_QV_BOREG0798_55_719 = function(entities, gridExecuteCommandEventArgs) { // GridCommand
																										// (Button)
																										// QueryView:
																										// Borrowers
        gridExecuteCommandEventArgs.commons.execServer = false;		
		if(FLCRE.UTILS.CUSTOMER.deleteDebtorGeneral(gridExecuteCommandEventArgs,true)){
			gridExecuteCommandEventArgs.commons.messageHandler.showTranslateMessagesSuccess('BUSIN.DLB_BUSIN_IEJTAITMT_92625');
		}		
    };

	task.gridInitColumnTemplate.QV_BOREG0798_55 = function (idColumn, gridInitColumnTemplateEventArgs) { // QueryView:
																   // Borrowers
        if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
    
        if(idColumn === 'creditBureau'){
          return  "<div class='cb-indicator cb-flex cb-column'>"+
                        "<div ng-switch on='dataItem.riskLevel'>"+
                            "<div ng-switch-when='VERDE' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-good'></div>"+ 
                            "<div ng-switch-when='AMARILLO' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-fair'></div>"+
                            "<div ng-switch-when='ROJO' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-bad'></div>"+
                            "<div ng-switch-default class='text-center'>Error</div>"+
						"</div>"+  
                    "</div>";
        }
    
};

	task.gridInitEditColumnTemplate.QV_BOREG0798_55 = function(idColumn) {
        // if(idColumn === 'NombreColumna'){
        // return "<span></span>";
        // }
    };

	//gridRowDeleting QueryView: Borrowers
        //Se ejecuta antes de que los datos eliminados en una grilla sean comprometidos.
        task.gridRowDeleting.QV_BOREG0798_55 = function (entities,gridRowDeletingEventArgs) {    
			if(entities.OriginalHeader.IDRequested === undefined || entities.OriginalHeader.IDRequested === 0 ){
				gridRowDeletingEventArgs.commons.execServer = true;
			}else{
				gridRowDeletingEventArgs.commons.serverParameters.OriginalHeader = true;
				gridRowDeletingEventArgs.commons.serverParameters.DebtorGeneral = true;
			}            
        };

	//Start signature to Callback event to QV_BOREG0798_55
task.gridRowDeletingCallback.QV_BOREG0798_55 = function(entities, gridRowDeletingCallbackEventArgs) {
//here your code
};

	//gridRowInserting QueryView: Borrowers
//Se ejecuta antes de que los datos insertados en una grilla sean comprometidos.
task.gridRowInserting.QV_BOREG0798_55 = function (entities, gridRowInsertingEventArgs) { // RowInserting
    // QueryView:								// Borrowers
    //SMO no debe lanzar
    gridRowInsertingEventArgs.commons.execServer = false;
    FLCRE.UTILS.CUSTOMER.removeEmptyDebtorByCode(entities, gridRowInsertingEventArgs, 0);
    //task.validateDebtor(entities, gridRowInsertingEventArgs); SMO no existe en grupales

    //Controla que no ingrese un deudor ya existente en la grilla
    if (typeRequest === FLCRE.CONSTANTS.TypeRequest.NORMAL) {
        var count = 0;
        var countDeudores = 0;
        for (var i = 0; i < entities.DebtorGeneral.data().length; i++) {
            var row = entities.DebtorGeneral.data()[i];
            if (row.CustomerCode == gridRowInsertingEventArgs.rowData.CustomerCode) {
                count++;
            }
        }
        if (count >= 2) {
            gridRowInsertingEventArgs.cancel = true;
            gridRowInsertingEventArgs.commons.execServer = false;

            if (!passInitData) {
                gridRowInsertingEventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BOWREDYXT_24458');
                passInitData = false;
            }
        }
    }

};

	//gridRowSelecting QueryView: Borrowers
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
	task.gridRowSelecting.QV_BOREG0798_55 = function(entities, gridRowSelectingEventArgs) { 
        //smo no debe lanzar
            gridRowSelectingEventArgs.commons.execServer = false;
	}

	//gridRowUpdating QueryView: Borrowers
        //Se ejecuta antes de que los datos modificados en una grilla sean comprometidos.
        task.gridRowUpdating.QV_BOREG0798_55 = function (entities, gridRowUpdatingEventArgs) {
            gridRowUpdatingEventArgs.commons.execServer = false;
            //no existe en grupales
            /*if (FLCRE.VARIABLES.Debtor.Role =='D' && gridRowUpdatingEventArgs.rowData.Role == 'C'){
				gridRowUpdatingEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ESNECESLE_92181');
				gridRowUpdatingEventArgs.cancel = true;
            }else{
            	task.validateDebtor(entities, gridRowUpdatingEventArgs);	
            }*/
            
        };

	//Entity: Aval
    //Aval. (Button) View: Aval
    //Evento ExecuteCommand: Permite personalizar la acción a ejecutar de un command o de un ActionControl.
    task.executeCommand.VA_VABUTTONFUIXKXW_718576 = function(  entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = true;
        //executeCommandEventArgs.commons.serverParameters.Aval = true;
        if(entities.OriginalHeader.ProductType === "INDIVIDUAL"){
            if((entities.Aval.idCustomer === undefined) || (entities.Aval.idCustomer === null)){
                executeCommandEventArgs.commons.messageHandler.showMessagesError('BUSIN.MSG_BUSIN_ELAVALEOB_47675');
                executeCommandEventArgs.commons.execServer = false;
                return;
            }
        }
    };

	//Start signature to Callback event to VA_VABUTTONFUIXKXW_718576
task.executeCommandCallback.VA_VABUTTONFUIXKXW_718576 = function(entities, executeCommandCallbackEventArgs) {
    if(executeCommandCallbackEventArgs.success){
		executeCommandCallbackEventArgs.commons.api.viewState.enable('CM_OIIRL51SVE80');
	} else{
		executeCommandCallbackEventArgs.commons.api.viewState.disable('CM_OIIRL51SVE80');
	}
};

	//Entity: Aval
    //Aval.customerName (TextInputButton) View: Aval
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXGRN_916576 = function( textInputButtonEventGridEventArgs ) {

    textInputButtonEventGridEventArgs.commons.execServer = false;
    
        
    };



}));