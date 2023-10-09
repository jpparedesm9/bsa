package com.cobiscorp.ecobis.clientviewer.test;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;

public class RateServiceTest {
	@SuppressWarnings("unused")
	private static ILogger logger = LogFactory.getLogger(RateServiceTest.class);

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void rate() {

		int customer = 3;

		// PrepareData
		String responseJSON = util.sendHttpPut("clientviewer/RateService/getRateByClientId/" + customer, "");
		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void asfi() {

		int customer = 3;

		// PrepareData
		String responseJSON = util.sendHttpPut("clientviewer/RateService/getAsfiByClientId/" + customer, "");
		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void infoCred() {

		int customer = 3;

		// PrepareData
		String responseJSON = util.sendHttpPut("clientviewer/RateService/getInfoCredByClientId/" + customer, "");
		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void portfolioRate() {

		int customer = 3;

		// PrepareData
		String responseJSON = util.sendHttpPut("clientviewer/RateService/getPortfolioRateByClientId/" + customer, "");
		ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

}
