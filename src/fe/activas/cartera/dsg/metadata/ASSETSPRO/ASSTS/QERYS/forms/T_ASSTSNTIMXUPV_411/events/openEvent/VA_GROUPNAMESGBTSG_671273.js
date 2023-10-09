//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.groupName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEvent.VA_GROUPNAMESGBTSG_671273 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"grupo");
        
    };