//gridBeforeEnterInLineRow QueryView: GrdWarrantyPolicies
        //Evento GridBeforeEnterInLineRow: Se ejecuta antes de la edición o inserción en línea de la grilla.
        task.gridBeforeEnterInLineRow.QV_ERWRL4097_89 = function (entities, gridBeforeEnterInLineRowEventArgs) {
            gridABeforeEnterInLineRowEventArgs.commons.execServer = false;

            var grid = gridABeforeEnterInLineRowEventArgs.commons.api.grid;
            if (entities.WarrantyPoliciy) {
                grid.disabledColumn('QV_ERWRL4097_89', 'numberPolicy');
                grid.disabledColumn('QV_ERWRL4097_89', 'insurance');
            }
            var nav = FLCRE.API.getApiNavigation(gridABeforeEnterInLineRowEventArgs, 'T_FLCRE_76_CRNTO32', 'VC_CRNTO32_RRNYM_717');
            nav.label = cobis.translate('BUSIN.DLB_BUSIN_PLIZAMMVK_53577');
            // nav.queryParameters = { mode: gridABeforeEnterInLineRowEventArgs.commons.constants.mode.Update };
            // nav.customDialogParameters = { maxRelation : task.getMaxPrelation(entities)};        
            nav.openModalWindow(gridABeforeEnterInLineRowEventArgs.commons.controlId, null);
        };