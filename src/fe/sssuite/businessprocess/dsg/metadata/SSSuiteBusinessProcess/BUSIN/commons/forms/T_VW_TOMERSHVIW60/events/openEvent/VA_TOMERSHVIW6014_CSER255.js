//Entity: CustomerSearch
    //CustomerSearch.Customer (TextInputButton) View: [object Object]
    
    task.textInputButtonEvent.VA_TOMERSHVIW6014_CSER255 = function(textInputButtonEventArgs) {
		textInputButtonEventArgs.commons.execServer = false;
		BUSIN.API.getNavigationFindCustomer(textInputButtonEventArgs.commons.api);
    };