task.gridInitColumnTemplate.QV_DTPEA0472_42 = function (idColumn) {
         if(idColumn === 'bankclient'){
			var template ="<span ng-class=\'vc.viewState.QV_DTPEA0472_42.column.VA_VOSOLDTENI3504_CTDT512.imageId\' class=\'glyphicon glyphicon-ok\' id=\'VA_CHECK01_#=Operation#\'>&nbsp;</span>";
			template = template +"<span  data-bind=\'text:DescriptionClient\'>#=bankclient#</span>";			
			return template;
        } if(idColumn === 'Recommended'){
			var template = "#if (Status === 'R') {# ";
			template = template + "<input type=\'checkbox\' name=\'Recommended\' id=\'VA_VOSOLDTENI3504_REOE379_#=Operation#\' #if (Recommended === true) {# checked #}# ";
			template = template + " ng-click=\"vc.grids.QV_DTPEA0472_42.events.customRowClick($event, \'VA_VOSOLDTENI3504_REOE379\', \'Punishment\', 'QV_DTPEA0472_42')\"/>";
			template = template +"#}#";			
			template = template +"<a name=\'btnObservation\' id=\'VA_VOSOLDTENI3504_CTDT512_#=Operation#\' class=\'btn btn-default cb-row-image-button\'";
			template = template + " ng-click=\"vc.grids.QV_DTPEA0472_42.events.customRowClick($event, \'VA_VOSOLDTENI3504_CTDT512\', \'Punishment\', 'QV_DTPEA0472_42')\"";
			template = template + " style=\'display: none; margin-left: 10px; height: 25px; width: 25px; padding: 0px; font-size: 20px;\'>";
			template = template + "<span >...</span>"
			template = template +"</a>";
			return template;
		}
    };