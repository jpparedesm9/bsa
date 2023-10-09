package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.List;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.NationalityResponse;

public class SearchNationalityTest {

	public SearchNationalityTest() {
	}

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		System.out.println("LOGIN CTS: " + util.doLogin());
	}

	// @Ignore
	@Test
	public void searchNationalityAll() {

		try {
			NationalityResponse request = new NationalityResponse();
			// request.setCountryId(4);
			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("NationalityService/searchNationality", requestJSON);
			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

			if (serviceResponse.isResult()) {
				List<NationalityResponse> response = (List<NationalityResponse>) serviceResponse.getData();
				System.out.println("TRAMA DE RESPUESTA: " + responseJSON);
			} else {
				System.out.println("No se recuperó Nacionalidad " + responseJSON);
			}
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
