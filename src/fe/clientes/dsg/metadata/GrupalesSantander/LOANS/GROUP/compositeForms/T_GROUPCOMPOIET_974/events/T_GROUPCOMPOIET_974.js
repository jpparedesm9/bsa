//"TaskId": "T_GROUPCOMPOIET_974"
var showHeader = true;
var taskHeader = {};
var type = '';
var stage = '';
var titular=0;
var typeConsulta = 'Consulta';
var typeIngreso = 'Ingreso';
var typeOrigin = '';
var porcentaje = 0;
var nameActivity = '';
var requestType = '';
var channel = 4; // tabla cl_canal caso203112

task.closeModalEvent.findCustomer = function (args) {
    var resp = args.commons.api.vc.dialogParameters;
	//args.model.Group.code = resp.CodeReceive;
    if (type == 'Consulta') {
        args.commons.api.viewState.disable('VA_TEXTINPUTBOXQKV_915725', false);
        args.commons.api.viewState.disable('VA_DATEFIELDBVXWGU_529725', false);
    }else if (type == 'Ingreso') {
        args.commons.api.viewState.enable('VA_TEXTINPUTBOXQKV_915725', false);
        args.commons.api.viewState.enable('VA_DATEFIELDBVXWGU_529725', false);
    }
     if( titular==1)
        {
        console.log("Entro a Titular1")
        args.model.Group.titular1Name  =resp.CodeReceive+"-"+ resp.name;
		args.model.Group.titularClient1  = resp.CodeReceive; 

        }
    else if(titular==2)
        {
       console.log("Entro a Titular2")  
       args.model.Group.titular2Name  =resp.CodeReceive+"-"+ resp.name;
       args.model.Group.titularClient2  = resp.CodeReceive;
        }
    if(titular==0)
    {
        args.model.Group.code = resp.CodeReceive;
    args.commons.api.vc.executeCommand('VA_VABUTTONPDPCKGB_382725', 'FindCustomer', undefined, true, false, 'VC_GROUPCOMOS_387974', false);
    }
};

//Para ocultar botones de grilla
task.hideButtonGridMember = function(args,entidad,queryId){
	var ds = args.commons.api.vc.model[entidad];
	var dsData = ds.data();
	for (var i = 0; i < dsData.length; i ++) {
		var dsRow = dsData[i];
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'edit');
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'delete');
	}
};

