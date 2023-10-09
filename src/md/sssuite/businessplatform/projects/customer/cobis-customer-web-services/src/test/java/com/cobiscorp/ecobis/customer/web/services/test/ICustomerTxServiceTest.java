package com.cobiscorp.ecobis.customer.web.services.test;

import java.util.Date;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataRequest;
import com.cobiscorp.ecobis.customer.services.dtos.CustomerDataResponse;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchRequest;
import com.cobiscorp.ecobis.customer.services.dtos.IdSearchResponse;

public class ICustomerTxServiceTest {
	private UtilClientTest util = null;
	private static ILogger logger = LogFactory.getLogger(ICustomerTxServiceTest.class);

	@Before
	public void setUp() {
		util = new UtilClientTest();
		// util.doLogin();
		System.out.println("Login: " + util.doLogin());
	}

	@Ignore
	@Test
	public void getCustomerDetails() {
		try {
			CustomerDataRequest request = new CustomerDataRequest();
			request.setCustomerId(52);
			System.out.println("Customer Id" + request.getCustomerId());

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("CustomerTxService/getCustomerDetails", requestJSON);
			System.out.println("TRAMA:" + responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);

			ServiceResponse serviceResponse1 = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
			CustomerDataResponse customer = (CustomerDataResponse) serviceResponse1.getData();
			System.out.println("Cliente: " + customer.getCustomerID());
			System.out.println("Cliente: " + customer.getCustomerName());
			System.out.println("Cliente: " + customer.getCustomerIdentification());
			Assert.assertNotNull(serviceResponse);
			logger.logDebug(serviceResponse);

			logger.logDebug(serviceResponse1);

			Assert.assertEquals(true, serviceResponse.isResult());

		} catch (Throwable ex) {
			// logger.logError("error:" + ex);
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@Ignore
	@Test
	public void getCustomerAllData() {
		try {
			System.out.println("BUSQUEDA GENERAL DE CLIENTES");
			CustomerDataRequest request = new CustomerDataRequest();
			request.setCustomerId(16);

			System.out.println("Customer Id: " + request.getCustomerId());

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("CustomerTxService/getCustomerAllData", requestJSON);
			// System.out.println("TRAMA DEVUELTA:"+responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
			Assert.assertNotNull(serviceResponse);
			CustomerDataResponse customer = (CustomerDataResponse) serviceResponse.getData();
			System.out.println("Id: " + customer.getCustomerID());
			System.out.println("Nombre: " + customer.getCustomerCompleteName());
			System.out.println("Fecha Creacion: " + customer.getCustomerCreatedDate());
			System.out.println("Estado: " + customer.getCustomerStatus());

			Assert.assertEquals(true, serviceResponse.isResult());

		} catch (Throwable ex) {
			// logger.logError("error:" + ex);
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@Ignore
	@Test
	public void getSearchById() {
		try {
			System.out.println("BUSQUEDA DE ID -EXISTE O NO");
			IdSearchRequest request = new IdSearchRequest();
			request.setIdentification("0980447642");// "78675647564666664");
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

	// @Ignore
	@Test
	public void searchCustomerNameById() {
		try {
			CustomerDataRequest request = new CustomerDataRequest();
			request.setCustomerId(77);
			System.out.println("Customer Id " + request.getCustomerId());

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("CustomerTxService/getCustomerNameById", requestJSON);
			System.out.println("TRAMA:" + responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);

			ServiceResponse serviceResponse1 = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataResponse.class);
			CustomerDataResponse customer = (CustomerDataResponse) serviceResponse1.getData();
			System.out.println("Cliente: " + customer.getCustomerID());
			System.out.println("Cliente: " + customer.getCustomerName());
			System.out.println("Cliente: " + customer.getCustomerIdentification());
			Assert.assertNotNull(serviceResponse);
			logger.logDebug(serviceResponse);

			logger.logDebug(serviceResponse1);

			Assert.assertEquals(true, serviceResponse.isResult());

		} catch (Throwable ex) {
			// logger.logError("error:" + ex);
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}
	}

	@Ignore
	@Test
	public void createCustomer() {
		try {
			System.out.println("CREACION DE CLIENTES");

			CustomerDataResponse request = new CustomerDataResponse();
			/*
			 * request.setCustomerTypeDocumentId("1.1");
			 * request.setCustomerIdentification("0909090909");
			 * request.setCustomerCompleteName("AB CD EF GH");
			 * request.setCustomerName("AB CD EF GH");
			 * request.setCustomerSubType("SUBTIPO");
			 * request.setCustomerTypePersonId("N");
			 * request.setCustomerSector("SECTOR");
			 * request.setCustomerAffiliate("S"); request.setCustomerOffice(1);
			 * request.setCustomerCreatedDate("30/09/2014");
			 * request.setCustomerModifiedDate("01/10/2014");
			 * request.setCustomerAddress(9); request.setCustomerReference(1);
			 * request.setCustomerBoxDef(1); request.setCustomerTypeDp("Dp");
			 * request.setCustomerBalance(1); request.setCustomerGroup(1);
			 * request.setCustomerCountry(1); request.setCustomerOffice(1);
			 * request.setCustomerOfficial(1);
			 * request.setCustomerActivity("Activity");
			 * request.setCustomerRetention("Retention");
			 * request.setCustomerBadReference("N");
			 * request.setCustomerBadNumber(1);
			 * request.setCustomerSex("MASCULINO");
			 * request.setCustomerBirthDate("01/01/1995");
			 * request.setCustomerProfession("INGENIERO");
			 * request.setCustomerPassport("0101010101");
			 * request.setCustomerMaritalStatus("Soltero");
			 * request.setCustomerFirstName("AB");
			 * request.setCustomerAdditionalLastName("EF");
			 * request.setCustomerSexCode(1);
			 * request.setCustomerDateCharge("3");
			 * request.setCustomerDescription("NUEVO CLIENTE");
			 * request.setCustomerCodelec("Codelec");
			 * request.setCustomerBoard("Board");
			 * request.setCustomerNationality(10);
			 * request.setCustomerSexType("2");
			 * request.setCustomerBusinessName("CMB");
			 * 
			 * request.setCustomerBurdenNumber(1);
			 * request.setCustomerChildrenNumber(3);
			 * //request.setCustomerEntry(2); request.setCustomerExpense(3);
			 * request.setCustomerStudyLevel("");
			 * request.setCustomerHouseType("");
			 * request.setCustomerPersonType("");
			 * request.setCustomerpropiedad(); request.setCustomerJob();
			 * request.setCustomerIssueDate("");
			 * request.setCustomerExpirationDate("");
			 * request.setCustomerAssociated("");
			 * request.setCustomerSituation("");
			 * request.setCustomerPatrimonyTec();
			 * request.setCustomerPatrimonyDate("");
			 * request.setCustomerEntailment("");
			 * request.setCustomerEntailmentType("");
			 * request.setCustomerOfficialSubstitute();
			 * request.setCustomerIsClient(""); request.setCustomerPreferen("");
			 * request.setCustomerEmploymentStatus("");
			 * request.setCustomerNationality();
			 * request.setCustomerTutorType("");
			 * request.setCustomerTutorName("");
			 * request.setCustomerOtherEntries("");
			 * request.setCustomerEntriesSource("");
			 */
			request.setCustomerFirstName("JOEL"); // 13 primer nombre
			// request.setCustomerMiddleName("AMPARO"); //14 segundo nombre
			request.setCustomerLastName("TURNNER"); // 15 apellido
			request.setCustomerSecondLastName("GUSNAY");
			request.setCustomerSex("F");
			// Date fecha = new Date();"Tue Jan 01 00:00:00 COT 1985",
			request.setBirthDate(new Date());
			// request.setCustomerBirthDate("Tue Jan 01 00:00:00 COT 1985");
			request.setCustomerTypeDocumentId("68.1"); // 4 tipo de documento
			request.setCustomerIdentification("0909098932"); // 5 numero de
																// identificacion
			request.setCustomerNationality(68);
			// request.setCustomerTutorName("JONATHAN"); //45 nombre de tutor
			request.setCustomerCategory("1");
			request.setCustomerStudyLevel("2"); // 25 nivel de estudio
			request.setCustomerHouseType("ALQ");
			request.setCustomerProfession("001");
			request.setCustomerMaritalStatus("CA");
			request.setCustomerChildrenNumber(2);
			request.setCustomerMonthlyIncome(1);
			request.setCustomerTypePersonId("1");
			request.setCustomerOfficial(1); // 65 oficial principal -MODAL
			request.setCustomerOfficialSubstitute(777); // 66 oficial suplente
														// -MODAL
			request.setCustomerPassport("0909098932");
			request.setCustomerRetention("N");
			request.setCustomerStatus("V");
			/*
			 * request.setCustomerManagementBranch(1); //1 sucursal de gestion
			 * //2 estado inicial del cliente -CATALOGO
			 * request.setCustomerUnderAge("N"); //9 minor de edad
			 * request.setCustomerExpirationDate("01/12/2014"); //10 fecha de
			 * expiracion //12 estado civil
			 * request.setCustomerAdditionalLastName("CHILIQUINGA"); //17
			 * apellido casada request.setCustomerCountry(68); //21 pais -
			 * lugarde nacimiento -CATALOGO
			 * 
			 * //27 tipo cliente-persona
			 * 
			 * //28 dependientes request.setCustomerNStaff(1); //31 planilla
			 * request.setCustomerCodRisk("1"); //32 codigo risk
			 * request.setCustomerIdCheck("1"); //33 validacion id check //36
			 * retencion por impuesto request.setCustomerReference(1); //37
			 * referido por -MODAL
			 * request.setCustomerInstitutionRelationship("1"); //38 relacion
			 * con el banco -CATALOGO
			 * request.setCustomerObservationEntailment("NNNNNNNNNNNNNNN"); //39
			 * comentarios //request.setCustomerpropiedad(1); //40 promotor
			 * -CATALOGO //43 categoria del ente
			 * request.setCustomerTutorType("1"); //44 codigo de tutor
			 * 
			 * //request.setCustomerSector(null); //46 sector economico
			 * -CATALOGO //request.setCustomerActivity("1"); //47 codigo
			 * actividad del ente - CATALOGO
			 * request.setCustomerDocValidated("1"); //48 documentacion validado
			 * request.setCustomerRegistrant("S"); //49 empadronado
			 * request.setCustomerActCompKYC("N"); //51 actualizacion completa
			 * KYC request.setCustomerActKYCDate("29/10/2014"); //52 fecha de
			 * actualizacion KYC request.setCustomerReqKYCNumber("N"); //53
			 * requiere KYC request.setCustomerActProfile("N"); //54
			 * actualizacion perfil transaccional
			 * request.setCustomerActProfileDate("29/10/2014"); //55 Fecha
			 * actualizacion perfil transaccional
			 * request.setCustomerSalary("N"); //56 con salario
			 * request.setCustomerInSalaryDate("29/10/2014"); //57 fecha con
			 * salario request.setCustomerNoSalary("S"); //58 sin salario
			 * request.setCustomerOutSalaryDate("29/10/2014"); //59 fecha sin
			 * salario //63 ingresos mensuales
			 * 
			 * /* request.setCustomerBusinessLine("1"); //67 linea de negocio
			 * -CATALOGO request.setCustomerBusinessSeg("1"); //68 segmento de
			 * negocio -MODAL request.setCustomerUpdateCic("29/10/2014"); //68
			 * actualización CIC –CATALOGO
			 */

			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("CustomerTxService/createCustomer", requestJSON);
			System.out.println("TRAMA DEVUELTA:" + responseJSON);

			ServiceResponse serviceResponse = util.deserializeServiceResponseForTestOnly(responseJSON, CustomerDataRequest.class);
			// Assert.assertNotNull(serviceResponse);
			if (serviceResponse.isResult()) {
				CustomerDataRequest response = (CustomerDataRequest) serviceResponse.getData();
				System.out.println(responseJSON);
				System.out.println("Tran OK ");
				System.out.println("Id Resultado: " + response.getCustomerId());
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
