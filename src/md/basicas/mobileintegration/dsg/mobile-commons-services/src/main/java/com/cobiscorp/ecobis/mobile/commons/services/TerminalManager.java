package com.cobiscorp.ecobis.mobile.commons.services;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalRequest;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalResponse;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.utils.CallServices;

public class TerminalManager extends BaseEvent {
    public TerminalManager(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    public void createTerminal(TerminalRequest terminalRequest, ICommonEventArgs arg1) throws BusinessException {
        CallServices callService = new CallServices(getServiceIntegration());
        callService.callService("inTerminalRequest", terminalRequest, "TerminalManagement.TerminalManagement.CreateTerminal", arg1);

    }

    public void updateTerminal(TerminalRequest terminalRequest, ICommonEventArgs arg1) throws BusinessException {
        CallServices callService = new CallServices(getServiceIntegration());
        callService.callService("inTerminalRequest", terminalRequest, "TerminalManagement.TerminalManagement.UpdateTerminal", arg1);

    }

    public void deleteTerminal(TerminalRequest terminalRequest, ICommonEventArgs arg1) throws BusinessException {
        CallServices callService = new CallServices(getServiceIntegration());
        callService.callService("inTerminalRequest", terminalRequest, "TerminalManagement.TerminalManagement.DeleteTerminal", arg1);
    }

    public TerminalResponse[] searchTerminales(TerminalRequest terminalRequest, ICommonEventArgs arg1) throws BusinessException {
        CallServices callService = new CallServices(getServiceIntegration());

        TerminalResponse[] business = callService.callServiceWithReturnArray("inTerminalRequest", terminalRequest, "TerminalManagement.TerminalManagement.QueryTerminal",
                "returnTerminalResponse", arg1);
        return business == null ? new TerminalResponse[0] : business;
    }
}
