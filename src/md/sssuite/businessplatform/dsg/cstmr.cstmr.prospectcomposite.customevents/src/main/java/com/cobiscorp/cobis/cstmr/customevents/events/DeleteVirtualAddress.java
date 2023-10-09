package com.cobiscorp.cobis.cstmr.customevents.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.VirtualAddress;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowDeleting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionMessage;
import com.cobiscorp.ecobis.business.commons.platform.services.utils.ExceptionUtils;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;

public class DeleteVirtualAddress extends BaseEvent implements IGridRowDeleting {

	private static final ILogger LOGGER = LogFactory.getLogger(DeleteVirtualAddress.class);

	public DeleteVirtualAddress(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs args) {
		try {
			AddressRequest addressRequest = new AddressRequest();
			addressRequest.setAddress(row.get(VirtualAddress.ADDRESSID));
			addressRequest.setCustomerId(row.get(VirtualAddress.PERSONSECUENTIAL));

			AddressManager addressManagement = new AddressManager(getServiceIntegration());

			addressManagement.deleteAddress(addressRequest, args);
		} catch (Exception e) {
        	ExceptionUtils.showError(ExceptionMessage.BussinessPlatform.DELETE_VIRTUAL_ADDRESS, e, args, LOGGER);
		}
	}

}
