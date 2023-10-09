package com.cobiscorp.ecobis.customer.bl;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;

public interface BusinessSegmentManager {
	
	public List<BusinessSegmentResponse> getBusinessSegment(BusinessSegmentResponse request);
	
}
