var portfolioClassAux = "";
    var mode;
    var closeModal = false;
//"TaskId": "T_RATESMODALKUB_953"

task.calculateTotal = function (indicator, rate, eventArgs) {
        //indicator especifica campos a calcular
        
        if (rate.valueDeafult == null) 
            rate.valueDeafult = 0;
        if (rate.valueMin == null)
            rate.valueMin = 0;
        if (rate.valueMax == null) 
            rate.valueMax = 0;
        if (rate.lockedDefault == null) 
            rate.lockedDefault = 0;
        if (rate.lockedMin == null) 
            rate.lockedMin = 0;
        if (rate.lockedMax == null) 
            rate.lockedMax = 0;
        if (rate.value == null) 
            rate.value = 0;
        
        if (indicator == 0 || indicator == 1) {
            switch (rate.signDefault)  {
                case "+":
                    rate.lockedDefault = rate.value + rate.valueDeafult;
                    break;
                case "-":
                    rate.lockedDefault = rate.value - rate.valueDeafult;
                    break;
                case "*" :
                    rate.lockedDefault = rate.value * rate.valueDeafult;
                    break;
                case "/":
                    rate.lockedDefault = rate.value / rate.valueDeafult;
                    break;
            }
        }
    
        if (indicator == 0 || indicator == 2) {
            switch (rate.signMin) {
                case "+":
                    rate.lockedMin = rate.value  + rate.valueMin;
                    break;
                case "-":
                    if (rate.value - rate.valueMin < rate.lockedDefault) {
                       eventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_PUNTOSNAT_99220",true);
                       rate.valueMin = 0;
                       rate.valueMin = rate.lockedDefault;
                    } else {
                       rate.lockedMin = rate.value - rate.valueMin;
                    }
                    break;
                case "*":
                    rate.lockedMin = rate.value  * rate.valueMin;
                    break;
                case "/":
                    rate.lockedMin = rate.value  / rate.valueMin;
                    break;
            }
        }

        if (indicator == 0 || indicator == 3) {
            switch (rate.signMax) {
                case "+":
                    rate.lockedMax = rate.value + rate.valueMax;
                    break;
                case "-":
                    if (rate.value - rate.valueMax  < rate.lockedDefault) {
                       eventArgs.commons.messageHandler.showMessagesError("ASSTS.MSG_ASSTS_PUNTOSNAT_99220",true);
                       rate.valueMax = 0;
                       rate.lockedMax = rate.lockedDefault;
                    } else {
                       rate.lockedMax= rate.value - rate.valueMax;
                    }
                    break;
                case "*":
                    rate.lockedMax = rate.value * rate.valueMax;
                    break;
                case "/":
                    rate.lockedMax = rate.value / rate.valueMax;
                    break;
            }
        }
    }