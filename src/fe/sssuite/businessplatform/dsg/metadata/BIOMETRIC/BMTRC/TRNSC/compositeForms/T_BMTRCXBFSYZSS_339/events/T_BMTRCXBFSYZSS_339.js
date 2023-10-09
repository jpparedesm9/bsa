//"TaskId": "T_BMTRCXBFSYZSS_339"
task.validateResult = function(entities){
    var customerList = entities.Customer;
        var aproved = 0;
        var rejected = 0;
     
        for(var i=0; i< customerList.length;i++){
            switch(customerList[i].validationStatus){
                case 'APROBADO': 
                    aproved++;
                    break
                case 'RECHAZADO':
                    rejected++;
                    break;
                case 'LIMITADO':
                    aproved++;
            }            
        }
        if(rejected >0){
             entities.ValidationData.resultValidation='RECHAZADO'
         }else{
			 if(aproved ==customerList.length){
				 entities.ValidationData.resultValidation='APROBADO'
			 }else{
				 entities.ValidationData.resultValidation='PENDIENTE'
			 }
		 }
}