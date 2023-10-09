(function (window) {
    'use strict';
	
	var app = cobis.createModule(cobis.modules.CLIENTVIEWER, ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', 'ngResource', 'ngCookies'], ['clientviewer', 'customer']);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });
	
    app
        .filter(
            'grouping',
            function () {

                return function (items, operationType) {

                    var arrayToReturn = [];
                    if (items != null) {
                        for (var i = 0; i < items.length; i++) {
                            var insert = true;
                            for (var j = 0; j < arrayToReturn.length; j++) {
                                if (items[i][operationType] == arrayToReturn[j][operationType]) {
                                    insert = false;
                                }
                            }
                            if (insert) {
                                arrayToReturn.push(items[i]);
                            }
                        }
                    }
                    return arrayToReturn;
                };
            });

    app.filter('filterById', function () {

        return function (items, selectId) {

            var arrayToReturn = [];
            if (items != null) {
                for (var i = 0; i < items.length; i++) {

                    if (items[i].mnemonic == selectId) {
                        arrayToReturn.push(items[i]);
                    }
                }
            }
            return arrayToReturn;
        };
    });

    app.filter('filterOperationType', function () {

        return function (items, operationType, propertyName) {

            var arrayToReturn = [];
            for (var i = 0; i < items.length; i++) {
                if (items[i][propertyName] == operationType) {
                    arrayToReturn.push(items[i]);
                }
            }
            return arrayToReturn;
        };
    });

    app
        .filter(
            'filterProcess',
            function () {

                return function (products, productId, isNotGeneric,
                    creditLine, generic, mnemonic) {
                    var arrayToReturn = [];
                    if (products != null) {
                        for (var i = 0; i < products.length; i++) {
                            for (var j = 0; j < products[i].processes.length; j++) {
                                if (products[i].id == productId && ((products[i].processes[j].isNotGeneric == isNotGeneric && (mnemonic != undefined && mnemonic.trim() != 'CONT' || productId == 'CRE')) || products[i].processes[j].generic == generic || (products[i].processes[j].creditLine == creditLine && mnemonic != undefined && mnemonic.trim() == 'CONT'))) {
                                    arrayToReturn
                                        .push(products[i].processes[j]);
                                }
                            }
                        }
                    }
                    return arrayToReturn;
                };
            });
			

	
    app.controller("clientviewer.clientviewerController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', '$timeout', 'clientviewer.queryClientViewerService', '$location', "designer", '$translate','dsgnrCommons', 'clientviewer.addressService',
       'clientviewer.consolidatePositionService',
       function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, queryClientViewerService,  $location, designer, $translate, dsgnrCommons, addressService, consolidatePositionService) {

            //*DESIGNER*//
            $scope.showGroup = false;
            $scope.showNaturalPerson = false;
            $scope.showCompany = false;
			$scope.showHistoryTree = true;
            $scope.classStyle = '';
			$scope.searchedCustomer = '';
			$scope.menu = [];
			$scope.choosenMenu='1';
			$scope.currentInfoView = null;
			$rootScope.clientType ='';
			$rootScope.countVcc = 0;
			$scope.menuTabStrip = null;
			$scope.dateFormat = cobis.userContext.getValue(cobis.constant.DATE_FORMAT);
			$scope.decimalSeparator = cobis.userContext.getValue(cobis.constant.CURRENCY_DECIMAL_SEPARATOR);
			$scope.groupSeparator = cobis.userContext.getValue(cobis.constant.CURRENCY_GROUP_SEPARATOR);
			
			$scope.abbreviateNumber = function(num, fixed) {
                if (num === null || num == undefined) {
                    return null;
                } // terminate early
                if (num === 0) {
                    return '0';
                } // terminate early
			  fixed = (!fixed || fixed < 0) ? 0 : fixed; // number of decimal places to show
			  var b = (num).toPrecision(2).split("e"), // get power
				  k = b.length === 1 ? 0 : Math.floor(Math.min(b[1].slice(1), 14) / 3), // floor at decimals, ceiling at trillions
				  c = k < 1 ? num.toFixed(0 + fixed) : (num / Math.pow(10, k * 3) ).toFixed(1 + fixed), // divide by power
				  d = c < 0 ? c : Math.abs(c), // enforce -0 is 0
				  e = d + ['', 'K', 'M', 'B', 'T'][k]; // append power
			  return e;
			};
			
			$scope.treeItemTemplateHistory = kendo.template($("#javascriptTemplateHistory").html());
			
			$rootScope.vc = designer.initCustomViewContainer('ClientViewer', $scope.customEvents);
					$rootScope.vc.viewState = {
						dynamic: {
							view: {},
							customView: {}
						},
						dynamicInfo: {
							view: {},
							customView: {}
						},
						historyDynamicInfo: {
							view: {},
							customView: {}
						},
						consolidateView: {
							view: {},
							customView: {}
						},
						productsSale: {
							view: {},
							customView: {}
						},
						informationView: {
							view: {},
							customView: {}
						},
						otherInformation: {
							view: {},
							customView: {}
						},
						clientDinamicInformation: {
							view: {},
							customView: {}
						},
						consolidatePositionView: {
							view: {},
							customView: {}
						},
						debts: {
							view: {},
							customView: {}
						},
						products: {
							view: {},
							customView: {}
						}
			};
			
			//$scope.selected = '';
            //Al abrir pantallas modales con el api de designer se puede simular los eventos 
            //personalizados de la siguiente manera
            //task.closeModalEvent.VC_ONITS38_LLTFM_306 =
            $scope.customEvents = {
                closeModalEvent: {

                    findCustomer: function (args) {
					    var result = args.result;						

                    }
                }
            };
			
            $scope.formatToContextDate = function (_date) {

                if (_date != null && _date != undefined && $.trim(_date) != "") {

                    _date = _date.replace('/Date(', '');
                    _date = _date.replace(')/', '');
                    _date = new Date(parseInt(_date));

                    var _day = parseInt(_date.getDate()) < 10 ? '0' + _date.getDate() : _date.getDate();
                    var _month = parseInt(_date.getMonth() + 1) < 10 ? '0' + parseInt(parseInt(_date.getMonth()) + 1) : _date.getMonth() + 1;
                    var _year = _date.getFullYear();


                    if ($scope.dateFormat == 'yyyy-MM-dd') {
                        return _year + '-' + _month + '-' + _day
                    } else if ($scope.dateFormat == 'yyyy/MM/dd') {
                        return _year + '/' + _month + '/' + _day
                    } else if ($scope.dateFormat == 'dd-MM-yyyy') {
                        return _day + '-' + _month + '-' + _year
                    } else if ($scope.dateFormat == 'dd/MM/yyyy') {
                        return _day + '/' + _month + '/' + _year
                    } else if ($scope.dateFormat == 'MM-dd-yyyy') {
                        return _month + '-' + _day + '-' + _year;
                    } else if ($scope.dateFormat == 'MM/dd/yyyy') {
                        return _month + '/' + _day + '/' + _year
                    }

                    return _date.toLocaleDateString();
                }
                return "";
            }

			var resultPrepareProductHistory = null;
			$scope.showOtherInfoView = function (item, e) {
                //solo carga la primera vez que se llama desde la página, no cuando se vuelve a abrir luego de colapsar
                if (angular.isUndefined(item.originalUrl)) {
                    item.originalUrl = item.manConSecUrl;
                }

                $rootScope.vc.removeChildVc('dynamicInfo');
				$scope.treeDataHistory = [];
				var api = new dsgnrCommons.API($rootScope.vc),
                    nav = api.navigation;
				if (e)
                    e.stopPropagation();
					
                if(item.manConSecType =="D"){
					var url=item.manConSecUrl.split('/');
					nav.address = {
						moduleId: url[0],
						subModuleId: url[1],
						taskId: url[2],
						taskVersion: url[3],
						viewContainerId:url[4]
					};
					nav.customDialogParameters = {
						customerCode: $rootScope.customerCode
					};
					
					nav.registerView('dynamicInfo');
				}else{
					
					
                    if (item.manConSecType == 'P_HIS') {
						if(resultPrepareProductHistory == null){
							$rootScope.showLoading();
							var resultPrepareProductHistory = null;
				
							if($rootScope.customerType == 'G' || $rootScope.customerType == 'S'){
								resultPrepareProductHistory = consolidatePositionService.prepareProductsDataHistory(0,$scope.customerCodeLocal);
							}else if($rootScope.customerType == 'P' || $rootScope.customerType == 'C'){
								resultPrepareProductHistory = consolidatePositionService.prepareProductsDataHistory($scope.customerCodeLocal,0);
							}	
							//resultPrepareProductHistory = consolidatePositionService.prepareProductsDataHistory($scope.customerCodeLocal,$scope.groupCode);
							resultPrepareProductHistory.then(function (data) {	
							$scope.spid = data.spid;
								var resultQueryProductHistory = queryClientViewerService.queryHistoryProductsByClientId ($scope.customerCodeLocal, $scope.spid);
								resultQueryProductHistory.then(function (data) {
									$rootScope.dynamicHistoryData = data.productsByClientDTO;
									//$("div[id='loader_CONSOLIDATEPOS']").each(function(i, element) {$(element).hide()});
									$rootScope.hideLoading();
									$scope.showHistoryTreeNodes(item);
                                }).
                                catch (function (data) {
									//$("div[id='loader_CONSOLIDATEPOS']").each(function(i, element) {$(element).hide()});
									$rootScope.hideLoading();
								});
							
							});
						}else{
								$scope.showHistoryTreeNodes(item);
					    }						
                    } else {
						$scope.clearOtherInformation($scope.treeDataHistory);
						
					}
					
					nav.customAddress = {
							id: 'otherInformationView',
							url: item.manConSecUrl
						};

						
					nav.registerCustomView('dynamicInfo');
					
				}
						}

			$scope.showHistoryTreeNodes = function(item){
						if($scope.showHistoryTree){
							var node = {};
							$scope.treeDataHistory = [];
						//corrige el url cuando se vuelve a abrir luego de colapsarse
						item.manConSecUrl=item.originalUrl;
							$rootScope.groupsProductHist.forEach(function(item){
								node = {
									id: null,
									idparent: null,
									nameParent: null,
									name: item.mnemonic,
									text: item.name,
									type: null,
									spriteCssClass: "fa fa-align-right noderight"
								}
								$scope.treeDataHistory.push(node);
							});
							
							$scope.treeDataSourceHistory = new kendo.data.HierarchicalDataSource({
								data: $scope.treeDataHistory
							});
							
							
							$scope.showHistoryTree = false;
						
					} else {
						//cuando se colapsa el menu
							$scope.clearOtherInformation($scope.treeDataHistory);
							item.manConSecUrl = 'clientviewer/templates/blank_page.html';
						}
						};
			
			$scope.clearOtherInformation = function(treeDataHistory ){
				$scope.showHistoryTree = true;
				$scope.treeDataSourceHistory = new kendo.data.HierarchicalDataSource({
					data: treeDataHistory
				});
			};
			
            $scope.sortProperties = function (_array) {

                var max = 0;

                for (var i = 0; i < _array.length; i++) {
                    if (_array[i].order != null && $.trim(_array[i].order) != "") {
                        max = parseInt(_array[i].order) > parseInt(max) ? parseInt(_array[i].order) : parseInt(max);
                    }
                };

                for (var i = 0; i < _array.length; i++) {
                    _array[i].order = _array[i].order == null ? max + 1 + i : _array[i].order;
                    _array[i].order = $.trim(_array[i].order) == "" ? max + 1 + i : _array[i].order;
                };

                _array.sort(function (a, b) {
                    return (parseInt(a.order) > parseInt(b.order)) ? 1 : ((parseInt(b.order) > parseInt(a.order)) ? -1 : 0);
                });

                return _array;
            }

            $rootScope.vc.selectData = function (args) {
				$rootScope.countVcc =0;
				$rootScope.showLoading();
				$scope.code = args.selectedData.code;
                $rootScope.type = args.selectedData.isGroup == true ? "Grupo" : "Cliente";
				$rootScope.customerType = args.selectedData.customerType;
				$scope.documentId =  args.selectedData.documentId;
				$scope.customerCodeLocal = $scope.code;
               	$rootScope.vc.removeChildVc('findCustomer');
				$scope.queryClientData();
				
				
			}

            /*END DESIGNER*/

            $scope.orientationv = "vertical";
            $scope.orientationh = "horizontal";
            $scope.code = "";
            $rootScope.type = "";
            $rootScope.customerCode = null;
            $rootScope.resultGrid = [];
            $rootScope.resultConsolidation = [];
            $scope.isEconomicGroup = false;
			$scope.isSolidarityGroup = false;

            $scope.controlClean = function () {
                var splitterElement = $("#splitterContainer").data("kendoSplitter");
                if (splitterElement != null) {
                    splitterElement.collapse("#paneAdditionalInformation");
                }
                $rootScope.spid = 0;
                $rootScope.consolidatePosition = 0;
                $rootScope.flagData = 0;
                $location.url("${contextPath}/cobis/web/views/clientviewer/templates/consolidate-view-tpl.htm");
                $scope.isOfficialVisible = false;
                $scope.isVisibleAdditionalData = false;
                $scope.isNaturalCustomer = false;
                $scope.isLegalPersonalData = false;
                $scope.isVisibleEconomicGroup = false;
                $scope.isAditionalBtnVisible = true;

                $rootScope.productsLoans = [];
                $rootScope.productsOverdraft = [];
                $rootScope.productsCurrentAccount = [];
                $rootScope.productsSavingAccount = [];
                $rootScope.productsFixedTerm = [];
                $rootScope.productsGuarantees = [];
                $rootScope.productsPromissoryNote = [];
                $rootScope.productsInsurancePolicy = [];
                $rootScope.productsCredits = [];
                $rootScope.productsContingencies = [];
                $rootScope.productsIndirectPortfolio = [];
                $rootScope.productsOtherComext = [];
                $rootScope.productsApplicationLoans = [];
                $rootScope.productsCreditsPendings = [];
                $rootScope.productsPendingGuaranties = [];
                $rootScope.productsPromissoryNotePending = [];
                $rootScope.resultGrid = [];
                $rootScope.resultConsolidation = [];
				$scope.currentView = null;

            }

            $scope.economicGroupDS = [];
            $scope.economicGroupDS2 = [];
            $scope.controlClean();


            $rootScope.clientGeneralData = {
                code: "",
                documentId: "",
                name: "",
                descriptionOfficial: "",
                clientSituationDescription: "",
                joinDate: "",
                tutorNumberId: "",
                tutorName: "",
                type: "",
				documentTypeDescription:""
            }
            $rootScope.clientAdditionalData = {
                nationality: "",
                birthDate: "",
                clientType: "",
                studyLevel: "",
                activity: "",
                linkUpType: "",
                reportSBS: "",
                maritalStatus: "",
                gender: "",
                category: "",
                profesion: "",
                economicGroup: "",
                prefenceClient: "",
                maxIDeb: "",
                businessLine: "",
                businessSegment: "",
                vinculating: "",
                status: "",
                companyType: "",
                relationshipTypeDescription: "",
                employeesNumber: "",
                preferredClient: "",
                segmentDescription: "",
                coverage: "",
                totalAssets: "",
                grossEstateDate: "",
                relationship: "",
                grossEstate: ""

            }
            $rootScope.maxDebtRequest = {
                limitDebt: "",
                debtAmount: "",
                available: ""
            }
			 $rootScope.clientAcademicData ={
				studyLevel: "",
				profesion: ""
			 }
			 $rootScope.clientOtherInformation = {
				officeName : "",
				nit: "",
				economicGroup:"",
				activity: "",
				reportSBS: "",
				maxIDeb:""
			 }
			 
			  $rootScope.clientCompanyData = {
				companyType: "",
				descriptionSegment: "",
				numberEmployees:"",
				legalRepresentative: "",
				groupName: "",
				entailment: "",
				linkUpTypeDescription: "",
				descState: ""
			 }
			  $rootScope.otherInformationCompany = {
				office: "",
				descriptionCoverage: "",
				nationality:"",
				totalAssets: "",
				heritage: "",
				dateHeritage: ""
			 }
			 
            
            /*
             * Function to block screen
             */
            $scope.blockScreen = function () {
                $('form#customerSearch').block({
                    message: $('<div>Procesando..</div>'),
                    css: {
                        border: 'none',
                        backgroundColor: '#000',
                        opacity: .5,
                        color: '#fff'
                    }
                });
            };

            /*
             * Function to unblock screen
             */

            $scope.unblockScreen = function () {
                $('form#customerSearch').unblock();
            };
			
			
			$scope.getMenu = function (){
				var menu =  [				
							{
								id:'1',
								option: 'CLIENTVIEWER.LABELS.LBL_OPTION_NATURAL_LEGAL_PERSON',
								checked: true
							},
							{
								id:'2',
								option: 'CLIENTVIEWER.LABELS.LBL_OPTION_ECONOMIC_GROUP',
								checked: false
							}
				];
				return menu;
			};
			
			
			
            $scope.getColor = function (code) {
                if (code != $rootScope.dynamicClientData.clientGeneralData.tutorNumberId) {
					return "";
                } else {
					return "background-color:#beebf0";
				}
			}
			
			$rootScope.queryClientPhones = function (dataItem) {
            
				   var searchCustomer = {                        
						customerID: "",
						addressId:""
						}
				   searchCustomer.customerID=$rootScope.customerCode;
				   searchCustomer.addressId= dataItem.addressId;
				   
				   var serviceResponse = addressService.queryPhones(searchCustomer);
				 
				   serviceResponse.then(function (data) {
						   $rootScope.seriesPhones = []; 
						   for (var i = 0; i < data.length; i++) {                         
							   $rootScope.seriesPhones.push(data[i]);                           
						   }                                     
						   $rootScope.isVisiblePhones = ($rootScope.seriesPhones != null && $rootScope.seriesPhones.length > 0);

                });
			   }
			   
			$rootScope.seriesContact = [];
			$rootScope.seriesDirections = [];
            /*
             * function to obtain the information of the client or
             * economic group the searching is by code
             */
            $scope.buscarbyid = function (customerCode, customerType) {
				$rootScope.showLoading();
                $scope.controlClean();

                if ($rootScope.type != "Grupo") {
					$scope.queryCustomer(customerCode);
                } else {
                    $scope.queryGroupDetail(customerCode, $rootScope.customerType);
                }

            };

            $scope.economicGroup = new kendo.data.DataSource({
                data: $rootScope.economicGroupMembers,
                schema: {
                    model: {
                        fields: {
                            image: {
                                type: ""
                            },
                            code: {
                                type: "string"
                            },
                            composedName: {
                                type: "string"
                            },
                            documentId: {
                                type: "string"
                            },
                            subtype: {
                                type: "string"
                            },
                            passport: {
                                type: "string"
                            },
                            entailment: {
                                type: "string"
                            }
                        }
                    }
                }
            });

			$scope.queryByType = function (customerType){
				$rootScope.showLoading();

                $scope.isMaxDebt = false;
                $scope.isVisibleAdditionalData = false;
				
				if ($scope.groupCode == null) {
					$scope.groupCode = 0;
					$scope.isAditionalBtnVisible = true;
					$scope.isMembersBtnVisible = false;
                }

				switch(customerType){
					case 'C':
						$scope.isAditionalBtnVisible = false;
                        $scope.isMembersBtnVisible = true;
						$scope.showNaturalPerson = false;
						$scope.isEconomicGroup = false;
						$scope.isSolidarityGroup = false;
						$scope.isEconomicGroupNecessary = false;
                        $scope.showCompany = true;
						$scope.showGroup = false;
                        $scope.classStyle = "profileClient profile02";
					break;
					case 'P':
						$scope.isAditionalBtnVisible = true;
                        $scope.isMembersBtnVisible = false;
                        $scope.showNaturalPerson = true;
						$scope.isEconomicGroup = false;
						$scope.isSolidarityGroup = false;
						$scope.isEconomicGroupNecessary = false;
                        $scope.showCompany = false;
                        $scope.showGroup = false;
                        $scope.classStyle = "profileClient profile01";
					break;			
				};			
			}

			$scope.queryGroupDetail = function (customerCode, type){
				var result = queryClientViewerService.queryGroupDetail(customerCode, type);
				result.then(function (data) {                
					$rootScope.dynamicClientData = data.clientInformation;
					//$scope.groupCode = resultg.groupId;
					$scope.isAditionalBtnVisible = true;
					$scope.isMembersBtnVisible = false;
					$scope.isOfficialVisible = true;
					$scope.isNaturalPerson = false;
					$scope.isCorporation = false;
					$scope.isEconomicGroup = type =='G'? true: false;
					$scope.isSolidarityGroup = type =='S'? true: false;
					$scope.isEconomicGroupNecessary = false;
					$scope.showGroup = true;
					$scope.showNaturalPerson = false;
					$scope.showCompany = false;
					if($scope.isEconomicGroup){
					$scope.classStyle = "profileClient profile03";
					}else if($scope.isSolidarityGroup){
						$scope.classStyle = "profileClient profile06";
					}
					$rootScope.loadInformationProductSale();
					$rootScope.countVcc++;
					$rootScope.hideLoading();
				
                }).
                catch (function (data) {
					$rootScope.count++;
					$rootScope.hideLoading();
				});
			};
			
			
			/****************************************************************************/
			/**************** 	Search Natural and Legal Customers 		******************/
			/****************************************************************************/			
			$scope.queryCustomer = function (customerCode){
				$rootScope.showLoading();
				var result = queryClientViewerService.queryCustomer(customerCode);
				result.then(function (data) {							
					var result = data;
					$rootScope.dynamicClientData = result.clientInformation;
					
					if( $rootScope.dynamicClientData!=null && $rootScope.dynamicClientData.customer != null){
					$rootScope.dynamicClientData.clientGeneralData.civilStatusDescription = $rootScope.dynamicClientData.customer.civilStatusDescription;
					$rootScope.clientType = $rootScope.dynamicClientData.customer.customerType;
					$scope.queryByType($rootScope.dynamicClientData.customer.customerType); 
						
                        $rootScope.dynamicClientData.customer.birthdate = $scope.formatToContextDate($rootScope.dynamicClientData.customer.birthdate);
                        $rootScope.dynamicClientData.clientGeneralData.birthDate = $scope.formatToContextDate($rootScope.dynamicClientData.clientGeneralData.birthDate);

                        $rootScope.dynamicClientData.customer.expirationDate = $scope.formatToContextDate($rootScope.dynamicClientData.customer.expirationDate);
                        $rootScope.dynamicClientData.clientGeneralData.expirationDate = $scope.formatToContextDate($rootScope.dynamicClientData.clientGeneralData.expirationDate);

                        $rootScope.dynamicClientData.customer.joinDate = $scope.formatToContextDate($rootScope.dynamicClientData.customer.joinDate);
                        $rootScope.dynamicClientData.clientGeneralData.joinDate = $scope.formatToContextDate($rootScope.dynamicClientData.clientGeneralData.joinDate);

					$rootScope.loadInformationProductSale();
					}
					$rootScope.countVcc++;
					$rootScope.hideLoading();

                }).
                catch (function (data) {
                    $rootScope.countVcc++;
					$rootScope.hideLoading();
                });
			};
			
			
            $scope.buscar = function () {
		
                if (angular.isDefined($scope.treeDataHistory) && $scope.treeDataHistory != null) {
                    //cerrar el menu para obligar que vuelvan a abrirlo y consultar los datos de historico del nuevo cliente
                    $scope.clearOtherInformation($scope.treeDataHistory);
                    resultPrepareProductHistory = null;
                    $scope.treeDataHistory = [];
                    $scope.controlClean();
                    $scope.expandCollapse(null);
                }

                //Se puede instanciar el API de designer en base a la variable vc creada anteriormente.
				$rootScope.resultGrid = null;
				$scope.customerCodeLocal = null;
				
                var api = new dsgnrCommons.API($rootScope.vc),
                    nav = api.navigation;

                nav.label = $filter('translate')('COMMONS.LABELS.TIT_CUSTOMER_SEARCH');
                nav.customAddress = {
                    id: 'findCustomer',
                    url: '/customer/templates/find-customers-tpl.html'
                };
                nav.scripts = [{
                    module: cobis.modules.CUSTOMER,
                    files: ['/customer/find-customers.js','/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                }];
                nav.customDialogParameters = {};
                /*nav.modalProperties = {
                    size: 'lg'
                };*/
                nav.registerCustomView('dynamic');		
            };
			
			$scope.buscarEntidad = function(){
				angular.element(document).ready(function () {
				if($("#searchForm").kendoValidator().data("kendoValidator").validate()){
				$scope.treeDataHistory = [];
						$scope.clearOtherInformation($scope.treeDataHistory);
				$scope.customerCodeLocal = $scope.searchedCustomer;
				$rootScope.countVcc = 0;
				$scope.groupCode = 0;
						$scope.queryClientData();
						$scope.expandCollapse(null);	
				switch($scope.choosenMenu){
					
					case '1':
						$rootScope.type = 'Cliente'
					break;
					case '2':
						$rootScope.type = 'Grupo'
					break;
					default:
						$scope.buscar();
					break;
					}
					}
				});				
			}

			 $scope.changeMenuOption = function(){
                 
                var item=this.item;
                item.checked = !item.checked;
                 
                $scope.menu.forEach(function (menu){
                    if(menu.id==item.id){
                        menu.checked = true;
                        $scope.choosenMenu = menu.id;
                    }else{
                        menu.checked = false;
                    }
                });
            };

			$scope.initializeData = function(){
                $scope.treeDataHistory = [];
				resultPrepareProductHistory = null;
				$scope.clearOtherInformation($scope.treeDataHistory);				
				$rootScope.showLoading();			
				$rootScope.countVcc = 0;
				$scope.controlClean();
				$scope.customerCodeLocal = $scope.searchedCustomer;
				$rootScope.customerCode = $scope.searchedCustomer;
				$scope.queryClientData();
            }

            /*
             * Function to allow entry only of digits
             */
            $scope.onKeyPressDigit = function (event) {
                var inputValue = event.keyCode;
                if ((inputValue < 48) || (inputValue > 57)) {
                    event.preventDefault();
                }
            };

            /*
             * Function for evaluate the button tab is pressed
             */
            $scope.tab = function (e) {
                if (e.keyCode == 9) {
                    $scope.code = $rootScope.dynamicClientData.clientGeneralData.code;
                    $rootScope.type = "Cliente";
                    $scope.buscarbyid($rootScope.dynamicData.clientGeneralData.code, $rootScope.customerType);
                    $rootScope.customerCode = $scope.code;
                    $rootScope.type = $rootScope.type;
                }
            };


            /*
             *Function for show Max Debt of customer
             */
            $scope.showMaxDebtRatio = function () {
                $scope.isMaxDebt = !$scope.isMaxDebt;
                $scope.isVisibleAdditionalData = false;
                $scope.isNaturalCustomer = false;
                $scope.isLegalPersonalData = false;

                var splitterElement = $("#splitterContainer").data("kendoSplitter");
                if ($scope.isMaxDebt) {
                    splitterElement.expand("#paneAdditionalInformation");
                } else {
                    splitterElement.collapse("#paneAdditionalInformation");
                }
            };

			//Colapsar menú de productos
			$scope.onSelect = function () {
				$("#products").data("kendoPanelBar").collapse($("li.k-state-active"));
			};
            /*
             *Function for show additional data of customer
             */
            /*$scope.showAdditionalData = function () {

                $scope.isVisibleAdditionalData = !$scope.isVisibleAdditionalData;
                $scope.isMaxDebt = false;

                if ($rootScope.clientGeneralData.type == "P") {
                    $scope.isNaturalCustomer = true;
                    $scope.isLegalPersonalData = false;
                    $scope.isVisibleEconomicGroup = false;
                } else {
                    $scope.isNaturalCustomer = false;
                }

                if ($rootScope.clientGeneralData.type == "C") {
                    $scope.isLegalPersonalData = true;
                    $scope.isNaturalCustomer = false;
                    $scope.isVisibleEconomicGroup = false;
                } else {
                    $scope.isLegalPersonalData = false;
                }

                if ($rootScope.type == "Grupo") {
                    $scope.isVisibleEconomicGroup = true;
                    $scope.isAditionalBtnVisible = false;
                    $scope.isMembersBtnVisible = true;
                    $scope.isNaturalCustomer = false;
                    $scope.isLegalPersonalData = false;
                } else {
                    $scope.isVisibleEconomicGroup = false;
                }

                var splitterElement = $("#splitterContainer").data("kendoSplitter");

                if ($scope.isVisibleAdditionalData) {
                    splitterElement.expand("#paneAdditionalInformation");
                } else {
                    splitterElement.collapse("#paneAdditionalInformation");
                }

            }*/
           	
			$rootScope.groupsProduct = [];
			$rootScope.groupsClient = [];
			$rootScope.groupsProductHist = [];

			
            $scope.selectCustomer = function (clientCode, subtype) {
				
                if (clientCode == -1) {
                    var id = $(this).closest("td");
                    clientCode = id.prevObject[0].dataItem.code;
                }
				var url = "/CTSProxy/services/cobis/web/views/clientviewer/container-clientviewer.html?ClientId=" + clientCode + "&CustomerType="+subtype;
				var menu = $filter('translate')('COMMONS.MENU.MNU_VCC');
                cobis.container.tabs.openNewTab(menu, url, menu, true);
			}
			
            $scope.getAllProductAdministratorDefault = function () {
                var promes = queryClientViewerService.getAllProductAdministratorDefault();
		
                promes.then(function (data) {
					if(data[0]!=undefined && data[0].conditionDefaultProductSons !=null){
                    $rootScope.groupsProduct = data[0].conditionDefaultProductSons;
					}
					if(data[1]!=undefined && data[1].conditionDefaultProductSons != null){
						$rootScope.groupsClient = data[1].conditionDefaultProductSons;
					}
					if(data[2]!=undefined && data[2].conditionDefaultProductSons != null){
						$rootScope.groupsProductHist = data[2].conditionDefaultProductSons;						
					}
                });
            };
			 $scope.getManagementContentSectionRoleByRol = function ( ) {
                var promes = queryClientViewerService.getManagementContentSectionRoleByRol();
                promes.then(function (data) {
                    $rootScope.otherInformation = data
                });
            };

            $scope.initData = function () {
				 //Creacion de arbol de productos basado en la lista de productos recuperados del servicio
                $scope.vc.removeChildVc('clientviewer');
				$scope.getAllProductAdministratorDefault();
				$scope.getManagementContentSectionRoleByRol();
				$scope.getRemittanceDetailColumns();
				
                if ( $location.absUrl().search("ClientId=") >= 0 && $location.absUrl().search("CustomerType=") >= 0) {                	
                	//Esconde el menu cuando muestro el arbol
					var clientCode = $location.absUrl().substring($location.absUrl().search("ClientId=")+9, $location.absUrl().search("&"))
					var customerType = $location.absUrl().substring($location.absUrl().search("CustomerType=")+13, $location.absUrl().search("#"))
					cobis.container.menu.hide();				
                    var splitterElement = $("#splitterContainer").data("kendoSplitter");
					$scope.customerCodeLocal = clientCode;
					$rootScope.customerType = customerType;
                    $scope.clientGeneralData.code = clientCode;
                    $rootScope.type = "Cliente";
					//Espera carga de html
					angular.element(document).ready(function () {
						$scope.queryClientData();					
						$scope.buscarbyid($scope.customerCodeLocal, $rootScope.customerType);
					});
								
                } else {
					//llenar con el servicio que obtiene los campos dinamicos de la VCC - MCA                
					$scope.buscar();
					$scope.menu = $scope.getMenu();
				}
								
				$scope.setConsolidateView();
				$scope.setProductsSale();
				$scope.setInformationView();
				$scope.setOtherInformation();
				$scope.setClientDinamicInformation();
				$scope.setProducts();
				$scope.setConsolidatePosition();
				$scope.setDebts();
				
            }
			$scope.setConsolidatePosition = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/consolidate-position-tpl.html"
						};                                            
						nav.registerCustomView('consolidatePositionView');
			}
			$scope.setDebts = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/debts-tpl.html"
						};                                            
						nav.registerCustomView('debts');
            }
			$scope.setProducts = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/products.html"
						};                                            
						nav.registerCustomView('products');
			}
			$scope.setClientDinamicInformation = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/client-infor-dinamic-tpl.html"
						};                                            
						nav.registerCustomView('clientDinamicInformation');
			}
			$scope.setConsolidateView = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/consolidate-view-tpl.html",
							useMinification: false
						};                                            
						nav.scripts = [ {
							module : "clientviewer",
							files : [ 'clientviewer/controllers/consolidate-view-ctrl.js']
					
						} ];
						nav.registerCustomView('consolidateView');
					}
			$scope.setProductsSale = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/products-sale-tpl.html",
							useMinification: false
						};                                            
						nav.scripts = [ {
							module : "clientviewer",
							files : [ 'clientviewer/controllers/products-sale-ctrl.js']
					
						} ];
						nav.registerCustomView('productsSale');
					}
			$scope.setInformationView = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
									   
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/information-view-tpl.html",
							useMinification: false
						};                                            
						
						nav.registerCustomView('informationView');
					}
			$scope.setOtherInformation = function () {
						var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;                     
			
						nav.customAddress = {
							id: 'clientviewer',
							url: "clientviewer/templates/other-information.html",
							useMinification: false
						};                                            
						                                          
						nav.registerCustomView('otherInformation');
					}
			//kendo.dataviz.ui["Chart"].fn.options.theme = 'Default';
				
                    $rootScope._scoreCustomer = 0;
                    $scope.riskObject = {};
                    $rootScope.portfolioRateObject = {};

                    $scope.orientationv = "vertical";
                    $scope.orientationh = "horizontal";
                    //$scope.customerCodeLocal = "0";
                    $scope.groupCode = "0";
                    $scope.type = "Cliente";
                    $scope.rateArray = [];
                    $scope.showProducts = false;
                    $scope.showProductsSale = false;
                    $scope.arrayColors = [ "#cd1533", "#d43851", "#dc5c71", "#e47f8f", "#eba1ad", "#009bd7", "#26aadd", "#4db9e3", "#73c8e9", "#99d7ef"];
					//"#3f51b5","#03a9f4","#4caf50","#f9ce1d", "#ff9800", "#ff5722"
					/*['#76d7fa', '#9ee1fc',
					  '#c0ebfc', '#def5fd', '#00b1f7',
					  '#01c4fa', '#77d8f9', '#c1ecfd',
					  '#0189d3', '#01a8dd', '#62c4e9',
					  '#b5e2f5', '#007ca8', '#459ec0',
					  '#8abed4', '#c7dfe9'];*/
                    $scope.bankingProductsActiveServices = [];

                    $rootScope.isVisiblePassive = true;
                    $rootScope.isVisibleDebts = true;
                    $rootScope.isVisibleContingents = true;
                    $rootScope.isVisibleGuarantees = true;
                    $rootScope.idPic = ""

                    $("#kpassive").hide();
                    $("#kdebts").hide();
                    $("#kcontigents").hide();
                    $("#kguarantees").hide();
                    $("#krisks").hide();
                    $("#backButton").hide();

                    var scope = $rootScope;
                    var local;

                    $scope.setCurrentView = function (currentView, e) {
                        if (e)
                            e.stopPropagation();
                        $scope.currentView = currentView;						
                    };

					$scope.setHistoryData = function (currentView, e) {
						$rootScope.showLoading();
						var api = new dsgnrCommons.API($rootScope.vc),
						nav = api.navigation;
						$rootScope.vc.removeChildVc('historyDynamicInfo');	
                        if (e)
                            e.stopPropagation();
						
                        $scope.currentView = currentView;	
						nav.customAddress = {
							id: 'otherInformationView',
							url: "clientviewer/templates/history-tpl.html"
						};
                
						
						
						nav.registerCustomView('historyDynamicInfo');
						$rootScope.hideLoading();
						
					}
                    $scope.clearBars = function () {
                        $($rootScope.idPic).hide();
                        $("#kpassive").hide();
                        $("#kdebts").hide();
                        $("#kcontigents").hide();
                        $("#kguarantees").hide();
                        $("#krisks").hide();
                        $("#backButton").hide();
                        $("#bars").delay().show();
                $("#panelbar").kendoPanelBar({
                    expandMode: "multiple"
                });
                    }
					
					$scope.expandCollapse = function (e) {
						var panelBar = $("#products").kendoPanelBar().data("kendoPanelBar");
						if(panelBar!=null && !angular.isUndefined(panelBar)){
							var item = panelBar.select();
							
							if (item.hasClass("k-state-active")) {						
								panelBar.collapse($("li", panelBar.element));						
							} else {
								panelBar.collapse($("li", panelBar.element));	
								panelBar.expand(item);
							}
						}
		
					}

                    $scope.getTotalAmount = function (property) {
                        return $rootScope[property];
                    }

                    $scope.getItem = function (object, property) {
                        if ($rootScope.dynamicData != undefined && $rootScope.dynamicData[object] != null) {
                            return $rootScope.dynamicData[object][property];
                        }
                        return null;
                    }

                    $rootScope.getObject = function (object, section, objectStructure, dtoParent, dataItem) {	
						if (dtoParent != null){
							var properties = $scope.getPropertiesSumaryPrimaryKey(dtoParent);
							object = object + dataItem[properties[0].name];
						}
						if(section == null){
							section = 'dynamicData';
                } else {
							section = section;
						}
                        if ($rootScope[section]!= undefined && object != null && $rootScope[section][object]!=undefined) {
							
							if(objectStructure != null && objectStructure != undefined) {
								if(objectStructure.properties!=null && objectStructure.properties!=undefined){
								if($rootScope[section][object].length>0){
									$scope.prepareData(section, object, objectStructure);
								}
                        } else {
									 $scope.getProperty($rootScope[section][object], objectStructure.name, objectStructure.format);
								}
							}
							
                            return $rootScope[section][object];
                        }
                        return null;
                    }
					
					$rootScope.getPadding = function (object){
						if(object != undefined && object != null ){
								var objectLength = $rootScope.getObject(object);
								if(objectLength != undefined  && objectLength != null && objectLength.length >0)
									return "padding:15px;";
						}
						return "";
					}

                    $rootScope.getDataSourceObject = function (object, objectStructure, section) {
						
						if(section ==null || angular.isUndefined(section)){
							section = 'dynamicData';
						}
                if (object != null && $rootScope[section] != undefined && $rootScope[section][object] != undefined) {
							$scope.prepareData(section, object, objectStructure);
							if (object != null) {
								if(section == 'dynamicData'){
									var columns = $rootScope.getDataColumns(objectStructure, false);
									return {
										dataSource: {
											data: $rootScope[section][object],
											columns : columns,
											pageSize: 10											
                                },
                                pageable: {
											numeric: true,
											previousNext: true,
											refresh: true
										},
										scrollable: true								
									};
								}else if(section == 'dynamicClientData'){
									var templates = $rootScope.getRowTemplate(objectStructure);
									var columns = $rootScope.getDataColumns(objectStructure, false);
									if(objectStructure.dtoName=="dataSourceGroup"){
									return {
										dataSource: {	
											data: $rootScope[section][object],
											pageSize: 10											
                                    },
                                    columns: columns,
										rowTemplate : templates.rowTemplate,
										altRowTemplate: templates.rowAltTemplate,										
										pageable: {
											numeric: true,
											previousNext: true,
											refresh: true
										},
										scrollable:  true								
									}
									}else{
										return {
										dataSource: {	
											data: $rootScope[section][object],
											pageSize: 10											
                                    },
                                    columns: columns,
										//rowTemplate : templates.rowTemplate, se comentan estos campos para mostrar detalle de grilla en Informacion adicional del cliente
										//altRowTemplate: templates.rowAltTemplate,										
										pageable: {
											numeric: true,
											previousNext: true,
											refresh: true
										},
										scrollable:  true								
									}
									}
									
									
								}
							}
						}
                        return null;
                    }

					$rootScope.getDataSourceObjectHistory = function (object, objectStructure, section) {
							if(section ==null || angular.isUndefined(section)){
							section = 'dynamicHistoryData';
						}

                if (object != null && $rootScope[section] != undefined && $rootScope[section][object] != undefined) {
							$scope.prepareData(section, object, objectStructure);
							if (object != null && section =='dynamicHistoryData') {
								var columnsInfo = $rootScope.getDataColumns(objectStructure,true);							
							return {
										toolbar: kendo.template($("#historyGridTemplate").html()),
									excel: {
											fileName: $filter('translate')(objectStructure.dtoText)+".xlsx",
												subject:"subject",
												allPages:true
												},
                            dataSource: {
                                data: $rootScope[section][object],
                                pageSize: 10
												},
									columns : columnsInfo,		
     								//pageable: true,
									resizable: true,
									excelExport: function(e) {
										var sheet = e.workbook.sheets[0];										
										sheet.rows[0].cells[0].hAlign = "center";
										for (var ci = 0; ci < sheet.rows[1].cells.length; ci++) {
											sheet.rows[1].cells[ci].hAlign = "center";
										}
										
									},
										pdfExport : function(e){
											e.preventDefault();
											$scope.onClickPDF(object, objectStructure.dtoText, $rootScope.dynamicClientData.clientGeneralData.name);
									},
									pageable: {
											pageable: true,
											numeric: true,
											previousNext: true,
											refresh: true
										},
									scrollable: true	
								};
						}
						}
                        return null;
                    }
					
					$scope.prepareData = function (section, object, objectStructure){
						for (var i = 0; i < $rootScope[section][object].length; i++) {
								for (var j = 0; j < objectStructure.properties.length; j++) {
                        if ($rootScope[section][object][i][objectStructure.properties[j].name] != null && !($rootScope[section][object][i][objectStructure.properties[j].name] instanceof Date) &&
                            isNaN($rootScope[section][object][i][objectStructure.properties[j].name])) {
										if ($rootScope[section][object][i][objectStructure.properties[j].name].indexOf("/Date(") > -1) {
												
											$rootScope[section][object][i][objectStructure.properties[j].name] = $scope.getConvertedDate($rootScope[section][object][i][objectStructure.properties[j].name]);
										}										
										}
									/*if (objectStructure.properties[j].type == 'decimal') {
										$rootScope[section][object][i][objectStructure.properties[j].name] =  $scope.getConvertedDecimal($rootScope[section][object][i][objectStructure.properties[j].name]);
									}*/
									if(objectStructure.properties[j].format == '{0:n}'){
							if(typeof $rootScope[section][object][i][objectStructure.properties[j].name] === 'string'){
							    var rate = kendo.parseFloat($rootScope[section][object][i][objectStructure.properties[j].name].trim());
							    if (rate != null){
							        $rootScope[section][object][i][objectStructure.properties[j].name] = kendo.toString(rate, "n");
							    }
							}else{
										$rootScope[section][object][i][objectStructure.properties[j].name] = kendo.toString($rootScope[section][object][i][objectStructure.properties[j].name], "n");
									}
								}																								
							}
					}
            }
					
                    $scope.getGroupingField = function (object) {
                        if (object.properties != null) {
                            for (var i = 0; i < object.properties.length; i++) {
                                if (object.properties[i].grouping) {
                                    return object.properties[i].name;
                                }
                            }
                        }
                        return '';
                    }

                    $scope.getHeader = function (object,
                        objectStructure) {
                        var separator = '';
                        var returnValue = '';
						var visible = false;
                        for (var i = 0; i < objectStructure.properties.length; i++) {
                            if (objectStructure.properties[i].visibleSumaryGroup) {
                                returnValue += separator + object[objectStructure.properties[i].name];
                                separator = ' - ';
								visible = true;
                            }
                        }
						if(!visible){
							returnValue = $filter('translate')(objectStructure.dtoText);
						}
                        return returnValue;
                    }

                    $scope.getProperty = function (object, property, format) {
						if(object != null){
							if(typeof object[property] === 'string'){
								if(object[property].indexOf("/Date(") > -1){
									object[property] = $scope.getConvertedDate(object[property]);
								}
							}
							if(typeof object[property] === 'number' && $scope.isFloat(object[property])){
								object[property] = kendo.toString(object[property], "n");
								return;						
							}							
							if(format == '{0:n}'){
									object[property] = kendo.toString(object[property], "n");
								}
							
				
                        return object[property];
						}
                    }

                    $scope.getPropertiesSumary = function (object,
                        property) {
						var propertiesSummary = [];
                        
                        for (var i = 0; i < object.properties.length; i++) {
                            if (object.properties[i].visibleSumaryDetail) {
                               propertiesSummary
                                    .push(object.properties[i]);
                            }
                        }
                        return propertiesSummary;
                    }
					$scope.getPropertiesPrimaryKey = function (object) {
                        var returnProperties = [];
                        for (var i = 0; i < object.properties.length; i++) {
                            if (object.properties[i].primaryKey) {
                               return object.properties[i].name;
                            }
                        }
                        return null;
                    }

                    $scope.getPropertiesSumary = function (object,
                        property) {
                        var returnProperties = [];
                        for (var i = 0; i < object.properties.length; i++) {
                            if (object.properties[i].visibleSumaryDetail && !object.properties[i].primaryKey) {
                                returnProperties
                                    .push(object.properties[i]);
                            }
                        }
                        return returnProperties;
                    }

                    $scope.getPropertiesSumaryPrimaryKey = function (
                        object, property) {
                        var returnProperties = [];
                        for (var i = 0; i < object.properties.length; i++) {
                            if (object.properties[i].visibleSumaryDetail && object.properties[i].primaryKey) {
                                returnProperties
                                    .push(object.properties[i]);
                            }
                        }
                        return returnProperties;
                    }

                    $scope.getProcessFilterField = function (object,  objectStructure) {
                        for (var i = 0; i < objectStructure.properties.length; i++) {
                            if (objectStructure.properties[i].filterInProcess) {
                                return object[objectStructure.properties[i].name];
                            }
                        }
                        return '';
                    }

                    $rootScope.getVisibleSection = function (objectName, section) {
						if(section == null || angular.isUndefined(section)){
							section = 'dynamicData'
						}
						if(objectName == "seriesEmails"){
							return false;
                } else {
							return ($rootScope[section]!=undefined && $rootScope[section][objectName] != null && $rootScope[section][objectName].length > 0);							
						}
                    }
				
					
					$rootScope.getVisibleSectionClient = function (typeClient) {						
						if (typeClient != null && $rootScope.dynamicClientData != null && $rootScope.dynamicClientData.clientGeneralData != null && $rootScope.dynamicClientData.clientGeneralData.type == typeClient){
								return true;
						}
						return false;
                    }
					
					$rootScope.isList = function (
                        isList) {
                        if (isList != null && isList){
							return true;
						}
						return false;
                    }
			
					$scope.getConvertedDate = function (date){						
                if (!angular.isUndefined(date) && date != null && date != "") {
							return kendo.toString(eval(date.replace(/\/Date\((\d+)\)\//gi,"new Date($1)")),$scope.dateFormat);
						}
					}
					
					$scope.getConvertedDecimal = function (decimal){						
						if(!angular.isUndefined(decimal) && decimal!=null){
							var decimalFormat = "n"+cobis.userContext.getValue(cobis.constant.CURRENCY_DECIMAL_PLACES);						
							return kendo.toString(decimal,decimalFormat);
						}
					}
					
					$scope.isFloat = function (number){					
						return number != "" && !isNaN(number) && Math.round(number) != number;
					}
					
					
					
                    $rootScope.getDataColumns = function (objectStructure, hasTitle) {
                        var columns = [];
                        if (objectStructure != undefined && objectStructure.properties != null) {

                    //ordenar
                    objectStructure.properties = $scope.sortProperties(objectStructure.properties);

                            for (var i = 0; i < objectStructure.properties.length; i++) {
                                if (objectStructure.properties[i].detailSection) {
                            var style = '',
                                objClass = '';
									if(objectStructure.properties[i].style!=null){
										style = objectStructure.properties[i].style;
									}
                                    columns.push({
                                            field: objectStructure.properties[i].name,
                                            title: $filter('translate')(objectStructure.properties[i].text),
                                            width: objectStructure.properties[i].width,
                                            format: objectStructure.properties[i].format,
                                attributes: {
                                    style: style
                                }
                                        });
                                }
                            }
                        }
						
						if (hasTitle){
                    return [{
                        title: objectStructure.dtoDescription,
                        headerAttributes: {
                            style: "text-align:center !important"
                        },
                        columns: columns
                    }];
						}else {
                        return columns;
                    }
                    }
					
					$rootScope.getRowTemplate = function (objectStructure) {
						var template = "",
							rowTemplate="",
							rowAltTemplate="",
							headerAltRowTemplate="";
				
						var headerRowTemplate = "<tr data-uid='#: uid #' class = 'blue ng-scope'";
						var headerAltRowTemplate = "<tr data-uid='#: uid #' class = 'k-alt ng-scope'";
						var isColumnTemplate = true;
						var trElement = '';
						
                        if (objectStructure.properties != null) {
						
                            for (var i = 0; i < objectStructure.properties.length; i++) {
                                if (objectStructure.properties[i].primaryKey) {									
									isColumnTemplate = false;
									trElement = " style='{{getColor(dataItem."+objectStructure.properties[i].name+")}}'>";
								}
							
								if(objectStructure.properties[i].detailSection){
									var tdClass = "ng-scope";
									if(i!=0 && i%5==0){
										tdClass += " page-break"
								}
									template += "<td colspan='1' style='text-align: center' role='gridcell' class='"+tdClass+"'>";
									
									if(objectStructure.properties[i].type=='BUTTON'){
										template = template + "<button type='button' class='btn btn-default btn-xs' ng-click='selectCustomer(dataItem.code, dataItem.subtype)'><span class='"+objectStructure.properties[i].format+"'></span></button>";
									}else{
										template += "<span ng-bind='dataItem."+objectStructure.properties[i].name+"' class='ng-binding'>{{dataItem."+objectStructure.properties[i].name+"}}</span>";
									}
									template += "</td>";
								}
                            }
							
							if(isColumnTemplate){
								headerRowTemplate +=   ">";
								headerAltRowTemplate +=  ">";
								isColumnTemplate = false;
							}else {							
								headerRowTemplate +=  trElement;
								headerAltRowTemplate +=  trElement;
							}
							rowAltTemplate = headerAltRowTemplate + template + "</tr>";
							rowTemplate = headerRowTemplate + template + "</tr>";
                        }
                return {
                    rowTemplate: rowTemplate,
                    rowAltTemplate: rowAltTemplate
                };
						
                    }
                    $rootScope.setDetailDataSoruce = function (dataItem, dto, dtoParent, section) {
                        $scope.nameDataSource = dto.dtoName;
						var properties = $scope.getPropertiesSumaryPrimaryKey(dtoParent);
						

                        if (dataItem != null || dataItem !=undefined) {
							$scope.primaryKey = dataItem[properties[0].name];
                            var result = consolidatePositionService
                                .getOperationGuarrantees(
                                    dto.serviceId,
                                    dataItem[properties[0].name]);
                            result
                                .then(function (data) {
                                    $rootScope[section][$scope.nameDataSource + $scope.primaryKey] = data[$scope.nameDataSource];
                                });
                        }
                    }
					
					//Prepara la data de Remesas
					$rootScope.setDetailRemittanceDataSoruce = function (dataItem, nameDataSource, section) {
						
						if (dataItem != null && dataItem != undefined && dataItem.details != null && dataItem.details != undefined && $scope.remittanceDetailColumns != undefined){
							dataItem.details.forEach(function(item){
								for(var i = 0; i < $scope.remittanceDetailColumns.length; i++){
									if(typeof item[$scope.remittanceDetailColumns[i].field] === 'string'){
										if(item[$scope.remittanceDetailColumns[i].field].indexOf("/Date(") > -1){
											item[$scope.remittanceDetailColumns[i].field] = $scope.getConvertedDate(item[$scope.remittanceDetailColumns[i].field]);
										}
									}
								}							
								
							});
						}
					}
				
				
					 $rootScope.setDetailDataSoruceDirections = function (
                        dataItem, nameDataSource, service) {
						 if(dataItem!= null && dataItem != undefined){
							var searchCustomer = {                        
								customerID: "",
								addressId:""
							}
						   searchCustomer.customerID=$scope.customerCodeLocal;
						   searchCustomer.addressId= dataItem.addressId;
						   $rootScope.customerAddressId = dataItem.addressId;
							if (dataItem != null) {
								var result = consolidatePositionService
									.getWebServiceExecutor(
										service,
										searchCustomer);
								result
									.then(function (data) {
										$rootScope.dynamicClientData[nameDataSource + $rootScope.customerAddressId] = data;
									});
							}
						}
                    }
					
					
                    $rootScope.ratesScoresConsolidated = function (customer) {
						$rootScope.showLoading();
                        $rootScope._scoreCustomer = 0;
                        $scope.riskObject = {};
                        $rootScope.portfolioRateObject = {};
                        if (customer != null) {

                            var resultInternalRate = consolidatePositionService
                                .getRateByClientId(customer);
                            resultInternalRate
                                .then(function (data) {
                                    $scope._data = [];
                                    angular
                                        .forEach(
                                            data,
                                            function (value) {

                                                $scope._data
                                                    .push({
                                                        operation: value.operation,
                                                        quota: value.quota,
                                                        tQuota: value.tQuota,
                                                        expirationDate: $filter(
                                                            'date')
                                                        (
                                                            new Date(
                                                                parseInt(value.expirationDate
                                                                    .substring(
                                                                        value.expirationDate
                                                                        .indexOf("(") + 1,
                                                                        value.expirationDate
                                                                        .indexOf(")")))),
                                                            "dd/MM/yyyy"),
                                                        cancelationDate: $filter(
                                                            'date')
                                                        (
                                                            new Date(
                                                                parseInt(value.cancelationDate
                                                                    .substring(
                                                                        value.cancelationDate
                                                                        .indexOf("(") + 1,
                                                                        value.cancelationDate
                                                                        .indexOf(")")))),
                                                            "dd/MM/yyyy"),
                                                        lateDays: value.lateDays,
                                                        rate: value.rate
                                                    });

                                            });

                                    $scope.internalRateSource = new kendo.data.DataSource({
                                        data: $scope._data,
										
                                        schema: {
                                            model: {
                                                fields: {
                                                    operation: {
                                                        type: "number"
                                                    },
                                                    quota: {
                                                        type: "number"
                                                    },
                                                    tquota: {
                                                        type: "string"
                                                    },
                                                    expirationDate: {
                                                        type: "string"
                                                    },
                                                    cancelationDate: {
                                                        type: "string"
                                                    },
                                                    lateDays: {
                                                        type: "number"
                                                    },
                                                    rate: {
                                                        type: "number"
                                                    }
                                                }
                                            }
                                },
                                sort: [
                                    {
                                        field: "operation",
                                        dir: "asc"
                                    },
                                    {
                                        field: "quota",
                                        dir: "asc"
                                        }
                                ]
                                    });
									$rootScope.countVcc++;
									$rootScope.hideLoading();
                        }).
                    catch (function (data) {
									$rootScope.countVcc++;
									$rootScope.hideLoading();
								});
                            $rootScope.countVcc++;
                            $rootScope.hideLoading();

                           
                            $rootScope.countVcc++;
                            $rootScope.hideLoading();

							var portfolioRate = consolidatePositionService.getPortfolioRateByClientId(customer);
							if(customer != null && customer != undefined){				
								portfolioRate.then(function (data) {
									$rootScope.portfolioRateObject = {};
									if(data[0] != undefined){
									$rootScope.portfolioRateObject.customerId = data[0].ente;
									$rootScope.portfolioRateObject.portfolioRate = data[0].ccaRate;
									}
									$rootScope.countVcc++;
									$rootScope.hideLoading();
                        }).
                        catch (function (data) {
									$rootScope.countVcc++;
									$rootScope.hideLoading();
								});
							}								
								
                            var result5 = consolidatePositionService
                                .searchScoreCustomer(customer);
                            result5.then(function (data) {

                                if (data != undefined) {
                                    $rootScope._scoreCustomer = data.scoreCustomer;
                                    if (data.changeDate != undefined) {

                                        $rootScope.rateScore = [];
                                        $rootScope.rateScore.push({
                                                changeDate: $filter(
                                                    'date')
                                                (
                                                    parseInt(data.changeDate
                                                        .substring(
                                                            data.changeDate
                                                            .indexOf("(") + 1,
                                                            data.changeDate
                                                            .indexOf(")"))),
                                                    "dd/MM/yyyy"),
                                                scoreCustomer: data.scoreCustomer
                                            });

                                        $scope.rateSource = new kendo.data.DataSource({
                                            data: $rootScope.rateScore,
                                            schema: {
                                                model: {
                                                    fields: {
                                                        changeDate: {
                                                            type: "string"
                                                        },
                                                        scoreCustomer: {
                                                            type: "number"
                                                        }
                                                    }
                                                }
                                            }
                                        });

                                    }
                                }
									$rootScope.countVcc++;
									$rootScope.hideLoading();
                    }).
                    catch (function (data) {
								$rootScope.countVcc++;
								$rootScope.hideLoading();
							});
                            
                        }
                    };

                    $rootScope.columnsRate = [
                        {
                            field: "changeDate",
                            title: $filter('translate')
                            (
                                'COMMONS.HEADERS.HDR_CHANGE_DATE')
          },
                        {
                            field: "scoreCustomer",
                            title: $filter('translate')(
                                'COMMONS.HEADERS.HDR_RATE')
          }];

                $scope.columnsInternalRate = function() { 
						return { 
								columns: [
                        {
                            field: "operation",
							title: $filter('translate')('COMMONS.HEADERS.HDR_OPERATION'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 100
						},
                        {
                            field: "quota",
							title: $filter('translate')('COMMONS.HEADERS.HDR_QUOTA'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 100
						},
                        {
                            field: "tQuota",
							title: $filter('translate')('COMMONS.HEADERS.HDR_TQUOTA'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "expirationDate",
							title: $filter('translate')('COMMONS.HEADERS.HDR_EXPIRATION_DATE'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 130
						},
                        {
                            field: "cancelationDate",
							title: $filter('translate')('COMMONS.HEADERS.HDR_CANCELATION_DATE'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 130
						},
                        {
                            field: "lateDays",
							title: $filter('translate')('COMMONS.HEADERS.HDR_LATE_DAYS'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "rate",
							title: $filter('translate')('COMMONS.HEADERS.HDR_SCORE'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						}]
						};
				}
	

	

			$scope.columnsInfoCred = function() {
                return {
                    columns: [
                        {
                            field: "entity",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_ENTITY'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 100
						},
                        {
                            field: "obligationType",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_OBLIGATION_TYPE'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "loanType",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_LOAN_TYPE'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "currentStatus",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_STATUS'),
							width: 100
						},
                        {
                            field: "currentAmount",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_BALANCE'),
							format: "{0:n}",
                            attributes: {
                                style: "text-align: right; white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "dateCreaDebt",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_CREA_DEBT'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 120
						},
                        {
                            field: "dateActDebt",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_DATE_ACT_DEBT'),
                            attributes: {
                                style: "white-space: normal"
                            },
							width: 130
						}]
								};
			}


                    if ($location != undefined) {
                        local = $location;

                        // cobis.userContext.setValue("URLANTERIOR",
                        // cobis.userContext.getValue('URLACTUAL'));
                        $rootScope.urlAnterior = $rootScope.urlActual;
                        // cobis.userContext.setValue("URLACTUAL",
                        // local.$$path);
                        $rootScope.urlActual = local.$$path;

                        if ($rootScope.urlActual != $rootScope.urlAnterior && $rootScope.urlAnterior == "/consolidatePosition") {
                            $rootScope.consolidatePosition = 1;
                        } else {
                            $rootScope.consolidatePosition = 0;
                        }

                    }

                    $scope.onBarClick = function (e) {

                        $("#kpassive").hide();
                        $("#kdebts").hide();
                        $("#kcontigents").hide();
                        $("#kguarantees").hide();
                        $("#krisks").hide();
                        $("#bars").hide(1000);

                        if (e.category == $filter('translate')(
                            'MENU.LABELS.LBL_PASSIVE')) {
                            $("#kpassive").delay(1000).show(1000);
                            $("#backButton").delay(1000).show(1000);

                            $rootScope.idPic = "#kpassive";
                        }
                        if (e.category == $filter('translate')(
                            'MENU.LABELS.LBL_DEBTS')) {
                            $("#kdebts").delay(1000).show(1000);
                            $("#backButton").delay(1000).show(1000);

                            $rootScope.idPic = "#kdebts";
                        }
                        if (e.category == $filter('translate')(
                            'MENU.LABELS.LBL_GUARANTEES')) {
                            $("#kguarantees").delay(1000)
                                .show(1000);
                            $("#backButton").delay(1000).show(1000);

                            $rootScope.idPic = "#kguarantees";
                        }
                        if (e.category == $filter('translate')(
                            'MENU.LABELS.LBL_CONTINGENTS')) {
                            $("#kcontigents").delay(1000)
                                .show(1000);
                            $("#backButton").delay(1000).show(1000);

                            $rootScope.idPic = "#kcontigents";
                        }
						if (e.category == $filter('translate')(
                            'MENU.LABELS.LBL_RISKS')) {
                            $("#krisks").delay(1000)
                                .show(1000);
                            $("#backButton").delay(1000).show(1000);

                            $rootScope.idPic = "#krisks";
                        }
                    }

                    $scope.onBackReturn = function () {
                        $($rootScope.idPic).hide(1000);
                        $("#backButton").hide(1000);
                        $("#bars").delay(1000).show(1000);
                    }

                    $scope.productSaleClick = function () {
                        $scope.showProducts = false;
                        $scope.showProductsSale = true;
                    }
                    $scope.productsClick = function () {
                        $scope.showProducts = true;
                        $scope.showProductsSale = false;
                    }

                    scope.isVisibleAdditionalInformation = true;
                    $rootScope.totales = [0, 0, 0, 0, 0, 0];
                    $rootScope.totalDebts = 0;
                    $rootScope.totalLiabilities = 0;
                    $rootScope.totalWarranties = 0;

                    $rootScope.totalContingencies = 0;
                    $rootScope.totalIndirect = 0;

                    $scope.isVisiblePassive = $rootScope.visiblePasives;
                    $scope.isVisibleDebts = $rootScope.visibleDebts;
                    $scope.isVisibleContingents = $rootScope.visibleContingents;
                    $scope.isVisibleGuarantees = $rootScope.visibleGuarantees;
                    $scope.isVisibleSavingAccounts = ($rootScope.productsSavingAccount != null && $rootScope.productsSavingAccount.length > 0);

                    // $scope.totales =
                    // cobis.userContext.getValue('TOTAL_PRODUCTS');

                    // dividir celdas
                    $scope.splitCells = function () {

                        $("#kpassive")
                            .removeClass($rootScope.clase);
                        $("#kguarantees").removeClass(
                            $rootScope.clase);
                        $("#kcontigents").removeClass(
                            $rootScope.clase);
                        $("#kdebts").removeClass($rootScope.clase);
                        $("#krisks").removeClass($rootScope.clase);

                        $("#kpassive").addClass("col-xs-12");
                        $("#kguarantees").addClass("col-xs-12");
                        $("#kcontingents").addClass("col-xs-12");
                        $("#kdebts").addClass("col-xs-12");
                        $("#krisks").addClass("col-xs-12");

                        $rootScope.clase = "col-xs-12";
                    };

                    // BlockScreen
                    $scope.blockScreen = function () {
                        $.blockUI({
                            message: $('<div>Procesando..</div>'),
                            css: {
                                border: 'none',
                                backgroundColor: '#000',
                                opacity: .5,
                                color: '#fff'
                            }
                        });
                    };

                    function contain(element) {
                        return element.search(this.stateCode) >= 0;
                    }


                    $scope.unblockScreen = function () {
                        $.unblockUI();
                    };

                    $scope.LoadDataConsolidation = function () {
						$rootScope.showLoading();					
						if($scope.customerCodeLocal!=null){
							// cobis.userContext.setValue("visiblePassives",
							// false);
							$rootScope.visiblePasives = false;
							// cobis.userContext.setValue("visibleGuarantees",
							// false);
							$rootScope.visibleGuarantees = false;
							// cobis.userContext.setValue("visibleContingents",
							// false);
							$rootScope.visibleContingents = false;
							// cobis.userContext.setValue("visibleDebts",
							// false);
							$rootScope.visibleDebts = false;
							var p = 0;
							var g = 0;
							var c = 0;
							var d = 0;
							$rootScope.totalDebts = 0;
							$rootScope.totalLiabilities = 0;
							$rootScope.totalWarranties = 0;

							// $rootScope.totalContingencies = 0;
							$rootScope.totalIndirect = 0;
							var result = $rootScope.resultConsolidation;

							if (result && result.length > 0) {
								$rootScope.dataProducts = new kendo.data.DataSource({
									schema: {
										data: function () {
											var prod = [];
											var products = [];
											angular.forEach(result,function (value) {
												var type = value.type;
												var product = value.product;
												var amount = value.amount;
												var flag = 0;

												if (value.product != "Riesgo") {
													for (var i = 0; i < products.length; i++) {
														if (type == products[i].type && product == products[i].product) {
															products[i].amount = products[i].amount + amount;
															flag = 1;
														}
													}

													if (flag == 0) {
														products
															.push({
																type: type,
																product: product,
																amount: amount
															});
													}
												}
											});

											var iteratorPasivas = 0;
											var iteratorGarantias = 0;
											var iteratorContigentes = 0;
											var iteratorDeudas = 0;

											products.forEach(function (pr,index) {
												var typeDescription = pr.type;

												if (pr.type == "PASIVAS") {
													typeDescription = $filter(
														'translate')
													(
														'MENU.LABELS.LBL_PASSIVE');

												};
												if (pr.type == "GARANTIAS") {
													typeDescription = $filter(
														'translate')
													(
														'MENU.LABELS.LBL_GUARANTEES');

												};
												if (pr.type == "CONTINGENTES") {
													typeDescription = $filter(
														'translate')
													(
														'MENU.LABELS.LBL_CONTINGENTS');

												};
												if (pr.type == "INDIRECTO") {
													typeDescription = $filter(
														'translate')
													(
														'MENU.LABELS.LBL_RISKS');

												};
												if (pr.type == "DEUDAS" || pr.type == "DEBTS") {
													typeDescription = $filter(
														'translate')
													(
														'MENU.LABELS.LBL_DEBTS');

												};

												prod
													.push({
														categ: typeDescription,
														value: pr.amount / 1000,
														nam: pr.product

													});
												});

											// dividir la celda
											// $scope.splitCells();

											return prod;
										}
									},
									group: {
										field: "nam"
									}
								});

								// TotalLiabilities

								angular
									.forEach(
										result,
										function (value) {
											if (value.type == "PASIVAS") {
												$rootScope.totalLiabilities = $rootScope.totalLiabilities + value.amount;
											}
											if (value.type == "GARANTIAS") {
												$rootScope.totalWarranties = $rootScope.totalWarranties + value.amount;
											}
											if (value.type == "DEUDAS" || value.type == "ACTIVAS") {
												$rootScope.totalDebts = $rootScope.totalDebts + value.amount;
											}
											if (value.type == "CONTINGENTES") {
												$rootScope.totalContingencies = $rootScope.totalContingencies + value.amount;
											}
											if (value.type == "INDIRECTO") { // validar
												// nombre
												// para
												// INDIRECTO
												$rootScope.totalIndirect = $rootScope.totalIndirect + value.amount;
											}
										});

								// riesgosDatasource
								var ancla = 1;
								$rootScope.risksSource = new kendo.data.DataSource({
									schema: {
										data: function () {
											var prod = [];
											var products = [];
											angular
												.forEach(
													result,
													function (
														value) {

														if (ancla == 1) {
															products
																.push({
																	type: "Risk",
																	product: "TOTAL RIESGOS",
																	amount: 1500000,
																	name: "TOTAL RIESGOS COBIS",
																	number: "152452RIESGOS5635"
																});

															ancla = 0;
														}

													});

											products
												.forEach(function (
													pr,
													index) {
													prod
														.push({
															categ: pr.type,
															value: pr.amount,
															nam: pr.product,
															text: pr.name,
															num: pr.number

														});
												});

											return prod;

										}
									},
									group: {
										field: "categ"
									}
								});

							} 
						}
					
                    };

                    $scope.LoadData = function () {
						$rootScope.showLoading();
                        $scope.totalLoans = 0;
                        $scope.totalOverdrafts = 0;
                        $scope.totalCurrentAccounts = 0;
                        $scope.totalFixedTerm = 0;
                        $scope.totalGuarantees = 0;
                        $scope.totalInsurancePolicy = 0;
                        $scope.totalPromissoryNotes = 0;
                        $scope.totalCredits = 0;
                        $scope.totalContingencies = 0;
                        $scope.totalIndirectPortfolio = 0;
                        $scope.totalSavingAccount = 0;

                        $rootScope.overdrafts = new kendo.data.DataSource({
                            data: $rootScope.productsOverdraft,
                            schema: {
                                model: {
                                    fields: {
                                        numberOperation: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        usedAmount: {
                                            type: "number"
                                        },
                                        rate: {
                                            type: "number"
                                        },
                                        amountRisk: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleOverdrafts = ($rootScope.productsOverdraft != null && $rootScope.productsOverdraft.length > 0);

                        // Use to format to date fields
                        $scope.convertFieldsLiabilities = function (
                            data) {
                            var currentAc = data;
                            for (var i in currentAc) {
                                if (currentAc[i].openingDate != null) {
                                    var dateChange = new Date(
                                        $filter('date')
                                        (
                                            parseInt(
                                                currentAc[i].openingDate
                                                .substring(
                                                    currentAc[i].openingDate
                                                    .indexOf("(") + 1,
                                                    currentAc[i].openingDate
                                                    .indexOf(")")),
                                                "dd/MM/yyyy")));
                                    currentAc[i].openingDate = dateChange
                                        .toLocaleDateString();
                                }
                                if (currentAc[i].expirationDate != null) {
                                    dateChange = new Date(
                                        $filter('date')
                                        (
                                            parseInt(
                                                currentAc[i].expirationDate
                                                .substring(
                                                    currentAc[i].expirationDate
                                                    .indexOf("(") + 1,
                                                    currentAc[i].expirationDate
                                                    .indexOf(")")),
                                                "dd/MM/yyyy")));
                                    currentAc[i].expirationDate = dateChange
                                        .toLocaleDateString();
                                }

                            }

                            return currentAc;
                        }

                        $rootScope.currentAccounts = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsLiabilities($rootScope.productsCurrentAccount),
                            schema: {
                                model: {
                                    fields: {
                                        typeDescription: {
                                            type: "string"
                                        },
                                        operationNumber: {
                                            type: "string"
                                        },
                                        rol: {
                                            type: "string"
                                        },
                                        openingDate: {
                                            type: "string"
                                        },
                                        expirationDate: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        available: {
                                            type: "number"
                                        },
                                        balance: {
                                            type: "number"
                                        },
                                        retentions: {
                                            type: "number"
                                        },
                                        blockades: {
                                            type: "number"
                                        },
                                        overdraftLimit: {
                                            type: "number"
                                        },
                                        protests: {
                                            type: "string"
                                        },
                                        rate: {
                                            type: "number"
                                        },
                                        status: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.savingAccounts = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsLiabilities($rootScope.productsSavingAccount),
                            schema: {
                                model: {
                                    fields: {
                                        typeDescription: {
                                            type: "string"
                                        },
                                        operationNumber: {
                                            type: "string"
                                        },
                                        rol: {
                                            type: "string"
                                        },
                                        openingDate: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        available: {
                                            type: "number"
                                        },
                                        balance: {
                                            type: "number"
                                        },
                                        retentions: {
                                            type: "number"
                                        },
                                        blockades: {
                                            type: "number"
                                        },
                                        rate: {
                                            type: "number"
                                        },
                                        status: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.fixedTerms = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsLiabilities($rootScope.productsFixedTerm),
                            schema: {
                                model: {
                                    fields: {
                                        typeDescription: {
                                            type: "string"
                                        },
                                        operationNumber: {
                                            type: "string"
                                        },
                                        rol: {
                                            type: "string"
                                        },
                                        openingDate: {
                                            type: "string"
                                        },
                                        expirationDate: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        balance: {
                                            type: "number"
                                        },
                                        pledgedAmount: {
                                            type: "number"
                                        },
                                        rate: {
                                            type: "number"
                                        },
										 status: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisiblecurrentAccount = ($rootScope.productsCurrentAccount != null && $rootScope.productsCurrentAccount.length > 0);
                        $scope.isVisibleSavingAccounts = ($rootScope.productsSavingAccount != null && $rootScope.productsSavingAccount.length > 0);
                        $rootScope.isVisiblefixedTerms = ($rootScope.productsFixedTerm != null && $rootScope.productsFixedTerm.length > 0);

                        $rootScope.warranties = new kendo.data.DataSource({
                            data: $rootScope.productsGuarantees,
                            schema: {
                                model: {
                                    fields: {
                                        warrantyType: {
                                            type: "string"
                                        },
                                        code: {
                                            type: "number"
                                        },
                                        currency: {
                                            type: "number"
                                        },
                                        initialValue: {
                                            type: "number"
                                        },
                                        actualValue: {
                                            type: "number"
                                        },
                                        mrc: {
                                            type: "string"
                                        },
                                        stateCode: {
                                            type: "string"
                                        },
                                        warrantyDescription: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.promissoryNotes = new kendo.data.DataSource({
                            data: $rootScope.productsPromissoryNote,
                            schema: {
                                model: {
                                    fields: {
                                        warrantyType: {
                                            type: "string"
                                        },
                                        code: {
                                            type: "number"
                                        },
                                        currency: {
                                            type: "number"
                                        },
                                        initialValue: {
                                            type: "number"
                                        },
                                        actualValue: {
                                            type: "number"
                                        },
                                        stateCode: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        // Use to format to date fields
                        $scope.convertFields = function (data, type) {
                            var currentAc = data;
                            if (type == undefined) {
                                for (var i in currentAc) {
                                    if (currentAc[i].date_vto != null) {
                                        var dateChange = new Date(
                                            $filter('date')
                                            (
                                                parseInt(
                                                    currentAc[i].date_vto
                                                    .substring(
                                                        currentAc[i].date_vto
                                                        .indexOf("(") + 1,
                                                        currentAc[i].date_vto
                                                        .indexOf(")")),
                                                    "dd/MM/yyyy")))
                                            .toLocaleDateString();
                                        currentAc[i].date_vto = dateChange;
                                    }
                                }
                            }

                            return currentAc;
                        }

                        $rootScope.insurancePolicy = new kendo.data.DataSource({
                            data: $scope
                                .convertFields($rootScope.productsInsurancePolicy),
                            schema: {
                                model: {
                                    fields: {
                                        type_op_desc: {
                                            type: "string"
                                        },
                                        insurance_company: {
                                            type: "string"
                                        },
                                        type_policy: {
                                            type: "string"
                                        },
                                        policy_number: {
                                            type: "number"
                                        },
                                        number_guaranteed: {
                                            type: "number"
                                        },
                                        line: {
                                            type: "string"
                                        },
                                        date_vto: {
                                            type: "string"
                                        },
                                        state: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleWarrantiesDet = ($rootScope.productsGuarantees != null && $rootScope.productsGuarantees.length > 0);

                        $rootScope.isVisiblePromissoryNotesDet = ($rootScope.productsPromissoryNote != null && $rootScope.productsPromissoryNote.length > 0);

                        $rootScope.isVisibleInsurancePolicyDet = ($rootScope.productsInsurancePolicy != null && $rootScope.productsInsurancePolicy.length > 0);

                        $scope.changeDate = function (dataS) {
                            for (var i in dataS) {
                                if (dataS[i].date_apt != null) {
                                    var dateChangeApt = new Date(
                                        $filter('date')
                                        (
                                            parseInt(
                                                dataS[i].date_apt
                                                .substring(
                                                    dataS[i].date_apt
                                                    .indexOf("(") + 1,
                                                    dataS[i].date_apt
                                                    .indexOf(")")),
                                                "dd/MM/yyyy")));
                                    dataS[i].date_apt = dateChangeApt
                                        .toLocaleDateString();
                                }
                                if (dataS[i].date_vto != null) {
                                    var dateChangeVto = new Date(
                                        $filter('date')
                                        (
                                            parseInt(
                                                dataS[i].date_vto
                                                .substring(
                                                    dataS[i].date_vto
                                                    .indexOf("(") + 1,
                                                    dataS[i].date_vto
                                                    .indexOf(")")),
                                                "dd/MM/yyyy")));
                                    dataS[i].date_vto = dateChangeVto
                                        .toLocaleDateString();
                                }
                            }
                            return dataS;
                        };

                        $rootScope.credits = new kendo.data.DataSource({

                            data: $scope
                                .changeDate($rootScope.productsCredits),
                            schema: {
                                model: {
                                    fields: {
                                        operationType: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        lineNumber: {
                                            type: "string"
                                        },
                                        openingDate: {
                                            type: "string"
                                        },
                                        usedAmount: {
                                            type: "number"
                                        },
                                        available: {
                                            type: "number"
                                        },
                                        riskAmount: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleStandbyCreditLine = ($rootScope.productsCredits != null && $rootScope.productsCredits.length > 0);

                        $rootScope.contingencies = new kendo.data.DataSource({
                            data: $scope
                                .changeDate($rootScope.productsContingencies),

                            schema: {
                                model: {
                                    fields: {
                                        numberOperation: {
                                            type: "string"
                                        },
                                        currency: {
                                            type: "string"
                                        },
                                        amountRisk: {
                                            type: "number"
                                        },
                                        amount: {
                                            type: "number"
                                        },
                                        beneficiary: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleContingencies = ($rootScope.productsContingencies != null && $rootScope.productsContingencies.length > 0);

                        var currentindirectRisk = $rootScope.productsIndirectPortfolio;
                        // var
                        // currentindirectRisk=$scope.indirectRisk;
                        for (var i in currentindirectRisk) {
                            var dateChange = new Date(
                                currentindirectRisk[i].date_apt);
                            currentindirectRisk[i].date_apt = dateChange
                                .toLocaleDateString();
                            var dateChange = new Date(
                                currentindirectRisk[i].date_vto);
                            currentindirectRisk[i].date_vto = dateChange
                                .toLocaleDateString();
                        }

                        $rootScope.indirectPortfolio = new kendo.data.DataSource({
                            data: $rootScope.productsIndirectPortfolio,
                            schema: {
                                model: {
                                    fields: {
                                        operation: {
                                            type: "string"
                                        },
                                        operationType: {
                                            type: "string"
                                        },
                                        currencyDesc: {
                                            type: "string"
                                        },
                                        amountOrigin: {
                                            type: "number"
                                        },
                                        amountCapital: {
                                            type: "number"
                                        },
                                        amountLosing: {
                                            type: "number"
                                        },
                                        amountMl: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleIndirectRiskDet = ($rootScope.productsIndirectPortfolio != null && $rootScope.productsIndirectPortfolio.length > 0);

                        // Use to format to date fields
                        $scope.convertFieldsOthers = function (data,
                            type) {
                            var currentAc = data;

                            if (type == undefined) {
                                for (var i in currentAc) {
                                    if (currentAc[i].dateApt != undefined) {
                                        var dateChange = new Date(
                                            $filter('date')
                                            (
                                                parseInt(
                                                    currentAc[i].dateApt
                                                    .substring(
                                                        currentAc[i].dateApt
                                                        .indexOf("(") + 1,
                                                        currentAc[i].dateApt
                                                        .indexOf(")")),
                                                    "dd/MM/yyyy")))
                                            .toLocaleDateString();
                                        currentAc[i].dateApt = dateChange;

                                    }
                                }
                            } else {
                                for (var i in currentAc) {

                                    if (currentAc[i].affiliateDate != undefined) {
                                        dateChange = new Date(
                                            $filter('date')
                                            (
                                                parseInt(
                                                    currentAc[i].affiliateDate
                                                    .substring(
                                                        currentAc[i].affiliateDate
                                                        .indexOf("(") + 1,
                                                        currentAc[i].affiliateDate
                                                        .indexOf(")")),
                                                    "dd/MM/yyyy")));
                                        currentAc[i].affiliateDate = dateChange
                                            .toLocaleDateString();
                                    }

                                    if (currentAc[i].openingDate != null) {
                                        dateChange = new Date(
                                            $filter('date')
                                            (
                                                parseInt(
                                                    currentAc[i].openingDate
                                                    .substring(
                                                        currentAc[i].openingDate
                                                        .indexOf("(") + 1,
                                                        currentAc[i].openingDate
                                                        .indexOf(")")),
                                                    "dd/MM/yyyy")));
                                        currentAc[i].openingDate = dateChange
                                            .toLocaleDateString();
                                    }
                                }
                            }

                            return currentAc;
                        }

                        $rootScope.applicationLoans = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsOthers($rootScope.productsApplicationLoans),
                            schema: {
                                model: {
                                    fields: {
                                        dateApt: {
                                            type: "string"
                                        },
                                        currencyDesc: {
                                            type: "string"
                                        },
                                        stateConta: {
                                            type: "string"
                                        },
                                        amountCapital: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.creditPendings = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsOthers(
                                    $rootScope.productsCreditsPendings,
                                    'CP'),
                            schema: {
                                model: {
                                    fields: {
                                        openingDate: {
                                            type: "string"
                                        },
                                        currencyDescription: {
                                            type: "string"
                                        },
                                        status: {
                                            type: "string"
                                        },
                                        available: {
                                            type: "number"
                                        },
                                        limitApproved: {
                                            type: "number"
                                        },
                                        riskAmount: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.pendingGuarantees = new kendo.data.DataSource({
                            data: $rootScope.productsPendingGuaranties,
                            schema: {
                                model: {
                                    fields: {
                                        code: {
                                            type: "string"
                                        },
                                        currency: {
                                            type: "string"
                                        },
                                        actualValue: {
                                            type: "number"
                                        },
                                        MRC: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.otherComext = new kendo.data.DataSource({
                            data: $rootScope.productsOtherComext,
                            schema: {
                                model: {
                                    fields: {
                                        numberOperation: {
                                            type: "string"
                                        },
                                        currencyDesc: {
                                            type: "string"
                                        },
                                        amount: {
                                            type: "number"
                                        },
                                        beneficiary: {
                                            type: "string"
                                        },
                                        amountML: {
                                            type: "number"
                                        }
                                    }
                                }
                            }
                        });
                        $rootScope.promissoryNotePending = new kendo.data.DataSource({
                            data: $rootScope.productsPromissoryNotePending,
                            schema: {
                                model: {
                                    fields: {
                                        code: {
                                            type: "string"
                                        },
                                        currency: {
                                            type: "string"
                                        },
                                        actualValue: {
                                            type: "number"
                                        },
                                        state: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.others = new kendo.data.DataSource({
                            data: $scope
                                .convertFieldsOthers(
                                    $rootScope.productsOthers,
                                    'O'),
                            schema: {
                                model: {
                                    fields: {
                                        affiliateDate: {
                                            type: "string"
                                        },
                                        profile: {
                                            type: "string"
                                        },
                                        stateRegistry: {
                                            type: "string"
                                        }
                                    }
                                }
                            }
                        });

                        $rootScope.isVisibleApplicationLoansSource = ($rootScope.productsApplicationLoans != null && $rootScope.productsApplicationLoans.length > 0);
                        $rootScope.isVisibleCreditsLinesPendingSource = ($rootScope.productsCreditsPendings != null && $rootScope.productsCreditsPendings.length > 0);
                        $rootScope.isVisibleGuaranteesPendingSource = ($rootScope.productsPendingGuaranties != null && $rootScope.productsPendingGuaranties.length > 0);
                        $rootScope.isVisibleOtherComextSource = ($rootScope.productsOtherComext != null && $rootScope.productsOtherComext.length > 0);
                        $rootScope.isVisiblePromissoryNotesSource = ($rootScope.productsPromissoryNotePending != null && $rootScope.productsPromissoryNotePending.length > 0);
                        $rootScope.isVisibleOthersSource = ($rootScope.productsOthers != null && $rootScope.productsOthers.length > 0);

                        if ($rootScope.currentAccounts.transport.data.length > 0) {
                            $rootScope.typesCurrentAccounts = new Array();

                            for (var i = 0; i < $rootScope.productsCurrentAccount.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesCurrentAccounts.length; j++) {

                                    if ($rootScope.typesCurrentAccounts[j].typeDescription == $rootScope.productsCurrentAccount[i].typeDescription) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesCurrentAccounts
                                        .push({
                                            typeDescription: $rootScope.productsCurrentAccount[i].typeDescription,
                                            product: $rootScope.productsCurrentAccount[i].product + " - " + $rootScope.productsCurrentAccount[i].typeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.overdrafts.transport.data.length > 0) {
                            $rootScope.typesOverdrafts = new Array();

                            for (var i = 0; i < $rootScope.productsOverdraft.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesOverdrafts.length; j++) {

                                    if ($rootScope.typesOverdrafts[j].descriptionType == $rootScope.productsOverdraft[i].descriptionType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesOverdrafts
                                        .push({
                                            product: $rootScope.productsOverdraft[i].product,
                                            descriptionType: $rootScope.productsOverdraft[i].product + " - " + $rootScope.productsOverdraft[i].descriptionType
                                        });
                                }
                            }
                        }

                        if ($rootScope.fixedTerms.transport.data.length > 0) {
                            $rootScope.typesFixedTerms = new Array();

                            for (var i = 0; i < $rootScope.productsFixedTerm.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesFixedTerms.length; j++) {

                                    if ($rootScope.typesFixedTerms[j].typeDescription == $rootScope.productsFixedTerm[i].typeDescription) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesFixedTerms
                                        .push({
                                            typeDescription: $rootScope.productsFixedTerm[i].typeDescription,
                                            product: $rootScope.productsFixedTerm[i].product + " - " + $rootScope.productsFixedTerm[i].typeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.warranties.transport.data.length > 0) {
                            $rootScope.typesWarranties = new Array();

                            for (var i = 0; i < $rootScope.productsGuarantees.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesWarranties.length; j++) {

                                    if ($rootScope.typesWarranties[j].warrantyType == $rootScope.productsGuarantees[i].warrantyType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesWarranties
                                        .push({
                                            warrantyType: $rootScope.productsGuarantees[i].warrantyType,
                                            warrantyDescription: $rootScope.productsGuarantees[i].module + " - " + $rootScope.productsGuarantees[i].warrantyDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.promissoryNotes.transport.data.length > 0) {
                            $rootScope.typesPromissoryNotes = new Array();

                            for (var i = 0; i < $rootScope.productsPromissoryNote.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesPromissoryNotes.length; j++) {

                                    if ($rootScope.typesPromissoryNotes[j].warrantyType == $rootScope.productsPromissoryNote[i].warrantyType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesPromissoryNotes
                                        .push({
                                            warrantyType: $rootScope.productsPromissoryNote[i].warrantyType,
                                            warrantyDescription: $rootScope.productsPromissoryNote[i].warrantyType + " - " + $rootScope.productsPromissoryNote[i].warrantyDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.insurancePolicy.transport.data.length > 0) {
                            $rootScope.typesInsurancePolicy = new Array();

                            for (var i = 0; i < $rootScope.productsInsurancePolicy.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesInsurancePolicy.length; j++) {

                                    if ($rootScope.typesInsurancePolicy[j].warrantyType == $rootScope.productsInsurancePolicy[i].warrantyType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesInsurancePolicy
                                        .push({
                                            warrantyType: $rootScope.productsInsurancePolicy[i].warrantyType,
                                            warrantyDescription: $rootScope.productsInsurancePolicy[i].warrantyType + " - " + $rootScope.productsInsurancePolicy[i].warrantyDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.credits.transport.data.length > 0) {
                            $rootScope.typesCredits = new Array();

                            for (var i = 0; i < $rootScope.productsCredits.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesCredits.length; j++) {

                                    if ($rootScope.typesCredits[j].operationType == $rootScope.productsCredits[i].operationType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesCredits
                                        .push({
                                            operationType: $rootScope.productsCredits[i].operationType,
                                            opTypeDescription: $rootScope.productsCredits[i].opTypeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.contingencies.transport.data.length > 0) {
                            $rootScope.typesContingencies = new Array();

                            for (var i = 0; i < $rootScope.productsContingencies.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesContingencies.length; j++) {

                                    if ($rootScope.typesContingencies[j].operationType == $rootScope.productsContingencies[i].operationType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesContingencies
                                        .push({
                                            operationType: $rootScope.productsContingencies[i].operationType,
                                            opTypeDescription: $rootScope.productsContingencies[i].opTypeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.indirectPortfolio.transport.data.length > 0) {
                            $rootScope.typesIndirectPortfolio = new Array();

                            for (var i = 0; i < $rootScope.productsIndirectPortfolio.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesIndirectPortfolio.length; j++) {

                                    if ($rootScope.typesIndirectPortfolio[j].operationType == $rootScope.productsIndirectPortfolio[i].type_operation) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesIndirectPortfolio
                                        .push({
                                            operationType: $rootScope.productsIndirectPortfolio[i].operationType,
                                            productDesc: $rootScope.productsIndirectPortfolio[i].productDesc
                                        });
                                }
                            }
                        }

                        if ($rootScope.others.transport.data.length > 0) {
                            $rootScope.typesOthers = new Array();

                            for (var i = 0; i < $rootScope.productsOthers.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesOthers.length; j++) {

                                    if ($rootScope.typesOthers[j].login == $rootScope.productsOthers[i].login) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesOthers
                                        .push({
                                            login: $rootScope.productsOthers[i].login,
                                            entity: "Servicio de Internet"
                                        });
                                }
                            }
                        }

                        if ($rootScope.applicationLoans.transport.data.length > 0) {
                            $rootScope.typesApplicationLoans = new Array();

                            for (var i = 0; i < $rootScope.productsApplicationLoans.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesApplicationLoans.length; j++) {

                                    if ($rootScope.typesApplicationLoans[j].operationType == $rootScope.productsApplicationLoans[i].operationType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesApplicationLoans
                                        .push({
                                            operationType: $rootScope.productsApplicationLoans[i].operationType,
                                            productDesc: $rootScope.productsApplicationLoans[i].product + " - " + $rootScope.productsApplicationLoans[i].operationTypeDesc
                                        });
                                }
                            }
                        }

                        if ($rootScope.creditPendings.transport.data.length > 0) {
                            $rootScope.typesCreditPendings = new Array();

                            for (var i = 0; i < $rootScope.productsCreditsPendings.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesCreditPendings.length; j++) {

                                    if ($rootScope.typesCreditPendings[j].opTypeDescription == $rootScope.productsCreditsPendings[i].opTypeDescription) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesCreditPendings
                                        .push({
                                            product: $rootScope.productsCreditsPendings[i].product,
                                            opTypeDescription: $rootScope.productsCreditsPendings[i].opTypeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.pendingGuarantees.transport.data.length > 0) {
                            $rootScope.typesPendingGuarantees = new Array();

                            for (var i = 0; i < $rootScope.productsPendingGuaranties.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesPendingGuarantees.length; j++) {

                                    if ($rootScope.typesPendingGuarantees[j].warrantyType == $rootScope.productsPendingGuaranties[i].warrantyType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesPendingGuarantees
                                        .push({
                                            warrantyType: $rootScope.productsPendingGuaranties[i].warrantyType,
                                            warrantyDescription: $rootScope.productsPendingGuaranties[i].module + " - " + $rootScope.productsPendingGuaranties[i].warrantyDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.promissoryNotePending.transport.data.length > 0) {
                            $rootScope.typesPromissoryNotePending = new Array();

                            for (var i = 0; i < $rootScope.productsPromissoryNotePending.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesPromissoryNotePending.length; j++) {

                                    if ($rootScope.typesPromissoryNotePending[j].warrantyType == $rootScope.productsPromissoryNotePending[i].warrantyType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesPromissoryNotePending
                                        .push({
                                            type_operation: $rootScope.productsPromissoryNotePending[i].warrantyType,
                                            productDesc: $rootScope.productsPromissoryNotePending[i].module + " - " + $rootScope.productsPromissoryNotePending[i].warrantyDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.otherComext.transport.data.length > 0) {
                            $rootScope.typesOtherComext = new Array();

                            for (var i = 0; i < $rootScope.productsOtherComext.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesOtherComext.length; j++) {

                                    if ($rootScope.typesOtherComext[j].operationType == $rootScope.productsOtherComext[i].operationType) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesOtherComext
                                        .push({
                                            operationType: $rootScope.productsOtherComext[i].operationType,
                                            operationTypeDescription: $rootScope.productsOtherComext[i].operationType + " - " + $rootScope.productsOtherComext[i].operationTypeDescription
                                        });
                                }
                            }
                        }

                        if ($rootScope.savingAccounts.transport.data.length > 0) {
                            $rootScope.typesSavingAccounts = new Array();

                            for (var i = 0; i < $rootScope.productsSavingAccount.length; i++) {
                                var insert = true;
                                for (var j = 0; j < $rootScope.typesSavingAccounts.length; j++) {

                                    if ($rootScope.typesSavingAccounts[j].typeDescription == $rootScope.productsSavingAccount[i].typeDescription) {
                                        insert = false;
                                    }
                                }
                                if (insert) {
                                    $rootScope.typesSavingAccounts
                                        .push({
                                            typeDescription: $rootScope.productsSavingAccount[i].typeDescription,
                                            product: $rootScope.productsSavingAccount[i].product + " - " + $rootScope.productsSavingAccount[i].typeDescription
                                        });
                                }
                            }
                        }

                        $scope.loadDataSources = function () {

                            if ($scope.rateSource != undefined) {
                                var gridRate = $("#kRateSource")
                                    .data("kendoGrid");
                                gridRate
                                    .setDataSource($scope.rateSource);
                            }
                        }

                        
						$rootScope.hideLoading();

                    };

                    $rootScope.actividadColumns = [
                        {
                            field: "activity",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_ECONOMIC_ACTIVITY')
						},
                        {
                            field: "sector",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_SECTOR_ACTIVITY')
						},
                        {
                            field: "subSector",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_SUB_SECTOR_ACTIVITY')
						},
                        {
                            field: "main",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_MAIN_SECTOR')
						}
					];

                    $rootScope.addressColumns = [
                        {
                            field: "addressId",
                            title: $filter('translate')(
                                'COMMONS.HEADERS.HDR_NO'),
                            width: "40px"
						},
                        {
                            field: "isMainAddress",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_PRINCIPAL')
						},
                        {
                            field: "type",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_TYPE_DIRECTION')
						},
                        {
                            field: "description",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
						},
                        {
                            field: "country",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_COUNTRY_NAME')
						},
                        {
                            field: "department",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_DEPARTMENT')
						},
                        {
                            field: "province",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_PROVINCE')
						},
                        {
                            field: "city",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_TOWN_SHIP_NAME')
							
						},
                        {
                            field: "street",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_STREET')
						}
					];

                    $rootScope.emailsColumns = [
                        {
                            field: "addressId",
                            title: $filter('translate')(
                                'COMMONS.HEADERS.HDR_NO')
						},
                        {
                            field: "description",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
						},
                        {
                            field: "type",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_TYPE_DIRECTION')
						}
					];

                    $rootScope.contactColumns = [
                        {
                            field: "name",
                            title: $filter('translate')('COMMONS.HEADERS.HDR_NAME')
						},
                        {
                            field: "address",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_DIRECTION_DESCRIPTION')
						},
                        {
                            field: "phone",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_PHONE')
						},
                        {
                            field: "email",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_EMAIL')
						}
					];

                    $rootScope.phoneColumns = [
                        {
                            field: "value",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_NUMBER'),
                            width: "150px"
						},
                        {
                            field: "typePhone",
                            title: $filter('translate')
                            ('COMMONS.HEADERS.HDR_PHONETYPE'),
                            width: "100px"
						}
					];
		  
					//Columnas Detalle Remesas
					$scope.getRemittanceDetailColumns = function(){
			
						$scope.remittanceDetailColumns = [
							{
								field : "sequence",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_CODE_NUMBER'),
								width : "150px"
							},
							{
								field : "dateAPRRegistry",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_SHIPMENT_DATE'),
								width : "150px"
							},
							{
								field : "currencyDesc",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_CURRENCY'),
								width : "150px"
							},
							{
								field : "balance",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_PAYMENT_VALUE'),
								format: "{0:n}",
								width : "150px"
							},							
							{
								field : "status",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_STATUS'),
								width : "150px"
							},							
							{
								field : "cancellationDate",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_PAYMENT_DATE'),
								format: "{0:dd-MMM-yyyy}",
								width : "150px"
							},
							{
								field : "operationType",
								title : $filter('translate')('CLIENTVIEWER.LABELS.LBL_REMITTANCE'),
								width : "150px"
							}
						];
						return $scope.remittanceDetailColumns;
					}
					
					
		   $scope.onClickPDF = function(dtoName, title, name) {
			var argsReport = [ 
								['title', $filter('translate')(title)], 
								['report',dtoName],
								['type','PDF'],
								['clientName',name],
								['formatDate', $scope.dateFormat]
							 ];
			$scope.generarReporte(dtoName,argsReport,title);
          };
		  
		  $scope.generarReporte = function(reporte, argumentos, title){
            var formaMapeo = document.createElement("form");
            formaMapeo.target = 'popup_window_'+reporte;
            formaMapeo.method = "POST"; // or "post" if appropriate
            formaMapeo.action = "/" + "CTSProxy" + "/services/cobis/web/clientviewer/"+reporte+ "?";

			 var param = "";
			  for (var i=0; i < argumentos.length; i++) {
				param = param + argumentos[i][0] + '=' + argumentos[i][1] + '&'
            }
			param =  param.substr(0, param.length-1);
            var url =  formaMapeo.action + param
			cobis.container.tabs.openNewTab('ctsConsole', url ,'RPT_VCC');
		}
		  
			$rootScope.hideLoading = function(){
				if($rootScope.countVcc >= 10){
					//$("div[id='loader_CONSOLIDATEPOS']").each(function(i, element) {$(element).hide()});
					cobis.showMessageWindow.loading(false);
				}
			}
			
			$rootScope.showLoading = function(){
                cobis.showMessageWindow.loading(true);
                /*if($("div[id='loader_CONSOLIDATEPOS']").css('display')=='none'){
                   $("div[id='loader_CONSOLIDATEPOS']").each(function(i, element) {
                       $(element).show()});
               }*/
                //Corrige el problema de estilos cuando se desalinean las pestañas de la VCC
				setTimeout(function () {
                    $('.k-tabstrip-items').css({
                        display: 'flex'
                    });
                    console.log("Entro a cargar estilo desde showLoading")
                }, 1000); 
			}
            $scope.queryClientData = function () {
				$rootScope.showLoading();
				$($rootScope.idPic).hide();
                $("#kpassive").hide();
                $("#kdebts").hide();
                $("#kcontigents").hide();
                $("#kguarantees").hide();
                $("#krisks").hide();
                $("#backButton").hide();
                $("#bars").delay().show();

                var tabToActivate = $("#tab1");
                $scope.menuTabStrip = $("#menuTab").kendoTabStrip().data("kendoTabStrip").activateTab(tabToActivate);
                $scope.showProducts = false;
                $scope.showProductsSale = false;
                $rootScope.isNaturalPersonTab = false;
                $rootScope.isCorporationTab = false;
                $rootScope.isEconomicGroupTab = false;
                $rootScope.isEcGroupNecessaryTab = false;
                $rootScope.isMaximunDebtsTab = false;
				var resultPrepareProduct = null;
				
				if($rootScope.customerType == 'G' || $rootScope.customerType == 'S')
				{
					resultPrepareProduct = consolidatePositionService.prepareProductsData(0,$scope.customerCodeLocal);
				}
				else if($rootScope.customerType == 'P' || $rootScope.customerType == 'C')
				{
					resultPrepareProduct = consolidatePositionService.prepareProductsData($scope.customerCodeLocal,0);
				}
				resultPrepareProduct.then(function (data) {	
					$scope.spid = data.spid;
                    
                    
					
					var resultQueryProduct = queryClientViewerService.queryProductsByClientId($scope.customerCodeLocal, $scope.documentId, $scope.spid);
					resultQueryProduct.then(function (data) {
						$rootScope.dynamicData = data.productsByClientDTO;
						$rootScope.countVcc++;
                        $scope.buscarbyid($scope.customerCodeLocal);
						$rootScope.hideLoading();



                        //cerrar el menu para obligar que vuelvan a abrirlo y consultar los datos de historico del nuevo cliente
                        $scope.clearOtherInformation($scope.treeDataHistory);
                        resultPrepareProductHistory = null;
					var resultConsolidatePosition = consolidatePositionService.queryConsolidatedPosition($scope.customerCodeLocal);
					resultConsolidatePosition.then(function (data) {
						$rootScope.resultConsolidation = data;
						var temporal = {};
                        var count = 0;
						angular.forEach(data,function (value) {
							if (value.product == 'Riesgo') {
                              
								if (value.name == 'Contingent') {
									temporal.contingent = value.amount;
								}

								if (value.name == 'IndirectRisk') {
									temporal.indirectRisk = value.amount;
								}

								if (value.name == 'DirectRisk') {
									temporal.directRisk = value.amount;
								}

								if (value.name == 'TotalRisk') {
									temporal.totalRisk = value.amount;
								}

							}

                        });
						$scope.riskObject = temporal;
						$scope.LoadDataConsolidation();
						$rootScope.countVcc++;
						$rootScope.hideLoading();
                        }).
                        catch (function (data) {
                        $rootScope.countVcc++;
						$rootScope.hideLoading();
					});

					/*InformaciÃ³n HistÃ³ricos*/
					/*var resultPrepareProductHistory = consolidatePositionService.prepareProductsDataHistory($scope.customerCodeLocal,$scope.groupCode);
					resultPrepareProductHistory.then(function (data) {	
					$scope.spid = data.spid;
						var resultQueryProductHistory = queryClientViewerService.queryHistoryProductsByClientId ($scope.customerCodeLocal, $scope.spid);
						resultQueryProductHistory.then(function (data) {
							$rootScope.dynamicHistoryData = data.productsByClientDTO;
							$rootScope.countVcc++;
							$rootScope.hideLoading();
						}).catch(function (data) {
							$rootScope.countVcc++;
							$rootScope.hideLoading();
						});
					
					});*/
					
					var resultPunctuation = consolidatePositionService.searchPunctuationCustomer($scope.customerCodeLocal);
					resultPunctuation.then(function (data) {

						if (null != data) {
							$rootScope._customerScore = data.scoreCustomer;
						} else {
							$rootScope._customerScore = "";
						}

						$rootScope.countVcc++;
						$rootScope.hideLoading();
					}).
					catch (function (data) {
						$rootScope.countVcc++;
						$rootScope.hideLoading();
					});
					
					$rootScope.ratesScoresConsolidated($scope.customerCodeLocal);
					var resultBankingProduct = consolidatePositionService.getBankinProductsApprovedStructure();
					resultBankingProduct.then(function (data) {
						$scope.processes = [];
						
						for (var i = 0; i < data.length; i++) {
							if (data[i].processes != null) {
								for (var j = 0; j < data[i].processes.length; j++) {
									if (data[i].processes[j].creditLine == 'N' && data[i].processes[j].generic == 'N') {
										$scope.processes
											.push(data[i]);
									}
									if (data[i].processes[j].creditLine == 'S') {
										$scope.processes
											.push(data[i]);
									}
									if (data[i].processes[j].generic == 'N') {
											$scope.processes.push(data[i]);
									}
								}
							}
						}
						
						var temp = [];
						for (var i = 0; i < $scope.processes.length; i++) {

							if (temp.length <= 0) {
								temp.push($scope.processes[i]);

							} else {
								var insert = true;
								for (var j = 0; j < temp.length; j++) {
									if (temp[j].id == $scope.processes[i].id) {
										insert = false;
									}
								}

								if (insert) {
									temp.push($scope.processes[i]);
								}
							}

						}

						for (i = 0; i < temp.length; i++) {

							var processes = [];

							for (var j = 0; j < temp[i].processes.length; j++) {
								if (temp[i].processes[j].generic == "N") {
									processes.push(temp[i].processes[j]);
								}
							}
							temp[i].processes = processes;
						}
	
						$scope.processes = angular.copy(temp);
						$rootScope.countVcc++;
						//$rootScope.loadInformationProductSale();
						$rootScope.hideLoading();
						
						
						
                        }).
                        catch (function (data) {
                            $rootScope.countVcc++;
						$rootScope.hideLoading();
					});
                    }).
                    catch (function (data) {
                        $rootScope.countVcc++;
						$rootScope.hideLoading();
					});
					
					
				});				
			}
			$scope.onKeyPressDigit = function (event) {
                        var inputValue = event.keyCode;
                           if ((inputValue < 48) || (inputValue > 57)) {
                               event.preventDefault();
                           }
                        };
			$scope.onOpenCtxMenuResume = function (kendoEvent) {
				$scope.mnemonic=kendoEvent.target.parentElement.getElementsByClassName("groupSelected")[0].attributes["value"].value;
				var detailDTO=kendoEvent.target.parentElement.getElementsByClassName("groupDetailSelected")[0].attributes["value"].value;
				var detailProductSel=kendoEvent.target.parentElement.getElementsByClassName("detailProductSelected")[0].attributes["value"].value;
				$scope.detailIdObj=JSON.parse(detailDTO);
				$scope.detailProductSelObj=JSON.parse(detailProductSel);
				$scope.objFilterField=$scope.getProcessFilterField($scope.detailProductSelObj,$scope.detailIdObj);
			 };
        }]);
		if (angular.isUndefined(window.cobisMainModule)) {
			window.cobisMainModule = app;
		}
		
}(window));