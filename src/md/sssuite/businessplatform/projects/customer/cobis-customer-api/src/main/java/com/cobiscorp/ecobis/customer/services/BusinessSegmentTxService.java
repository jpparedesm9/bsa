package com.cobiscorp.ecobis.customer.services;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;

public interface BusinessSegmentTxService {
	
	public List<BusinessSegmentResponse> getBusinessSegment(BusinessSegmentResponse line);

}
