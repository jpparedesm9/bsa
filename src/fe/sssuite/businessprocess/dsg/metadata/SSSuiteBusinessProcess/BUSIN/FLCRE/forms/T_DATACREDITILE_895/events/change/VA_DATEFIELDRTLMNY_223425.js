//Entity: DataCreditLine
    //DataCreditLine.fechaVencimiento (DateField) View: DataCreditLineForm
    //Evento Change: Se ejecuta al cambiar el valor de un InputControl.
    task.change.VA_DATEFIELDRTLMNY_223425 = function( entities, changeEventArgs ) {
        changeEventArgs.commons.execServer = true;
        //changeEventArgs.commons.serverParameters.DataCreditLine = true;
    };