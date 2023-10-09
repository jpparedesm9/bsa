//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocuments
    
    task.textInputButtonEvent.VA_CLIENTNAMEKVNFS_105273 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"cliente");
    
        
    };