package com.cobiscorp.ecobis.customer.dal;

import java.util.List;

import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;

public interface BusinessSegmentDAO {
	
	public List<BusinessSegmentResponse> getBusinessSegment(BusinessSegmentResponse line);

}
