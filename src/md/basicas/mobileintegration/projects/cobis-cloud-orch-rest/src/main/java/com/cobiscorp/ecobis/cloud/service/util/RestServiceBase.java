package com.cobiscorp.ecobis.cloud.service.util;

import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.Message;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.ServiceBase;

import java.util.Iterator;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public abstract class RestServiceBase extends ServiceBase {

    private static final String PRINT_MESSAGE_CODE = "0";
    private final ILogger logger = LogFactory.getLogger(RestServiceBase.class);
    private static Pattern pattern = Pattern.compile("(\\[.*?\\])");
    private ICTSServiceIntegration integration;

    public RestServiceBase(ICTSServiceIntegration integration) {
        this.integration = integration;
    }

    public RestServiceBase() {
		super();
	}

	protected ServiceResponse execute(String serviceId, ServiceRequestTO serviceRequest) {
        ServiceResponse response = super.execute(integration, logger, serviceId, serviceRequest);
        clearCodesInMessages(response);
        if (!response.isResult()) {
            throw new IntegrationException(response);
        }
        return response;
    }
    
    protected ServiceResponse executeNormal(String serviceId, ServiceRequestTO serviceRequest) {
        ServiceResponse response = super.execute(integration, logger, serviceId, serviceRequest);
        clearCodesInMessages(response);
        return response;
    }

    static void clearCodesInMessages(ServiceResponse response) {
        if (!response.isResult()) {
            if (response.getMessages() != null) {
                Iterator<Message> iterator = response.getMessages().iterator();
                while (iterator.hasNext()) {
                    Message message = iterator.next();
                    if (PRINT_MESSAGE_CODE.equals(message.getCode())) {
                        iterator.remove();
                    } else {
                        processMessage(message);
                    }
                }
            }
        }
    }

    static void processMessage(Message message) {
        Matcher matcher = pattern.matcher(message.getMessage());
        if (matcher.find()) {
            message.setCode(matcher.group(0).replace("[", "").replace("]", ""));
        }
        message.setMessage(
                matcher.replaceAll("")
                        .replaceAll("&apos;", "'")
                        .trim()
        );
    }

    protected ICTSServiceIntegration getIntegration() {
        return integration;
    }

}
