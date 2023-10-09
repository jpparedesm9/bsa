package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.TelephoneRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.Phone;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.PhoneManager;

public class UpdatePhone extends BaseEvent implements IGridRowUpdating {
	private static final ILogger LOGGER = LogFactory
			.getLogger(UpdatePhone.class);

	public UpdatePhone(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try {
			TelephoneRequest phoneRequest = new TelephoneRequest();

			phoneRequest.setAddress(row.get(Phone.ADDRESSID));
			phoneRequest.setValue(row.get(Phone.PHONENUMBER));
			phoneRequest.setAreaCode(row.get(Phone.AREACODE));
			phoneRequest.setTypeTelephone(row.get(Phone.PHONETYPE));
			phoneRequest.setCustomerId(row.get(Phone.PERSONSECUENTIAL));
			phoneRequest.setSecuencial(row.get(Phone.PHONEID));

			PhoneManager phoneManager = new PhoneManager(
					getServiceIntegration());

			phoneManager.updatePhone(phoneRequest, args);
		} catch (Exception e) {
			ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.UPATE_PHONE, e, args, LOGGER);
		}

	}

}
