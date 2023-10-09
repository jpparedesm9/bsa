package com.cobiscorp.ecobis.customer.services.impl;

import java.util.List;

import com.cobiscorp.ecobis.customer.bl.BusinessSegmentManager;
import com.cobiscorp.ecobis.customer.services.BusinessSegmentTxService;
import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;


public class BusinessSegmentTxServiceImpl implements BusinessSegmentTxService{
	
	BusinessSegmentManager businessSegmentManager;
	
	@Override
	public List<BusinessSegmentResponse> getBusinessSegment(
			BusinessSegmentResponse line) {
		List<BusinessSegmentResponse> resp = businessSegmentManager.getBusinessSegment(line);
		return resp;
	}

	public BusinessSegmentManager getBusinessSegmentManager() {
		return businessSegmentManager;
	}

	public void setBusinessSegmentManager(
			BusinessSegmentManager businessSegmentManager) {
		this.businessSegmentManager = businessSegmentManager;
	}
	
}
