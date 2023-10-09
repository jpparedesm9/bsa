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