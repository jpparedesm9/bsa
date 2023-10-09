task.gridInitColumnTemplate.QV_BOREG0798_55 = function (idColumn, gridInitColumnTemplateEventArgs) { // QueryView:
																   // Borrowers
        if(idColumn === 'DateCIC'){
			return FLCRE.UTILS.CUSTOMER.getTemplateForDateCIC();
		}
    
        if(idColumn === 'creditBureau'){
          return  "<div class='cb-indicator cb-flex cb-column'>"+
                        "<div ng-switch on='dataItem.riskLevel'>"+
                            "<div ng-switch-when='VERDE' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-good'></div>"+ 
                            "<div ng-switch-when='AMARILLO' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-fair'></div>"+
                            "<div ng-switch-when='ROJO' class='cb-flex cb-grow cb-center cb-middle cb-indicator-value cb-rule-alert-bad'></div>"+
                            "<div ng-switch-default class='text-center'>Error</div>"+
						"</div>"+  
                    "</div>";
        }
    
};