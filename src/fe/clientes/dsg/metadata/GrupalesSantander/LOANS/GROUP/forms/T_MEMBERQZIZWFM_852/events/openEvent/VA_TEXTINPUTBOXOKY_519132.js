//Entity: Member
    //Member.customer (TextInputButton) View: MemberPopPupForm
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXOKY_519132 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
        nav.label = 'B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: "findCustomer",
            url: "customer/templates/find-customers-tpl.html"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ["/customer/services/find-customers-srv.js",
                 //"/customer/services/find-program-srv.js",
                   "/customer/controllers/find-customers-ctrl.js"]
         }];
        
        nav.customDialogParameters = {
        
        };    
    };

    task.closeModalEvent.findCustomer = function (args) {        
        var resp = args.commons.api.vc.dialogParameters;
		var customerCode=  args.commons.api.vc.dialogParameters.CodeReceive;
		var CustomerName=  args.commons.api.vc.dialogParameters.customerType ==='C'?args.commons.api.vc.dialogParameters.commercialName:args.commons.api.vc.dialogParameters.name;
		var identification= args.commons.api.vc.dialogParameters.documentId;
		args.model.Member.customer  = customerCode +"-"+ CustomerName;
		args.model.Member.customerId  = customerCode; 
        //args.model.Member.qualification='AMARILLO'
        args.commons.api.vc.executeCommand('VA_VABUTTONTPUAZVF_333132', 'FindCustomer', undefined, true, false, 'VC_MEMBERLFPC_722852', false);
     
    };