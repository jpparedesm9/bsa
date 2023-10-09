package com.cobiscorp.cobis.assets.reports.service;

import com.cobiscorp.cobis.assets.reports.commons.ConstantValue;
import com.cobiscorp.cobis.commons.domains.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import cobiscorp.ecobis.assets.cloud.dto.FooterRespose;
import cobiscorp.ecobis.commons.dto.ServiceRequestTO;
import cobiscorp.ecobis.commons.dto.ServiceResponseTO;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;

public class FooterPageService extends BaseService {
	private static final ILogger LOGGER = LogFactory.getLogger(FooterPageService.class);

	public String getFooterPage(ICTSServiceIntegration serviceIntegration) {

		if (LOGGER.isDebugEnabled()) {
			LOGGER.logDebug("Start method getFooterPage");
		}
		FooterRespose[] footerResponse = null;
		StringBuilder footer = new StringBuilder();
		try {
			ServiceRequestTO serviceReportRequestTO = getHeaderRequest(ConstantValue.SERVICE_READ_FOOTER_PAGE);
			ServiceResponseTO serviceResponseTo = serviceIntegration.getResponseFromCTS(serviceReportRequestTO);
			if (serviceResponseTo.isSuccess()) {
				footerResponse = (FooterRespose[]) serviceResponseTo.getValue(ConstantValue.RETURN_FOOTERPAGE_RESPONSE);

				for (FooterRespose footerItem : footerResponse) {
					footer.append(footerItem.getDescription());
					footer.append("\n");
				}
			} else {
				LOGGER.logError("Fail method getFooterPage");
				util.error(serviceResponseTo);
			}
		} catch (Exception ex) {
			LOGGER.logError("Exception: " + ex);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("Finish method getFooterPage");
			}
		}
		return footer.toString();
	}
}
