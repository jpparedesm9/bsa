package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.PhoneManager;
import com.cobiscorp.ecobis.customer.services.PhoneTxService;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
//import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;

public class PhoneTxServiceImpl implements PhoneTxService {
	private PhoneManager phoneManager;	
	private static ILogger logger = LogFactory.getLogger(PhoneTxServiceImpl.class);
	
	public void setPhoneManager(PhoneManager phoneManager) {
		this.phoneManager = phoneManager;
	}
	
	public void unsetPhoneManager(PhoneManager phoneManager) {
		this.phoneManager = null;
	}
	
	@Override
	public List<PhoneDataResponse> getPhonebyCustomer(CustomerDataRequest request) {
	
		List<PhoneDataResponse> response =  phoneManager.getPhonebyCustomer(request);
		
		return response;
	}

	@Override
	public List<PhoneDataResponse> getPhonebyCustomerAndAddress(
			PhoneDataRequest request) {
		logger.logDebug("Phone request------->"+request.getAddressId()+", "+request.getCustomerID());
		List<PhoneDataResponse> resp = phoneManager.getPhonebyCustomerAndAddress(request);
		
		for(PhoneDataResponse phone: resp){
			logger.logDebug("Phone resp ---->"+phone.getAddress()+phone.getValue());
		}
		return resp;
	}
	
}
