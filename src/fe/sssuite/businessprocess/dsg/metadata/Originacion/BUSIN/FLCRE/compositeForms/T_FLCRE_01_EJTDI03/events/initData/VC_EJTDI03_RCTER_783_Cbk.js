//Start signature to callBack event to VC_EJTDI03_RCTER_783
    task.initDataCallback.VC_EJTDI03_RCTER_783 = function(entities, initDataEventArgs) {
        //here your code
        initDataEventArgs.commons.execServer = false;   		
   	    task.loadTaskHeader(entities,initDataEventArgs);            
    };