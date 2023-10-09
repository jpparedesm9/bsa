task.gridInitColumnTemplate.QV_UERXC4756_18 = function (idColumn) {
        if (idColumn === 'Aproved') {
            //return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', grids.QV_UERXC4756_18)\" />";
            return "<input type=\'checkbox\' name=\'Aproved\' id=\'VA_OVECRDTRQE4824_EULT673\' #if (Aproved === true) {# checked #}# ng-click=\"vc.grids.QV_UERXC4756_18.events.customRowClick($event, \'VA_OVECRDTRQE4824_EULT673\', \'Exceptions\', \'QV_UERXC4756_18\')\" />";

        }
    };