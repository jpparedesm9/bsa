//Entity: RelationPerson
    //RelationPerson.namePersonLeft (TextInputButton) View: RelationForm
    //Aparentemente este archivo no va... Revisar
    task.textInputButtonEventGrid.VA_TEXTINPUTBOXDOE_961954 = function(textInputButtonEventGridEventArgs ) {
        textInputButtonEventGridEventArgs.commons.execServer = false;
        var nav = textInputButtonEventGridEventArgs.commons.api.navigation;        
        nav.label='B\u00FAsqueda de Clientes A';
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