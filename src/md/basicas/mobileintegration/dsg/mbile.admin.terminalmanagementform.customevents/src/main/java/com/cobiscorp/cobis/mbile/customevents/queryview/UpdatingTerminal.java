package com.cobiscorp.cobis.mbile.customevents.queryview;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalRequest;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Terminal;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.TerminalManager;

public class UpdatingTerminal extends BaseEvent implements IGridRowUpdating {

    private static final ILogger LOGGER = LogFactory.getLogger(UpdatingTerminal.class);

    public UpdatingTerminal(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    @Override
    public void rowAction(DataEntity dataEntity, IGridRowActionEventArgs iGridRowActionEventArgs) {
        String mac = dataEntity.get(Terminal.MAC);
        String mac1 = dataEntity.get(Terminal.MAC1);
        String mac2 = dataEntity.get(Terminal.MAC2);

        if (mac != null) {
            mac = mac.toLowerCase().replace("-", "");
            mac = mac.toLowerCase().replace(":", "");
        }

        if (mac1 != null) {
            mac1 = mac1.toLowerCase().replace("-", "");
            mac1 = mac1.toLowerCase().replace(":", "");
        }

        if (mac2 != null) {
            mac2 = mac2.toLowerCase().replace("-", "");
            mac2 = mac2.toLowerCase().replace(":", "");
        }

        TerminalManager terminalManager = new TerminalManager(getServiceIntegration());
        TerminalRequest request = new TerminalRequest();
        request.setMac(mac);
        request.setMac1(mac1);
        request.setMac2(mac2);
        request.setReference1(dataEntity.get(Terminal.REFERENCE1));
        request.setReference2(dataEntity.get(Terminal.REFERENCE2));
        terminalManager.updateTerminal(request, iGridRowActionEventArgs);
    }
}
