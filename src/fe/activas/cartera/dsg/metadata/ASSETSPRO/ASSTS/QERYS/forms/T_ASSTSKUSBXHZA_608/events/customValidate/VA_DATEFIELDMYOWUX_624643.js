//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.untilDate (DateField) View: DebitOrderProcessingLog

    task.customValidate.VA_DATEFIELDMYOWUX_624643 = function (entities, customValidateEventArgs) {
        var currentDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(customValidateEventArgs.currentValue),
            fromDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(entities.DebitOrderProcessingLogFilter.fromDate);

        if (currentDate !== null && fromDate === null) {
            customValidateEventArgs.isValid = true;
            return;
        }


        if (currentDate === null && fromDate !== null) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_INGRESEFF_23610';
            customValidateEventArgs.isValid = false;
            return;
        }

        if (currentDate < fromDate) {
            customValidateEventArgs.errorMessage = 'ASSTS.MSG_ASSTS_LAFECHASH_16014';
            customValidateEventArgs.isValid = false;
            return;
        }

        if (currentDate > entities.DebitOrderProcessingLogFilter.processDate) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_LAFECHAHR_40120';
            customValidateEventArgs.isValid = false;
            return;
        }

        customValidateEventArgs.isValid = true;

    };