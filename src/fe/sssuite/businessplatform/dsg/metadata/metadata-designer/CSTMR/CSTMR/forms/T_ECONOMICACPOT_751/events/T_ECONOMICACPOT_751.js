//"TaskId": "T_ECONOMICACPOT_751"
var msgIDResourse = "";
task.calculateAntiquity = function (economicActivity) {
    var startDate = economicActivity.startdateActivity;
    var today = new Date();
    var antiquity = 0;
    
    if (startDate != null) {
        var d1Y = startDate.getFullYear();
        var d2Y = today.getFullYear();
        var d1M = startDate.getMonth();
        var d2M = today.getMonth();

        antiquity = (d2M+12*d2Y)-(d1M+12*d1Y);
    }

    economicActivity.antiquity = antiquity;
}

task.validateEconomicActivityData = function (EconomicActivity) {
    msgIDResourse = '';
    
    if (EconomicActivity.economicSector == null || EconomicActivity.economicSector == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOLG_31964'; 
        return false;
    }
    if (EconomicActivity.subSector == null || EconomicActivity.subSector == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOTL_36929'; 
        return false;
    }
    if (EconomicActivity.economicActivity == null || EconomicActivity.economicActivity == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOMO_47217'; 
        return false;
    }
    if (EconomicActivity.description == null || EconomicActivity.description == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPODG_19434'; 
        return false;
    }
    if (EconomicActivity.principal == null || EconomicActivity.principal == '') {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPOLO_76706'; 
        return false;
    }
    if (EconomicActivity.startdateActivity == null || EconomicActivity.startdateActivity == '') {
        EconomicActivity.startdateActivity = '';
    } else {
        var today = new Date();
        if (EconomicActivity.startdateActivity > today) {
            EconomicActivity.startdateActivity = today;
        }
    }
    if (EconomicActivity.environment == null || EconomicActivity.environment == '') {
        EconomicActivity.environment = '';
    }
    if (EconomicActivity.propertyType == null || EconomicActivity.propertyType == '') {
        EconomicActivity.propertyType = '';
    }
    if (EconomicActivity.numberEmployees == null) {
        msgIDResourse = 'CSTMR.MSG_CSTMR_ELCAMPODG_30371'; 
        return false;
    } else {
        if (EconomicActivity.numberEmployees < 0) {
            msgIDResourse = 'CSTMR.MSG_CSTMR_ELNMEROAD_90901'; 
            return false;
        }
    }
    if (EconomicActivity.antiquity == null) {
        EconomicActivity.antiquity = 0;
    }
    if (EconomicActivity.affiliate == null || EconomicActivity.affiliate == '') {
        EconomicActivity.affiliate = '';
    } else {
        if (EconomicActivity.affiliate == 'S' && (EconomicActivity.placeAffiliation == null || EconomicActivity.placeAffiliation == '')) {
            EconomicActivity.placeAffiliation = '';
            EconomicActivity.affiliate = 'S';
        }
    }
    return true;
}