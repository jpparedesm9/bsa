package com.cobiscorp.ecobis.customer.web.services.test;

import java.math.BigDecimal;
import java.util.Date;

import junit.framework.Assert;

import org.junit.After;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;

import com.cobiscorp.cobis.web.services.commons.model.ServiceResponse;
import com.cobiscorp.cobis.web.services.commons.utils.UtilClientTest;
import com.cobiscorp.ecobis.customer.services.dtos.ProductDetailDTO;

public class ProductDetailTest {
	private UtilClientTest util = null;

	@Before
	public void setUp() {
		util = new UtilClientTest();
		System.out.println("LOGIN CTS: " + util.doLogin());
	}


	@Ignore
	public void createProductDetail() {
		try {
			System.out.println("DET PRODUCTO");
			ProductDetailDTO request = new ProductDetailDTO();
			request.setAccount("1112000012212");
			request.setAccountOfficer(102);
			request.setAmount(new BigDecimal(10500));
			request.setClient(1);
			request.setCurrency(1);
			request.setDate(new Date());
			request.setDescription("REGISTRO DE PRUEBA PRODUCT DETAIL SERVICE");
			request.setOffice(1);
			request.setProduct(3);
			request.setSubsidiary(1);
			request.setType("R");
			request.setStatus("V");
			request.setComment("CUENTA CORRIENTE PRUEBA SERVICE");
			String requestJSON = util.serializeJson(request);
			String responseJSON = util.sendHttpPut("ProductDetailService/createProductDetail", requestJSON);

			System.out.println("TRAMA RECIBIDA: " + responseJSON);
			ServiceResponse serviceResponse = util.deserializeServiceResponse(responseJSON);
			Assert.assertNotNull(serviceResponse);
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
