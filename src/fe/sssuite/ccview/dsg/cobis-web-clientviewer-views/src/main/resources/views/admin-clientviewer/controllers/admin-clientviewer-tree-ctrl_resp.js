(function (window) {
    'use strict';

    //var app = angular.module(cobis.modules.ADMCLIENTVIEWER);
var app = cobis.createModule(cobis.modules.ADMCLIENTVIEWER, ["oc.lazyLoad",cobis.modules.ADMCLIENTVIEWER, 'ui.bootstrap', "designerModule", "ngResource"]);    
    
    app.config(["$controllerProvider", "$compileProvider", "$routeProvider", "$filterProvider",
        function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
            app.controllerProvider = $controllerProvider;
            app.compileProvider = $compileProvider;
            app.routeProvider = $routeProvider;
            app.filterProvider = $filterProvider;
        }]);

    app.controller("adminclientviewer.treeController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', 'adminclientviewer.treeServices', '$translate', 'cobisMessage', 'dsgnrCommons', 'designer',
                                               function ($scope, $rootScope, $filter, $modal, $routeParams, adminclientviewerService, $translate, cobisMessage, dsgnrCommons,designer ) {

            $scope.vc = designer.initCustomViewContainer('adminclientviewer', $scope.customEvents);
            
            $scope.vc.viewState = {
            		dynamic: {
            			view: {},
            			customView: {}
                    }
            };
            
            //Funcion para pantalla de espera del usuario
            $scope.blockScreen = function () {
                var varProcess = $filter('translate')("COMMONS.MESSAGES.MSG_PROCESSING");
                $.blockUI({
                    message: $('<div>' + varProcess + '..</div>'),
                    css: {
                        border: 'none',
                        backgroundColor: '#000',
                        opacity: 0.5,
                        color: '#fff'
                    }
                });
            };

            $scope.unblockScreen = function () {
                $.unblockUI();
            };


            //Funcion Initdata de la pantalla
            $scope.initData = function () {
            	
            	
            	//Inicializo los nodos de los arboles
                $scope.getTreeRootProduct();
                $scope.getTreeRootCustomer();
            	
                //Esconde el menu cuando muestro el arbol
                //cobis.container.menu.hide();

            };


            /**
             * Nodo del arbol que carga Action
             */
            $scope.treeItemTemplateProduct = kendo.template($("#javascriptTemplateProduct").html());

            $scope.getTreeRootProduct = function () {

                var node = {
                    id: null,
                    idparent: null,
                    nameParent: null,
                    name: "ADMCLIENTVIEWER.MENU.MNU_PRODUCTS",
                    text: "ADMCLIENTVIEWER.MENU.MNU_PRODUCTS",
                    type: "",
                    menuType: 'product',
                    spriteCssClass: "fa fa-check nodecheck"
                };

                $scope.treeDataProduct = [];
                $scope.treeDataProduct.push(node);
                $scope.treeDataSourceProduct = new kendo.data.HierarchicalDataSource({
                    data: $scope.treeDataProduct
                });

            };

            //Metodo para cargar la informacion Action o actualizar
            $scope.onItemSelectedProduct = function (dataItem) {

                $scope.tree = $("#treeControlProduct").data("kendoTreeView");

                if (dataItem.menuType === "product" && !dataItem.hasChildren) {
                	
                	var result = adminclientviewerService.getAllProductAdministratorDefaultDinamicByType(" ","PR");
                    
                    result.then(function (data) {
                    	
                        for (var i = 0; i < data.length; i++) {
                    
                            var newItem = {
                                id: data[i].idProduct,
                                idparent: data[i].parent,
                                nameParent: dataItem.name,
                                name: data[i].description,
                                text: data[i].description,
                                type: data[i].clientType,
								order:  data[i].order,
                                menuType: 'itemProductType',
                                spriteCssClass: "fa fa-calendar-o nodecalendar"
                            };
                            dataItem.id = data[i].parent;
                            $scope.tree.append(newItem, $scope.tree.select());
                        }
                    
                    })
                	
                }else if (dataItem.menuType === "itemProductType" && !dataItem.hasChildren) {
                	
                    var result = adminclientviewerService.getProductAdministratorDefaultDinamicByParent(dataItem.id);
                    
                    result.then(function (data) {
                    	
                        for (var i = 0; i < data.length; i++) {
                    
                            var newItem = {
                                id: data[i].idProduct,
                                idparent: 0,
                                nameParent: dataItem.name,
                                name: data[i].description,
                                text: data[i].description,
                                type: data[i].clientType,
                                menuType: 'itemProductType',
                                spriteCssClass: "fa fa-calendar-o nodecalendar"
                            };
                    
                            $scope.tree.append(newItem, $scope.tree.select());
                        }
                    
                    })
					
				}
                
                if (dataItem.menuType == "itemProductType") {
                	$scope.dataitem = dataItem;
                    $scope.funtionCrudSection(dataItem, null,"updateSection");
				} else {
	                var api = new dsgnrCommons.API($scope.vc),
	                nav = api.navigation;
	                nav.registerView('dynamic');
				}

            };

            $scope.onClickNewProductParentSection = function (dataItem) {
                 $scope.funtionCrudSection(dataItem,null,"newParentSection");
            };
            
            $scope.onClickNewProductSection = function (dataItem) {
                $scope.funtionCrudSection(dataItem,null,"newSection");
            };

            //Metodo para enviar a la pantalla para crear o editar un DocumentType
            $scope.funtionCrudSection = function (dataItem, type, action) {

                var api = new dsgnrCommons.API($scope.vc),
                nav = api.navigation;
                nav.label = 'Consulta de Usuarios';
                nav.address = {
					moduleId: 'LATFO',
					subModuleId: 'UCSPM',
					taskId: 'T_UCSPM_08_RMOCN27',
					taskVersion: '1.0.0',
                    viewContainerId: 'VC_RMOCN27_NECIN_829'
                };
				
                nav.customDialogParameters = {
                	idSection : dataItem.id,
                	action : action,
                	type : type,		
					name : dataItem.name,
					nameParent :dataItem.nameParent,
					addNode : $scope.addNode,
					updateNode : $scope.updateNode
					
                };
                
               nav.registerView('dynamic');
               
            };

            /**
             * Nodo del arbol que carga DocumentType
             */
            $scope.treeItemTemplateCustomer = kendo.template($("#javascriptTemplateCustomer").html());

            $scope.getTreeRootCustomer = function () {

                var node = {
                	id: null,
                    idparent: null,
                    nameParent: null,
                    name: "ADMCLIENTVIEWER.MENU.MNU_CUSTOMERS",
                    text: "ADMCLIENTVIEWER.MENU.MNU_CUSTOMERS",
                    type: null,
                    menuType: 'customer',
                    spriteCssClass: "fa fa-align-right noderight"
                };

                $scope.treeDataCustomer = [];
                $scope.treeDataCustomer.push(node);
                $scope.treeDataSourceCustomer = new kendo.data.HierarchicalDataSource({
                    data: $scope.treeDataCustomer
                });

            };

            //Metodo para cargar la informacion Section Customer y actualizar
            $scope.onItemSelectedCustomer = function (dataItem) {

                $scope.tree = $("#treeControlCustomer").data("kendoTreeView");

                if (dataItem.menuType === "customer" && !dataItem.hasChildren) {

                	var nodeNaturalPerson = {
                        id: null,
                        idparent: null,
                        nameParent: dataItem.name,
                        name: "ADMCLIENTVIEWER.MENU.MNU_NATURAL_PERSON",
                        text: "ADMCLIENTVIEWER.MENU.MNU_NATURAL_PERSON",
                        type:"P",
                        menuType: 'customerType',
                        spriteCssClass: "fa fa-align-right noderight"
                    };
                        
                    var nodeLegalPerson = {
                        id: null,
                        idparent: null,
                        nameParent: dataItem.name,
                        name: "ADMCLIENTVIEWER.MENU.MNU_LEGAL_PERSON",
                        text: "ADMCLIENTVIEWER.MENU.MNU_LEGAL_PERSON",
                        type: "C",
                        menuType: 'customerType',
                        spriteCssClass: "fa fa-align-right noderight"
                    };
                       
                    var nodeEconomicGroup = {
                        id: null,
                        idparent: null,
                        nameParent: dataItem.name,
                        name: "ADMCLIENTVIEWER.MENU.MNU_ECONOMIC_GROUP",
                        text: "ADMCLIENTVIEWER.MENU.MNU_ECONOMIC_GROUP",
                        type: "G",
                        menuType: 'customerType',
                        spriteCssClass: "fa fa-align-right noderight"
                    };
                       
                    $scope.tree.append(nodeNaturalPerson, $scope.tree.select());
                    $scope.tree.append(nodeLegalPerson, $scope.tree.select());
                    $scope.tree.append(nodeEconomicGroup, $scope.tree.select());

                } else if (dataItem.menuType === "customerType" && !dataItem.hasChildren) {
                	
                    var result = adminclientviewerService.getAllProductAdministratorDefaultDinamicByType(dataItem.type,"CL");
                    
                    result.then(function (data) {
                    	
                        for (var i = 0; i < data.length; i++) {
                    
                            var newItem = {
                                id: data[i].idProduct,
                                idparent: data[i].parent,
                                nameParent: dataItem.name,
                                name: data[i].description,
                                text: data[i].description,
                                type: data[i].clientType,
                                menuType: 'itemCustomerType',
                                spriteCssClass: "fa fa-calendar-o nodecalendar"
                            };
                            dataItem.id = data[i].parent;
                            $scope.tree.append(newItem, $scope.tree.select());
                        }
                    
                    })
					
				} else if (dataItem.menuType === "itemCustomerType" && !dataItem.hasChildren) {
                	
                    var result = adminclientviewerService.getProductAdministratorDefaultDinamicByParent(dataItem.id);
                    
                    result.then(function (data) {
                    	
                        for (var i = 0; i < data.length; i++) {
                    
                            var newItem = {
                                id: data[i].idProduct,
                                idparent: dataItem.id,
                                nameParent: dataItem.name,
                                name: data[i].description,
                                text: data[i].description,
                                type: data[i].clientType,
                                menuType: 'itemCustomerType',
                                spriteCssClass: "fa fa-calendar-o nodecalendar"
                            };
                    
                            $scope.tree.append(newItem, $scope.tree.select());
                        }
                    
                    })
					
				}
                
                if (dataItem.menuType == "itemCustomerType") {
                	$scope.dataitem = dataItem;
                	$scope.funtionCrudSection(dataItem, dataItem.type,"updateSection");
				} else {
	                var api = new dsgnrCommons.API($scope.vc),
	                nav = api.navigation;
	                nav.registerView('dynamic');
				}
            };

            $scope.onClickNewCustomerParentSection = function (dataItem) {
                $scope.funtionCrudSection(dataItem, dataItem.type,"newParentSection");
            };
            
            $scope.onClickNewCustomerSection = function (dataItem) {
               $scope.funtionCrudSection(dataItem,dataItem.type,"newSection");
            };
            
            $scope.onDeleteSection = function (dataItem) {

                var answer = cobis.showMessageWindow.confirm($filter('translate')('COMMONS.MESSAGES.MSG_CONFIRM_REMOVAL'), $filter('translate')('COMMONS.HEADERS.HDR_WARNING')).then(function (data) {
                    if (data.buttonIndex == 1 == true && !dataItem.hasChildren) {

                        adminclientviewerService.deleteDefaultProductAdministratorById(dataItem.id).then(function (data) {
                            if (!data.success) {
                                cobisMessage.showTranslateMessagesSuccess($filter('translate')('COMMONS.MESSAGES.MSG_ACTIONS_SUCCESS_DELETE'),[],3000,false);
                                var arrayNode = dataItem.parent();
                                var indexDelete = arrayNode.indexOf(dataItem);
                                arrayNode.splice(indexDelete, 1);
                            } else {
                            	cobisMessage.showTranslateMessagesSuccess($filter('translate')('COMMONS.ERROR.MSG_ERROR_DELETE'),[],3000,false);
							}
                        });
                    }
                    else{
                    	cobisMessage.showTranslateMessagesSuccess($filter('translate')('COMMONS.ERROR.MSG_ERROR_DELETE'),[],3000,false);
                    }
                });
                
            };
            
            $scope.addNode = function (newNode) {
            	$scope.tree.append(newNode, $scope.tree.select());
            };
            
            $scope.updateNode = function (name) {
            	$scope.dataitem.text = name;
            	$scope.dataitem.name = name;
            };

        }]);

    window.cobisMainModule = app;
}(window));