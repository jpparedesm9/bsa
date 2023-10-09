package com.cobiscorp.ecobis.clientviewer.test;

import java.util.ArrayList;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.clientviewer.admin.dal.entities.ProductAdministrator;
import com.cobiscorp.ecobis.clientviewer.admin.dto.DefaultProductAdministratorDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ManagementContentSectionRoleDTO;
import com.cobiscorp.ecobis.clientviewer.admin.dto.ProductAdministratorDTO;

@Ignore
public class AdministratorServiceTest {
	@SuppressWarnings("unused")
	private static ILogger logger = LogFactory.getLogger(RateServiceTest.class);

	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		util.doLogin();
	}

	@Test
	public void getAllRoleConfigurationVCC() {
		String responseJSON = util
				.sendHttpPut(
						"ClientViewer/AdministrationService/GetAllRoleConfigurationVCC",
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();
		for (Object object : resp2) {

			System.out.println(object.toString());

		}

		Assert.assertNotNull(serviceResponse);
		// Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void queryConfigurationVCC() {

		int productCode = 3;
		// InputClientConsultation request = new InputClientConsultation();
		// request.setClientNumber(customer);

		String requestJSONC = util.serializeJson(productCode);

		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/queryConfigurationVCC",
				requestJSONC);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();
		for (Object object : resp2) {

			System.out.println(object.toString());
		}

		Assert.assertNotNull(serviceResponse);
		// Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void updateConfigurationVCC() {

		Byte visible = 1;
		Byte encrypted = 1;
		ProductAdministratorDTO objProduct = new ProductAdministratorDTO();
		objProduct.setIdRole(3);
		objProduct.setIdProduct(23.0);
		objProduct.setVisible(visible);
		objProduct.setEncrypted(encrypted);
		objProduct.setRoleName("MENU POR PROCESOS");

		String requestJSONC = util.serializeJson(objProduct);
		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/updateConfigurationVCC",
				requestJSONC);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void insertConfigurationVCC() {
		ProductAdministrator objProduct = new ProductAdministrator();
		objProduct.setIdRole(1);
		objProduct.setRoleName("ADMINISTRADOR");

		String requestJSONC = util.serializeJson(objProduct);
		requestJSONC = "{idRole:\"1\",nameRole:\"ADMINISTRADOR\"}";
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/insertConfigurationVCC/1/ADMINSTRADOR",
						requestJSONC);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void deleteConfigurationVCC() {

		int roleCode = 1;

		String requestJSONC = util.serializeJson(roleCode);
		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/deleteConfigurationVCC",
				requestJSONC);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getAllRoleAssociates() {
		int productCode = 73;
		String requestJSONC = util.serializeJson(productCode);
		String responseJSON = util.sendHttpPut("commons/getAllRoleAssociates",
				requestJSONC);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();
		for (Object object : resp2) {

			System.out.println(object.toString());
		}

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getServicesProductAdministratorTest() {

		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/getConfigurationServicesVCC",
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		ArrayList resp2 = (ArrayList) serviceResponse.getData();
		for (Object object : resp2) {

			System.out.println(object.toString());
		}

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());

	}

	@Test
	public void deleteManagementContentSectionByIdVCC() {
		int code = 1;

		// PrepareData
		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/deleteManagementContentSectionById/"
						+ code, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void deleteManagementContentSectionRole() {
		int code = 1;
		int section = 3;

		// PrepareData
		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/deleteManagementContentSectionRole/"
						+ code + "/" + section, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void updateManagementContentSectionById() {

		ManagementContentSectionDTO mcs = new ManagementContentSectionDTO();
		mcs.setCode(1);
		mcs.setDescription("CAMBIO GVI");
		mcs.setName("NAME GVI");
		mcs.setUrlTemplate("NEW URL");

		// PrepareData
		String data = util.serializeJson(mcs);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/updateManagementContentSectionById/",
						data);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void insertManagementContentSection() {

		ManagementContentSectionDTO mcs = new ManagementContentSectionDTO();
		mcs.setCode(3);
		mcs.setDescription("CAMBIO GVI 2");
		mcs.setName("NAME GVI 2");
		mcs.setUrlTemplate("NEW URL 2");

		// PrepareData
		String data = util.serializeJson(mcs);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/insertManagementContentSection/",
						data);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void insertManagementContentSectionRole() {

		ManagementContentSectionRoleDTO mcs = new ManagementContentSectionRoleDTO();
		mcs.setIdRole(3);
		mcs.setIdManConSec(2);

		// PrepareData
		String data = util.serializeJson(mcs);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/insertManagementContentSectionRole/",
						data);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getAllManagementContentSectionRole() {

		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/getAllManagementContentSectionRole/",
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getAllManagementContentSectionVCC() {

		String responseJSON = util
				.sendHttpPut(
						"ClientViewer.Administration.GetAllManagementContentSectionVCC/",
						"");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void insertDefaultProductAdministrator() {

		DefaultProductAdministratorDTO dpa = new DefaultProductAdministratorDTO();
		dpa.setIdProduct(100.0);
		dpa.setIdDtoFk(10);
		dpa.setMnemonic("PRUEBA");
		dpa.setName("NAME ECA 1");
		dpa.setDescription("CAMBIO ECA 1");
		dpa.setParent(-1.0);
		dpa.setClientType("P");
		dpa.setOrder(1);
		// PrepareData
		String data = util.serializeJson(dpa);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/insertManagementContentSectionRole/",
						data);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void updateDefaultProductAdministratorById() {

		DefaultProductAdministratorDTO dpa = new DefaultProductAdministratorDTO();
		dpa.setIdProduct(100.0);
		dpa.setIdDtoFk(11);
		dpa.setMnemonic("PRUEBA 2");
		dpa.setName("NAME ECA 2");
		dpa.setDescription("CAMBIO ECA 2");
		dpa.setParent(-2.0);
		dpa.setClientType("C");
		dpa.setOrder(2);

		// PrepareData
		String data = util.serializeJson(dpa);
		String responseJSON = util
				.sendHttpPut(
						"clientviewer/AdministrationService/updateDefaultProductAdministratorById/",
						data);
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void deleteDefaultProductAdministratorById() {
		double code = 100.0;

		// PrepareData
		String responseJSON = util.sendHttpPut(
				"clientviewer/AdministrationService/deleteDefaultProductAdministratorById/"
						+ code, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);

		serviceResponse = util.deserializeServiceResponse(responseJSON);

		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getAllProductAdministratorDefaultDinamicByType() {
		String typeClient = "P";
		String typeClientParent = "SG";
		String responseJSON = util.sendHttpPut(
				"ClientViewer.Administration.getAllProductAdministratorDefaultDinamicByType/"
						+ typeClient + "/" + typeClientParent, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		serviceResponse = util.deserializeServiceResponse(responseJSON);
		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getProductAdministratorDefaultDinamicByParent() {
		double code = 100.0;
		String responseJSON = util.sendHttpPut(
				"ClientViewer.Administration.getProductAdministratorDefaultDinamicByParent/"
						+ code, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		serviceResponse = util.deserializeServiceResponse(responseJSON);
		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

	@Test
	public void getAllDtosByParent() {
		double code = 100.0;
		String responseJSON = util.sendHttpPut(
				"ClientViewer.Administration.getAllDtosByParent/" + code, "");
		ServiceResponse serviceResponse = util
				.deserializeServiceResponse(responseJSON);
		serviceResponse = util.deserializeServiceResponse(responseJSON);
		System.out.println("--------> " + serviceResponse.getData());

		Assert.assertNotNull(serviceResponse);
		Assert.assertEquals(true, serviceResponse.isResult());
	}

}
