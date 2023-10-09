(function () {
    'use strict';
    var app = cobis.createModule("collateral", [cobis.modules.CONTAINER, 'ui.bootstrap',"designerModule","ngCookies","ngResource","oc.lazyLoad"]);

    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });
	
	app.directive('popover', function($compile){
    return {
        link: function(scope, element, attrs) {
            // define popover for this element
            $(element).popover({
                html: true,
                placement: "bottom",
                // grab popover content from the next element
                content: $compile( $(element).siblings(".pop-content").contents() )(scope)
            });
        }
    }
});

    app.controller("collateral.collateralHeaderController", ['$scope', '$rootScope', '$filter','$location', "cobisMessage","$translate", "$log", "$modal", "designer","dsgnrCommons","$compile",
    function ($scope, $rootScope, $filter, $location, cobisMessage, $translate, $log, $modal, designer, dsgnrCommons, $compile) {
		$scope.taskHeader = {};
		$scope.taskPopover = [];
		$scope.value = "asdasd";
		$scope.htmlString = "";
		$scope.custodyId = "";
		$scope.type = "";
		$scope.mode = "";

		$scope.customEvents = {
			closeModalEvent: {
                    VC_GURNH31_OMREA_904 : function (onCloseModalEventArgs){
						onCloseModalEventArgs.commons.api.parentVc.currentRow = {"CodeWarranty": onCloseModalEventArgs.result.parameterGuarantee.GuaranteeCode,"Type": onCloseModalEventArgs.result.parameterGuarantee.GuaranteeType,"Office": onCloseModalEventArgs.result.parameterGuarantee.Office};
						onCloseModalEventArgs.commons.api.parentVc.showContent(false);
						onCloseModalEventArgs.commons.api.parentVc.setContainerView(onCloseModalEventArgs.result.parameterGuarantee.GuaranteeCode);
						
						$scope.idGuarantee = onCloseModalEventArgs.result.parameterGuarantee.GuaranteeCode;
					},
					VC_CHANGEVAEU_190472 : function (onCloseModalEventArgs){
						onCloseModalEventArgs.commons.api.parentVc.currentRow = {"CodeWarranty":$scope.externalCode,"Type":$scope.type,"Office": "1"};
						onCloseModalEventArgs.commons.api.parentVc.showContent(false);
						
					}
			}

		};
    	
    	//Funcion para llamar ventana con informacion adicional del la tarea 
        $scope.vc = designer.initCustomViewContainer('collateralHeader', $scope.customEvents);
        
        $scope.vc.viewState = {
        		dynamic: {
                    view: {},
                    customView: {}
            },
			dynamicInfo: {
				view: {},
				customView: {}
            }
        };
		
		
		$scope.searchCollateral = function(){
			var api = new dsgnrCommons.API($scope.vc);
			var nav = api.navigation;	
			
			nav.address = {
				moduleId: "BUSIN",
				subModuleId: "FLCRE",
				taskId: "T_FLCRE_24_GURNH31",
				taskVersion: "1.0.0",
				viewContainerId: "VC_GURNH31_OMREA_904",
				useMinification: false
			};
			
			nav.label = cobis.translate('BUSIN.DLB_BUSIN_ARANEESRH_29071');
            nav.modalProperties = {
                size: 'lg'
            };
			
            nav.queryParameters = {
                mode: 2
            };
            nav.customDialogParameters = {
                maxRelation: 0			
            };
            nav.openModalWindow("VC_RRCAI67_WACRI_88");
					
		};

    	//Metodo que se ejecuta al cargar la pagina
    	$scope.initData = function () {
    		var api = new dsgnrCommons.API($scope.vc);
    		$scope.taskHeader = api.navigation.getCustomDialogParameters().taskHeader;
			$scope.taskPopover = api.navigation.getCustomDialogParameters().taskPopover;
			$scope.mode = api.navigation.getCustomDialogParameters().mode;
			$scope.custodyId = api.navigation.getCustomDialogParameters().custody;
			$scope.type = api.navigation.getCustomDialogParameters().custodyType;
			$scope.externalCode = api.navigation.getCustomDialogParameters().externalCode;
			$scope.warranty = api.navigation.getCustomDialogParameters().warranty;
			
			$("[data-toggle=popover]").popover({
				html: true, 
				content: function() {
					return $('#popoverinfo').html();
				}
			});

	
    	};
		
	$scope.liberation = function(){
	    var api = new dsgnrCommons.API($scope.vc);
	    var nav = api.navigation;	

		nav.address = {
		moduleId: "WRRNT",
		subModuleId: "MNTNN",
		taskId: "T_LIBERATIONIFY_422",
		taskVersion: "1.0.0",
		viewContainerId: "VC_LIBERATINO_737422",
		useMinification: false
	    };
	
	    nav.label = cobis.translate('WRRNT.LBL_WRRNT_LIBERACIN_97447');
        nav.modalProperties = {
            size: 'sm'
        };
		
        nav.queryParameters = {
            mode: 1
        };
        nav.customDialogParameters = {
           custodyType : $scope.type,
		custody : $scope.custodyId,
		externalCode : $scope.externalCode
        };
        nav.openModalWindow("VC_RRCAI67_WACRI_88");
					
	};
	
	$scope.changeValue = function(){
	    var api = new dsgnrCommons.API($scope.vc);
	    var nav = api.navigation;	

		nav.address = {
		moduleId: "WRRNT",
		subModuleId: "MNTNN",
		taskId: "T_CHANGEVALUEEE_472",
		taskVersion: "1.0.0",
		viewContainerId: "VC_CHANGEVAEU_190472",
		useMinification: false
	    };
	
	    nav.label = cobis.translate('WRRNT.LBL_WRRNT_CAMBIODEE_48627');
        nav.modalProperties = {
            size: 'sm'
        };
		
        nav.queryParameters = {
            mode: 1
        };
        nav.customDialogParameters = {
           warranty : $scope.warranty
		   
        };
        nav.openModalWindow("VC_RRCAI67_WACRI_88");
					
	};
	
	$scope.vc.setContainerView = function(externalCode){
		if ($scope.vc.parentVc != undefined){
            $scope.vc.parentVc.setContainerView(externalCode);
        }
	}

   }]);

    window.cobisMainModule = app;

}());