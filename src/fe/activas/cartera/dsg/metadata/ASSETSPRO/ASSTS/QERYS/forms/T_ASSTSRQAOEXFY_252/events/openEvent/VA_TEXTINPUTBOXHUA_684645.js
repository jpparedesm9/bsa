//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.groupName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXHUA_684645 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"grupo");
        
    };