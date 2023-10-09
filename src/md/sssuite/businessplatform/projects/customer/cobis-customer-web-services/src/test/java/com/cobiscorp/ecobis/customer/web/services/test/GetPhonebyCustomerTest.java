package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.PhoneDataResponse;

public class GetPhonebyCustomerTest {
	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// System.out.println("LOGIN CTS: "+util.doLogin());
		util.doLogin();
	}

	// @Ignore
	@Test
	public void getPhone() {
		try {
			CustomerDataRequest request = new CustomerDataRequest();
			List<PhoneDataResponse> telefono = new ArrayList<PhoneDataResponse>();
			request.setCustomerId(76);

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("PhoneTxService/executeGetPhone", requestJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			System.out.println("Trama getPhonebyCustomer: " + responseJSON);
			if (serviceResponse.isResult()) {
				String phoneTrama = responseJSON.substring(responseJSON.indexOf("["), responseJSON.indexOf("]") + 1);

				String phoneAux = phoneTrama;

				while (phoneTrama.length() == 1) {

					if (phoneAux.length() == 0) {
						break;
					} else {
						if (phoneAux.indexOf("{") != -1) {
							String aux = phoneAux.substring(phoneAux.indexOf("{"), phoneAux.indexOf("}") + 1);

							telefono.add((PhoneDataResponse) util.deserialize(aux, PhoneDataResponse.class));
							if (phoneAux.length() > aux.length() + 1)
								phoneAux = phoneAux.substring(aux.length() + 1);
							else
								break;
						} else
							break;
					}

				}
				System.out.println("# Telefono: " + telefono.size());
				System.out.println("---Telefono 1---");
				System.out.println("Id Cliente: " + telefono.get(0).getEntity());
			}
			Assert.assertNotNull(serviceResponse);
			Assert.assertEquals(true, serviceResponse.isResult());
			// Assert.assertSame(AddressDataResponse.class,telefono.get(0).getClass());
		} catch (Throwable ex) {
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@Ignore
	@Test
	public void getPhoneAddress() {
		try {
			PhoneDataRequest request = new PhoneDataRequest();
			List<PhoneDataResponse> telefono = new ArrayList<PhoneDataResponse>();
			request.setCustomerID(3);
			request.setAddressId(1);

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("PhoneTxService/executeGetPhoneAddress", requestJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			System.out.println("Trama getPhonebyCustomerAndAddress: " + responseJSON);
			if (serviceResponse.isResult()) {
				String phoneTrama = responseJSON.substring(responseJSON.indexOf("["), responseJSON.indexOf("]") + 1);

				String phoneAux = phoneTrama;

				while (phoneTrama.length() == 1) {

					if (phoneAux.length() == 0) {
						break;
					} else {
						if (phoneAux.indexOf("{") != -1) {
							String aux = phoneAux.substring(phoneAux.indexOf("{"), phoneAux.indexOf("}") + 1);

							telefono.add((PhoneDataResponse) util.deserialize(aux, PhoneDataResponse.class));
							if (phoneAux.length() > aux.length() + 1)
								phoneAux = phoneAux.substring(aux.length() + 1);
							else
								break;
						} else
							break;
					}

				}
				System.out.println("# Telefono: " + telefono.size());
				System.out.println("---Telefono 1---");
				System.out.println("Id Cliente: " + telefono.get(0).getEntity());
				System.out.println("Id Codigo: " + telefono.get(0).getAddress());
			}
			Assert.assertNotNull(serviceResponse);
			Assert.assertEquals(true, serviceResponse.isResult());
			// Assert.assertSame(AddressDataResponse.class,telefono.get(0).getClass());
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
