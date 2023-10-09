(function () {
    'use strict';
//    cobis.log.debugEnabled = true;
        var app = cobis.createModule("assetsUpload", [cobis.modules.CONTAINER]);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });


    app.controller("assetsUpload.assetsUploadFileDriver", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', '$timeout',
	'assetsUpload.assetsUploadFileServices', '$location', "designer", '$translate', 'dsgnrCommons','cobisMessage',
	function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, assetsUploadFileServices, $location, designer, $translate, dsgnrCommons, cobisMessage) {
            $scope.vc = designer.initCustomViewContainer("assetsUpload");	
			$scope.loadFilesTemplate = kendo.template($("#loadFilesTemplate").html());
			
			
			$scope.operatorStructure = [];
			$scope.errors = "";
			$scope.resultLength = 0;
			$scope.selected = {};
			$scope.filesUp = [];
			$scope.attributes = [];
			$scope.operators = [];
			$scope.uploadSuccess = false;
			$scope.CSV_EXTENSION = ".csv";
			$scope.XML_EXTENSION = ".xml";
			
			$scope.vc.viewState = {
                dynamic: {
                    view: {},
					customView: {},
					
                }
            };
            
           		
            $scope.initData = function () {	
				//$(":file").filestyle({buttonText: "Seleccionar");
				cobis.showMessageWindow.loading(true);
				$(document).ready(function() {
					var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;
					nav.customAddress = {
										id: 'assetsUpload',
										url: '/ASSTS/CMMNS/UPLOADFILE/templates/upload-file-tpl.html',
										useMinification: false
									};
									
					nav.registerCustomView('dynamic');			
					
				});
				
			
            };
			//Evento Init Combo Corresponsales			
			$scope.initComboBox = function(){
				$(document).ready(function() {
					var catalog = assetsUploadFileServices.getCatalogs('ca_corresponsales');
					catalog.then(function(data){
						$scope.operators = data.data["returnHpCatalogResponse"];
						$scope.selected = $scope.operators[0];
						$scope.getFileStructure($scope.selected.code);
						cobis.showMessageWindow.loading(false);
					});
				});
			};
			
			//Evento Change Combo Corresponsales
			$scope.onChangeComboBox = function(){
				cobis.showMessageWindow.loading(true);
				if($scope.selected	!= null && $scope.selected != undefined){
					$scope.getFileStructure($scope.selected.code);
				}
			};
			
			
			//Carga Archivo			
			$scope.uploadFile = function(e){
				//var files = evt.target.files;
				var hasValidPayments = true;
				cobis.showMessageWindow.loading(true);
				$scope.paymentRequest = {};
				$scope.payments = [];
				if (!$scope.filesUp.length) {
					cobisMessage.showTranslateMessagesInfo($filter('translate')('ASSTS.MSG_ASSTS_FAVORSEPP_90090'),[],3000,false);
					cobis.showMessageWindow.loading(false);
					return;
				}
				
								
								
				cobis.showMessageWindow.loading(false);
				console.log('Registro eliminados con éxito.');
				var file = $scope.filesUp[0];
				
				if(file.extension.toLowerCase() == $scope.CSV_EXTENSION){
				var reader = new FileReader();
				reader.readAsText(file.rawFile);
				reader.onloadend = (function(file){
					return function (e){
							var fileName = file.name;
							switch(file.extension.toLowerCase()){
								case $scope.CSV_EXTENSION:
									var csvData = e.target.result;
									hasValidPayments = $scope.getPayments($scope.getDataFromCsv(csvData), fileName);
									
								break;
								case $scope.XML_EXTENSION:
									//No se usa pero se mantiene por version inicial
						var xmlData = $(reader.result);
									hasValidPayments = $scope.getPayments($scope.getDataFromXml(xmlData), fileName);
								break;
								default:
								break;
							
							
							}						
							
							if(hasValidPayments){
							if($scope.payments == null || $scope.payments.length == 0){
								var messages = [];
								messages.push("ASSTS.MSG_ASSTS_ESTRUCTCR_26791");
								$scope.appendDiv(messages, false);
							}else{
								$scope.paymentRequest.payments = $scope.payments;
									$scope.paymentRequest.structures = $scope.operatorStructure;
								var insertTmpResponse = assetsUploadFileServices.insertFileinTemp($scope.paymentRequest);
								insertTmpResponse.then(function(data){													
									console.log('Registros insertados con éxito');
															
									var uploadResponse = assetsUploadFileServices.uploadFile(data);
									uploadResponse.then(function(data){
										$scope.uploadSuccess = true;
										var messages = [];
										messages.push("ASSTS.MSG_ASSTS_PROGRESLR_82296");
										$scope.appendDiv(messages, true);						
										cobis.showMessageWindow.loading(false);
										
									}).catch (function (data) {
										var messages = [];
										messages.push("ASSTS.MSG_ASSTS_ERRORENAA_77685");
										$scope.appendDiv(messages, false);
										cobis.showMessageWindow.loading(false);
									});
									
									
										
								});
							}
							}else{
								var messages = [];
								messages.push("ASSTS.MSG_ASSTS_ESTRUCTCR_26791");
								$scope.appendDiv(messages, false);
								cobis.showMessageWindow.loading(false);
						}
					}})(file);
				}else{
					var messages = [];
					messages.push("ASSTS.MSG_ASSTS_SOLOSEPSE_76055");
					$scope.appendDiv(messages, false);		
				}
				
				
			}
			
			//Obtener data desde archivo xml
			$scope.getDataFromXml = function (xml){
				var xmlDOM = new DOMParser().parseFromString(xml, 'text/xml');
				return $scope.xml2json(xml, false);			
				
			};
			
			//Obtener data desde archivo csv
			$scope.getDataFromCsv = function (csv){
				var lines = csv.split("\n");
				$scope.results= [];
				var headers = $scope.spliCSV(lines[0]);
		
				for (var i = 1; i < lines.length; i++) {
				
					if(lines[i] != undefined && lines[i] != null && lines[i].trim() !=""){
						$scope.result = {};
		
						var currentline = $scope.spliCSV(lines[i]);
						for (var j = 0; j < headers.length; j++) {
							$scope.result[headers[j]] = currentline[j];
						}
							
						$scope.results.push($scope.result);
					}
				}
				
				return $scope.results;
				
		
			};
			
			$scope.spliCSV = function spliCSV(row){
				var insideQuote = false,                                             
					entries = [],                                                    
					entry = [];
				row.split('').forEach(function (character) {                         
					if(character === '"') {
					insideQuote = !insideQuote;                                      
					} else {
					if(character == "," && !insideQuote) {                           
						entries.push(entry.join(''));                                  
						entry = [];                                                    
					} else {
						entry.push(character);                                         
					}                                                                
					}                                                                  
				});
				entries.push(entry.join(''));                                        
				return entries;                                                      
			};
			
			//Armar mapa de Pagos
			$scope.getPayments = function(result, fileName){
						if(result == null){
							var messages = [];
							messages.push("ASSTS.MSG_ASSTS_ELARCHISO_29045");
							$scope.appendDiv(messages, false);
					return false;
						}else{
							$scope.resultLength = result.length;
							for(var i = 0; i < $scope.resultLength; i++){
								cobis.showMessageWindow.loading(true);
								$scope.payment = {};
						$scope.payment.filename = fileName; 
								$scope.payment.sequential = $scope.sequential;
								$scope.payment.operator = $scope.selected.code;
								
						var keys = Object.keys(result[i]);
						var isEmpyLine = false;
						var emptyKeys = 0;
						for(var h = 0; h<  keys.length; h++){
							 if (result[i][keys[h]] == undefined || result[i][keys[h]] == null || result[i][keys[h]] == ""){
								emptyKeys++;
							 }
						}
						if(emptyKeys < keys.length - 1){
								for(var j = 0; j < $scope.operatorStructure.length; j++){
									var map = $scope.operatorStructure[j];							
								
									for (var key  in map) {	
								var value = result[i][key];
					
									if( value != null && value != undefined && value != "" && $scope.validateDataType(value.trim(), map[key].type, map[key].regularExp)){
											$scope.payment[map[key].value] = value.trim();	
										
										}else{
											var messages = [];
											messages.push("ASSTS.MSG_ASSTS_ATODELCMM_82274");
											messages.push(key);
											messages.push("ASSTS.MSG_ASSTS_NOESVLIOO_28545");
											$scope.appendDiv(messages, false);
											cobis.showMessageWindow.loading(false);
										return false;
										}
								
							
									}							
								}
								
								$scope.payments.push($scope.payment);
							}
						}	
					return true;
				}
						
			};
				
				
            //Cancelar
            $scope.close = function () {
				var response = {};
                $scope.vc.closeModal(response);
            };
			//Aceptar
			 $scope.ok = function () {
				var response = {};
				if (!$scope.uploadSuccess){
					cobisMessage.showTranslateMessagesInfo($filter('translate')('ASSTS.MSG_ASSTS_NOSEHARIA_71720'),[],4000,false);
				}
                $scope.vc.closeModal(response);
            };
		
			$scope.onSelect = function(e) {
				$("#console").empty();
				$scope.filesUp = e.files;
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_ARCHIVOHL_95272");
				messages.push($scope.getFileInfo(e));
				$scope.appendDiv(messages, true);
			};

            $scope.onUpload	= function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_CARGADBJK_87235");
				messages.push($scope.getFileInfo(e));
              	$scope.appendDiv(messages, true);
            }

            $scope.onSuccess = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_XITOQDMXE_78905");
				messages.push("(");
				messages.push(e.operation);
				messages.push(") :: ");
				messages.push($scope.getFileInfo(e));
				$scope.appendDiv(messages, true);
                    
            }

            $scope.onError = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_ERROROPQL_73758");
				messages.push("(");
				messages.push(e.operation);
				messages.push(") :: ");
				$scope.appendDiv(messages, false);
                    
            }

            $scope.onComplete = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_FINALIZOD_92092");
				$scope.appendDiv(messages, true);
            }

            $scope.onCancel = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_CANCELAOD_83603");
				messages.push($scope.getFileInfo(e));
				$scope.appendDiv(messages, true);
                   
            }

            $scope.onRemove = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_BORRADOFI_98692");
				messages.push($scope.getFileInfo(e));
				$scope.appendDiv(messages, true);
            }

            $scope.onProgress = function(e) {
				var messages = [];
				messages.push("ASSTS.MSG_ASSTS_PROGRESOA_46749");
				messages.push(e.percentComplete);
				messages.push("% :: ");
				messages.push($scope.getFileInfo(e));
				$scope.appendDiv(messages, true);
            }
				
				
			/****************************Métodos***************************************/

			//Obtner Estructura del Archivo (definida en archivo configuración)
			$scope.getFileStructure = function(operator){
				cobis.showMessageWindow.loading(true);
				var result = assetsUploadFileServices.getPaymentOperatorStructure(operator);
				result.then(function(data){
					$scope.operatorStructure = data;					
					cobis.showMessageWindow.loading(false);
				});
			};
			
			//Añadir div con mensaje en Registro de Carga
			$scope.appendDiv = function(messages, success){
				var className = "block-message",
					consoleDiv = document.getElementById("console"),
					newDiv  = document.createElement( "div" ),		
					spanIcon = document.createElement( "span" ),			
					spanText = document.createElement( "span" ),	
					text = ""; 
				
				if (success){
					spanIcon = document.createElement('span')
					spanIcon.className = "glyphicon glyphicon-info-sign";
					newDiv.className = className + " block-message-success";
				}
				else{
					spanIcon = document.createElement('span')
					spanIcon.className = "glyphicon glyphicon-remove";
					newDiv.className = className + " block-message-error";
					
				}
				var api = new dsgnrCommons.API($scope.vc)
				
				for (var i = 0; i <messages.length; i++){
					if(messages[i]!=null){
						text = text + " " +$filter('translate')(messages[i]);
					}
					
				}
				spanText.innerHTML  =  text;
				newDiv.appendChild(spanIcon);
				newDiv.appendChild(spanText);
				consoleDiv.appendChild(newDiv);
			};
			
			//Obtener información del Archivo
			$scope.getFileInfo = function(e) {
                return $.map(e.files, function(file) {
                    var info = file.name;

                    // File size is not available in all browsers
                    if (file.size > 0) {
                        info  += " (" + Math.ceil(file.size / 1024) + " KB)";
                    }
                    return info;
                }).join(", ");
            };			
			
			//Transformar XML a JSON
			$scope.xml2json = function(xml, isItem) {
				try {
					
					if (xml.children.length > 0 && !isItem) {
						var obj = [];
						for (var i = 0; i < xml.children().length; i++) {
						
							if(xml.children()[i].hasChildNodes()){
								var item = xml.children()[i];
								var nodeName = item.nodeName;
								obj.push($scope.xml2json(item, true));
							}
							
							
						}
					} else if (xml.children.length > 0 && isItem) {
						var obj = {};
						for (var i = 0; i < xml.children.length; i++) {
							var item = xml.children[i];
							var nodeName = item.nodeName;
							
							if ( typeof(obj[nodeName] ) == "undefined" ) {
								obj[nodeName] = $scope.xml2json( item , true);
							} else {
								if ( typeof( obj[nodeName].push ) == "undefined" ) {
									var old = obj[nodeName];
									obj[nodeName] = [];
									obj[nodeName].push( old );
								}
								obj[nodeName].push( $scope.xml2json( item , true));
							}
							//obj[nodeName] = $scope.xml2json(item, true);
						}
					}else {
						obj = xml.textContent;
					}
					return obj;
				} catch (e) {
					console.log(e.message);
					var messages = [];
					messages.push("ASSTS.MSG_ASSTS_ESTRUCTCR_26791");					
					$scope.appendDiv(messages, true);
				}
			};
			
			//Obtener Nodos hijos XML
			$scope.getChildNodes = function(xml){
				var childNodes = xml.childNodes;
				
				for(var i = 0; i < childNodes.length; i++){
					childNodes[i]
				}
			};

            
			//Validar tipos de datos Archivo
			$scope.validateDataType = function(value, type, regularExp){
				var isValid = true;				
				var regex = null;
		
				switch (type){
					case 'A'://Alfanumérico
						regex = new RegExp(regularExp);
						if (!regex.test(value))
							return false;
						return true;
					break;
					case 'F'://Flotante
						regex = new RegExp(regularExp);
						if (!regex.test(value))
							return false;
						var floatVal = parseFloat(value);
						if (isNaN(floatVal))
							return false;						
					break;
					case 'N'://Número
						regex = new RegExp(regularExp);
						if (!regex.test(value))
							return false;
							
						var intVal = parseInt(value, 10);
						return parseFloat(value) == intVal && !isNaN(intVal);
					break;
					case 'M'://Moneda
						regex = new RegExp(regularExp);
						if (!regex.test(value))
							return false;
							
						var intVal = parseInt(value, 10);
						return parseFloat(value) == intVal && !isNaN(intVal);
					break;
					case 'D'://Fecha
						regex =  new RegExp(regularExp);
						if (!regex.test(value))
							return false;
						if(!value.match(regex))
							return false;
					break;
					default:
						return true;
					break;
				}
				
				return true;
			};



    }]);
}());