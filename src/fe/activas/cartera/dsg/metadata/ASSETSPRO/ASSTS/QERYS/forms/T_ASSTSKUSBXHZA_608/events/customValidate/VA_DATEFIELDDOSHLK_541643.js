//Entity: DebitOrderProcessingLogFilter
    //DebitOrderProcessingLogFilter.fromDate (DateField) View: DebitOrderProcessingLog

    task.customValidate.VA_DATEFIELDDOSHLK_541643 = function (entities, customValidateEventArgs) {
        var currentDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(customValidateEventArgs.currentValue),
            untilDate = ASSETS.Utils.convertDateWithoutHoursMinutesSecondsMilliseconds(entities.DebitOrderProcessingLogFilter.untilDate);
        //hay que validar con designer si es la mejor solucion cuando se arrastra el texto al control
        validadeIfDragText(entities);

        if (currentDate !== null && untilDate === null) {
            customValidateEventArgs.isValid = true;
            return;
        }


        if (currentDate === null && untilDate !== null) {
            customValidateEventArgs.errorMessage = 'ASSTS.LBL_ASSTS_INGRESEFF_23610';
            customValidateEventArgs.isValid = false;
            return;
        }

        customValidateEventArgs.isValid = true;

    };