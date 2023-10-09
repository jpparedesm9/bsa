package com.cobiscorp.cobis.mbile.customevents.query;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalRequest;
import cobiscorp.ecobis.mobilemanagement.dto.TerminalResponse;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.mbile.model.Terminal;
import com.cobiscorp.cobis.mbile.model.TerminalFiltro;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.DataEntityList;
import com.cobiscorp.designer.api.DynamicRequest;
import com.cobiscorp.designer.api.customization.IExecuteQuery;
import com.cobiscorp.designer.api.customization.arguments.IExecuteQueryEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.mobile.commons.services.TerminalManager;

import java.util.Arrays;
import java.util.List;

public class QueryTerminal extends BaseEvent implements IExecuteQuery {

    private static final ILogger LOGGER = LogFactory.getLogger(QueryTerminal.class);

    public QueryTerminal(ICTSServiceIntegration serviceIntegration) {
        super(serviceIntegration);
    }

    @Override
    public List<?> executeDataEvent(DynamicRequest dynamicRequest, IExecuteQueryEventArgs iExecuteQueryEventArgs) {
        TerminalManager terminalManager = new TerminalManager(getServiceIntegration());
        TerminalRequest terminalRequest = new TerminalRequest();

        String filterName = dynamicRequest.getData().get("filterName")!=null?dynamicRequest.getData().get("filterName").toString():null;
        String value = dynamicRequest.getData().get("filterValue")!=null?dynamicRequest.getData().get("filterValue").toString():null;

        LOGGER.logInfo("filterName" + filterName);
        LOGGER.logInfo("filterValue" + value);


        if (filterName != null && filterName.equals("NAME")) {
            terminalRequest.setReference1(value);
        }

        if (filterName != null && filterName.equals("MAC")) {
            terminalRequest.setMac(value);
            terminalRequest.setMac1(value);
            terminalRequest.setMac2(value);
        }

        if (filterName != null && filterName.equals("REF")) {
            terminalRequest.setReference2(value);
        }


        List<TerminalResponse> data = Arrays.asList(terminalManager.searchTerminales(terminalRequest, iExecuteQueryEventArgs));

        DataEntityList dataEntityList = new DataEntityList();
        DataEntity entity;
        for (TerminalResponse t : data) {
            entity = new DataEntity();
            entity.set(Terminal.MAC, t.getMac());
            entity.set(Terminal.MAC1, t.getMac1());
            entity.set(Terminal.MAC2, t.getMac2());
            entity.set(Terminal.REFERENCE1, t.getReference1());
            entity.set(Terminal.REFERENCE2, t.getReference2());
            dataEntityList.add(entity);
        }
        return dataEntityList.getDataList();
    }
}
