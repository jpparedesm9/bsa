(function () {
    'use strict';
    var app = cobis.createModule(cobis.modules.CLIENTVIEWER, [cobis.modules.CONTAINER]);

    app.controller("clientviewer.productsSaleController", ['$scope',
   '$rootScope', '$filter', 'clientviewer.consolidatePositionService',
      function ($scope, $rootScope, $filter, consolidatePositionService) {

            var scope = $rootScope;
            $scope.orientationv = "vertical";
            $scope.orientationh = "horizontal";
            $rootScope.spid = 0;
			$scope.treeData = [];
            //Creaci�n de �rbol de productos basado en la lista de productos recuperados del servicio            
            $scope.currenciesProductColumns = [
                {
                    field: "name",
                    title: $filter('translate')("COMMONS.LABELS.LBL_NAME_PS")
                }];

            $rootScope.loadInformationProductSale = function () {
                $scope.getTreeProducts = function (item) {
                    var i = 0;
                    $scope.treeData = [];
                    $scope.detProduct = {
                        nameDP: $filter('translate')("COMMONS.LABELS.LBL_SELECT_PRODUCT_SALE"),
                        descriptionDP: $filter('translate')("COMMONS.LABELS.LBL_SELECT_PRODUCT_SALE"),
                        categoryDP: $filter('translate')("COMMONS.LABELS.LBL_SELECT_PRODUCT_SALE"),
                        availableDP: "S"
                    };


                    var ID_ROOT = "BPROOT";

                    var searchProductsSale = {};
					var clientId = "";
                    if ($rootScope.dynamicClientData.clientGeneralData.code == 0) {
                        clientId = "";
                    }
                    if (cobis.userContext.getValue(cobis.constant.USER_NAME) == null) {
                        cobis.userContext.getValue(cobis.constant.USER_NAME) = "";
                    }

                    searchProductsSale = {
                        clientId: $rootScope.dynamicClientData.clientGeneralData.code,
                        oficialId: cobis.userContext.getValue(cobis.constant.USER_NAME)
                    }

                    //Se recupera el listado plano de todos los productos
					
					if(searchProductsSale.clientId!=null){
						var allProducts = consolidatePositionService.queryAllProductsSale(searchProductsSale);
						allProducts.then(function (data) {
							if (!$rootScope.dynamicClientData.clientGeneralData.code || !cobis.userContext.getValue(cobis.constant.USER_NAME))
								return [];

							//Si se pudo recuperar productos bancarios se arma el �rbol de productos
							if (data != null && data.length >= 0) {
								//Identificaci�n del nodo ra�z para ubicar a sus hijos a n niveles
								for (i = 0; i < data.length; i++) {
									if (data[i].id == ID_ROOT) {
										//Se crea el nodo ra�z para el �rbol en base al objeto recuperado del servicio
										var node = {
											id: data[i].id,
											name: data[i].name,
											//type: $scope.NodeImage(data[i].nodeTypeCategory.nodeTypeProduct.id),
											spriteCssClass :$scope.NodeImage(data[i].nodeTypeCategory.nodeTypeProduct.id),
											expanded: true,
											description: data[i].description,
											category: data[i].nodeTypeCategory.id,
											productType: data[i].nodeTypeCategory.nodeTypeProduct.id,
											available: data[i].available,
											processes: data[i].processes
										};

										//Se recupera recursivamente los nodos hijos
										node.items = $scope.ProductChilds(data, ID_ROOT);

										//Se agrega el nodo raiz con sus hijos para retornado
										$scope.treeData.push(node);

									}
								}

								$scope.treeDataProducts = new kendo.data.HierarchicalDataSource({
									data: $scope.treeData
								});
							}
						});
					}

                    $scope.currenciesSelectedProduct = [];

                    $scope.policiesSelectedProduct = [];
                    $scope.infoSelectedProduct = [];
                    $scope.processesSelectedProduct = [{
                        text: "Procesos"
                    }];
                }



                $scope.getTreeProducts();

                //M�todo que completa la lista de informaci�n de las monedas de un producto
                $scope.CurrenciesProduct = function (currenciesProduct) {
                    //Se recupera la lista de todas las monedas disponibles
                    var allCurrencies = consolidatePositionService.queryAllCurrenciesProductsSale();

                    //Se recorre la lista b�sica de ids de monedas del producto y con esto se recupera la informaci�n completa en base 
                    //al listado total de monedas
                    allCurrencies.then(function (data) {
                        for (var i = 0; i < currenciesProduct.length; i++) {
                            for (var j = 0; j < data.length; j++) {
                                if (currenciesProduct[i].id.currencyId == data[j].code) {
                                    currenciesProduct[i].code = data[j].code;
                                    currenciesProduct[i].name = data[j].name;
                                    break;
                                }
                            }
                        }
                        $scope.currenciesSelectedProduct = currenciesProduct;
                    });

                }

                $scope.pMenu = [{
                    text: "Procesos",
                    items: [{
                        text: "SOLICITUD DE AHORRO VOLUNTARIO",
                        url: "debts-tpl.html"
                    }, {
                        text: "SOLICITUD OPERACION ORIGINAL",
                        url: "debts-tpl.html"
                    }, {
                        text: "SOLICITUD REFINANCIAMIENTO",
                        url: "debts-tpl.html"
                    }, {
                        text: "SOLICITUD RESTRUCTURACION",
                        url: "debts-tpl.html"
                    }]
                }];

                //permite armar el men� de procesos del producto
                $scope.ProcessesProduct = function (processesList) {
                    //Se crea el nodo raiz
                    var rootMenu = [{
                        text: "Procesos"
                    }];
                    var aditionalMenu = new Array();
                    $scope.pMenu = [{
                        text: "Procesos"
                    }];

                    //Si existen procesos asociados al producto se cargan como hijos del nodo ra�z
                    if (processesList != null && processesList.length > 0) {
                        for (var i = 0; i < processesList.length; i++) {
                            aditionalMenu.push({
                                text: processesList[i].processName,
                                url: "debts-tpl.html"
                            });
                        }

                        rootMenu[0].items = aditionalMenu;
                    }

                    $scope.pMenu = rootMenu;
                }

                //M�todo que permite recuperar la informaci�n de un producto en base a su Id
                $scope.ProductInfo = function (product) {

                    if (product.available == "S")
                        $scope.availableProduct = true;
                    else
                        $scope.availableProduct = false;

                    var ProductDet = consolidatePositionService.queryBankingProductBasicInformation(product.id);
                    ProductDet.then(function (data) {
                        $scope.detProduct = {
                            nameDP: data.name,
                            descriptionDP: data.description,
                            categoryDP: data.nodeTypeCategory.name,
                            availableDP: data.available,
                            currencyProductsDP: data.currencyProducts
                        };
                        $scope.CurrenciesProduct($scope.detProduct.currencyProductsDP);

                    })

                }

                //Funci�n que retorna la imagen para los diferentes nodos del �rbol
                $scope.NodeImage = function (productType) {
                    var baseImageDir = "../../assets/commons/img/";
                    var nodeImage;
                    switch (productType) {
                    case 1:
						nodeImage = 'fa fa-university nodecompany';
                        break;
                    case 2:
						nodeImage = 'fa fa-bar-chart nodefamilyproduct';
                        break;
                    case 3:
						nodeImage = 'fa fa-tasks nodeproductgroup';
                        break;
                    case 4:
						nodeImage = 'fa fa-puzzle-piece nodeproduct';
                        break;
                    case 5:
						nodeImage = 'fa fa-puzzle-piece nodeproduct';
                        break;
                    default:
						nodeImage = 'fa fa-puzzle-piece nodeproduct';
                    }

                    return nodeImage;
                }

                $scope.menuOrientation = "vertical";

                //M�todo que permite recuperar los nodos hijos en base al id del padre y de la lista de nodos totales recuperados del servicio
                $scope.ProductChilds = function (allProducts, idParent) {
                    var i = 0;
                    var childList = new Array();

                    //Se buscan los nodos hijos en base al id del padre
                    for (i = 0; i < allProducts.length; i++) {
                        if (allProducts[i].parentnode == idParent) {
                            //Se crea un nodo para agregar al �rbol de productos en base al objeto recuperado por el servicio
                            var node = {
                                id: allProducts[i].id,
                                name: allProducts[i].name,
                                //type: $scope.NodeImage(allProducts[i].nodeTypeCategory.nodeTypeProduct.id),
                                expanded: true,
                                description: allProducts[i].description,
                                category: allProducts[i].nodeTypeCategory.id,
                                productType: allProducts[i].nodeTypeCategory.nodeTypeProduct.id,
                                available: allProducts[i].available,
                                processes: allProducts[i].processes,
								spriteCssClass : $scope.NodeImage(allProducts[i].nodeTypeCategory.nodeTypeProduct.id)
                            };

                            //Se agrega en la lista de hijos
                            childList.push(node);

                            //Se buscan los hijos del nodo actual y se los agrega como hijos en la propiedad items
                            node.items = $scope.ProductChilds(allProducts, allProducts[i].id);
                        }
                    }

                    //Se retorna la lista de nodos hijos
                    return childList;

                };

                //Evento que se dispara al seleccionar un producto
                $scope.onProductSelected = function (item) {
                    //Se recupera el item del viewModel correspondiente al producto seleccionado
                    //var uid = $(e.node).closest("li").data("uid");
                    //var item = e.sender.dataSource.getByUid(uid);

                    if (item.productType == 5) {
                        //Se consulta la informaci�n general del producto seleccionado y se la coloca en el viewModel
                        $scope.ProductInfo(item);
                        $scope.infoSelectedProduct = $scope.detProduct;
                        //viewModel.set("processProduct", getProcessesProduct(item.processes));
                        //Se consultan los procesos del producto seleccionado y despliega como un men�
                        $scope.ProcessesProduct(item.processes);
                        //Se consultan las monedas del producto seleccionado y se la coloca en el viewModel
                        //Se encera la lista de pol�ticas ya que esta depende de la moneda seleccionada
                        $scope.policiesSelectedProduct = [];

                    } else {
                        //Se inicializa la informaci�n del producto
                        $scope.infoSelectedProduct = {};
                        //Se inicializa el men� de producto para que desaparezca visualmente
                        //viewModel.set("processProduct", []);                                      
                        //Se inicializa la informaci�n de las monedas del producto
                        $scope.currenciesSelectedProduct = [];
                        //Se inicializa la lista de pol�ticas ya que esta depende de la moneda seleccionada
                        $scope.policiesSelectedProduct = [];

                        cobis.getMessageManager().showTranslateMessagesInfo("COMMONS.LABELS.LBL_MSG_FINAL_PRODUCT");
                    }
                }

                //Evento que se dispara al seleccionar una moneda del producto
                $scope.onCurrencyProductSelected = function (item) {

                    //Se recupera el item del producto seleccionado en el grid
                    //var item=e.sender.dataItem(e.sender.select());

                    //Si el item tiene pol�ticas definas
                    if (item.policyProducts != null) {
                        //Se agregan las pol�ticas en un listado y se coloca en la grilla destinada las pol�ticas
                        var policiesArray = new Array();
                        for (var i = 0; i < item.policyProducts.length; i++) {
                            policiesArray.push({
                                code: item.policyProducts[i].code,
                                name: item.policyProducts[i].name
                            });
                        }
                        $scope.policiesSelectedProduct = policiesArray;

                        //Se mapea el modelo a la grilla de pol�ticas
                        //kendo.bind($("#grdPolicies"), viewModel);
                    }

                }
				
				
				//Crea instancia de un proceso
                $scope.processClick = function (productId, processId) {
					$scope.processClick(productId, processId, isLine);
				}

                //Crea instancia de un proceso
                $scope.processClick = function (productId, processId, isLine) {
					var operation = null;
					if (productId.operationType == 'CCA' || productId.product == 'CCA')
					{
                        if(productId.operation==null){
                            operation = productId.numberOperation;
                        }else{
                            operation = productId.operation;
                        }
						
					}
					
					if ((productId.operationType == 'CTA' || productId.operationType == 'AHO' || productId.operationType == 'PFI')||(productId.product == 'CTA' || productId.product == 'AHO' || productId.product == 'PFI'))
					{
						operation = productId.operationNumber;
					}
					
					if (productId.operationType == 'CUS'||productId.product == 'CUS')
					{
						operation = productId.operationNumber;
					}
					
					if (productId.operationType == 'GRB'||productId.product == 'CEX')
					{
						operation = productId.numberOperation;
						if (operation == null) {
							operation = productId.lineNumber;
						}
					}
					
					if (productId.operationType == 'CRE'||productId.product == 'CRE')
					{
						operation = productId.lineNumber;
					}
					
					if (operation == null && isLine == 'S')
					{
						operation = productId.lineNumber;
					}
					var productIdentifier = "";
					var paremterOne = "";
					if (isLine == 'N')
					{
						if (operation != null)
						{
							productIdentifier = operation;
						}
						else
						{
							productIdentifier = productId.id;
						}
					}
					else
					{
						productIdentifier = productId.id;
						paremterOne = operation;
					}
					
					var clientID = 0;
					if (productId.id != 'CLAIMS')
					{
						clientID = $rootScope.dynamicClientData.clientGeneralData.code;
					}
					//CPN Renovacion
					if (productId.id == undefined){
						productIdentifier = productId.operationType;
					}
					
                    var process = {
                        processId: processId,
                        cobisUserName: cobis.userContext.getValue(cobis.constant.USER_NAME),
                        filial: 1,
                        bussinessInformationIntOne: clientID,
                        bussinessInformationStringTwo: productIdentifier,
                        bussinessInformationIntThree: 0,
                        bussinessInformationIntTwo: 0,
                        bussinessInformationStringOne: paremterOne
                    }
					process.bussinessInformationStringSeven = $rootScope.dynamicClientData.clientGeneralData.type;
					
						
					
                    var serviceInstance = consolidatePositionService.createProcessInstance(process);
                    serviceInstance.then(function (data) {
                        console.log(data);
                        cobis.userContext.setValue("OPENFILTERMODE", "Q");
//                      var url = "/CTSProxy/services/cobis/web/views/LATFO/INBOX/T_INBOX_38_KBXNR21/1.0.0/VC_KBXNR21_RMBPE_966_TASK.html?processInstanceIdentifier=" + data.processInstanceId;
            			var url = "${contextPath}/cobis/web/views/inbox/inbox-task-container-page.html?processInstanceIdentifier=" + data.processInstanceId;
                        var menu = $filter('translate')('COMMONS.MENU.MNU_CONTAINER_INBOX_FF');
                        cobis.container.tabs.openNewTab(menu, url, menu, true);

                    });
                }
                //Crea instancia de un proceso
                $scope.simulationClick = function (productId) {
                    var customer = $rootScope.dynamicClientData.clientGeneralData;
					customer.onlyDocumentId = (customer.onlyDocumentId === null) ? $rootScope.dynamicClientData.customer.documentId : customer.onlyDocumentId;
                    cobis.userContext.setValue("OPENFILTERMODE", "Q");
                    var url = "/CTSProxy/services/cobis/web/views/LATFO/SIMUL/T_SIMUL_55_ESAOR56/1.0.0/VC_ESAOR56_SATOR_398_TASK.html?operationType=" + productId.id + "&customerName=" + customer.name + "&customerId=" + customer.onlyDocumentId;
                    var menu = $filter('translate')('COMMONS.MENU.MNU_SIMULATION');
                    cobis.container.tabs.openNewTab(menu, url, menu, true);

                }


                $rootScope.rootProcessClick = function (productId, processId) {
                    $rootScope.rootProcessClick(productId, processId, 'N');
                }
				
				$rootScope.rootProcessClick = function (productId, processId, isLine, operationType) {
					//productId.operationType = operationType;
                    $scope.processClick(productId, processId, isLine);
                }
            };
			
			 $scope.onOpenCtxMenu = function (dataItem,e) {
				cobis.userContext.setValue('DATATASK',null);
				$scope.tree=$("#tree").data("kendoTreeView");
				$scope.dataItemSelectedProduct = $scope.tree.dataItem(e.target);				
				$scope.ctxMenu = [];
				
				if($scope.dataItemSelectedProduct.processes != null&&$scope.dataItemSelectedProduct.processes.length >= 0){
					$scope.ctxMenu.push({code:"simulation",text:$filter('translate')('CLIENTVIEWER.BUTTONS.BTN_SIMULATION')});
					for(var i=0 ; i < $scope.dataItemSelectedProduct.processes.length;i++ ) {
						if ($scope.dataItemSelectedProduct.processes[i].generic == 'S') {
							$scope.ctxMenu.push({code:$scope.dataItemSelectedProduct.processes[i].flowId,text:$scope.dataItemSelectedProduct.processes[i].processName});
            }
					}
				}				
				$scope.tree.select($scope.tree.findByUid($scope.dataItemSelectedProduct.uid));
			 };
			 
			 $scope.ctxMnuClick = function(opt){
				cobis.userContext.setValue('DATATASK',null);
				if(opt=="simulation"){
					$scope.simulationClick($scope.dataItemSelectedProduct);
				}
				if(opt!="simulation"){
					$scope.processClick($scope.dataItemSelectedProduct,opt);
				}
			 };
   }]);
		if (angular.isUndefined(window.cobisMainModule)) {
			window.cobisMainModule = app;
		}
		
}(window));