package com.cobiscorp.cobis.cstmr.commons.events;

import cobiscorp.ecobis.cts.integration.services.ICTSServiceIntegration;
import cobiscorp.ecobis.customerdatamanagement.dto.AddressRequest;

import java.util.HashMap;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.cstmr.model.NaturalPerson;
import com.cobiscorp.cobis.cstmr.model.Person;
import com.cobiscorp.cobis.cstmr.model.VirtualAddress;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.designer.api.DataEntity;
import com.cobiscorp.designer.api.customization.IGridRowInserting;
import com.cobiscorp.designer.api.customization.arguments.IGridRowActionEventArgs;
import com.cobiscorp.designer.common.BaseEvent;
import com.cobiscorp.ecobis.customer.commons.prospect.services.AddressManager;
import com.cobiscorp.ecobis.customer.prospect.commons.constants.Constants;

public class RowInserting_QV_9303_22386 extends BaseEvent implements IGridRowInserting {

	private static final ILogger LOGGER = LogFactory.getLogger(RowInserting_QV_9303_22386.class);

	public RowInserting_QV_9303_22386(ICTSServiceIntegration serviceIntegration) {
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
					addressRequest.setAddressType(Constants.VIRTUALADRESSTYPE);
					addressRequest.setAddressDesc(row.get(VirtualAddress.ADDRESSDESCRIPTION));
					AddressManager addressManager = new AddressManager(getServiceIntegration());
					Integer idAddress =addressManager.createAddress(addressRequest, arg1);
					if(idAddress != null && idAddress!=0) {
						row.set(VirtualAddress.ADDRESSID,idAddress);
						row.set(VirtualAddress.PERSONSECUENTIAL, customerId);
						row.set(VirtualAddress.ADDRESSTYPE, Constants.VIRTUALADRESSTYPE);
					
					}else {
						row.isRemoved();
						arg1.setSuccess(false);
						arg1.setCancel(true);
					}

				}
			}
		} catch (BusinessException bex) {
			LOGGER.logError("BusinessException:  " + bex);
			LOGGER.logError(" Argumentos" + arg1);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
		} catch (Exception ex) {
			LOGGER.logError("Exception:  " + ex);
			arg1.getMessageManager().showErrorMsg("CSTMR.MSG_CSTMR_OCURRIONR_93100");
			LOGGER.logError(" Argumentos" + arg1);
		} finally {
			if (LOGGER.isDebugEnabled()) {
				LOGGER.logDebug("---> Finish Change_VA_TEXTINPUTBOXDXR_200739");
			}
		}
	}

}
