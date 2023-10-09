package com.cobiscorp.ecobis.customer.bl.impl;

import java.util.List;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.customer.bl.BusinessSegmentManager;
import com.cobiscorp.ecobis.customer.dal.BusinessSegmentDAO;
import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;
 
public class BusinessSegmentManagerImpl implements BusinessSegmentManager {
	private static ILogger logger = LogFactory.getLogger(BusinessSegmentManagerImpl.class);
	BusinessSegmentDAO businessSegmentDAO;

	@Override
	public List<BusinessSegmentResponse> getBusinessSegment(BusinessSegmentResponse request) {
		List<BusinessSegmentResponse> listBusinessSegment = businessSegmentDAO.getBusinessSegment(request);
			
		if(listBusinessSegment!=null){
			if(listBusinessSegment.size()==0){
				throw new BusinessException(1, "BUSINESS SEGMENT NOT FOUND");
			}
			return null;
		}else{
			logger.logError("listBusinessSegment= " + listBusinessSegment);
		}
		
		return listBusinessSegment;
	}

	public BusinessSegmentDAO getBusinessSegmentDAO() {
		return businessSegmentDAO;
	}

	public void setBusinessSegmentDAO(BusinessSegmentDAO businessSegmentDAO) {
		this.businessSegmentDAO = businessSegmentDAO;
	}
	
	
}




