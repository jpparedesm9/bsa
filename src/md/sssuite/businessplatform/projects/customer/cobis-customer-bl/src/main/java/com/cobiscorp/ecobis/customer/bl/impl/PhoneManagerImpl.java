package com.cobiscorp.ecobis.customer.bl.impl;


import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.PhoneManager;
import com.cobiscorp.ecobis.customer.dal.PhoneDAO;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;



public class PhoneManagerImpl implements PhoneManager {
	private static ILogger logger = LogFactory.getLogger(PhoneManagerImpl.class);
	
	PhoneDAO phoneDAO;

	public PhoneDAO getPhoneDAO() {
		return phoneDAO;
	}


	public void setPhoneDAO(PhoneDAO phoneDAO) {
		this.phoneDAO = phoneDAO;
	}


	@Override
	public List<PhoneDataResponse> getPhonebyCustomer(CustomerDataRequest request) {
	List<PhoneDataResponse> listPhoneDataResponse = new ArrayList<PhoneDataResponse>();
	List<PhoneDataResponse> listAllPhone = phoneDAO.getPhonebyCustomer(request);

	
		for(PhoneDataResponse phoneDTO : listAllPhone){
			if (phoneDTO.getEntity() != null) {

				PhoneDataResponse phoneResponse = new PhoneDataResponse();
			
				phoneResponse.setEntity(phoneDTO.getEntity());
				phoneResponse.setAddress(phoneDTO.getAddress());
				phoneResponse.setSequential(phoneDTO.getSequential());
				phoneResponse.setValue(phoneDTO.getValue());
				phoneResponse.setTypePhone(phoneDTO.getTypePhone());
				phoneResponse.setPhoneCharge(phoneDTO.getPhoneCharge());
				phoneResponse.setFunctionary(phoneDTO.getFunctionary());
				phoneResponse.setVerified(phoneDTO.getVerified());
				phoneResponse.setDateSee(phoneDTO.getDateSee());//==null? null:sdf.format(phoneDTO.getDateSee()));
				phoneResponse.setDateRegistration(phoneDTO.getDateRegistration());//==null? null:sdf.format(phoneDTO.getDateRegistration()));
				phoneResponse.setDateModified(phoneDTO.getDateModified());//==null? null:sdf.format(phoneDTO.getDateModified()));
				listPhoneDataResponse.add(phoneResponse);
			}
		} 
		return listPhoneDataResponse;
		
	}


	@Override
	public List<PhoneDataResponse> getPhonebyCustomerAndAddress(
			PhoneDataRequest request) {
		List<PhoneDataResponse> listPhoneDataResponse = new ArrayList<PhoneDataResponse>();
		List<PhoneDataResponse> listAllPhone = phoneDAO.getPhonebyCustomerAndAddress(request);
		for(PhoneDataResponse phoneDTO : listAllPhone){
			if (phoneDTO.getEntity() != null) {
				PhoneDataResponse phoneResp = new PhoneDataResponse();
				
				phoneResp.setEntity(phoneDTO.getEntity());
				phoneResp.setAddress(phoneDTO.getAddress());
				phoneResp.setSequential(phoneDTO.getSequential());
				phoneResp.setValue(phoneDTO.getValue());
				phoneResp.setTypePhone(phoneDTO.getTypePhone());
				phoneResp.setPhoneCharge(phoneDTO.getPhoneCharge());
				phoneResp.setFunctionary(phoneDTO.getFunctionary());
				phoneResp.setVerified(phoneDTO.getVerified());
				phoneResp.setDateSee(phoneDTO.getDateSee());//==null? null:sdf.format(phoneDTO.getDateSee()));
				phoneResp.setDateRegistration(phoneDTO.getDateRegistration());//==null? null:sdf.format(phoneDTO.getDateRegistration()));
				phoneResp.setDateModified(phoneDTO.getDateModified());//==null? null:sdf.format(phoneDTO.getDateModified()));
				listPhoneDataResponse.add(phoneResp);
			}else{
				logger.logError("phoneDTO = " + phoneDTO.getEntity());
			}
		} 
		return listPhoneDataResponse;
		
	}
}