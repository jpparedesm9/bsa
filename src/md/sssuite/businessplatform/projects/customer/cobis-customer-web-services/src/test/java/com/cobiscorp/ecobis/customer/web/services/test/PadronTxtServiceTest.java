package com.cobiscorp.ecobis.customer.web.services.test;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public class PadronTxtServiceTest {

	private UtilClientTest util = null;

	// private static ILogger logger =
	// LogFactory.getLogger(executeTransaferFundsTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// System.out.println("LOGIN CTS: "+util.doLogin());
		util.doLogin();
	}

	private static ILogger logger = LogFactory.getLogger(ICustomerTxServiceTest.class);

	// @Ignore
	@Test
	public void getPadron() {
		try {

			logger.logInfo("IN TO PadronTxtServiceTest");

			System.out.println("padron RAPIDA");
			CustomerQuickCreateRequest request = new CustomerQuickCreateRequest();
			request.setModeCode(1);
			request.setType("P");
			// request.setPadron("SUG");
			request.setId("000091313");
			request.setIdentificationTypeCode("01");

			System.out.println("llamada JSON");
			String requestJSON = util.serializeJson(request);
			System.out.println("llamada HTTP");
			String responseJSON = util.sendHttpPut("PadronTxService/executeGetPadron", requestJSON);
			System.out.println("TRAMA:" + responseJSON);
			// System.out.println("TRAMA:"+requestJSON);
			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);

			ServiceResponse serviceResponse1 = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
			CustomerDataResponse customer = (CustomerDataResponse) serviceResponse1.getData();

			System.out.println("Id: " + customer.getCustomerIdentification());
			System.out.println("Fecha: " + customer.getCustomerDateCharge());
			System.out.println("Pais: " + customer.getCustomerCountry());
			System.out.println("nombre: " + customer.getCustomerFirstName());

			System.out.println("nombre: " + customer.getCustomerBusinessName());
			Assert.assertNotNull(serviceResponse);

			Assert.assertEquals(true, serviceResponse.isResult());

		} catch (Throwable ex) {
			// logger.logError("error:" + ex);
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@After
	public void tearDown() {

	}

}
