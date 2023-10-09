package com.cobiscorp.cobis.cstmr.customevents.utils;
import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import com.cobiscorp.designer.api.customization.arguments.ICommonEventArgs;
import com.cobiscorp.ecobis.customer.commons.prospect.services.ProspectManager;

public class Utils {

	public String validateDocumentNumber(String documentType, String documentNumber, ICTSServiceIntegration serviceIntegration, ICommonEventArgs arg1) {

		if (documentType != null && documentNumber != null) {
			ProspectManager prospectManager = new ProspectManager(serviceIntegration);
			int result = prospectManager.searchByIdentificationAndIdentificationType(documentNumber, documentType, arg1);

			if (result == 1) {
				arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_LAIDENTFP_63853");
				arg1.setSuccess(false);
			} else if (result == 0) {
				return documentNumber;
			}
		}

		return "";
	}
}
