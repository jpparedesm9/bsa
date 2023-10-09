package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.Date;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerQuickCreateRequest;

public class QuickCreateCustomerTest {
	private UtilClientTest util = null;

	@Ignore
	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void quickCreateCustomer() {
		try {
			System.out.println("CREACION RAPIDA");
			CustomerQuickCreateRequest request = new CustomerQuickCreateRequest();
			request.setIdentificationTypeCode("CED");
			request.setId("123");
			request.setFirstName("PEDRO");
			request.setLastName("ROMERO");
			request.setMiddleName("JOSE");
			request.setAdditionalLastName("AGURTO");
			request.setNationalityCode(218);
			request.setProfessionCode("001");
			request.setStatusCode("N");
			request.setOfficial(99);
			request.setSexCode("M");
			request.setMarriedName("NO HAY");
			request.setMaritalStatusCode("SO");
			request.setTypeCode("1");
			request.setDigitCheck(null);
			@SuppressWarnings("deprecation")
			Date date = new Date("01/01/2000");
			@SuppressWarnings("deprecation")
			Date date1 = new Date("01/01/2012");
			request.setBirthDate(date);
			request.setIdExpirationDate(date1);

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("QuickCreateTxService/executeQuickCreate", requestJSON);

			if (responseJSON.indexOf("code") != -1)
				System.out.println("Error: " + responseJSON);
			else {
				ServiceResponse serviceResponse = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
				Assert.assertNotNull(serviceResponse);
				CustomerDataResponse customer = (CustomerDataResponse) serviceResponse.getData();
				System.out.println("Id: " + customer.getCustomerID());
				Assert.assertEquals(true, serviceResponse.isResult());
			}

		} catch (Throwable ex) {
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}

	}

	@Ignore
	@After
	public void tearDown() {

	}

}
