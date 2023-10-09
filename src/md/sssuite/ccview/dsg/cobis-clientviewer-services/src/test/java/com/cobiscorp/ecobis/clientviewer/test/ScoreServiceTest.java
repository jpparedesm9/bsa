package com.cobiscorp.ecobis.clientviewer.test;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;



public class ScoreServiceTest {
	//@SuppressWarnings("unused")
	private static ILogger logger = LogFactory
			.getLogger(QueryProductsServiceTest.class);

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void searchScoreCustomer(){
		
		int customer = 10;
				
		String requestJSONC = util.serializeJson(customer);

		String responseJSON = util.sendHttpPut(
				"IScoreServices/searchScoreCustomer/"+customer,
				"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		
		System.out.println("---" + serviceResponse.getData());
		
		Assert.assertNotNull(serviceResponse);
	}
}
