var BUSIN = {
	API: {
		getApiNavigation : function(PSubModuleId,eventArgs,PTaskId,PViewContainerId){
			var apiNav = eventArgs.commons.api.navigation;
			apiNav.address = {
				moduleId: "BUSIN",
				subModuleId: PSubModuleId,
				taskId: PTaskId,
				taskVersion: "1.0.0",
				viewContainerId: PViewContainerId
			};
			apiNav.queryParameters = { mode: eventArgs.commons.args.mode };
			return apiNav
		},
		getApiNavigationPopover : function(PSubModuleId,eventArgs, width, height, position, ppOvr, taskName,viewName){
			var apiNav = BUSIN.getApiNavigation(PSubModuleId,eventArgs, taskName, viewName);
			apiNav.popoverProperties = {
				width: width,
				height: height,
				position: position
			};
			apiNav.customDialogParameters = { ppOvr : ppOvr };
			return apiNav;
		},
		getNavigationFindCustomer : function(api){
			var nav = api.navigation;
			nav.label = cobis.translate('BUSIN.DLB_BUSIN_CTMESERCH_53064');
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
					 "/customer/controllers/find-customers-ctrl.js"]
			 }];
			return nav;
		},
		getNavigationFindGuarantee : function(api){ //fb
			var nav = api.navigation;
			nav.label = cobis.translate('BUSIN.DLB_BUSIN_GARANTASQ_18496');
			//api.vc.removeChildVc('process');
			nav.customAddress = {
				id: "process",
				url: "businessprocess/busin-tree-process-page.html",
				//url: "businessprocess/templates/busin-tree-process-tpl.html",
				useMinification: false
			};
			nav.modalProperties = {
				size: 'lg'
			};
			nav.scripts = [{
				module: "businessprocess",
				files: ["/businessprocess/services/busin-tree-process-srv.js",
					 "/businessprocess/controllers/busin-tree-process-ctrl.js",
					 "/businessprocess/busin-tree-process.js"]
			 }];
			return nav;
		},
		getNavigationUploadDocument : function(api){ 
			var nav = api.navigation;
			nav.label = "Subir Documento";//cobis.translate('BUSIN.DLB_BUSIN_GARANTASQ_18496');			
			nav.customAddress = {
				id: "uploadFile",				
				//url: "uploaddocument/templates/upload-file-tpl.html",
				url: "uploaddocument/container-upload-file.html",
				useMinification: false
			};
			nav.modalProperties = {
				size: 'lg'
			};
			nav.scripts = [{				
				module: "uploaddocument",
				files: [/*"/../scripts/lib/lodash/lodash.js",
					"/../scripts/lib/sheetjs/xls.js",
					"/../scripts/lib/sheetjs/xlsx.js",
					"/../scripts/lib/sheetjs/xlsx-reader.js",*/
					"/uploaddocument/services/upload-file-srv.js",
					"/uploaddocument/controllers/upload-file-ctrl.js"					 
					 ]
			 }];
			return nav;
		},
		disable : function(viewState,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					viewState.disable(controls[i]);
		},
		enable : function(viewState,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					viewState.enable(controls[i]);
		},
		show : function(viewState,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					viewState.show(controls[i]);
		},
		hide : function(viewState,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					viewState.hide(controls[i]);
		},
		setVisible : function(viewState,condition,controls) {
			if(condition===true)
				BUSIN.API.show(viewState,controls);
			else
				BUSIN.API.hide(viewState,controls);
		},
		setEnabled : function(viewState,condition,controls) {
			if(condition===true)
				BUSIN.API.enable(viewState,controls);
			else
				BUSIN.API.disable(viewState,controls);
		},
		setDisabled : function(viewState,condition,controls) {
			BUSIN.API.setEnabled(viewState,!condition,controls);
		},
		disableCTR : function(api, controls) {
		    if((controls!=null)&&(controls.length>0)) {
				for (var i=0; i < controls.length; i++) {
					$('#'+controls[i]).addClass('Disable_group');
				}
			}
		},
		enableCTR : function(api,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					$('#'+controls[i]).removeClass('Disable_group');
		},
		disableAsync : function(eventArgs,controls,timeoutMili) {
			if((controls!=null)&&(controls.length>0)){
				var viewState = eventArgs.commons.api.viewState;
				eventArgs.commons.api.ext.timeout(function(){
					for (var i=0; i<controls.length; i++)
						viewState.disable(controls[i]);
				},timeoutMili);
			}
		},
		disableAsyncForce : function(eventArgs,controlId,count) {
			var viewState = eventArgs.commons.api.viewState;
			if(BUSIN.VALIDATE.IsNull(count)){count=0;}
			count = count+1;
			eventArgs.commons.api.ext.timeout(function(){
				var isDisable = viewState.isDisabled(controlId);
				viewState.disable(controlId);
				if(count<10 && isDisable==false){
					BUSIN.API.disableAsyncForce(eventArgs,controlId,count);
				}
			},3000);
		},
		enableAsync : function(eventArgs,controls,timeoutMili) {
			if((controls!=null)&&(controls.length>0)){
				var viewState = eventArgs.commons.api.viewState;
				eventArgs.commons.api.ext.timeout(function(){
					for (var i=0; i<controls.length; i++)
						viewState.enable(controls[i]);
				},timeoutMili);
			}
		},
		readOnlyAsync : function(eventArgs,controls,value,timeoutMili) {
			if((controls!=null)&&(controls.length>0)){
				var viewState = eventArgs.commons.api.viewState;
				eventArgs.commons.api.ext.timeout(function(){
					for (var i=0; i<controls.length; i++)
						viewState.readOnly(controls[i],value);
				},timeoutMili);
			}
		},
		validateTypeData : function(type, value) {
			if(type === '0' || type === '1' || type === '2'){
	            var res = value.match(/^([0-9])*$/)
				if(res != null)
					return ''
				else
					return 'BUSIN.DLB_BUSIN_GRAUNLNRO_51408'
			}else if(type === '3'){
				var res = value.match(/^[a-zA-Z]+$/)
				if(res != undefined)
					return ''
				else
					return 'BUSIN.DLB_BUSIN_EBGVOAFBT_97083'
			}else if(type === '4'){
				var res = value.match(/^[a-zA-Z\s0-9]*$/)
				if(res != undefined)
					return ''
				else
					return 'BUSIN.DLB_BUSIN_DLOALNURC_23197'
			}else if(type === '5'){
				var newDate = value;
				if(cobis.userContext.getValue(cobis.constant.DATE_FORMAT) === 'dd/MM/yyyy'){
					var data = value.split("/");
					newDate = data[1] + '/' + data[0] + '/' + data[2]
				}else if (cobis.userContext.getValue(cobis.constant.DATE_FORMAT) === 'MM/dd/yyyy'){
					newDate = value;
				}
				var res = Date.parse(newDate)
				if(!isNaN(res))
					return ''
				else
					return 'BUSIN.DLB_BUSIN_FODFCANIO_16176'
			}else if(type === '6' || type === '7' ){
				var res = parseFloat(value)
				if(!isNaN(res))
					return ''
				else
					return 'BUSIN.DLB_BUSIN_ERERUATNM_40998'
			}
		},
		addStyle : function(style,viewState,controls) {
			if((controls!=null)&&(controls.length>0))
				for (var i=0; i<controls.length; i++)
					viewState.addStyle(controls[i],style);
		},
		GRID: {
			hideFilter : function(idGrid, api){
				api.viewState.addStyle(idGrid, 'Grid_Hide_Filter');
			},
			hideColumns : function(idGrid, columns, api){
				if((columns!=null)&&(columns.length>0))
				for (var i=0; i<columns.length; i++)
					api.grid.hideColumn (idGrid, columns[i]);
			},
			hideCommandColumns : function(idGrid, dsData, api, command){
				for (var i = 0; i < dsData.length; i ++) {
					api.grid.hideGridRowCommand(idGrid, dsData[i], command);
				}
				api.grid.resizeGridColumn(idGrid, command, 10);
			},
			addColumnsStyle : function(idGrid, styleName, api, columns){
				if((columns!=null)&&(columns.length>0))
					for (var i=0; i<columns.length; i++)
						api.grid.addColumnStyle(idGrid, columns[i], styleName);
			},
			disableEnableToolbar: function(eventArgs, entity , idGrid, show, btnAdd){
				var ds = eventArgs.commons.api.vc.model[entity];
				var grid = eventArgs.commons.api.grid;
				var dsData = ds.data();
				if(show){
					for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
					   grid.showGridRowCommand(idGrid, dsRow, 'delete');
					   grid.showGridRowCommand(idGrid, dsRow, 'edit');

					}
					grid.showToolBarButton(idGrid, btnAdd)
				}else{
					for (var i = 0; i < dsData.length; i ++) {
						var dsRow = dsData[i];
					   grid.hideGridRowCommand(idGrid, dsRow, 'delete');
					   grid.hideGridRowCommand(idGrid, dsRow, 'edit');
					}
					grid.hideToolBarButton(idGrid, btnAdd);
				}
			}
		},
		GROUP: {
			selectTab : function(idGroup, numTab, api){
				var tab = api.viewState.getKendoContainer(idGroup);
				if (tab !== null) {
					tab.select(numTab);
				}
			}
		},
		
		addTaskHeader : function(taskHeader, title, value, rowNumber) {
			
			rowNumber = rowNumber === undefined ? 0 : rowNumber;
		
			if (title != null && value != null) {
			
				if (title == "title") {
					taskHeader.title = value;
				} else {

					var update = false;
					taskHeader.subtitle = taskHeader.subtitle == null ? [] : taskHeader.subtitle;
					taskHeader.subtitle[rowNumber] = taskHeader.subtitle[rowNumber] == null ? [] : taskHeader.subtitle[rowNumber];
					
					for (var i = 0; i < taskHeader.subtitle.length; i++) {
						if(i == rowNumber) {
							for (var j = 0; j < taskHeader.subtitle[i].length; j++) {
								if(taskHeader.subtitle[i][j].title == title){
								   taskHeader.subtitle[i][j].value = value;
								   update = true;
								   break;
								}
							}
							if(!update){
								taskHeader.subtitle[i].push({title: title, value : value });
							}
							break;
						}
					}				

				}
			}
		},
		
		updateTaskHeader : function(taskHeader, eventArgs, groupViewHeader) {
			eventArgs.commons.api.vc.removeChildVc('taskHeader');
			
			var nav = eventArgs.commons.api.navigation;
				
			nav.customAddress = {
				id : 'taskHeader',
				url : 'inbox/templates/header-task.html',
				useMinification: false
			};

			nav.scripts = [ {
				module : cobis.modules.INBOX,
				files : [ '/inbox/controllers/header-task-ctrl.js']
			} ];

			nav.customDialogParameters = {
				taskHeader : taskHeader
			};
				
			nav.registerCustomView(groupViewHeader);
		},
		setDecimalFormat : function(decimal){
			
			if(!angular.isUndefined(decimal) && decimal!=null){
				var decimalFormat = "n"+cobis.userContext.getValue(cobis.constant.CURRENCY_DECIMAL_PLACES);						
				return kendo.toString(decimal,decimalFormat);
			}
			return decimal;
		},
        checker: function (entities, gridExecuteCommandEventArgs) {
            var check = true;
            if(entities.DocumentProduct.data().length != 0){
                for(var i=0 ; i <= entities.DocumentProduct.data().length -1 ; i++ ){
                    if(entities.DocumentProduct.data()[i].YesNot === false){
                        check = true;
                        break;
                    } else {
                        check = false;
                    }
                }
            }
            if(entities.DocumentProduct.data().length != 0){
                for(var i=0 ; i <= entities.DocumentProduct.data().length -1 ; i++ ){
                    gridExecuteCommandEventArgs.rowData = entities.DocumentProduct.data()[i];
                    if(check === true){
                        gridExecuteCommandEventArgs.commons.api.grid.updateRowData(gridExecuteCommandEventArgs.rowData, 'YesNot', 'true');
                        /* Ocultar botones */
                        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_143');
                        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_659');
                    } else if(check === false){
                        gridExecuteCommandEventArgs.commons.api.grid.updateRowData(gridExecuteCommandEventArgs.rowData, 'YesNot', 'false');
                        /* Ocultar botones */
                        gridExecuteCommandEventArgs.commons.api.grid.hideToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_659');
                        gridExecuteCommandEventArgs.commons.api.grid.showToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_143');
                    }
                }
            }
        },
        changeImageChecker: function (entities, args) {
            var check = true;
            if(entities.DocumentProduct.data().length != 0){
                for(var i=0 ; i <= entities.DocumentProduct.data().length -1 ; i++ ){
                    if(entities.DocumentProduct.data()[i].YesNot === false){
                        check = true;
                        break;
                    } else {
                        check = false;
                    }
                }
            }
            if(check === true){
                args.commons.api.grid.hideToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_659');
                args.commons.api.grid.showToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_143');
            } else if(check === false){
                args.commons.api.grid.hideToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_143');
                args.commons.api.grid.showToolBarButton('QV_QDMNT8051_16','CEQV_201QV_QDMNT8051_16_659');
            }
        }
	},
	INBOX: {
		STATUS: {
			nextStep : function(option,api) {
				if(api.parentApi() != undefined){
					var isCompleted = 'NO';
					if(option) {isCompleted = 'YES';}
					var parentVc = api.parentApi().vc;
					parentVc.model.InboxContainerPage.HiddenInCompleted = isCompleted;
				}
			},
			openNewTab : function(instProcCode,menu){
				//var url = "/CTSProxy/services/cobis/web/views/LATFO/INBOX/T_INBOX_38_KBXNR21/1.0.0/VC_KBXNR21_RMBPE_966_TASK.html?processInstanceIdentifier="+instProcCode;				
				var url = "/CTSProxy/services/cobis/web/views/inbox/inbox-task-container-page.html?processInstanceIdentifier="+instProcCode;//se modifica para la llamada a la solicitud de castigo, cargaba una tarea anterior, aparentemente no usada
				cobis.container.tabs.openNewTab(menu, url, menu, true);
			},
			openNewTabGen : function(menu,url){				
				cobis.container.tabs.openNewTab(menu, url, menu, true);
			},
		},
		addTaskHeader : function(taskHeader, title, value, rowNumber) {
			
			rowNumber = rowNumber === undefined ? 0 : rowNumber;
		
			if (title != null && value != null) {
			
				if (title == "title") {
					taskHeader.title = BUSIN.CONVERT.getCapitalizeCase(value);
				} else {

					var update = false;
					taskHeader.subtitle = taskHeader.subtitle == null ? [] : taskHeader.subtitle;
					taskHeader.subtitle[rowNumber] = taskHeader.subtitle[rowNumber] == null ? [] : taskHeader.subtitle[rowNumber];
					
					for (var i = 0; i < taskHeader.subtitle.length; i++) {
						if(i == rowNumber) {
							for (var j = 0; j < taskHeader.subtitle[i].length; j++) {
								if(taskHeader.subtitle[i][j].title == title){
								   taskHeader.subtitle[i][j].value = value;
								   update = true;
								   break;
								}
							}
							if(!update){
								taskHeader.subtitle[i].push({title: title, value : value });
							}
							break;
						}
					}				

				}
			}
		},
		
		updateTaskHeader : function(taskHeader, eventArgs, groupViewHeader) {
			eventArgs.commons.api.vc.removeChildVc('taskHeader');
			
			var nav = eventArgs.commons.api.navigation;
				
			nav.customAddress = {
				id : 'taskHeader',
				url : 'inbox/templates/header-task.html',
				useMinification: false
			};

			nav.scripts = [ {
				module : cobis.modules.INBOX,
				files : [ '/inbox/controllers/header-task-ctrl.js']
			} ];

			nav.customDialogParameters = {
				taskHeader : taskHeader
			};
				
			nav.registerCustomView(groupViewHeader);
		},
	},
	REPORT: {
		Open : function(name, reportArgs){
			//Arma la URL
			if(name === 'reportingService')
				var url = BUSIN.SYSTEM.getIpServer() + '/CTSProxy/services/cobis/web/reporting/actions/' + name + '?';
			else
			    var url = BUSIN.SYSTEM.getIpServer() + '/CTSProxy/services/cobis/web/reports/' + name + '?';

			//Concatena los parametos
			if((reportArgs!=null)&&(reportArgs.length>0))
				for (var i=0; i<reportArgs.length; i++)
					url = url + reportArgs[i][0] + '=' + reportArgs[i][1] + '&'
			//Codifica la URL
			url = encodeURI(url);
			//Opciones de abrir ventana
			var params = ['height='+screen.height, 'width='+screen.width,'fullscreen=yes'].join(',');
			//Abre ventana del reporte
			var popup = window.open(url + '&flag=' + Math.random(), 'popup_window_' + name, params);
			popup.moveTo(0,0);
		},
         Char_convert:function(original){
				  var chars = ["\u00e1","\u00e0","\u00e9","\u00e8","\u00ed","\u00ec","\u00f3","\u00f2","\u00fa","\u00f9","\u00c1","\u00c0","\u00c9","\u00c8","\u00cd","\u00cc","\u00d3","\u00d2","\u00da","\u00d9","\u00f1","\u00d1"]; 
    			  var codes = ["%e1","%e1","%e9","%e9","%ed","%ed","%f3","%f3","%fa","%fa","%c1","%c1","%c9","%c9","%cd","%cd","%d3","%d3","%da","%da","%f1","%d1"];
    			if(original !== null && original !== undefined && original.constructor === String){
					for(var i=0; i<chars.length; i++){
						original = original.replace(chars[i], codes[i]);
					}
				}
				return original;
		},
        GenerarReporte : function(reporte, argumentos, title){
			var Crue = '?myValue=' + Math.random() + '&';
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_'+reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate
		
            formaMapeo.action = "${contextPath}/cobis/web/reporting/actions/reportingService" + Crue;
		    var param = "";
            for (var i=0; i < argumentos.length; i++) {
				param = param + argumentos[i][0] + '=' + BUSIN.REPORT.Char_convert(argumentos[i][1]) + '&'
            }
			param =  param.substr(0, param.length-1);
            var url =  formaMapeo.action + param
			if (BUSIN.VALIDATE.IsNullOrEmpty(title)) {title='COMMONS.MENU.TIT_PRINT_REPORT';}
			cobis.container.tabs.openNewTab('ctsConsole', url ,title, true);
		}
	},
	SYSTEM: {
		getIpServer : function() {return location.origin;},
		getParameterByName : function (name) {
			name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
			var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
			results = regex.exec(location.search);
			return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
		},
		importScript : function (fileName) {
			var oHead = document.getElementsByTagName('head')[0];
			var oScript = document.createElement('script');
			oScript.type = 'text/javascript';
			oScript.charset = 'utf-8';
			oScript.src = '${contextPath}/cobis/web/views/BUSIN/assets/scripts/'+fileName;
			oHead.appendChild(oScript);
		}
	},
	CONVERT: {
		DATE : {
			FromStringMDY : function (strignValue) {
				return new Date(strignValue.substring(6,10),strignValue.substring(0,2)-1,strignValue.substring(3,5));
			}			
		},
		NUMBER:{
			Format:function (stringValue,stringAdd,finalLength){			
				for(i=stringValue.toString().length;i<parseInt(finalLength);i++){
					stringValue=stringAdd+stringValue;
				}
				return stringValue;
			}
		},
		CURRENCY:{
			Format:function(stringValue,intPrecision){
				return stringValue.toFixed(parseInt(intPrecision)).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
			}
		},
		getCapitalizeCase : function (string){
			return string.replace(/\w\S*/g, function(tStr){
				return tStr.charAt(0).toUpperCase() + tStr.substr(1).toLowerCase();
			});
		}
	},
	VALIDATE: {
		IsNull : function (parValue) {
			return (parValue===null || parValue===undefined);
		},
		IsNullOrEmpty : function (parValue) {
			return (BUSIN.VALIDATE.IsNull(parValue) || parValue==='');
		},
		IsGreaterThanZero : function(value, args, execServer, showMessage) {
			if(execServer===true  || execServer=== false ){args.commons.execServer = execServer;}
			if(BUSIN.VALIDATE.IsNull(value) || (value<=0)){
				if(showMessage===true){args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_IPAESOZEO_95873');}
				return false;
			}
			return true;
		},
		IsGreaterOrEqualThanZero : function(value, args, execServer, showMessage) {
			if(execServer===true  || execServer=== false ){args.commons.execServer = execServer;}
			if(BUSIN.VALIDATE.IsNull(value) || (value<0)){
				if(showMessage===true){args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LAIGDNRUO_68962');}
				return false;
			}
			return true;
		},
		EmptyFieldValue : function(value,fieldLabel,args,execServer){
			if(BUSIN.VALIDATE.IsNullOrEmpty(value)){
				var fielName = cobis.translate(fieldLabel);
				args.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_DEBEESTAR_51364',[fielName],10000,false);
				if( (execServer===true) && !BUSIN.VALIDATE.IsNull(args) ){
					args.commons.execServer = false;
				}
				return false;
			}
			return true;
		}
	},
	SHAREDDATA:{
		getKeySession : function(args){
			//se concatena un keySession
			var dato=cobis.userContext.getValue(cobis.constant.USER_NAME)+
			cobis.userContext.getValue(cobis.constant.USER_ROLE).code+
			"T"+cobis.container.tabs.getCurrentTabIndex()+
			args.commons.api.vc.taskId;
			return dato;
		}		
	}	
};
var FLCRE = {
	CONSTANTS: {
        Report : { Infocred:'CentralRiesgo', LoanApplication:'SolicitudCredito', ReportinService: 'reportingService', RecomendacionAgencia: 'recomendacionJefeAgencia', Affidavit: 'DeclaracionJuramentada', RequestMoratorium: 'solicitudMoratoria', TicketApplication:'solicitudBoletasGarantia' ,
                   TicketApplicationContract:'ContratoGarantia', ReportPunishmentRequest:'solicitudInformeCastigo', AffidavitPunishment: 'declaracionJuramentadaCastigo',ReportRequestPunishment:'informeSolicitudCastigo', ReportResponseLetter:'respuesta',
				   PunishmentList:'ReportCastigo'},
        Tramite : { Original:'O', Linea:'L', Expromision:'R', Refinanciamiento: 'R', DesembolsoBajoLinea: 'O', Reprogramacion:'E', ModificacionLinea:'P', Moratoria:'M', Castigo:'C' , WarrantyModify:'G'},
        Stage : {Analisis :'ANALISIS', Entry:'INGRESO', Exception:'EXCEPTION', VerificationDocuments : 'VERIFICATION_DOCUMENTS', LegalApproval: 'LEGAL_APPROVAL' , Recalculation: 'RECALCULO', PaymentPlan: 'PLANPAGO',   RevisedRecommendation: 'REVISION_RECOMENDACION',
                 Aprobacion:'APROBACION',AnalisisLegal:'ANALISIS_LEGAL',AsociacionGarantias:'ASOCIACION_GARANTIAS',Gravamen:'GRAVAMEN',Ejecucion:'EJECUCION',Desembolso:'DESEMBOLSO',AnalisisOficial: 'ANALISIS_OFICIAL',AsignacionOficial: 'ASIGNACION_OFICIAL',
                 IngresoDeDatos:'INGRESO_DATOS', ImpresionDocumentos:'IMPRESION_DOCUMENTOS', ConstanciaDeGravamen: 'CONSTANCIA_GRAVAMEN', ValidaRequisitos:'VALIDAR_REQUISITOS',
                 Rejection:'REJECTION',AltaCSGravamen:'ALTA_C/S_GRAVAMEN', QuotaVsBalanceAvailable:'CUOTA_SALDO_DISPONIBLE',Massive:'MASSIVE'},
		RequestName : {Expromission:'EXPROMISION', Refinancing:'REFINANCING', Reprogramming:'REPROGRAMMING', Moratorium:'MORATORIUM' ,Original:'ORIGINAL',Vivienda:'VIVIENDA',Castigo:'CASTIGO',
		               Desembolso:'DESEMBOLSO_LC', Bonus:'BONUS', ModificacionLCPlazo: 'MODLCPLAZO', ModificacionLCMontoPlazo: 'MODLC_MONTO_PLAZO', WarrantyModify:'WARRANTYMODIFY', GuaranteesTicket:'GUARANTEESTICKET',
					   Line:'LINE',Renovation:'RENOVATION',Reestructuration:"REESTRUCTURATION"},
		Product : {ViviendaSocial:'V'},
		OfficerType : {ChiefAgency:'JA', RegionalSubManager:'SR', RegionalManager:'GR', CreditAnalyst:'AC', Inbox:'IN'},
		StatusPenalization : {Processed:'P', Entered:'I', Unassigned:'X'},
		ScoreType : {BusinessManual:'MEM'},
		Mode:{Editable:'E',Query:'Q',NoHeader:'NH'},        
		TypeRequest: { GRUPAL: 'GRUPAL', INTERCICLO: 'INTERCICLO', NORMAL:'NORMAL', REVOLVENTE:'LCR', COLECTIVOS:'COLECTIVOS'},
      TypeWarranty: { Supported: 'A', Owner: 'J'},
	},
	VARIABLES: {
        Debtor : { Role:''}
	},
	API: {
		getApiNavigation : function(eventArgs,PTaskId,PViewContainerId){
			return BUSIN.API.getApiNavigation('FLCRE',eventArgs,PTaskId,PViewContainerId);
		},
		getApiNavigationPopover : function(eventArgs, width, height, position, ppOvr){
			return BUSIN.API.getApiNavigationPopover('FLCRE',eventArgs,width,height,position,ppOvr,'T_FLCRE_XX_XXXXXXX', 'VC_XXXXXXX_XXXXX_XXX');
		}
	},
	UTILS: {
      validate_fechaMayorQue: function (fechaInicial,fechaFinal)
        {
            var valuesStart=fechaInicial.split("/");
            var valuesEnd=fechaFinal.split("/");
 
            // Verificamos que la fecha no sea posterior a la actual
            var dateStart=new Date(valuesStart[2],(valuesStart[1]-1),valuesStart[0]);
            var dateEnd=new Date(valuesEnd[2],(valuesEnd[1]-1),valuesEnd[0]);
            if(dateStart>=dateEnd)
            {
                return 0;
            }
            return 1;
        },
        
      clearDateField: function (id) {
         idVisualAttribute = "#" + id;
         $(idVisualAttribute).data("kendoDatePicker").element[0].value=null
      },      
      clearNumericField: function (id) {
         idVisualAttribute = "#" + id;
         $(idVisualAttribute).data("kendoNumericTextBox").element[0].value=0
      },      
      getQueryStrings : function() {
            var queryDict = {};
            location.search.substr(1).split("&").forEach(function(item) {
                queryDict[item.split("=")[0]] = item.split("=")[1];
            });
            return queryDict;
        },
        
		APPLICATION: {
			isDisbursement : function(api){
				var client = api.parentVc.model.Task;
				return (client.bussinessInformationStringOne != null && typeof client.bussinessInformationStringOne !== 'undefined' &&
						client.bussinessInformationStringOne !== ''  && client.bussinessInformationStringOne !== '0' && client.bussinessInformationStringOne.trim() !== '' );
			},
			setStage : function(entities, args) {
				if( !BUSIN.VALIDATE.IsNull(entities.Context) ){
					entities.Context.TaskSubject = null;
					var parentParameters = args.commons.api.parentVc.customDialogParameters;
					if( !BUSIN.VALIDATE.IsNull(parentParameters) && !BUSIN.VALIDATE.IsNull(parentParameters.Task) ){
						if( !BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.taskSubject) &&  !BUSIN.VALIDATE.IsNullOrEmpty(parentParameters.Task.processInstanceIdentifier)){
							entities.Context.Application = parentParameters.Task.processInstanceIdentifier;
							entities.Context.TaskSubject = parentParameters.Task.taskSubject;
						}
					}
				}
			},
			setContext : function(entities, args, errorContext, stopExecServer) {
				if( !BUSIN.VALIDATE.IsNull(entities.Context) ){
					var parentParameters = args.commons.api.parentVc.customDialogParameters;
					if( !BUSIN.VALIDATE.IsNull(parentParameters) && !BUSIN.VALIDATE.IsNull(parentParameters.Task) ){
						var taskI = parentParameters.Task;
						if( !BUSIN.VALIDATE.IsNullOrEmpty(taskI.processInstanceIdentifier) ) { entities.Context.Application = taskI.processInstanceIdentifier; }
						if( !BUSIN.VALIDATE.IsNullOrEmpty(taskI.processSubject) ) { entities.Context.ApplicationSubject = taskI.processSubject; }
						if( !BUSIN.VALIDATE.IsNullOrEmpty(taskI.bussinessInformationIntegerTwo) &&  taskI.bussinessInformationIntegerTwo!=0) { entities.Context.RequestId = taskI.bussinessInformationIntegerTwo; }
						else if(entities.OriginalHeader.IDRequested != undefined && !BUSIN.VALIDATE.IsNullOrEmpty(entities.OriginalHeader.IDRequested)) {
							entities.Context.RequestId =parseInt(entities.OriginalHeader.IDRequested);
						}else{
							entities.Context.RequestId = 0;
						}
						if( !BUSIN.VALIDATE.IsNullOrEmpty(taskI.taskSubject) ) { entities.Context.TaskSubject = taskI.taskSubject; }

						if(!BUSIN.VALIDATE.IsNullOrEmpty(taskI.urlParams.TRAMITE)){ entities.Context.RequestName = taskI.urlParams.TRAMITE;}
						else if(!BUSIN.VALIDATE.IsNullOrEmpty(taskI.urlParams.Tramite)){ entities.Context.RequestName = taskI.urlParams.Tramite;}

						if(!BUSIN.VALIDATE.IsNullOrEmpty(taskI.urlParams.ETAPA)){ entities.Context.RequestStage = taskI.urlParams.ETAPA;}
						else if(!BUSIN.VALIDATE.IsNullOrEmpty(taskI.urlParams.Etapa)){ entities.Context.RequestStage = taskI.urlParams.Etapa;}

						if(!BUSIN.VALIDATE.IsNullOrEmpty(taskI.urlParams.Type)){ entities.Context.RequestType = taskI.urlParams.Type;}
					}
				}else{
					if(errorContext===true){ args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ECOTEXASI_69364'); }
					if(stopExecServer===true){ args.commons.execServer = false;}
				}
			}
		},
		CUSTOMER: {
			getDebtor : function(debtors){
				for (var i = 0; i < debtors.length; i++) {
					if(debtors[i].Role == 'D'){
						return debtors[i];
					}
				}
				return null;
			},
			exists : function(debtors,code){
				for (var i = 0; i < debtors.data().length; i++) {
					if(debtors.data()[i].CustomerCode == code){
						return true;
					}
				}
				return false;
			},
			getDebtorGeneral : function(idClient, name, role, idType, idNumber, calificacion){
				this.CustomerCode = idClient;
				this.CustomerName = name;
				this.Role = role;
				this.TypeDocumentId = idType;
				this.Identification = idNumber;
				this.Qualification = calificacion;
				this.DateCIC = null;
			},
			deleteDebtorGeneral : function(eventArgs, validateType){
				var selectedRow = eventArgs.commons.api.grid.getSelectedRows('QV_BOREG0798_55');
				if( !BUSIN.VALIDATE.IsNull(selectedRow) && selectedRow.length>0 ){
					if(BUSIN.VALIDATE.IsNull(selectedRow[0].dsgnrId)){
						selectedRow[0].dsgnrId = selectedRow[0].uid;
					}
					if(BUSIN.VALIDATE.IsNull(validateType) || validateType===true){
						if(selectedRow[0].Role === 'D'){
							eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_EOECIPLOR_93728',null,5000);
						} else{
							eventArgs.commons.api.grid.removeRowByDsgnrId('DebtorGeneral',selectedRow[0]);
							return true;
						}
					} else{
						eventArgs.commons.api.grid.removeRowByDsgnrId('DebtorGeneral',selectedRow[0]);
						return true;
					}
				} else {
					eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
				}
				return false;
			},
			
			deleteCustomerGeneral : function(eventArgs, validateType){
				var selectedRow = eventArgs.commons.api.grid.getSelectedRows('QV_QRYLI5474_83');
				if( !BUSIN.VALIDATE.IsNull(selectedRow) && selectedRow.length>0 ){
					if(BUSIN.VALIDATE.IsNull(selectedRow[0].dsgnrId)){
						selectedRow[0].dsgnrId = selectedRow[0].uid;
					}
					if(BUSIN.VALIDATE.IsNull(validateType) || validateType===true){
						eventArgs.commons.api.grid.removeRowByDsgnrId('CustomerSearch',selectedRow[0]);
						return true;
					}
				} else {
					eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_ELCNEUNAR_05370',null,5000);
				}
				return false;
			},
			
			deleteCoDebtor : function(DebtorGeneral, args){				
				for (var i = 0; i < DebtorGeneral.data().length; i++) {
					if(DebtorGeneral.data()[i].Role === 'C'){
						args.commons.api.grid.removeRow('DebtorGeneral', i);
						i=0;
					}
			    }
			},
			deleteCoDebtorSourceRevenue : function(DebtorGeneral, SourceRevenueCustomer, args){				
				for (var i = 0; i < DebtorGeneral.data().length; i++) {
					if(DebtorGeneral.data()[i].Role === 'C'){
						for (var j = 0; j < SourceRevenueCustomer.data().length; j++) {
							if(DebtorGeneral.data()[i].CustomerCode === SourceRevenueCustomer.data()[j].IdClient){
								args.commons.api.grid.removeRow('SourceRevenueCustomer', j);
								j=0;
							}
						}
					}
			    }
			},
			
			openFindCustomer : function(entities,eventArgs,params,deleteNewRow){
				var grid = eventArgs.commons.api.grid;
				if(entities.DebtorGeneral){
					grid.disabledColumn('QV_BOREG0798_55', 'CustomerCode');
					grid.disabledColumn('QV_BOREG0798_55', 'CustomerName');			
					grid.disabledColumn('QV_BOREG0798_55', 'TypeDocumentId');
					grid.disabledColumn('QV_BOREG0798_55', 'Identification');
				}
				
				var nav = BUSIN.API.getNavigationFindCustomer(eventArgs.commons.api);
				nav.customDialogParameters = params;
				nav.openCustomModalWindow(eventArgs.commons.controlId, null);
				//BORRA FILA QUE SE GENERA VISUALMENTE
				if(deleteNewRow===undefined || deleteNewRow===null || deleteNewRow===true){
					FLCRE.UTILS.CUSTOMER.removeEmptyDebtorByCode(entities,eventArgs,0);
				}
			},
			
			openFindGuarantor : function(eventArgs,params){	
				var nav = BUSIN.API.getNavigationFindCustomer(eventArgs.commons.api);
				nav.customDialogParameters = params;				
			},
			addDebtorFromSearch : function(args,role,addHasNew){
				var resp = args.commons.api.vc.dialogParameters;
				if(!FLCRE.UTILS.CUSTOMER.exists(args.model.DebtorGeneral,resp.CodeReceive)) {
					if(BUSIN.VALIDATE.IsNull(addHasNew) || addHasNew===true){
						var cust = new FLCRE.UTILS.CUSTOMER.getDebtorGeneral(resp.CodeReceive,'', role, resp.documentType, resp.documentId, resp.califCartera);
						if(resp.commercialName !== ''){ cust.CustomerName = resp.commercialName; }
						else{ cust.CustomerName = resp.name; }
						args.commons.api.grid.addRow('DebtorGeneral', cust, false);
					} else{
						var row = args.model.DebtorGeneral.data()[0];
						row.set('CustomerCode',  resp.CodeReceive);
						row.set('Role',  role);
						row.set('TypeDocumentId', resp.documentType);
						row.set('Identification', resp.documentId);
						row.set('Qualification', resp.califCartera);
						if(resp.commercialName !== ''){ row.set('CustomerName',  resp.commercialName); }
						else{ row.set('CustomerName',  resp.name); }
					}
				} else {
					args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_BOWREDYXT_24458');
					//BORRA FILA QUE SE GENERA VISUALMENTE
					FLCRE.UTILS.CUSTOMER.removeEmptyDebtorByCode(args.model,args,0);
				}
			},
			removeEmptyDebtorByCode : function(entities,args,code){
				var stringCode = '' + code + '';
				var debtors = entities.DebtorGeneral.data();
					for (var i = 0; i < debtors.length; i++) {
						if(debtors[i].CustomerCode === stringCode || debtors[i].CustomerCode === code){
							args.commons.api.grid.removeRow('DebtorGeneral', i);
						}
				}
			},
			removeEmptyCustomerByCode : function(entities,args,code){
				var stringCode = '' + code + '';
				var customer = entities.CustomerSearch.data();				
					for (var i = 0; i < customer.length; i++) {
						if(customer[i].CustomerId === stringCode || customer[i].CustomerId === code){
							args.commons.api.grid.removeRow('CustomerSearch', i);
						}
				}
			},
			removeDuplicateCustomerByCode : function(entities,args,code,warrantyType){
				var countDuplicate = 0;
            var countType = 0;
				var customer = entities.CustomerSearch.data();				
					for (var i = 0; i < customer.length; i++) {
						if((parseInt(customer[i].CustomerId)  === parseInt(code))){
							countDuplicate+= 1;
						}
                  if (customer[i].warrantyType === warrantyType){
                     countType += 1;
					}
					}
					if(countDuplicate > 1 || countType > 1){
						args.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_DUPLITIEN_05472');
                  args.cancel = true
                  if (countDuplicate > 1){
						args.commons.api.grid.removeRow('CustomerSearch', 0);
					}
						
					}
               
               for (var i = 1; i < customer.length; i++) {
                  if ( customer.length > 1 && (customer[i].warrantyType  == 'C' && warrantyType =='C')){
                     args.commons.messageHandler.showTranslateMessagesError('Ya ha sido asignado el CONSTITUYENTE O PROPIETARIO');
                     args.cancel = true
                     return
                  }
                  if ( customer.length > 1 && (customer[i].warrantyType  == 'J' && warrantyType =='J')){
                     args.commons.messageHandler.showTranslateMessagesError('Usted ya ha ingresado un cliente tipo PROPIETARIO/AMPARADO como primer cliente de la Garantía');
                     args.cancel = true
                     return
                  }
                  if ( customer.length > 1 && ((customer[i].warrantyType  == 'C' && warrantyType =='J') || (customer[i].warrantyType  == 'J' && warrantyType =='C'))){
                     args.commons.messageHandler.showTranslateMessagesError('Usted ya ha ingresado un cliente tipo PROPIETARIO/AMPARADO como primer cliente de la Garantía');
                     args.cancel = true
                     return
                  }
               }
               
			},
			hasDebtors : function(entities, eventArgs, showMessage) { //VALIDA SI TIENE DEUDORES
				var debtors = entities.DebtorGeneral.data();
				if(debtors!=null && debtors.length>0){
					return true;
				} else if(showMessage===true) {
					eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_PNOTSBORW_04809',null,6000);
				}
				return false;
			},
			hasOnlyOneDebtor : function(entities, eventArgs, showMessage) { //VALIDA SI TIENE UN SOLO DEUDOR PRINCIPAL
				var debtors = entities.DebtorGeneral.data();
				var count = 0;
				if(debtors!=null && debtors.length>0){
					for (var i = 0; i < debtors.length; i++) {
						if(debtors[i].Role == 'D'){
								count = count + 1;
						}
					}
				}
				if(count!=1 && showMessage===true){
					eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LLUOUNUCO_20908',null,6000);
				}
				return (count===1);
			},
			hasDateCIC : function(entities, eventArgs, showMessage) { //VALIDA SI TIENE FECHA
				var debtors = entities.DebtorGeneral.data();
				if(debtors!=null && debtors.length>0){
					for (var i = 0; i < debtors.length; i++) {
						if(BUSIN.VALIDATE.IsNullOrEmpty(debtors[i].DateCIC)){
							if(showMessage===true) {
								eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LAHDROTCA_53471',null,6000);
							}
							return false;
						}
					}
				}
				return true;
			},
			getTemplateForDateCIC : function() { //OBTINE EL TEMPLATE PARA LA FECHA CIC EN EL GRID DE - Secci�n de Deudores
				var formatDate = cobis.userContext.getValue(cobis.constant.DATE_FORMAT);
				var placeholder = cobis.userContext.getValue(cobis.constant.DATE_FORMAT_PLACEHOLDER);
				var template = "<input id=\'VA_BORRWRVIEW2783_DTCC540_#=CustomerCode#\' kendo-ext-date-picker k-format=\'" + formatDate + "\' placeholder=\'" + placeholder  + "\' ";
				template = template + " ng-init=\"vc.auxDate_#=CustomerCode#='#=((DateCIC !== null) ? kendo.toString(DateCIC, '" +formatDate +"') : '')#\'\"";
				template = template + " ng-model=\'vc.auxDate_#=CustomerCode#\'" ;
				template = template + " data-bind=\"value:DateCIC\" ";
				template = template + " k-on-change=\"vc.change(kendoEvent,\'VA_BORRWRVIEW2783_DTCC540\',this.dataItem,\'DateCIC\')\" ";
				template = template + " ng-focus=\"vc.events.focus($event,\'VA_BORRWRVIEW2783_DTCC540\',this.dataItem,\'DateCIC\')\"  ";
				template = template + " name=\'DateCIC\'  >";
				return template;
			},
			setDateCIC : function(changedEventArgs) { //SETEA LA FECHA CIC DEL GRID DE - Secci�n de Deudores
				var ctr = $('#VA_BORRWRVIEW2783_DTCC540_' + changedEventArgs.rowData.CustomerCode);
				var formatDate = cobis.userContext.getValue(cobis.constant.DATE_FORMAT);
				var date = kendo.parseDate(ctr[0].value, formatDate );
				changedEventArgs.rowData.DateCIC = date;
			},
			openFindLoan : function(eventArgs,params,option){
				var grid = eventArgs.commons.api.grid;
				var nav = FLCRE.API.getApiNavigation(eventArgs,'T_FLCRE_00_CCOVI89','VC_CCOVI89_AECIT_172');
				nav.queryParameters = { mode: eventArgs.commons.args.mode };
				nav.queryParameters = params;
				nav.modalProperties = { size: 'lg' };
				nav.label = cobis.translate('BUSIN.DLB_BUSIN_DAATACNIA_90398');
			}
		},
		INFOCRED: {
			openReentryWindowFull : function(args,similarList,source,role,requestIdLoanId,customerId){
				var nav = FLCRE.API.getApiNavigation(args,'T_FLCRE_18_FOTYI44','VC_FOTYI44_RTTYV_089');
				nav.label = cobis.translate('BUSIN.DLB_BUSIN_PTEIOCRED_97562');
				nav.modalProperties = { size: 'sm' };
				nav.customDialogParameters = {SimilarList:similarList, Source:source, Role:role, RequestIdLoanId:requestIdLoanId, CustomerId:customerId};
				nav.openModalWindow(args.commons.controlId);
			},
			openReentryWindowDebtor : function(InfocredHeader,args){
				if(args.success===false && InfocredHeader.Out_HasManySimilar===true){
					var nav = FLCRE.API.getApiNavigation(args,'T_FLCRE_18_FOTYI44','VC_FOTYI44_RTTYV_089');
					nav.label = cobis.translate('BUSIN.DLB_BUSIN_PTEIOCRED_97562');
					nav.modalProperties = { size: 'sm' };
					nav.customDialogParameters = {SimilarList:InfocredHeader.Out_SimilarList, Source:'T', Role:InfocredHeader.Role, RequestIdLoanId:InfocredHeader.NewRequestId, CustomerId:InfocredHeader.CustomerId};
					nav.openModalWindow(args.commons.controlId);
				}
			},
			getReportByCustomer : function(args){
				var rows = args.commons.api.grid.getSelectedRows('QV_BOREG0798_55'); //'DebtorGeneral'
				if( !BUSIN.VALIDATE.IsNull(rows) && rows.length>0){
					var params = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstCode',rows[0].CustomerCode],['cstOption','1']];
					BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.Infocred,params,'MNU_REQUEST_INFOCRED');
				}else{
					args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612',null,5000);
				}
			},
			getReportById : function(args,idCode){
				var params = [['report.module','credito'],['report.name',FLCRE.CONSTANTS.Report.LoanApplication],['cstCode',idCode],['cstOption','2']];
				BUSIN.REPORT.GenerarReporte(FLCRE.CONSTANTS.Report.Infocred,params,'MNU_REQUEST_INFOCRED');
			},
			getDataForProcess : function(InfocredHeader,requestId,args){
				if(BUSIN.VALIDATE.IsNull(requestId) || requestId<=0){
					args.commons.execServer = false;
					args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_NMRREEUID_75532',null,5000);
					return;
				}
				var rows = args.commons.api.grid.getSelectedRows('QV_BOREG0798_55'); //'DebtorGeneral'
				if( !BUSIN.VALIDATE.IsNull(rows) && rows.length>0){
					InfocredHeader.CustomerId = rows[0].CustomerCode;
					InfocredHeader.Role = rows[0].Role;
					InfocredHeader.NewRequestId	= requestId;
				}else{
					args.commons.execServer = false;
					args.commons.messageHandler.showMessagesError('BUSIN.DLB_BUSIN_OSEEOULIN_28612',null,5000);
				}
			}
		},
		GUARANTEE: {
			hasDateCIC : function(entities, eventArgs, showMessage) { //VALIDA SI TIENE FECHA
				var guarantees = entities.PersonalGuarantor.data();
				if(guarantees!=null && guarantees.length>0){
					for (var i = 0; i < guarantees.length; i++) {
						if(BUSIN.VALIDATE.IsNullOrEmpty(guarantees[i].DateCIC)){
							if(showMessage===true) {
								eventArgs.commons.messageHandler.showTranslateMessagesError('BUSIN.DLB_BUSIN_LAHDROTCA_53471',null,6000);
							}
							return false;
						}
					}
				}
				return true;
			},
			openFindGuarantee : function(entities,eventArgs,params){
				eventArgs.commons.api.vc.closeDialog("VC_RRCAI67_WACRI_884");
				var nav = BUSIN.API.getNavigationFindGuarantee(eventArgs.commons.api);
				nav.customDialogParameters = params;
				nav.openCustomModalWindow(eventArgs.commons.controlId, null);
			},
			getTemplateForDateCIC : function() { //OBTINE EL TEMPLATE PARA LA FECHA CIC EN EL GRID DE - Garant�a Personal
				var formatDate = cobis.userContext.getValue(cobis.constant.DATE_FORMAT);
				var placeholder = cobis.userContext.getValue(cobis.constant.DATE_FORMAT_PLACEHOLDER);
				var template = "<input id=\'VA_PRSAUARNTE3588_DATE142_#=CodeWarranty#\' kendo-ext-date-picker k-format=\'" + formatDate + "\' placeholder=\'" + placeholder  + "\' ";
				template = template + " ng-init=\"vc.auxDateG_#=CodeWarranty#='#=((DateCIC !== null) ? kendo.toString(DateCIC, '" +formatDate +"') : '')#\'\"";
				template = template + " ng-model=\'vc.auxDateG_#=CodeWarranty#\'" ;
				template = template + " data-bind=\"value:DateCIC\" ";
				template = template + " k-on-change=\"vc.change(kendoEvent,\'VA_PRSAUARNTE3588_DATE142\',this.dataItem,\'DateCIC\')\" ";
				template = template + " ng-focus=\"vc.events.focus($event,\'VA_PRSAUARNTE3588_DATE142\',this.dataItem,\'DateCIC\')\"  ";
				template = template + " name=\'DateCIC\'  >";
				return template;
			},
			setDateCIC : function(changedEventArgs) { //SETEA LA FECHA CIC DEL GRID DE - Garant�a Personal
				var ctr = $('#VA_PRSAUARNTE3588_DATE142_' + changedEventArgs.rowData.CodeWarranty);
				var formatDate = cobis.userContext.getValue(cobis.constant.DATE_FORMAT);
				var date = kendo.parseDate(ctr[0].value, formatDate );
				changedEventArgs.rowData.DateCIC = date;
			},
			addFromSearch: function(eventArgs){
				var parameter = eventArgs.result.parameterGuarantee;
				if(parameter.UserCreation != eventArgs.commons.args.user){
					//mensaje que indica que el usuario de la sesion no ha dado de alta la garantia que esta asociando
					eventArgs.commons.messageHandler.showTranslateMessagesInfo('BUSIN.DLB_BUSIN_USENEATAA_82909');
				}
				if(parameter.IsPersonal === 'S'){
					var newPersonalGuarantor={
					  CodeWarranty: parameter.GuaranteeCode,
					  Type: parameter.GuaranteeType,
					  Description: parameter.Description,
					  GuarantorPrimarySecondary: parameter.GuarantorName,
					  ClassOpen: parameter.CloseOpen,
					  IdCustomer:parameter.CustomerId,
					  State: parameter.Status,
					  DateCIC: null,
					  isHeritage:parameter.isHeritage,
					  CurrentValue:null,
					  Currency:null,
					  modifyStatus:"N",//se agrega para la historia de Modificar Garantias
					  bddStatus:"NO"//se agrega para la historia de Modificar Garantias
					};
					eventArgs.commons.api.grid.addRow('PersonalGuarantor', newPersonalGuarantor);
				}else{
					var newOtherWarranty={
					  CodeWarranty: parameter.GuaranteeCode,
					  Type: parameter.GuaranteeType,
					  Description: parameter.Description,
					  InitialValue: parameter.InitialValue,
					  DateAppraisedValue: parameter.AppraisedValueDate,
					  ValueApportionment: 0, //error: requiere un valor
					  ClassOpen: parameter.CloseOpen,
					  ValueAvailable: parameter.ValueAvailable,
					  IdCustomer:parameter.CustomerId,
					  NameGar: parameter.GuarantorName,
					  State: parameter.Status,
					  ValueVNR: 0, //error: requiere un valor
					  RelationshipGuarantees: 0, //error: requiere un valor
					  isHeritage:parameter.isHeritage,
					  modifyStatus:"N",//se agrega para la historia de Modificar Garantias
					  bddStatus:"NO"//se agrega para la historia de Modificar Garantias
					};
					eventArgs.commons.api.grid.addRow('OtherWarranty', newOtherWarranty);
				}
			}
		}
	},
};

document.write('<script src="${contextPath}/cobis/web/scripts/commons/GENERIC_BSA/generic_bsa.js"></script>');
