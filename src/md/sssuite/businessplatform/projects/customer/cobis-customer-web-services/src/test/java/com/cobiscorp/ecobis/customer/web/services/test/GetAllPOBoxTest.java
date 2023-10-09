package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.POBoxDataResponse;

public class GetAllPOBoxTest {
	private UtilClientTest util = null;

	// private static ILogger logger =
	// LogFactory.getLogger(executeTransaferFundsTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
		System.out.println("Login: " + util.doLogin());
	}

	@Test
	public void getAddress() {
		try {
			CustomerDataRequest request = new CustomerDataRequest();
			List<POBoxDataResponse> poBoxes = new ArrayList<POBoxDataResponse>();

			request.setCustomerId(1);

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("POBoxTxService/executeGetAllPOBox", requestJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			System.out.println("Trama Respuesta: " + responseJSON);
			// SI MI SERVICERESPONSE FUE OK DESERIALIZO EL CONTENIDO DEL DATA
			if (serviceResponse.isResult()) {
				String poBoxTrama = responseJSON.substring(responseJSON.indexOf("["), responseJSON.indexOf("]") + 1);

				String poBoxAux = poBoxTrama;

				while (poBoxTrama.length() == 1) {// estaba esto 1==1

					// DESCOMPONGO LA LISTA DE DIRECCIONES
					if (poBoxAux.length() == 0) {
						break;
					} else {
						if (poBoxAux.indexOf("{") != -1) {
							String aux = poBoxAux.substring(poBoxAux.indexOf("{"), poBoxAux.indexOf("}") + 1);

							// DESERIALIZO EL CONTENIDO EN UN
							// ADDRESSDATARESPONSE
							poBoxes.add((POBoxDataResponse) util.deserialize(aux, POBoxDataResponse.class));

							if (poBoxAux.length() > aux.length() + 1)
								poBoxAux = poBoxAux.substring(aux.length() + 2);
							else
								break;

						} else
							break;
					}
				}
				System.out.println("# PO Box : " + poBoxes.size());
				System.out.println("---PO Box 1---");
				System.out.println("Casilla: " + poBoxes.get(0).getBox());
				System.out.println("Valor: " + poBoxes.get(0).getValue());
				System.out.println("---PO Box 2---");
				System.out.println("Casilla: " + poBoxes.get(1).getBox());
				System.out.println("Valor: " + poBoxes.get(1).getValue());

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
