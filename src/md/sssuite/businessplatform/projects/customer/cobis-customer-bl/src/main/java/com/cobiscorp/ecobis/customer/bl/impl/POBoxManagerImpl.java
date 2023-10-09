package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.ArrayList;
import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.POBoxManager;
import com.cobiscorp.ecobis.customer.dal.POBoxDAO;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;

public class POBoxManagerImpl implements POBoxManager {
	private static ILogger logger = LogFactory.getLogger(POBoxManagerImpl.class);

	private POBoxDAO poBoxDAO;
	public POBoxDAO getPoBoxDAO() {
		return poBoxDAO;
	}

	public void setPoBoxDAO(POBoxDAO poBoxDAO) {
		this.poBoxDAO = poBoxDAO;
	}
	
	@Override
	public List<POBoxDataResponse> getAllPOBOX(CustomerDataRequest request) {

		List<POBoxDataResponse> listAllPOBoxResponse = new ArrayList<POBoxDataResponse>();
		List<POBoxDataResponse> listAllPOBox = poBoxDAO.getAllPOBox(request);
		POBoxDataResponse poBoxDataResponse = null;
		
		
		if(listAllPOBox!=null && listAllPOBox.size()!=0){
			for(POBoxDataResponse poBoxResponse : listAllPOBox){
				poBoxDataResponse = new POBoxDataResponse();
				poBoxDataResponse.setEntity(poBoxResponse.getEntity());
				poBoxDataResponse.setBox(poBoxResponse.getBox());
				poBoxDataResponse.setValue(poBoxResponse.getValue());
				poBoxDataResponse.setType(poBoxResponse.getType());
				poBoxDataResponse.setCity(poBoxResponse.getCity());
				poBoxDataResponse.setProvince(poBoxResponse.getProvince());
				poBoxDataResponse.setSubsidiary(poBoxResponse.getSubsidiary());
				poBoxDataResponse.setRegistrationDate(poBoxResponse.getRegistrationDate());
				poBoxDataResponse.setModifiedDate(poBoxResponse.getModifiedDate());
				poBoxDataResponse.setFunctionary(poBoxResponse.getFunctionary());
				poBoxDataResponse.setVerified(poBoxResponse.getVerified());
				poBoxDataResponse.setVerifiedDate(poBoxResponse.getModifiedDate());
				poBoxDataResponse.setEmpPO(poBoxResponse.getEmpPO());
				poBoxDataResponse.setOwnerBox(poBoxResponse.getOwnerBox());
				poBoxDataResponse.setCountry(poBoxResponse.getCountry());
				poBoxDataResponse.setCanton(poBoxResponse.getCanton());
				poBoxDataResponse.setCorrespondence(poBoxResponse.getCorrespondence());
				
				listAllPOBoxResponse.add(poBoxDataResponse);
			}
		
		}
		else{
			logger.logError("listAllPOBox = " + listAllPOBox);
			throw new BusinessException(0, "CUSTOMER DON'T HAS PO BOX");
		}		
		return listAllPOBoxResponse;
	}
	
}




