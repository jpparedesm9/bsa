//Entity: RelationPerson
    //RelationPerson.namePersonRight (TextInputButton) View: RelationForm
    
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXJMD_724954 = function( textInputButtonEventGridEventArgs ) {
        textInputButtonEventGridEventArgs.commons.execServer = false;
        var nav = textInputButtonEventGridEventArgs.commons.api.navigation;        
        nav.label='B\u00FAsqueda de Clientes';
        nav.customAddress = {
            id: 'findCustomer',
            url: '/customer/templates/find-customers-tpl.html'
        };
        nav.scripts = [{
            module: cobis.modules.CUSTOMER,
            files: ['/customer/services/find-customers-srv.js', '/customer/controllers/find-customers-ctrl.js']
                }];
        nav.customDialogParameters = {
            mode: "relation"
        };
        nav.modalProperties = {
            size: 'lg'
        };
        //nav.openCustomModalWindow('findCustomer');
        
    };