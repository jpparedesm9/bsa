package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.AddressDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;

public class GetAddressesbyCustomerTest {
	private UtilClientTest util = null;

	// private static ILogger logger =
	// LogFactory.getLogger(executeTransaferFundsTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// System.out.println("LOGIN CTS: "+util.doLogin());
		util.doLogin();
	}

	// @Ignore
	@Test
	public void getAddress() {
		try {
			CustomerDataRequest request = new CustomerDataRequest();
			List<AddressDataResponse> direcciones = new ArrayList<AddressDataResponse>();

			request.setCustomerId(76);

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("AddressTxService/executeGetAddress", requestJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);

			// SI MI SERVICERESPONSE FUE OK DESERIALIZO EL CONTENIDO DEL DATA
			if (serviceResponse.isResult()) {
				String addressTrama = responseJSON.substring(responseJSON.indexOf("["), responseJSON.indexOf("]") + 1);

				String addressAux = addressTrama;

				while (addressTrama.length() == 1) {// estaba esto 1==1

					// DESCOMPONGO LA LISTA DE DIRECCIONES
					if (addressAux.length() == 0) {
						break;
					} else {
						if (addressAux.indexOf("{") != -1) {
							String aux = addressAux.substring(addressAux.indexOf("{"), addressAux.indexOf("}") + 1);

							// DESERIALIZO EL CONTENIDO EN UN
							// ADDRESSDATARESPONSE
							direcciones.add((AddressDataResponse) util.deserialize(aux, AddressDataResponse.class));

							if (addressAux.length() > aux.length() + 1)
								addressAux = addressAux.substring(aux.length() + 2);
							else
								break;

						} else
							break;
					}
				}
				System.out.println("# Direcciones: " + direcciones.size());
				System.out.println("---Direccion 1---");
				System.out.println("Id Direccion: " + direcciones.get(0).getAddressId());
				System.out.println("Direccion: " + direcciones.get(0).getDescription());

			}

			Assert.assertNotNull(serviceResponse);
			Assert.assertEquals(true, serviceResponse.isResult());
			// Assert.assertSame(AddressDataResponse.class,direcciones.get(0).getClass());
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
