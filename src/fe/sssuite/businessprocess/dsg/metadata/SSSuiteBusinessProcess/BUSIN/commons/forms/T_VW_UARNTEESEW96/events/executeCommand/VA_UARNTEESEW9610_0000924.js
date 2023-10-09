//Botón Nuevo
    task.executeCommand.VA_UARNTEESEW9610_0000924 = function( entities, executeCommandEventArgs ) {
        executeCommandEventArgs.commons.execServer = false;
        executeCommandEventArgs.commons.api.parentVc.model.Task.ownerIdentifier = entities.OriginalHeader.IDRequested;
        FLCRE.UTILS.GUARANTEE.openFindGuarantee(entities,executeCommandEventArgs, {});
    };