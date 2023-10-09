task.gridInitColumnTemplate.QV_6806_82610 = function (idColumn, gridInitColumnTemplateEventArgs) {
       if (idColumn === 'withoutFingerprint') {
            return "<span>#if(withoutFingerprintValue == 'S'){# <input type=\'checkbox\' disabled checked ng-model=\"dataItem.withoutFingerprint\" ng-click=\"vc.grids.QV_ITRIC1523_63.events.customRowClick($event, \'VA_TEXTINPUTBOXUSB_323559\', \'ValidationMemberQuery\', 'QV_6146_83140')\"/>#}#</span>";
        }
    
};