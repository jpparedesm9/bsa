package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;
import cobiscorp.ecobis.customerdatamanagement.dto.CustomerRequest;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.PhysicalAddress;
import com.cobiscorp.cobis.cstmr.model.VirtualAddress;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowUpdating;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Constants;

public class RowUpdating_QV_9303_22386 extends BaseEvent implements IGridRowUpdating {

	private static final ILogger LOGGER = LogFactory.getLogger(RowUpdating_QV_9303_22386.class);

	public RowUpdating_QV_9303_22386(ICTSServiceIntegration serviceIntegration) {
		super(serviceIntegration);
		// TODO Auto-generated constructor stub
	}

	@Override
	public void rowAction(DataEntity row, IGridRowActionEventArgs arg1) {
		Integer customerId = row.get(VirtualAddress.PERSONSECUENTIAL);
		try {

			if (row.get(VirtualAddress.ADDRESSDESCRIPTION) != null) {
				AddressRequest addressRequest = new AddressRequest();
				if (customerId == null) {
					arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_ELPROSPGA_21497");
				} else {
					addressRequest.setCustomerId(customerId);
					addressRequest.setAddress(row.get(VirtualAddress.ADDRESSID));
					addressRequest.setAddressType(Constants.VIRTUALADRESSTYPE);
					addressRequest.setAddressDesc(row.get(VirtualAddress.ADDRESSDESCRIPTION));
					AddressManager addressManager = new AddressManager(getServiceIntegration());
					Integer idAddress = addressManager.updateAddressResp(addressRequest, arg1);
					
					if(idAddress !=null && idAddress > 0)
					{
						arg1.getMessageManager().showSuccessMsg("CSTMR.MSG_CSTMR_REGISTREE_31818");
						arg1.setSuccess(true);
						
						LOGGER.logDebug("****Inicia UpdateState*****");
						LOGGER.logDebug("****enteId*****" + customerId);

						CustomerRequest customerRequest = new CustomerRequest();
						customerRequest.setOperation('U');
						customerRequest.setType('M');
						customerRequest.setCustomerId(customerId);
						customerRequest.setState("S");

						AddressManager addressManagerV = new AddressManager(getServiceIntegration());
						addressManagerV.updateState(customerRequest, arg1);

						LOGGER.logDebug("****Finaliza UpdateState*****");
					}else{
						arg1.setSuccess(false);
						arg1.setCancel(true);
					}
				}
			}
		} catch (BusinessException bex) {
			LOGGER.logError("BusinessException: " , bex);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} catch (Exception ex) {
			LOGGER.logError("Exception: " , ex);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---> Finish Change_VA_TEXTINPUTBOXDXR_200739");
			}
		}

	}

}
