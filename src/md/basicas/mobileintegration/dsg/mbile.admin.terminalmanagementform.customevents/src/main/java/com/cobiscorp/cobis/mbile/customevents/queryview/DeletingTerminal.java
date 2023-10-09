package com.cobiscorp.cobis.mbile.customevents.queryview;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalRequest;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Terminal;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.TerminalManager;

public class DeletingTerminal extends BaseEvent implements IGridRowDeleting {

    private static final ILogger LOGGER = LogFactory.getLogger(DeletingTerminal.class);

    public DeletingTerminal(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    @Override
    public void rowAction(DataEntity dataEntity, IGridRowActionEventArgs iGridRowActionEventArgs) {

        TerminalManager terminalManager = new TerminalManager(getServiceIntegration());
        TerminalRequest request = new TerminalRequest();
        request.setMac(dataEntity.get(Terminal.MAC));
        terminalManager.deleteTerminal(request, iGridRowActionEventArgs);
    }
}
