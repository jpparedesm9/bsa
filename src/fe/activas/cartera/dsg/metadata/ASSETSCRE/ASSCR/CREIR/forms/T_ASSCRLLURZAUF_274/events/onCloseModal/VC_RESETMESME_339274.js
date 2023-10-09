//Evento onCloseModalEvent : Evento que actua como listener cuando se cierra ventanas modales.
//ViewContainer: ResetMessageImage
task.onCloseModalEvent = function (entities, onCloseModalEventArgs) {
    onCloseModalEventArgs.commons.execServer = false;

    var response = onCloseModalEventArgs.result;
    codClienteReset = response.codigoCliente;
    nameCliente = response.nameClient;

    if (codClienteReset !== undefined || codClienteReset == 0) {

        // Se muestran los botones


        onCloseModalEventArgs.commons.api.viewState.show('VA_VABUTTONKOXRDID_200225');

        entities.ResetImageMessage.codResetClient = codClienteReset;
        entities.ResetImageMessage.nameClient = nameCliente;
    }

    onCloseModalEventArgs.commons.api.viewState.show('VA_CODRESETCLIENTN_154225');
    onCloseModalEventArgs.commons.api.viewState.show('VA_NAMECLIENTFJHNP_973225');



};