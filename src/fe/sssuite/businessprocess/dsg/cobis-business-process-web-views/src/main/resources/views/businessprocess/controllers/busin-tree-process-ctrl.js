(function (window) {
    'use strict';

    var app = cobis.createModule("businessprocess", ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', "ngResource", 'ngCookies']);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });
	
    app.controller("busin.treeProcessController", ['$scope', '$rootScope', '$filter','$modal', '$routeParams', '$timeout', 
												'designer', 'dsgnrCommons', 'busin.businServices','$translate', 'cobisMessage', cobis.modules.CONTAINER + '.containerInfoService', 
  function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, designer, dsgnrCommons, businServices,$translate, cobisMessage, containerInfoService) {
    $scope.isParentNodeTree = false;
	$scope.saveClick = false;
	$scope.orientationv = "vertical";
    $scope.orientationh = "horizontal";
	$scope.vc = designer.initCustomViewContainer('process', $scope.customEvents);
	$scope.treeDataSourceWarranties = [];
	$("#treeViewWarranties").kendoTreeView({
					  dataSource: [
						{ 	id: 0,
							idparent: "",
							name: "",
							text: "",
							menuType: "",
							type: "glyphicon glyphicon-th",
							nodeLevel:1,
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
					label: "BUSIN.DLB_BUSIN_SAVELKIAQ_89169",
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
		$scope.getTreeWarranties();
	};
	
	$scope.setTreeView = function () {
		var api = new dsgnrCommons.API($scope.vc),
		nav = api.navigation;		
		
		nav.customAddress = {
			id: 'businessprocess',
			url: "businessprocess/templates/busin-tree-process-tpl.html",
			useMinification: false
		};
	
		nav.registerCustomView('dynamicTreeGroup');
	};
	
	
	//$scope.treeItemProduct = kendo.template($("#javascriptProductAdmin").html());			
    
	$scope.getTreeWarranties = function () {//construccion primer nodo
		$scope.warrantiesType = [];
		
		
		
		var promise = businServices.GetAllWarrantiesTypes(null);
		promise.then(function(data){
			$scope.warrantiesType = $scope.getWarrantiesByType(data.data.returnCollateralTypeResponse);
			var tree=$("#treeViewWarranties").data("kendoTreeView");
			tree.setDataSource(new kendo.data.HierarchicalDataSource({data:$scope.warrantiesType}));
			//$scope.treeDataSourceWarranties = new kendo.data.HierarchicalDataSource({data:$scope.warrantiesType});
			
		});
	};
	
	$scope.onItemSelectedWarranty = function(item){
		
		$scope.isParentNodeTree = false;
		var tree=$scope.treeViewProduct=$("#treeViewWarranties").getKendoTreeView();
		var promise = businServices.GetAllWarrantiesTypes(item.menuType);
		
		for(var i = 0; i<tree.dataSource._data.length; i++){
			if(tree.dataSource._data[i].menuType == item.menuType){  //compara si el nodo seleccionado es un nodo padre dentro del árbol
				$scope.isParentNodeTree = true;
			}
		}
		
		if(item.hasChildren && item.items.length == 0){
			promise.then(function(data){
				$scope.getWarrantiesByType(data.data.returnCollateralTypeResponse).forEach(function(newItem){
					tree.append(newItem, tree.select());					
				});			
			});

		}
		
		if($scope.isParentNodeTree == false){  //si el nodo seleccionado es nodo hijo
			if(item.children.data.length == 0){  //si el item no tiene hijos se puede crear la garantía
				promise = businServices.GetWarrantyType(item.menuType);
				promise.then(function(data){
					$scope.showWarrantyTypeData(data.data.returnTypeGuaranteeData);
					
					$scope.showEnableButtons(1);
					
				});	
			}
		}else{
			$scope.showBlankPage();
			$scope.vc.viewState.SAVEBUTTON.disabled=true;
			$scope.vc.viewState.FINISHBUTTON.disabled=false;
		}
		
	};
	
	$scope.getWarrantiesByType = function(returnCollateralTypeResponse){
		var collateralTypes = returnCollateralTypeResponse;
		var length = collateralTypes.length;
		var newItem;
		$scope.warrantiesType = [];
			
		for( var i = 0; i < length; i++){
		
			if(collateralTypes[i].description!=null && collateralTypes[i].description.trim() != "" ){
				newItem = {	id: i+1,
							idparent: "0",
							name: collateralTypes[i].description,
							text: collateralTypes[i].description,
							menuType: collateralTypes[i].type,
							type: "glyphicon glyphicon-th",
							nodeLevel:1,
							//level: 1,
							expanded: true,								
							items:[]
							};
				$scope.warrantiesType.push(newItem);
			}
		}
		
		return $scope.warrantiesType;
	};
	
	$scope.showWarrantyTypeData = function(returnTypeGuaranteeData){
	    var api = new dsgnrCommons.API($scope.vc),
		nav = api.navigation;
	    nav.queryParameters = {mode: 1};
		nav.address = {
		              moduleId: 'BUSIN',
		              subModuleId: 'FLCRE',
		              taskId: 'T_FLCRE_35_RRCAI67',
		              taskVersion: '1.0.0',
		              viewContainerId: 'VC_RRCAI67_WACRI_884',
					  useMinification: false
					  };	   
		nav.customDialogParameters = {
					typeGuaranteeData:returnTypeGuaranteeData,
					isNew: true,
					processDate: $scope.processDate
			};					  
		nav.registerView('dynamicGroup');
	};
	
	$scope.showBlankPage = function(){	
		var api = new dsgnrCommons.API($scope.vc),
		nav = api.navigation;		
		
		nav.customAddress = {
			id: 'businessprocess',
			url: "businessprocess/templates/blank.html",
			useMinification: false
		};
		nav.registerCustomView('dynamicGroup');
	};
	
	$scope.CtxProductMenu = function (e){//construccion del menu contextual de productos
		$scope.ctxMenu = [];
		$scope.treeViewWarranties =$("#treeViewWarranties").getKendoTreeView();
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
		   
	$scope.saveOnClick = function (currentTask){	
	//executeSave_ se creo en el evento initData de la tarea
	$scope.vc.executeSave_T_FLCRE_35_RRCAI67();					
		$scope.saveClick = true;
	};
				
	//Método para llamar pantalla blank y encerar entidades y cerrar modal al guardar
	$scope.$watch('vc.model.ClosePage', function () {
		if($scope.saveClick == true){
			$scope.showBlankPage();
			$scope.vc.closeModal("");
		}
	});
	
	$scope.vc.setContainerView = function(externalCode){
		if ($scope.vc.parentVc != undefined){
            $scope.vc.parentVc.setContainerView(externalCode);
        }
	};
	
	$scope.showEnableButtons = function(mode){
		//Acciones sobre la barra de navegación
		switch(mode){
			case 1:
                $("#NAVIGATIONBUTTONBAR").css("visibility", "visible");
                $scope.vc.viewState.SAVEBUTTON.visible = true;
                $scope.vc.viewState.SAVEBUTTON.disabled = false;
                $scope.vc.viewState.FINISHBUTTON.visible = true;
                $scope.vc.viewState.FINISHBUTTON.disabled = false;
			    break;
			default: break;
		}
	};
				
  }]);
    if (angular.isUndefined(window.cobisMainModule)) {
		window.cobisMainModule = app;
	}
}(window));