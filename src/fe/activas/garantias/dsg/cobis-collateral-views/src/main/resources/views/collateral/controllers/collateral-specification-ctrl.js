(function (window) {
    'use strict';

    var app = cobis.createModule("collateral", ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', 'ngResource', 'ngCookies']);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });

	

    app.controller("collateral.collateralSpecificationController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', '$timeout', 'collateral.collateralSpecificationServices', '$location', "designer", '$translate', 'dsgnrCommons','cobisMessage',
 function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, collateralSpecificationServices, $location, designer, $translate, dsgnrCommons, cobisMessage) {
            
			$scope.customEvents = {
				closeModalEvent: {
                    rendercollateral : function (onCloseModalEventArgs){
						var result = onCloseModalEventArgs.result;
						if(result.dataItem!= null && result.dataItem!= undefined){
							$scope.specifications =  $scope.grid.dataSource;
							if('insert'==result.mode){
								$scope.sequential = result.dataItem.sequential;													
								$scope.specifications.add(result.dataItem);
							}else if('cancel'==result.mode){
								for(var i = 0; i < $scope.columns.length - 1; i++){
									$scope.dataItem.set($scope.columns[i].field, result.dataItem[$scope.columns[i].field]);
								}
							
							}
						}
					}
				}
			};
			$scope.vc = designer.initCustomViewContainer('collateral', $scope.customEvents);
            $scope.vc.viewState = {
                dynamic: {
                    view: {},
					customView: {},
					
                },
				dynamicField: {
                    view: {},
					customView: {},
					
                }
            };
			
			
					
            $scope.items = null;
            $scope.dataItems = null;
			$scope.dataItem = {};
			$scope.columns = [];
			$scope.datasource = [];
			$scope.toolbarTemplate = kendo.template($("#toolbarTemplate").html());
			$scope.gridButtonsTemplate = kendo.template($("#gridButtonsTemplate").html());
			$scope.hasData = false;
			$scope.fields = [];
			$scope.modalMode = "";
			$scope.sequential = 0;
			$scope.grid = null;			
			$scope.gridData =  {};
			$scope.isNew = false;
			$scope.collateralType = '';
			$scope.collateralId = 0;
			$scope.branchOffice = 1;

            $scope.initData = function () {
				cobis.showMessageWindow.loading(true);
				var api = new dsgnrCommons.API($scope.vc),
					nav = api.navigation, 
					customDialogParameters = nav.getCustomDialogParameters();
					
				
				if(customDialogParameters!=undefined && customDialogParameters != null){
					$scope.isNew = customDialogParameters.isNew;
					$scope.collateralType = customDialogParameters.collateralType;
					$scope.collateralId = customDialogParameters.collateralId;
					
					if(customDialogParameters.collateralType != null && customDialogParameters.collateralType != undefined){
						$scope.items = collateralSpecificationServices.getCollateralItems(customDialogParameters.collateralType);
					}
					if(customDialogParameters.collateralId != null && customDialogParameters.collateralId != 0){
						$scope.dataItems = collateralSpecificationServices.getSearchedCollateralItems(customDialogParameters.collateralId, customDialogParameters.branchOffice, customDialogParameters.collateralType);
					}
					$scope.getCollateralDataItems();
				}
				
				
				cobis.showMessageWindow.loading(false);
            };

            //Obtener columnas Grilla Especificación Garantías
            $scope.getCollateralDataItems = function () {
  				$(document).ready(function(){
					var api = new dsgnrCommons.API($scope.vc),
						nav = api.navigation;
					if($scope.datasource.length == 0  && $scope.columns.length == 0){
						if ($scope.items != null && $scope.items != undefined) {
							$scope.items.then(function (data) {
								cobis.showMessageWindow.loading(true);
								$scope.fields = data;
								if (data != null && data != undefined && data.length > 0) {
									for (var i = 0; i < data.length; i++) {
										$scope.columns.push(data[i]);
									}
								}
								$scope.columns.push({ command: { name: "gridButtons", template: $scope.gridButtonsTemplate}, title: "", width: "180px" });
							
								if($scope.dataItems != null && $scope.dataItems != undefined){
									$scope.dataItems.then(function (items) {
										cobis.showMessageWindow.loading(true);
										$scope.sequential = 0;
										//Convert map to array
										var keys = Object.keys(items);
										var elements = keys.map(function(v) { return items[v]; });
										
										$scope.dataSource = new kendo.data.DataSource();
										elements.forEach(function(element){
											if($scope.sequential < parseInt(element.sequential)){
												$scope.sequential = parseInt(element.sequential);
											}
											$scope.dataSource.add(element);
										});
								
										$scope.fillGrid(nav);
									});
								}	

								$scope.fillGrid(nav);
								
							});
						}
					}
					cobis.showMessageWindow.loading(false);
				});
            };
			
			/******************************** Grid Events **********************************/
			
			//Render
			$scope.$on("kendoWidgetCreated", function(event, widget){
				$scope.grid =  $("#specificationGrid").data("kendoGrid");
				if (widget === $scope.grid) {
					//Double Click to Edit
					$("#specificationGrid").on("dblclick", " tbody > tr", function () {
						if($scope.isNew == false){
							var grid =  $("#specificationGrid").data("kendoGrid");
							$scope.dataItem = grid.dataItem($(this));
							$scope.callCollateralSpecificationModal("update", $scope.dataItem, $scope.dataItem.sequential);
						}
					});				
				}
			});
  
			//Edit (Not used)
			$scope.gridEditing = function(e){
				$scope.dataItem = this.dataItem;
				$scope.callCollateralSpecificationModal("update", dataItem, dataItem.sequential);
			};
			
			//Delete item row 
			$scope.gridDeleting = function(){
				$scope.dataItem = this.dataItem;
				var result = collateralSpecificationServices.deleteCollateralItems($scope.collateralId,$scope.collateralType,$scope.dataItem.sequential,1);
				result.then(function(){
					cobisMessage.showTranslateMessagesSuccess($filter('translate')('COLLATERAL.MSG.MSG_SUCCESS_DELETE'),[],3000,false);
					$scope.grid.removeRow($($scope.grid.dataItem($(this)))); //just gives alert message
					$scope.grid.dataSource.remove($scope.dataItem); //removes it actually from the grid
					
				});
			
			};
			//Create item row
			$scope.gridCreating = function(){
				$scope.callCollateralSpecificationModal("insert", [], $scope.sequential);
			};
			
			$scope.callCollateralSpecificationModal = function(mode, dataItem, sequential){
				var api = new dsgnrCommons.API($scope.vc),
                    nav = api.navigation;
                
                nav.label = 'Especificaci\u00f3n de Garant\u00edas';
				nav.customAddress = {
					id: 'rendercollateral',
					url: '/collateral/templates/render-items-values.html',
					useMinification: false
				};
				
				nav.scripts = [ {
					module : "collateral",
					files : [ 'collateral/controllers/collateral-render-items-ctrl.js']
					
				} ];
				
				nav.modalProperties = {
					size: 'lg'
				};
				dataItem.collateralType = $scope.collateralType;
				dataItem.collateralId = $scope.collateralId;
				dataItem.branchOffice = $scope.branchOffice;
				dataItem.sequential = sequential;
				nav.customDialogParameters = {
					fields: $scope.fields,
					dataItem: dataItem,
					mode: mode
				};
				nav.openCustomModalWindow('rendercollateral')
			};
			
			/******************Utils*********************/
		
			$scope.fillGrid = function(nav){
				$scope.gridData =  {
									dataSource: $scope.dataSource,										
									columns: $scope.columns,
									pageable: {
										numeric: true,
										previousNext: true,
										refresh: true
									},
									toolbar: $scope.toolbarTemplate,
									scrollable: true,
									selectable: true
								};
								
				nav.customAddress = {
									id: 'collateral',
									url: '/collateral/templates/collateral-specification-grid-tpl.html',
									useMinification: false
								};
								
				nav.registerCustomView('dynamic');
				cobis.showMessageWindow.loading(false);
		
			};
			
			$scope.showButton = function(){
				return $scope.isNew == false && $scope.columns.length > 1;
			}
			
			
        }]);
		
		
		
    if (angular.isUndefined(window.cobisMainModule)) {
        window.cobisMainModule = app;
    }
}(window));