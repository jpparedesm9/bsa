task.gridInitColumnTemplate.QV_5241_65721 = function (idColumn, gridInitColumnTemplateEventArgs) {
   
        if(idColumn === 'mac'){    
          return  "<div>"+
                       "{{dataItem.mac.toLowerCase()}}"+ 
                        "<a href='/CTSProxy/services/resources/cobis-cloud/device/licence/manager/{{dataItem.mac.toLowerCase()}}' style='float:right;'>"+
                        "<span class='fa fa-download' aria-hidden='true'></span><a>"+
                    "</div>";
        }
    
        //if(idColumn === 'NombreColumna'){
        //  return "<span></span>";
        //}
        //if(idColumn === 'NombreColumna'){
        //  return  "#=nombreColumna#" ;
        //}
    
};