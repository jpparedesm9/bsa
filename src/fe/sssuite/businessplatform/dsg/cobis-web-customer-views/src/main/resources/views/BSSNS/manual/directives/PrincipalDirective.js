(function (angular,cobis) {
    'use strict';
    var app = cobis.createModule('customer',[cobis.modules.CONTAINER]);
    app.directive('generateElements', ["$compile", "$templateRequest", "$parse", function ($compile, $templateRequest, $parse) {
        //Tipos de controles
        /*
          M : moneda
          C : combo
          T : tabla
          F : fecha
          N : numeros
        */
        return {
          restrict: 'AE',
          require: '?ngModel',
          link: function (scope, element, attr) {
            var finalTemlate = "";
            var elementAux = "";
            var dataSource = "";
            var section = attr.id.split("-");
            var actualSection = scope.$index;
            //Barrido de data
            var sections = scope.$root.result.section;
			
			if(angular.isDefined(sections[actualSection])){    
				for (var j = 0; j < sections[actualSection].questions.length; j++) {
				  var disable='';
				  if(sections[actualSection].enabled==='N'){
					  disable='ng-disabled="true"'
				  }
				  
				  var initElement = '<div id="q' + sections[actualSection].questions[j].idQuestion + '" class="col-xs-6 cb-control"> ' +
					'<h6>' +
					'<label id="lbl-q' + sections[actualSection].questions[j].idQuestion + '" class="control-label">' + sections[actualSection].questions[j].label + '</label>' +
					'</h6>';
				  var finalElement = '</div>';
						var req='';
						if(sections[actualSection].questions[j].required=='S'){
							req='required data-validation-code="32" data-required-msg="'+cobis.translate("BSSNS.MSG_BSSNS_CAMPOREDR_21366")+'"';
						}	
		
				  switch (sections[actualSection].questions[j].type) {
					case 'C':
								elementAux = '<input id="vaS' + sections[actualSection].idSection + 'Q' + sections[actualSection].questions[j].idQuestion + '" class="non-readonly" kendo-drop-down-list placeholder="Seleccione" ng-model="s' + sections[actualSection].idSection + 'q' + sections[actualSection].questions[j].idQuestion + '" k-options="getComboDataSource(' + actualSection + ',' + j + ')" k-auto-bind="true" '+req+' '+ disable+' />';
					  finalTemlate += initElement + elementAux + finalElement;
					  break;
					case 'N':
					  elementAux = '<input id="vaS' + sections[actualSection].idSection + 'Q' + sections[actualSection].questions[j].idQuestion + '" kendo-numeric-text-box style="border: #f5f5f5 1px solid" ng-model="s' + sections[actualSection].idSection + 'q' + sections[actualSection].questions[j].idQuestion + '"  k-format="\'n\'" k-decimals="0" k-min="0" k-max="9999999999" '+req+'/>';
					  finalTemlate += initElement + elementAux + finalElement;
					  break;
					case 'F':
					  elementAux = '<input id="vaS' + sections[actualSection].idSection + 'Q' + sections[actualSection].questions[j].idQuestion + '" kendo-ext-date-picker ng-model="s' + sections[actualSection].idSection + 'q' + sections[actualSection].questions[j].idQuestion + '" placeholder="' + scope.datePlaceHolder + '" date-input=true date-format="' + scope.dateFormat + '"/>';
					  finalTemlate += initElement + elementAux + finalElement;
					  break;
					case 'M':
								elementAux = '<input id="vaS' + sections[actualSection].idSection + 'Q' + sections[actualSection].questions[j].idQuestion + '" kendo-numeric-text-box style="border: #f5f5f5 1px solid" ng-model="s' + sections[actualSection].idSection + 'q' + sections[actualSection].questions[j].idQuestion + '" k-format="\'c2\'" k-decimals="3" k-min="0" k-max="9999999999" '+req+ ' ' +disable+' />';
					  finalTemlate += initElement + elementAux + finalElement;
					  break;
					case 'T':
								scope.$root.gridNumbers ++;
					  initElement =  '<div id="q' + sections[actualSection].questions[j].idQuestion + '" class="cb-group cb-group-simple"> ' ;
								elementAux = '<div id="vaS' + sections[actualSection].idSection + 'Q' + sections[actualSection].questions[j].idQuestion + '" kendo-grid k-options="createGrid(' + actualSection + ',' + j + ',\''+sections[actualSection].enabled+'\')" k-pageable="10" k-resizable="false" k-reorderable="true" k-scrollable="true" k-edit="$scope.gridEvents.edit" k-auto-bind="true" k-cancel="$scope.gridEvents.cancel"></div>';
					  finalTemlate += initElement + elementAux + finalElement;
					  break;
		
				  }
		
				}
			}
                var templateAux = '${contextPath}/cobis/web/views/BSSNS/CSTMR/T_BSSNSKNPPLXIB_479/1.0.0/VC_GENERALBSI_401479_TASK.html';
            $templateRequest(templateAux).then(function (html) {
              var linkFn = $compile(finalTemlate)(scope);
              element.append(linkFn);
                });
    
          }
        }
    
      }]);
    
}(window.angular,window.cobis));
