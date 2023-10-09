package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.ArrayList;
import java.util.List;

import junit.framework.Assert;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.IdCustomerDataResponse;

public class IdCustomerTest {
	private UtilClientTest util = null;
	private static ILogger logger = LogFactory.getLogger(IdCustomerTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Ignore
	@Test
	public void getIdCustomer() {
		logger.logInfo("in to IdCustomerTest");
		try {
			List<IdCustomerDataResponse> idCustomers = new ArrayList<IdCustomerDataResponse>();
			IdCustomerDataResponse request = new IdCustomerDataResponse();
			// request.setCustomerId(52);
			// request.setCode("1.1");
			// request.setDescription("PERSONA FISICA NACIONAL");
			// request.setMask(" 0#-####-####");
			request.setTypePerson("P");
			// request.setProvince("N");
			request.setAperquick("S");
			// request.setBlocks("N");
			// request.setNationality(" ");
			// request.setDigit("N");

			System.out.println("Tipo de Persona" + request.getTypePerson());

			System.out.println("Apertura" + request.getAperquick());

			// System.out.println("Customer Id" + request.getCustomerId());

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("IdCustomerTxService/executeIdCustomer", requestJSON);
			System.out.println("TRAMA2:" + responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);

			/*
			 * ServiceResponse serviceResponse1 =
			 * util.deserializeServiceResponseForTestOnly(responseJSON,
			 * IdCustomerDataResponse.class); IdCustomerDataResponse
			 * customer=(IdCustomerDataResponse)serviceResponse1.getData();
			 * 
			 * 
			 * System.out.println("Code" + customer.getCode());
			 * System.out.println("Descripcion" + customer.getDescription());
			 * System.out.println("Mascara" + customer.getMask());
			 * 
			 * Assert.assertNotNull(serviceResponse);
			 * logger.logDebug(serviceResponse);
			 * 
			 * logger.logDebug(serviceResponse1);
			 * 
			 * 
			 * Assert.assertEquals(true, serviceResponse.isResult());
			 */

			if (serviceResponse.isResult()) {
				String idCustomerTrama = responseJSON.substring(responseJSON.indexOf("["), responseJSON.indexOf("]") + 1);
				System.out.println("id trama: " + idCustomerTrama);
				String idCustomerAux = idCustomerTrama;
				while (idCustomerTrama.length() == 1) {// 1==1

					// DESCOMPONGO LA LISTA DE DIRECCIONES
					if (idCustomerAux.length() == 0) {
						break;
					} else {
						if (idCustomerAux.indexOf("{") != -1) {
							String aux = idCustomerAux.substring(idCustomerAux.indexOf("{"), idCustomerAux.indexOf("}") + 1);
							// System.out.println("id trama aux: "+aux);ESTE
							// System.out.println("idCustomerAux: "+idCustomerAux);ESTE
							// DESERIALIZO EL CONTENIDO EN UN
							// ADDRESSDATARESPONSE
							idCustomers.add((IdCustomerDataResponse) util.deserialize(aux, IdCustomerDataResponse.class));
							// System.out.println("idCustomerAux.length(): "+idCustomerAux.length());ESTE
							// System.out.println("aux.length(): "+aux.length()+1);ESTE

							if (idCustomerAux.length() > aux.length() + 1)
								idCustomerAux = idCustomerAux.substring(aux.length() + 2);
							else
								break;
						} else
							break;
					}
				}
				System.out.println("# idCustomers: " + idCustomers.size());
				System.out.println("---idCustomer 1---");
				System.out.println("Mascara 1: " + idCustomers.get(0).getMask());
				System.out.println("---idCustomer 2---");
				System.out.println("Mascara 2: " + idCustomers.get(1).getMask());
				System.out.println("---idCustomer 3---");
				System.out.println("Mascara 3: " + idCustomers.get(2).getMask());

			}

		} catch (Throwable ex) {
			// logger.logError("error:" + ex);
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

}
