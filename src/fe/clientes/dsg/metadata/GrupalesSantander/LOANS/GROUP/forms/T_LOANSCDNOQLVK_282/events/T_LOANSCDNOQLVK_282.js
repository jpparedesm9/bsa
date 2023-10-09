//"TaskId": "T_LOANSCDNOQLVK_282"
function openFindCustomer(nav){
      nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer'
            , url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER
            , files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                                                                              }];
        nav.customDialogParameters = {
            mode: "findCustomer"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.openCustomModalWindow('findCustomer');
}

function setHeaderForm(customerData, eventArgs){    
    var taskHeader={};          
    LATFO.INBOX.addTaskHeader(taskHeader, 'title', customerData.name, 0);
    LATFO.INBOX.addTaskHeader(taskHeader, 'Tipo de Identificaci\u00f3n', customerData.documentType, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'No. de Identificaci\u00f3n', customerData.documentId, 1);
    LATFO.INBOX.addTaskHeader(taskHeader, 'C\u00f3digo del cliente', customerData.code, 2);
	LATFO.INBOX.updateTaskHeader(taskHeader, eventArgs, 'G_MEMBERRLIL_519911');  
}