    task.closeModalEvent.findCustomer = function (args) {
        var resp = args.commons.api.vc.dialogParameters,
            customerCode = args.commons.api.vc.dialogParameters.CodeReceive,
            CustomerName = args.commons.api.vc.dialogParameters.name,
            identification = args.commons.api.vc.dialogParameters.documentId,
            customerType = args.commons.api.vc.dialogParameters.customerType;

        args.model.DebitOrderProcessingLogFilter.clientId = customerCode;
    };

    //valida si arrastra el texto
    function validadeIfDragText(entities) {
        if (entities.DebitOrderProcessingLogFilter.loanNumber === null || entities.DebitOrderProcessingLogFilter.loanNumber === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.loanNumber)) {
            entities.DebitOrderProcessingLogFilter.loanNumber = $("#VA_TEXTINPUTBOXRBR_513643").val();
        }
        if (entities.DebitOrderProcessingLogFilter.accountNumberSantander === null || entities.DebitOrderProcessingLogFilter.accountNumberSantander === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.accountNumberSantander)) {
            entities.DebitOrderProcessingLogFilter.accountNumberSantander = $("#VA_TEXTINPUTBOXMRW_242643").val();
        }
        if (entities.DebitOrderProcessingLogFilter.clientId === null || entities.DebitOrderProcessingLogFilter.clientId === "" ||
            angular.isUndefined(entities.DebitOrderProcessingLogFilter.clientId)) {
            entities.DebitOrderProcessingLogFilter.clientId = $("#VA_TEXTINPUTBOXNGO_790643").val();
        }
    }