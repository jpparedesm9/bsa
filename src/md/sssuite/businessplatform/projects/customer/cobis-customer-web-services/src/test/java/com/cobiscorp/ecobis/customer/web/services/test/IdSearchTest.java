package com.cobiscorp.ecobis.customer.web.services.test;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;

public class IdSearchTest {
	private UtilClientTest util = null;

	public IdSearchTest() {
		// TODO Auto-generated constructor stub
	}

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	// @Ignore
	@Test
	public void getSearchById() {
		try {
			System.out.println("BUSQUEDA DE ID -EXISTE O NO");
			IdSearchRequest request = new IdSearchRequest();
			request.setIdentification("");// "78675647564666664");
			System.out.println("Customer Id: " + request.getIdentification());
			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("CustomerTxService/searchById", requestJSON);
			System.out.println("TRAMA DEVUELTA:" + responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponseForTestOnly(responseJSON, IdSearchResponse.class);
			// Assert.assertNotNull(serviceResponse);
			if (serviceResponse.isResult()) {
				IdSearchResponse idSearch = (IdSearchResponse) serviceResponse.getData();
				System.out.println(responseJSON);
				System.out.println("Tran OK ");
				System.out.println("Id Resultado: " + idSearch.getResult());

			} else {
				System.out.println("No se recuperó BUSQUEDA DE ID ");
			}

			// Assert.assertEquals(true, serviceResponse.isResult());

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
