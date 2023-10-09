(function (window) {
    'use strict';

    var app = cobis.createModule('ChartGeneralInfo', ['oc.lazyLoad', cobis.modules.CONTAINER, 'ui.bootstrap', 'designerModule', 'ngResource', 'ngCookies']);
    app.config(function ($controllerProvider, $compileProvider, $routeProvider, $filterProvider) {
        app.controllerProvider = $controllerProvider;
        app.compileProvider = $compileProvider;
        app.routerProvider = $routeProvider;
        app.filterProvider = $filterProvider;
    });

    app.controller('LeftChartCtrl', ['$scope', '$rootScope', '$filter', '$modal', '$routeParams', '$timeout', '$location', 'designer', '$translate', 'dsgnrCommons', "cobisMessage",

        function ($scope, $rootScope, $filter, $modal, $routeParams, $timeout, $location, designer, $translate, dsgnrCommons, cobisMessage) {
            $scope.chartModel = $scope.vc.model;

            var consolidatedLoan = $scope.chartModel.ConsolidatedLoanStatus;
            var categories = [];
            var data = [];
            var series = [];
			var capital=[];
			var interest=[];
			var others=[];
			var total=[];
			var items=['CAP', 'INT', 'OTROS', 'TOTAL'];
			var item="CAP";
			var capitalTotal=0;
			var interesTotal=0;
			var othersTotal=0;
			var valorTotal=0;
			var i=0;

           
			angular.forEach(consolidatedLoan, function (consolidated) {
				if (consolidated.amortizationStatus != undefined && consolidated.amortizationStatus != null) {
                        i+=1;
					   capital[i]=consolidated.capital;
					   interest[i]=consolidated.interest;
					   others[i]=consolidated.otherItems;
					   total[i]=consolidated.total;
					   
					   capitalTotal+=consolidated.capital;
					   interesTotal+=consolidated.interest;
					   othersTotal+=consolidated.otherItems;
					   valorTotal+=consolidated.total;
                }
            });
			
			angular.forEach(items, function (item) {
                	var tmp_valor =0;
					var tmp_vencido=0;
					var tmp_por_vencer=0;
					var tmp_descripcion="";
					
					switch(item) {
                    case 'CAP':
                          tmp_valor     = Math.round(capitalTotal*100)/100;
						  tmp_vencido   = capital[1];
						  tmp_por_vencer= capital[2];
						  tmp_descripcion=$filter('translate')('ASSTS.LBL_ASSTS_CAPITALBZ_88457').toUpperCase();
                          break;
                    case 'INT':
					      tmp_valor= Math.round(interesTotal*100)/100;
						  tmp_vencido   = interest[1];
						  tmp_por_vencer= interest[2];
						  tmp_descripcion=$filter('translate')('ASSTS.LBL_ASSTS_INTERESWJ_80123').toUpperCase();						  
                          break;
                    case 'OTROS':
                         tmp_valor= Math.round(othersTotal*100)/100;
						 tmp_vencido   = others[1]; 
						 tmp_por_vencer= others[2];
						 tmp_descripcion=$filter('translate')('ASSTS.LBL_ASSTS_OTROSRYRP_40547').toUpperCase();						  
						break;
				    case 'TOTAL':
					     tmp_valor=Math.round(valorTotal*100)/100;
						 tmp_vencido   = total[1]; 
						 tmp_por_vencer= total[2];
						 tmp_descripcion=$filter('translate')('ASSTS.LBL_ASSTS_TOTALSTVG_12909').toUpperCase();						  
                    }
					
					categories.push(((tmp_descripcion)+ '\n (' + tmp_valor + ')'));
					data.push({
                        'VENCIDO': tmp_vencido == 0 ? null : tmp_vencido,
                        'POR_VENCER': tmp_por_vencer == 0 ? null : tmp_por_vencer,                        
                    }); 					
            });
			

            var vencidoSerieLabel = $filter('translate')('ASSTS.LBL_ASSTS_VENCIDOUG_82584').toUpperCase();
            var validSerieLabel = $filter('translate')('ASSTS.LBL_ASSTS_PORVENCER_21871').toUpperCase();
            
            series.push({ field: 'VENCIDO', name: vencidoSerieLabel, color: "#ff6800", zIndex: 0 });
            series.push({ field: 'POR_VENCER', name: validSerieLabel, color: "#a0a700", zIndex: 1 });
            	
            $("#chartLeft").kendoChart({
                title: {
                    text: $filter('translate')('ASSTS.LBL_ASSTS_ESTADOPST_41961')
                },
                dataSource: {
                    data: data
                },
                legend: {
                    position: "bottom"
                },
                seriesDefaults: {
                    stack: true,
                    type: "column",
                    labels: {
                        position: "center",
                        visible: true,
                        format: $scope.currencySymbol + "{0:n2}",
                        background: "transparent"
                    },
                    spacing: 0,
                    gap: 0.90,
                },
                chartArea: {
                    background: "#FFFFFF",
                    margin: 10,
                    padding: 10
                },
                series: series,
                categoryAxis: {
                    categories: categories
                },
                valueAxis: {
                    name: "DINERO",
                    labels: {
                        format: $scope.currencySymbol + "{0}"
                    }
                },
                tooltip: {
                    position: "center",
                    visible: true,
                    template: "#= series.name #: " + $scope.currencySymbol + "#= kendo.toString(value,'n2') #"
                },
                template: "#= series.name #: " + $scope.currencySymbol + "#= kendo.toString(value,'n2') #"
            });

        }]);
}(window));