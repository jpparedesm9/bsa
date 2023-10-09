task.gridInitColumnTemplate.QV_9498_38003 = function (idColumn, gridInitColumnTemplateEventArgs) {
        if(idColumn === 'isSelected'){
            return "<input type=\'checkbox\' #if (isSelected) {# checked #}# ng-click=\"vc.grids.QV_9498_38003.events.customRowClick($event, \'VA_GRIDROWCOMMMAND_129547\', \'ConciliationManualSearch\', \'QV_9498_38003\')\"/>";
        }
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
    };