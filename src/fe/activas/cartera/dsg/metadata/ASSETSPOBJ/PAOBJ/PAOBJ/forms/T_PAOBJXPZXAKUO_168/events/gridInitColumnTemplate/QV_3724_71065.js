task.gridInitColumnTemplate.QV_3724_71065 = function (idColumn, gridInitColumnTemplateEventArgs) {
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
        //debugger;
        if (idColumn === 'seleccionar') {
            //return "<input type=\'checkbox\' name=\'seleccionar\' id=\'VA_CHECKBOXSAGRGOQ_593505' #if (seleccionar === true) {# checked #}# />";
            
            return "<input type=\'checkbox\' name=\'seleccionar\' id=\'VA_CHECKBOXSAGRGOQ_593505' #if (seleccionar === true) {# checked #}# ng-click=\"vc.grids.QV_3724_71065.events.customRowClick($event, \'VA_CHECKBOXSAGRGOQ_593505\',\'ResultadoPagosObjetados\', \'QV_3724_71065\')\"/>";
        }
    };