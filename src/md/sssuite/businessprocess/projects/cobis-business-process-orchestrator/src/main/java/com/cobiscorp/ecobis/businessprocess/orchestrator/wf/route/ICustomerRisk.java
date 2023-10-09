package com.cobiscorp.ecobis.businessprocess.orchestrator.wf.route;

import com.cobiscorp.cobis.cts.commons.exceptions.CTSInfrastructureException;
import com.cobiscorp.cobis.cts.commons.exceptions.CTSServiceException;

public interface ICustomerRisk {
	
	public boolean evaluateCustomerRisk(String processInstanceIdentifier, String field1, String field2, Integer field3, String field4) throws CTSServiceException, CTSInfrastructureException;

}
