//"TaskId": "T_RELATIONAJNQY_494"
//var tipoPersona;
var codigoCliente;
var banBorrado;
banBorrado = true;
var ban=true;
 var numsecuential=0;

task.closeModalEvent.findCustomer = function (args) {
   // var tipoPersona ;
    if (args.result.params.mode == "findCustomer"){
        var taskHeader = {};
        if (args.result.selectedData.customerType == "P"){
            LATFO.INBOX.addTaskHeader(taskHeader,'title',args.result.selectedData.name,0);
        }
        else if (args.result.selectedData.customerType == "C"){
            LATFO.INBOX.addTaskHeader(taskHeader,'title',args.result.selectedData.commercialName,0);
        }
        LATFO.INBOX.addTaskHeader(taskHeader,'No. de Identificaci\u00f3n',args.result.selectedData.documentId,1);
        LATFO.INBOX.addTaskHeader(taskHeader,'Tipo de Identificaci\u00f3n',args.result.selectedData.documentType,1);
        LATFO.INBOX.addTaskHeader(taskHeader,'C\u00f3digo del cliente',args.result.selectedData.code,2);
        LATFO.INBOX.updateTaskHeader(taskHeader, args, 'G_RELATIONNN_434954');        
        codigoCliente = args.result.selectedData.code;
        args.model.RelationContext.secuential= codigoCliente;
        //TRAER LAS RELACIONES
        args.commons.api.vc.executeCommand('VA_VABUTTONAPPHYWK_615954','Relation', undefined, true, false, 'VC_RELATIONQE_861494', false);
        
    }
    if (args.result.params.mode == "relation"){
        var api = args.commons.api;        
        var resp = args.commons.api.vc.dialogParameters;
        var selectedRow = api.vc.grids.QV_6114_93961.selectedRow;       
        selectedRow.set('namePersonRight', resp.name);
        selectedRow.set('secuentialPersonLeft', args.model.RelationContext.secuential);
		selectedRow.set('secuentialPersonRight', args.result.selectedData.code);
        //args.model.RelationPerson.data()[0].secuentialPersonLeft = codigoCliente;		
    }              
};

task.hideButtonGridMember = function(args,entidad,queryId){
	var ds = args.commons.api.vc.model[entidad];
	var dsData = ds.data();
	for (var i = 0; i < dsData.length; i ++) {
		var dsRow = dsData[i];
		args.commons.api.grid.hideGridRowCommand(queryId, dsRow, 'delete');
    }
};