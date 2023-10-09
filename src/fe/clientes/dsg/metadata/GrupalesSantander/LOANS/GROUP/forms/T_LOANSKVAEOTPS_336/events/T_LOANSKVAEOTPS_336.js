//"TaskId": "T_LOANSKVAEOTPS_336"
task.showHeaderGrid = function (entities, renderEventArgs) {
            renderEventArgs.commons.execServer = false;
            var itemsNumber = entities.Item.length;
            var indexEndColumn = 14;
            var i;
            for (i = 1; i < itemsNumber; i++) {
                renderEventArgs.commons.api.grid.title("QV_6763_19315", "item" + i, entities.Item[i].concept, null, null);
            }
            for (i = itemsNumber ; i < indexEndColumn; i++) {
                renderEventArgs.commons.api.grid.hideColumn("QV_6763_19315",
                        "item" + i);
            }
        }