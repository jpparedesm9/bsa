(function (window) {
    'use strict';

    var app = cobis.createModule("collateral", ["oc.lazyLoad", cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', 'ngResource', 'ngCookies']);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });

	app.directive('collateralValidators', ['$compile', '$filter',
		function ($compile, $filter) {
			return {
				restrict: 'A',
				priority: 1,
				template: "",
				replace: true,
				link: function (scope, elm, attr) {	
					var field = eval('(' + attr.collateralValidators + ')');
					var elString = '<input id="'+ field.field + '" name="' + field.field + '" ';

					if (field.isMandatory) {
						var requiredMsg = null;
						requiredMsg = $filter('translate')('RENDERCOLLATERAL.MSG.MSG_REQ_FIELD_PT1') + ' ' + field.title + ' ' + $filter('translate')('RENDERCOLLATERAL.MSG.MSG_REQ_FIELD_PT2');
						elString = elString.concat(' required ');						
						elString = elString.concat(' data-required-msg ="'+ requiredMsg +'" ');
						
					}
					elString = elString.concat(' ng-model="dataItem[field.field]"');

					switch (field.type) {
							case 'N':
							elString = elString.concat(' kendo-numeric-text-box ');
							elString = elString.concat(' k-format ="\'#\'"');
							elString = elString.concat(' k-decimals = 0 ');
							break;
							case 'D':
							elString = elString.concat(' kendo-numeric-text-box ');
							elString = elString.concat(' k-decimals = 2 ');
							elString = elString.concat(' k-format="\'#,##0.0\'" ');
							break;
							case 'A':	
							//elString = elString.concat(' kendo-masked-text-box ');	
							elString = elString.concat(' class="form-control" ');																	
							break;
							case 'F':
							elString = elString.concat(' kendo-ext-date-picker');
							elString = elString.concat(' placeholder ="dd/MM/yyyy"');
							elString = elString.concat(' date-format="dd/MM/yyyy"');
							break;
					}
					
					
					elString = elString.concat(' ng-model-onblur />');
					//elString=elString.concat(' />');
					elm.html(elString).show();
					elm.removeAttr('collateral-validators');
					elm[0].removeAttribute('collateral-validators');
					$compile(elm.contents())(scope);
					var container = $('#'+field.field);
					kendo.init(container);
					container.kendoValidator();
					
				}
				
			}
		}
	]);


    app.controller("collateral.collaterRenderController", ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', '$timeout', 'collateral.collateralSpecificationServices', '$location', "designer", '$translate', 'dsgnrCommons','cobisMessage',
 function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, collateralSpecificationServices, $location, designer, $translate, dsgnrCommons, cobisMessage) {
            $scope.vc = designer.initCustomViewContainer('rendercollateral', $scope.customEvents);
			//$scope.vc.parentVc = designer.initCustomViewContainer('collateral', $scope.customEvents);
			
			/*********************************Entities****************************/
			$scope.CustodyInformation = function CustodyInformation(custody, type, branchOffice1, items){
				this.custody = custody;
				this.type = type;
				this.branchOffice1 = branchOffice1;
				this.items = items;
			};
			
		
			
			$scope.CollateralItemDTO = function CollateralItemDTO(custodyInformation, itemsInformation, mode){
				this.custodyInformation = custodyInformation;
				this.itemsInformation = itemsInformation;
				this.mode = mode;
			};
			
			
			
            $scope.vc.viewState = {
                dynamicField: {
                    view: {},
					customView: {},
					
                },
				SAVEBUTTON: {
					_readonly: undefined,
					_disabled: undefined,
					_visible: undefined,
					label: "RENDERCOLLATERAL.BUTTONS.BTN_SAVE",
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
				CANCELBUTTON: {
					_readonly: undefined,
					_disabled: false,
					_visible: undefined,
					label: "RENDERCOLLATERAL.BUTTONS.BTN_CANCEL",
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
			
			
	
            
			$scope.fields = [];
			$scope.dataItem = {};
			$scope.mode = '';
			$scope.sequential = 0;
			$scope.collateralType = '';
			$scope.collateralId = 0;
			$scope.branchOffice = 1;
			$scope.dataItemCopy = {};
			
			/******************************** Load Modal Event **********************************/
			$scope.loadModal = function(){
				var api = new dsgnrCommons.API($scope.vc),
                    nav = api.navigation,
					customDialogParameters = api.navigation.getCustomDialogParameters();
                
				
				if(customDialogParameters != null && customDialogParameters != undefined)
				{
					
					$scope.fields = customDialogParameters.fields;
					$scope.dataItem = customDialogParameters.dataItem;
					$scope.mode = customDialogParameters.mode;
					$scope.sequential = $scope.dataItem.sequential;
					$scope.collateralType = $scope.dataItem.collateralType;
					$scope.collateralId = $scope.dataItem.collateralId;
					$scope.branchOffice = $scope.dataItem.branchOffice;
					angular.copy($scope.dataItem, $scope.dataItemCopy);
					
				}
				
                $scope.vc.removeChildVc('dynamicField');
                
                nav.label = $filter('translate')('COMMONS.LABELS.TIT_CUSTOMER_SEARCH');
                nav.customAddress = {
                    id: 'renderCollateral',
                    url: '/collateral/templates/render-default-input.html'
                };
				
                nav.registerCustomView('dynamicField');
			};
			
			/***************************************Insert/Update Events***********************************/
			$scope.saveOnClick = function(){
				var items = $scope.fields.length;
				var validation = true;
				
				for(var i = 0; i < items; i++){
					var validator = $("#"+$scope.fields[i].field).kendoValidator().data("kendoValidator"); 
					if(validator!=null && !validator.validate() && validation){
						validation = false;
					}	
				}
					
				if(validation){
					var custodyInformation = new $scope.CustodyInformation($scope.collateralId, $scope.collateralType, $scope.branchOffice, items);
					
					var itemsInformation = {};
					for(var i =0; i < items; i++){
						var value = $scope.dataItem[$scope.fields[i].field] == null || $scope.dataItem[$scope.fields[i].field] == undefined ? '':$scope.dataItem[$scope.fields[i].field];
						itemsInformation["itemValue"+(i+1)] = value;
						itemsInformation["itemName"+(i+1)] = $scope.fields[i].title;
						
					}
					if('update' == $scope.mode){
						itemsInformation.sequential = parseInt($scope.sequential);
					}else if('insert' == $scope.mode){
						$scope.sequential = parseInt($scope.sequential) + 1;
						itemsInformation.sequential = $scope.sequential;
					}
					var result = collateralSpecificationServices.insertOrUpdateCollateralItems(new $scope.CollateralItemDTO(custodyInformation, itemsInformation, $scope.mode));
					result.then(function(){
						if('update' == $scope.mode){
							cobisMessage.showTranslateMessagesSuccess($filter('translate')('RENDERCOLLATERAL.MSG.MSG_SUCCESS_UPDATE'),[],3000,false);
							$scope.closeModal('update');
						}else if('insert' == $scope.mode){
							cobisMessage.showTranslateMessagesSuccess($filter('translate')('RENDERCOLLATERAL.MSG.MSG_SUCCESS_SAVE'),[],3000,false);
							$scope.closeModal('insert');
						}
					});
				}else{
					cobisMessage.showTranslateMessagesError($filter('translate')('RENDERCOLLATERAL.MSG.MSG_FIELD_WITH_ERROR'),[],3000,false);
				}
				
			};
			
			$scope.cancelOnClick = function(){
				$scope.closeModal('cancel');
			}
			
			/*********************************Close Modal******************************/
			$scope.closeModal = function (source) {
                var api = new dsgnrCommons.API($scope.vc),
                    nav = api.navigation,
					response = {};
				if('cancel' == source){
					$scope.dataItem = $scope.dataItemCopy;					
				}else{
					$scope.dataItem.sequential = $scope.sequential;                    
				}
				response = {
                        dataItem: $scope.dataItem,
						mode: source
                };
                $scope.vc.closeModal(response);
            }

			
        }]);
		
		
    if (angular.isUndefined(window.cobisMainModule)) {
        window.cobisMainModule = app;
    }
}(window));