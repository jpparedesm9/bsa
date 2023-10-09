//"TaskId": "T_CSTMRKOYOOADV_774"
var taskHeader = {};
var nombreCompleto = '';
var nombre2 = '';
var apellido2 ='';
var nombreGrupo = '';
var idGrupo = '';
var perteneceGroup = 'N';

task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
    args.model.NaturalPerson.personSecuential = resp.CodeReceive;
	args.commons.api.vc.executeCommand('VA_VABUTTONBISUTWO_919882', 'FindCustomer', undefined, true, false, 'VC_MODIFICAIC_908774', false);
};