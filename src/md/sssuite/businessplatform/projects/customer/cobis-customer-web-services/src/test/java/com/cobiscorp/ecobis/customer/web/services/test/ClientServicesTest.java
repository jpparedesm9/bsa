package com.cobiscorp.ecobis.customer.web.services.test;

import java.math.BigDecimal;
import java.util.Date;
import java.util.LinkedHashMap;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;
import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public class ClientServicesTest {
	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		System.out.println("LOGIN CTS: " + util.doLogin());
	}

	@Test
	// @Ignore
	public void createClient() {
		try {
			System.out.println("CL_CLIENTE");
			ProductDetailDTO productDetail = setProduct();
			String requestJSONPro = util.serializeJson(productDetail);
			String responseJSONPro = util.sendHttpPut("ProductDetailService/createProductDetail", requestJSONPro);
			ServiceResponse serviceResponseProduct = util.deserializeServiceResponse(responseJSONPro);
			LinkedHashMap lhm = (LinkedHashMap) serviceResponseProduct.getData();
			productDetail.setCode((Integer) lhm.get("code"));

			System.out.println("CODIGO PROD: " + productDetail.getCode());

			ClientDTO request = new ClientDTO();
			request.setClient(1);
			request.setRole("T");
			request.setIdentification("1120021255");
			request.setProductDetail(productDetail);
			request.setDate(new Date());
			String requestJSON = util.serializeJson(request);
			System.out.println("TRAMA ENVIADA: " + requestJSON);
			String responseJSON = util.sendHttpPut("ClientService/createClient", requestJSON);

			System.out.println("TRAMA RECIBIDA: " + responseJSON);
			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);
		} catch (Throwable ex) {
			System.out.println("Error al registrar la prueba");
			System.out.println("error:" + ex);
			Assert.assertTrue(false);
		}

	}

	public ProductDetailDTO setProduct() {
		ProductDetailDTO request = new ProductDetailDTO();
		request.setAccount("1112000012213");
		request.setAccountOfficer(102);
		request.setAmount(new BigDecimal(10500));
		request.setClient(1);
		request.setCurrency(1);
		request.setDate(new Date());
		request.setDescription("REGISTRO DE PRUEBA PRODUCT DETAIL SERVICE CLIENTE 1");
		request.setOffice(1);
		request.setProduct(3);
		request.setSubsidiary(1);
		request.setType("R");
		request.setStatus("V");
		request.setComment("CUENTA CORRIENTE PRUEBA SERVICE CLIENT");
		return request;
	}

	@After
	public void tearDown() {

	}

}
