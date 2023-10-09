//Entity: HeaderQueryDocuments
//HeaderQueryDocuments.clientId (TextInputButton) View: QueryDocumentsByFilter

task.textInputButtonEvent.VA_CLIENTIDBZOEDEE_140698 = function (textInputButtonEventArgs) {
    textInputButtonEventArgs.commons.execServer = false;
    var nav = textInputButtonEventArgs.commons.api.navigation;
    loadFindCustomer(nav, "cliente");

};