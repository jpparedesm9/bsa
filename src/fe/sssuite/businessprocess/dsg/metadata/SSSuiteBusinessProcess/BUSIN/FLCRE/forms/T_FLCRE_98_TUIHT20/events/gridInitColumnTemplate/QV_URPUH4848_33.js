task.gridInitColumnTemplate.QV_URPUH4848_33 = function (idColumn) {
         if(idColumn === 'selection'){
var template = "<input type=\'checkbox\' name=\'selection\' id=\'VA_CHECKBOXSNOAAAG_461_05#=Operation#\' ";				
			template = template +"#if (selection === true) {#checked #}#";//verificar si el campo esta siendo mapeado en la grilla
			template = template + " ng-click=\"vc.grids.QV_URPUH4848_33.events.customRowClick($event, \'VA_CHECKBOXSNOAAAG_461_05\', \'Punishment\', 'QV_URPUH4848_33')\"/>";
			return template;
         } 
    };