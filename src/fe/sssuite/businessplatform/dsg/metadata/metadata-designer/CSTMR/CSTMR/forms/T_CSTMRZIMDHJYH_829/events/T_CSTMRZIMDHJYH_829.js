//"TaskId": "T_CSTMRZIMDHJYH_829"
task.validateOnlyLettersAndSpaces = function (text) {
    var expreg = new RegExp("^[a-zA-ZÑñáéíóúÁÉÍÓÚ ]{1,20}$");
    if (expreg.test(text)) {
        return true;
    }
    return false;
};