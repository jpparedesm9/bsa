//"TaskId": "T_REFERENCESPPP_957"

task.findValueInCatalog=function(code,data){
    if(code==null){
        return null;
    }else{
        code=code.toString();
    }
    for(var i=0;i<data.length;i++){
        if(data[i].code == code){
            return data[i].value;
        }		
    }
    return null;
};
