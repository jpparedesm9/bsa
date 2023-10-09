//Entity: HeaderQueryDocuments
    //HeaderQueryDocuments.clientName (TextInputButton) View: QueryDocumentsCycle
    
    task.textInputButtonEvent.VA_TEXTINPUTBOXFVY_775645 = function( textInputButtonEventArgs ) {

        textInputButtonEventArgs.commons.execServer = false;
        var nav = textInputButtonEventArgs.commons.api.navigation;
		loadFindCustomer(nav,"cliente");
    };