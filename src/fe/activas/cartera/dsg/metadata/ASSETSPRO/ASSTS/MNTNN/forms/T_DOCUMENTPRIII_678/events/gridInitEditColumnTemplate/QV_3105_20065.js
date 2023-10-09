task.gridInitEditColumnTemplate.QV_3105_20065 = function (idColumn) {
    if (idColumn === 'item') {
        return "<span><input type=\'checkbox\' #if (item === true) {# checked #}# ng-click=\"vc.grids.QV_3105_20065.events.customRowClick($event, \'VA_VDATOSALUD3211_SEOA837\', \'PrintingDocuments\', \'QV_3105_20065\')\"/></span>";
    }
};