task.gridInitColumnTemplate.QV_QDMNT8051_16 = function (idColumn) {
    if (idColumn === 'YesNot') {
        return "<input type=\'checkbox\' name=\'YesNot\' id=\'VA_DOCUNODCVW7303_YSNO533\' #if (YesNot === true) {# checked #}# ng-click=\"vc.grids.QV_QDMNT8051_16.events.customRowClick($event, \'VA_DOCUNODCVW7303_YSNO533\', \'DocumentProduct\', \'QV_QDMNT8051_16\')\"/>";
    }
};