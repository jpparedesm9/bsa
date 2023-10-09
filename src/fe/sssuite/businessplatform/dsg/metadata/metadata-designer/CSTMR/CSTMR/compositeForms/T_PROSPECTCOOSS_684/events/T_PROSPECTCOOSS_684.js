//"TaskId": "T_PROSPECTCOOSS_684"
var showHeader = true;
var section = null;
var casado = null;
var unionLibre = null;
var edadMin = 0;
var edadMax = 0;
var today ='';

var dirResidencia=null;
var dirNegocio=null;
var cargaInicial = false;
var activeChange = false;
var screenMode = null;
var activeChangeIniDocs = false; //caso153311
var typeRequest = ''; //caso#162288
var mode = ''; //caso#162288
var channel = 4; // tabla cl_canal caso203112

//Limpiar Persona Natural
task.clearNaturalPerson = function (entities) {
    entities.NaturalPerson.personSecuential = '';
    entities.NaturalPerson.firstName = '';
    entities.NaturalPerson.secondName = '';
    entities.NaturalPerson.surname = '';
    entities.NaturalPerson.secondSurname = '';
    entities.NaturalPerson.marriedSurname = '';
    entities.NaturalPerson.email = '';
};
//Limpiar Persona Juridica
task.clearLegalPerson = function (entities) {
    entities.LegalPerson.personSecuential = '';
    entities.LegalPerson.emailAddress = '';
    entities.LegalPerson.businessName = '';
    entities.LegalPerson.tradename = '';
};
//Limpiar Persona Conyuge
task.clearSpousePerson = function (entities) {
    entities.SpousePerson.personSecuential = '';
    entities.SpousePerson.firstName = '';
    entities.SpousePerson.secondName = '';
    entities.SpousePerson.surname = '';
    entities.SpousePerson.secondSurname = '';
};
task.showHideSpouceInformation = function (entities, args) {
    if (entities.NaturalPerson.maritalStatusCode == entities.Context.married) {
        if (entities.NaturalPerson.genderCode == "F") {
            args.commons.api.viewState.show('VA_TEXTINPUTBOXECU_912739');
        }
        else {
            args.commons.api.viewState.hide('VA_TEXTINPUTBOXECU_912739');
        }
        args.commons.api.viewState.show('G_GENERALEAO_954739');
        args.commons.api.viewState.enable('VA_GENDERCODEVBBDG_772739');
    }
    else {
        args.commons.api.viewState.hide('VA_TEXTINPUTBOXECU_912739');
        args.commons.api.viewState.hide('G_GENERALEAO_954739');
    }
};
task.disableFields = function (args, controls, disable) {
    if (disable){
        for (var i = 0; i < controls.length; i++) {
            args.commons.api.viewState.disable(controls[i], disable);
        }
    }else{
        for (var i = 0; i < controls.length; i++) {
            args.commons.api.viewState.enable(controls[i]);
        }
    }
};

task.validateOnlyLettersAndSpaces = function (text, type, stringLength) {
    //Las vocales y letras se encuentran en unicode
    if(type === 0){ //0 es sin punto
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA ]{1,"+stringLength +"}$");
    }else if(type === 1){ //1 es con punto
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA.]{1,"+stringLength +"}$");
    }else if(type === 3){ //3 es con punto y espacio cs: 150907
        var expreg = new RegExp("^[a-zA-Z\u00D1\u00F1\u00E1\u00E9\u00ED\u00F3\u00FA\u00C1\u00C9\u00CD\u00D3\u00DA. ]{1,"+stringLength +"}$");
    }
    
    if (expreg.test(text)) {
            return true;
    }
    return false;
};


task.FechaNacimiento = function (fecha, edadMin, edadMax) {
    var birthday = new Date(fecha);    
    var years = today.getFullYear() - birthday.getFullYear();
    birthday.setFullYear(today.getFullYear());
    //if (today < birthday)
    if (today < birthday) {
        years--;
    }
    if (fecha == null) {
        return false;
    }
    if ((years < edadMin) || (years > edadMax)) {
        return false;
    }
    else {
        return true;
    }
};
task.ValidaVencimiento = function (fecha) {
    //var today = new Date();
    if (fecha.getTime() <= today.getTime()) {
        return false;
    }
    return true;
}