(function (window) {
    'use strict';

    var app = cobis.createModule("businessprocess", ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', "ngResource", 'ngCookies']);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });
	
    app.controller("busin.treeEconomicActivityController", ['$scope', '$rootScope', '$filter','$modal', '$routeParams', '$timeout', 
												'designer', 'dsgnrCommons', 'busin.businServices','$translate', 'cobisMessage', cobis.modules.CONTAINER + '.containerInfoService', 
  function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, designer, dsgnrCommons, businServices,$translate, cobisMessage, containerInfoService) {
    $scope.isParentNodeTree = false;
	$scope.saveClick = false;
	$scope.orientationv = "vertical";
    $scope.orientationh = "horizontal";
	$scope.vc = designer.initCustomViewContainer('process', $scope.customEvents);
	$scope.treeDataSourceEconomicActivity = [];
	$("#treeViewEconomicActivity").kendoTreeView({
					  dataSource: [
						{ 	id: 0,
							idparent: "",
							name: "",
							text: "",
							code: "",
							type: "glyphicon glyphicon-th",
							nodeLevel:0,
							level: 1,
							expanded: true,								
							items:[]
						}
					  ]
					});
	
	$scope.vc.viewState = {
        dynamicTreeGroup: {
            view: {},
            customView: {}
        },
		dynamicGroup: {
            view: {},
            customView: {}
        },
		SAVEBUTTON: {
					_readonly: undefined,
					_disabled: undefined,
					_visible: undefined,
					label: "BUSIN.DLB_BUSIN_CHOOSEPHQ_89411",
					labelArgs: {},
					validationCode: 0,
					get readonly() {
						if (angular.isDefined(this._readonly)) {
							return this._readonly;
						}
						return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
					},
					set readonly(readonly) {
						this._readonly = readonly;
					},
					get disabled() {
						if (angular.isDefined(this._disabled)) {
							return this._disabled;
						}
						return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
					},
					set disabled(disabled) {
						this._disabled = disabled;
					},
					get visible() {
						if (angular.isDefined(this._visible)) {
							return this._visible;
						}
						return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
					},
					set visible(visible) {
						this._visible = visible;
					}
				},
		FINISHBUTTON: {
					_readonly: undefined,
					_disabled: false,
					_visible: undefined,
					label: "BUSIN.DLB_BUSIN_CANCELARI_56591",
					labelArgs: {},
					validationCode: 0,
					get readonly() {
						if (angular.isDefined(this._readonly)) {
							return this._readonly;
						}
						return designer.enums.hasFlag(designer.constants.mode.Query, $scope.vc.mode);
					},
					set readonly(readonly) {
						this._readonly = readonly;
					},
					get disabled() {
						if (angular.isDefined(this._disabled)) {
							return this._disabled;
						}
						return !designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
					},
					set disabled(disabled) {
						this._disabled = disabled;
					},
					get visible() {
						if (angular.isDefined(this._visible)) {
							return this._visible;
						}
						return designer.enums.hasFlag(designer.constants.mode.All, $scope.vc.mode);
					},
					set visible(visible) {
						this._visible = visible;
					}
				}
	};
	
	
	$scope.initData = function () {
		containerInfoService.getProcessDate().then(function (processDate) {
            $scope.processDate = processDate;
        });
		$("#NAVIGATIONBUTTONBAR").css("visibility","visible");
		$scope.vc.viewState.SAVEBUTTON.visible=true;
		$scope.vc.viewState.FINISHBUTTON.visible=true;
		$scope.getTreeEconomicActivity();
	};
	
	$scope.setTreeView = function () {
		var api = new dsgnrCommons.API($scope.vc),
		nav = api.navigation;		
		
		nav.customAddress = {
			id: 'businessprocess',
			url: "businessprocess/templates/busin-tree-economicActivity-tpl.html",
			useMinification: false
		};
	
		nav.registerCustomView('dynamicTreeGroup');
	};
		
    
	$scope.getTreeEconomicActivity = function () {//construccion primer nodo
		$scope.economicActivityType = [];
		
		
		
		var promise = businServices.GetAllEconomicActivityTypes("0");
		promise.then(function(data){
			$scope.economicActivityType = $scope.getEconomicActivityByType(data.data.returnEconomicActivityDataResponse);
			var tree=$("#treeViewEconomicActivity").data("kendoTreeView");
			tree.setDataSource(new kendo.data.HierarchicalDataSource({data:$scope.economicActivityType}));			
		});
	};
	
	$scope.onItemSelectedEconomicActivity = function(item){
		
		$scope.isParentNodeTree = false;
		var flag = false;																				//Flag por metodo asincrono
		var tree=$scope.treeViewProduct=$("#treeViewEconomicActivity").getKendoTreeView();
		
		if(item.nodeLevel != 6){
			var promise = businServices.GetAllEconomicActivityTypes(item.code);
		
			if(item.hasChildren && item.items.length == 0){
				promise.then(function(data){
					flag = true;
					$scope.getEconomicActivityByType(data.data.returnEconomicActivityDataResponse).forEach(function(newItem){
						tree.append(newItem, tree.select());					
					});			
				});
			}else{
				flag = true;
				$scope.isParentNodeTree = true;
			}
		}else{
			flag = true;
		}	
		
		if($scope.isParentNodeTree == false && flag){  //si el nodo seleccionado es nodo hijo
			if(item.children.data.length == 0){  //si el item no tiene hijos se puede crear la garantía
				$scope.vc.viewState.SAVEBUTTON.disabled=false;
				$scope.vc.viewState.FINISHBUTTON.disabled=false;
				$scope.getNodeData(item);
			}
		}else{
			$scope.showBlankPage();
			$scope.vc.viewState.SAVEBUTTON.disabled=true;
			$scope.vc.viewState.FINISHBUTTON.disabled=false;
		}
		
	};
	
	$scope.getEconomicActivityByType = function(returnEconomicActivityDataResponse){
		var economicActivitiesTypes = returnEconomicActivityDataResponse;
		var length = economicActivitiesTypes.length;
		var newItem;
		$scope.economicActivityType = [];
			
		for( var i = 0; i < length; i++){
		
			if(economicActivitiesTypes[i].descripcion!=null && economicActivitiesTypes[i].descripcion.trim() != "" ){
				newItem = {	id: i+1,
							idparent: "0",
							name: economicActivitiesTypes[i].descripcion,
							text: economicActivitiesTypes[i].codigo + " ... " + economicActivitiesTypes[i].descripcion,
							code: economicActivitiesTypes[i].codigo,
							type: "glyphicon glyphicon-th",
							nodeLevel:economicActivitiesTypes[i].nivel,
							//level: 1,
							expanded: true,								
							items:[]
							};
				$scope.economicActivityType.push(newItem);
			}
		}
		
		return $scope.economicActivityType;
	};
	
	$scope.getNodeData = function(item){
		//$scope.itemCode = item.code;
		//$scope.itemName = item.name;
		//var nodeData;
		$scope.nodeData = { itemCode: item.code,
					 itemName: item.name
					};
	};
	
	$scope.showBlankPage = function(){	
		var api = new dsgnrCommons.API($scope.vc),
		nav = api.navigation;		
		
		nav.customAddress = {
			id: 'businessprocess',
			url: "economicActivity/templates/blank.html",
			useMinification: false
		};
		nav.registerCustomView('dynamicGroup');
	};
	
	$scope.CtxProductMenu = function (e){//construccion del menu contextual de productos
		$scope.ctxMenu = [];
		$scope.treeViewEconomicActivity =$("#treeViewEconomicActivity").getKendoTreeView();
	};
	
	/*******************************************************************************************************************/
	/*******************************Eventos para los botones de la Barra de Navegación**********************************/
	/*******************************************************************************************************************/
	
	 //Navigation button bar finish event 
	$scope.finishOnClick = function(){
		$scope.showBlankPage();
		$scope.vc.viewState.SAVEBUTTON.disabled=true;
		$scope.vc.closeModal("");
	};
		   
	$scope.saveOnClick = function (){	
	//executeSave_ se creo en el evento initData de la tarea
		$scope.vc.closeModal($scope.nodeData);				
		$scope.saveClick = true;
	};
				
	//Método para llamar pantalla blank y encerar entidades y cerrar modal al guardar
	$scope.$watch('vc.model.ClosePage', function () {
		if($scope.saveClick == true){
			$scope.showBlankPage();
			$scope.vc.closeModal("");
		}
	});
	
				
  }]);
    if (angular.isUndefined(window.cobisMainModule)) {
		window.cobisMainModule = app;
	}
}(window));