task.gridInitColumnTemplate.QV_9498_31225 = function (idColumn) {
        if(idColumn === 'isSelected'){
            return "<input type=\'checkbox\' #if (isSelected) {# checked #}# ng-click=\"vc.grids.QV_9498_31225.events.customRowClick($event, \'VA_GRIDROWCOMMMNDA_868547\', \'ConciliationManualSearch\', \'QV_9498_31225\')\"/>";
        }
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
    };