package com.cobiscorp.ecobis.cloud.service.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cts.domains.IProcedureRequest;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetBlock;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetData;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRow;
import com.cobiscorp.cobis.cts.domains.sp.IResultSetRowColumnData;
import com.cobiscorp.cobis.cts.dtos.ProcedureRequestAS;
import com.cobiscorp.cobis.cts.dtos.ProcedureResponseAS;
import com.cobiscorp.cobis.cts.services.orchestrator.ISPOrchestrator;
import com.cobiscorp.ecobis.cloud.service.OfficerService;
import com.cobiscorp.ecobis.cloud.service.dto.common.CatalogDto;
import com.cobiscorp.ecobis.cloud.service.util.ParameterType;
import org.apache.felix.scr.annotations.Component;
import org.apache.felix.scr.annotations.Reference;
import org.apache.felix.scr.annotations.Service;

import javax.ws.rs.Consumes;
import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.Produces;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.ArrayList;
import java.util.List;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.errorResponse;

import static com.cobiscorp.ecobis.cloud.service.util.ServiceResponseUtil.successResponse;

/**
 * Created by ntrujillo on 20/07/2017.
 */
@Path("/cobis-cloud/mobile/officer")
@Component
@Service({OfficerRestService.class})
public class OfficerRestService implements OfficerService {


    private final ILogger logger = LogFactory.getLogger(OfficerRestService.class);
    private final String className = "Class [OfficerRestService] ";

    @Reference(bind = "setSpOrchestrator", unbind = "unsetSpOrchestrator", target = "(service.callingSource=15)")
    private ISPOrchestrator spOrchestrator;


    public void setSpOrchestrator(ISPOrchestrator spOrchestrator) {
        this.spOrchestrator = spOrchestrator;
    }

    public void unsetSpOrchestrator(ISPOrchestrator spOrchestrator) {
        this.spOrchestrator = null;
    }

    @GET
    @Consumes(MediaType.APPLICATION_JSON)
    @Produces(MediaType.APPLICATION_JSON)
    @Override
    public Response getOfficers() {

    	logger.logInfo(
				"/cobis-cloud/mobile/officer/getOfficers");


        List<CatalogDto> officers = new ArrayList<CatalogDto>();
        logger.logDebug("spOrchestrator" + spOrchestrator);
        IProcedureRequest wProcedureRequest = new ProcedureRequestAS();
        wProcedureRequest.setSpName("cob_cartera..sp_oficiales");
        wProcedureRequest.addInputParam("@t_trn", ParameterType.INT_4.getDataType(), "7063");
        wProcedureRequest.addInputParam("@i_tipo", ParameterType.VARCHAR.getDataType(), "A");
        wProcedureRequest.addInputParam("@i_oficial", ParameterType.INT_4.getDataType(), "0");


        ProcedureResponseAS wProcedureResponseAS = (ProcedureResponseAS) this.spOrchestrator.execute(wProcedureRequest, null, null);

        if (wProcedureResponseAS != null) {
            wProcedureResponseAS = (ProcedureResponseAS) wProcedureResponseAS.parseMessageData();

            if (!wProcedureResponseAS.hasError()) {
                for (int i = 1; i <= wProcedureResponseAS.getResultSetListSize(); i++) {
                    IResultSetBlock resultSetBlock = wProcedureResponseAS.getResultSet(i);

                    if (resultSetBlock == null)
                        continue;

                    IResultSetData resultSetData = resultSetBlock.getData();
                    CatalogDto catalogDto;
                    for (int j = 1; j <= resultSetData.getRowsNumber(); j++) {
                        IResultSetRow row = resultSetData.getRow(j);
                        if (row == null)
                            continue;
                        catalogDto = new CatalogDto();

                        for (int k = 1; k <= row.getColumnsNumber(); k++) {
                            if (k == 1)
                                catalogDto.setCode(getStringRowDataValue(row.getRowData(k)));
                            if (k == 2)
                                catalogDto.setValue(getStringRowDataValue(row.getRowData(k)));
                        }
                        officers.add(catalogDto);
                    }
                }
            }

            return successResponse(officers,"/cobis-cloud/mobile/officer/getOfficers");
        } else {

            return errorResponse(wProcedureResponseAS.getMessages(),"/cobis-cloud/mobile/officer/getOfficers");

        }


    }


    public String getStringRowDataValue(IResultSetRowColumnData rowColumnData) {
        try {
            if ((rowColumnData != null) && (rowColumnData.getValue() != null)) {
                String value = rowColumnData.getValue();

                if (value.contains("&amp;")) {
                    value = getReplaceString(value);
                }
                return value;
            }
            return null;
        } catch (Exception e) {
            logger.logError(e);
        }
        return null;
    }

    private String getReplaceString(String value) {
        if ((value != null) && (value.contains("&amp;")))
            value = getReplaceString(value.replace("&amp;", "&"));
        else if ((value != null) && (value.contains("&lt;")))
            value = getReplaceString(value.replace("&lt;", "<"));
        else if ((value != null) && (value.contains("&gt;")))
            value = getReplaceString(value.replace("&gt;", ">"));
        else if ((value != null) && (value.contains("&quot;")))
            value = getReplaceString(value.replace("&quot;", "\\"));
        else if ((value != null) && (value.contains("&apos;"))) {
            value = getReplaceString(value.replace("&apos;", "'"));
        }

        return value;
    }
}
