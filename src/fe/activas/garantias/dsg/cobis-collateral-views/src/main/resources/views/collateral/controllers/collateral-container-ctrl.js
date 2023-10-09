(function () {
    'use strict';
    var app = cobis.createModule("collateral", [cobis.modules.CONTAINER, 'ui.bootstrap',"designerModule","ngCookies","ngResource","oc.lazyLoad"]);


	
    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routeProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });

	
    app.controller("collateral.collateralContainerController", ['$scope', '$rootScope', '$filter','$location', "cobisMessage","$translate", "$log", "$modal", "designer","dsgnrCommons", "collateral.collateralService",
      function ($scope, $rootScope, $filter, $location, cobisMessage, $translate, $log, $modal, designer, dsgnrCommons, collateralServices) {
    	
    	//Funcion para llamar ventana con informacion adicional del la tarea 
        $scope.vc = designer.initCustomViewContainer('collateralContainer', $scope.customEvents);
        
        $scope.customEvents = {};
		$scope.allowLiberation = false;
		$scope.showOptions = false;
		$scope.allowChangeVal= false;
		

		
		$scope.vc.currentRow  = null;
        
        $scope.vc.viewState = {
        		header: {
                    view: {},
                    customView: {}
            },
			content: {
				view: {},
				customView: {}
            }
        };
		$scope.vc.container = true;
		
    	
		var queryString = {};
		
		$scope.getQueryStrings = function() {
            var queryDict = {};
            location.search.substr(1).split("&").forEach(function(item) {
                queryDict[item.split("=")[0]] = item.split("=")[1];
            });
            return queryDict;
        }
	
	    queryString = $scope.getQueryStrings();
		
		$scope.number_format =function (amount, decimals) {
            amount += ''; // por si pasan un numero en vez de un string
            amount = parseFloat(amount.replace(/[^0-9\.]/g, '')); // elimino cualquier cosa que no sea numero o punto
            
            decimals = decimals || 0; // por si la variable no fue fue pasada
            
            // si no es un numero o es igual a cero retorno el mismo cero
            if (isNaN(amount) || amount === 0) 
                return parseFloat(0).toFixed(decimals);
            
            // si es mayor o menor que cero retorno el valor formateado como numero
            amount = '' + amount.toFixed(decimals);
            
            var amount_parts = amount.split('.'),
                regexp = /(\d+)(\d{3})/;
            
            while (regexp.test(amount_parts[0]))
                amount_parts[0] = amount_parts[0].replace(regexp, '$1' + ',' + '$2');
            
            return amount_parts.join('.');
        }
		
    	$scope.vc.addTaskHeader = function(taskHeader, title, value, rowNumber) {
			
			rowNumber = rowNumber === undefined ? 0 : rowNumber;
		
			if (title != null && value != null) {
			
				if (title == "title") {
					taskHeader.title = value;//--LATFO.COMMONS.getCapitalizeCase(value);
				} else if (title == "statement"){
				    taskHeader.statement = value
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
		};
		
		$scope.vc.updateTaskHeader = function(taskHeader, taskPopover) {
			$scope.vc.removeChildVc('collateralHeader');
			

			var api = new dsgnrCommons.API($scope.vc);
			var nav = api.navigation;	 
				
			nav.customAddress = {
				id : 'collateralHeader',
				url : 'collateral/templates/collateral-header.html',
				useMinification: false
			};

			nav.scripts = [ {
				module : "collateral",
				files : [ 'collateral/controllers/collateral-header-ctrl.js']
			} ];
			
			if ($scope.vc.currentRow == null)
			{
			
				nav.customDialogParameters = {
					taskHeader : taskHeader,
					taskPopover : taskPopover,
                    mode: $scope.mode,
                    externalCode : 	$scope.externalCode,
                    custody : $scope.custody,
                    custodyType : $scope.custodyType,
					warranty : $scope.warranty			
				};
			}
			else
			{
				nav.customDialogParameters = {
					taskHeader : taskHeader,
					taskPopover : taskPopover,
					currentRow : $scope.vc.currentRow,
					mode: $scope.mode,
					externalCode: $scope.externalCode,
					custody : $scope.custody,
                    custodyType : $scope.custodyType,
					warranty : $scope.warranty,
					menu: true
				};
			}

		
			nav.registerCustomView("header");
		};
		
		$scope.vc.setContainerView = function(idCollateral){
			
			var result = collateralServices.searchCollateral(idCollateral);
            result.then(function (data) {
				var data =data;
				var currencyDesc = data.data.returnCollateralResponse[0].currencyDesc;	
                var actualValue = $scope.formatMoneyValue($scope.number_format(data.data.returnCollateralResponse[0].actualValue, 2));
				$scope.taskPopover = [];
								
				var taskHeader = {};
			    $scope.vc.addTaskHeader(taskHeader, 'statement', "#"+data.data.returnCollateralResponse[0].externalCode);
                $scope.vc.addTaskHeader(taskHeader, 'title', data.data.returnCollateralResponse[0].description + " - "+ actualValue + currencyDesc);
                $scope.vc.addTaskHeader(taskHeader, 'Clase', data.data.returnCollateralResponse[0].openClosed, 0);
                $scope.vc.addTaskHeader(taskHeader, 'Estado', data.data.returnCollateralResponse[0].state, 0);
                $scope.vc.addTaskHeader(taskHeader, 'Oficina', data.data.returnCollateralResponse[0].accountOfficeDesc, 0);
                $scope.vc.addTaskHeader(taskHeader, 'Ubicaci\u00f3n', data.data.returnCollateralResponse[0].location, 0);
				
				$scope.warranty = data.data.returnCollateralResponse[0];
				$scope.custody = data.data.returnCollateralResponse[0].custody;
				$scope.custodyType = data.data.returnCollateralResponse[0].type;
				$scope.externalCode = data.data.returnCollateralResponse[0].externalCode;
				
				$scope.taskPopover.push({title: "Categor\u00eda", value : data.data.returnCollateralResponse[0].type});
				$scope.taskPopover.push({title: "Fecha Ingreso", value : data.data.returnCollateralResponse[0].entryDate});
				$scope.taskPopover.push({title: "Fecha Vencimiento", value : data.data.returnCollateralResponse[0].expirationDate});
				$scope.taskPopover.push({title: "Fecha \u00daltimo Aval\u00fao", value : data.data.returnCollateralResponse[0].valuationDate});
				$scope.taskPopover.push({title: "Valor Inicial", value : $scope.formatMoneyValue(data.data.returnCollateralResponse[0].initialValue, currencyDesc)});
				$scope.taskPopover.push({title: "Valor Comercial", value : $scope.formatMoneyValue(data.data.returnCollateralResponse[0].commercialValue, currencyDesc)});
				$scope.taskPopover.push({title: "Valor Utilizado", value : $scope.formatMoneyValue(data.data.returnCollateralResponse[0].usedValue, currencyDesc)});
				$scope.taskPopover.push({title: "Valor Disponible", value : $scope.formatMoneyValue(data.data.returnCollateralResponse[0].available, currencyDesc)});
				$scope.taskPopover.push({title: "Calidad", value : data.data.returnCollateralResponse[0].qualityDesc == null? '': data.data.returnCollateralResponse[0].qualityDesc});
				
				if ($scope.mode == 2 && data.data.returnCollateralResponse[0].statusId != 'C'){
					$scope.allowChangeVal = true;
				}else {
				    $scope.allowChangeVal = false;
				}
				
			    $scope.vc.updateTaskHeader (taskHeader, $scope.taskPopover);
				
            }).catch(function (data) {
            	$scope.execButtonPolicy = false;
            	cobis.showMessageWindow.loading(false);
            });			
		}
		
		
		
		$scope.vc.showContent = function(){
			var api = new dsgnrCommons.API($scope.vc);
			var nav = api.navigation;	
			if (queryString.type =="D")
			{
			    nav.address = {
			    	moduleId: queryString.mod,
			    	subModuleId: queryString.sub,
			    	taskId: queryString.task,
			    	taskVersion: queryString.ver,
			    	viewContainerId: queryString.view,
			    	useMinification: false
			    };
			   
			    nav.customDialogParameters = {
			    	currentRow : $scope.vc.currentRow,
					loadSearchCollateral: true,
					mode: queryString.option,
					menu: true
			    };
								
				$scope.mode = queryString.option;
				nav.registerView('content');
			}else if (queryString.type=="M")
			{
				nav.customAddress = {
				id : queryString.id,
				url : queryString.mod+'/'+queryString.pag+'.html',
				useMinification: false
			    };

				var files = []
				
				queryString.ctr.split(';').forEach(function(item) {
                    files.push(queryString.mod+"/controllers/"+item+".js");
                });
				
				queryString.srv.split(';').forEach(function(item) {
                    files.push(queryString.mod+"/services/"+item+".js");
                });
				
			    nav.scripts = [ {
			    	module : queryString.mod,
			    	files : files,
			    } ];
			
			    if ($scope.vc.currentRow != null)
			    {
			    	nav.customDialogParameters = {
			    		currentRow : $scope.vc.currentRow
			    	};
			    }
				nav.registerCustomView('content');
			}
			
			if ($scope.mode == 1 || $scope.mode ==2){
			    $scope.showOptions = true;
			    if ($scope.mode == 2){
			        $scope.allowLiberation = true;
					$scope.allowChangeVal = true;
			    }
			}
			
			
			
        };
		$scope.formatMoneyValue = function(value, currencyDesc){
			if(angular.isUndefined(currencyDesc) || currencyDesc == null){
				currencyDesc = "";
			}
			if(angular.isUndefined(value) || value == null){
				value = 0.00;
			}
			return "$"+ $scope.number_format(value, 2) + " " + currencyDesc;
		};
		$scope.vc.updateTaskHeader();
		$scope.vc.showContent();
		$scope.orientation = "vertical";
		
   }]);
    window.cobisMainModule = app;

}());