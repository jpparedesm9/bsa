package com.cobiscorp.ecobis.customer.web.services.test;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.BusinessSegmentResponse;

public class BusinessSegmentTest {
	private UtilClientTest util = null;

	// private static ILogger logger =
	// LogFactory.getLogger(executeTransaferFundsTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// System.out.println("LOGIN CTS: "+util.doLogin());
		util.doLogin();
	}

	@Test
	public void getBusinessSegment() {
		try {
			BusinessSegmentResponse resp = new BusinessSegmentResponse();
			resp.setLine("CMB");

			String requestJSON = util.serializeJson(resp);
			String responseJSON = util.sendHttpPut("BusinessSegmentTxService/executeGetBusinessSegment", requestJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

			if (serviceResponse.isResult()) {
				System.out.println("Trama Business Segment: " + responseJSON);
			}

			Assert.assertNotNull(serviceResponse);
			Assert.assertEquals(true, serviceResponse.isResult());
		} catch (Throwable ex) {
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@After
	public void tearDown() {

	}

}
