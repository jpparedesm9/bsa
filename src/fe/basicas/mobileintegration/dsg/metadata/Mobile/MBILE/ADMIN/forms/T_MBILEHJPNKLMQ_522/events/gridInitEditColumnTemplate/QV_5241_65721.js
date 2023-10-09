task.gridInitEditColumnTemplate.QV_5241_65721 = function (idColumn, gridInitColumnTemplateEventArgs) {
    
         if(idColumn === 'mac'){
          return  "<div>"+
                       "<input style='text-transform:lowercase' data-bind='value:mac'/>"+                        
                    "</div>";
        }
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "<span data-bind='text:nombreColumna'><span>" ;
        //}
    };