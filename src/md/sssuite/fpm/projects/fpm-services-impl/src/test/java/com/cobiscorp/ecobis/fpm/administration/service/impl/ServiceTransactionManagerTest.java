package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.administration.service.IServiceTransactionManager;
import com.cobiscorp.ecobis.fpm.model.ServiceTransaction;
import com.cobiscorp.ecobis.fpm.model.ServiceTransactionId;
@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class ServiceTransactionManagerTest {
	@Autowired
	private IServiceTransactionManager service;

	
	@Test
	public void getInformationServiceTransactionByProductCategory() {

		List<ServiceTransaction> st = service
				.getInformationServiceTransactionByProductCategory(3100l);
		Assert.assertNotNull("No existen transacciones", st);
		st.toString();

	}
	@Test
	public void insertServiceTransactionTest(){
		ServiceTransaction st = new ServiceTransaction();
		st.setServicesTransactionsId(new ServiceTransactionId("RET", 3100l));
		st.setNombre("Retiro");
		st.setDescription("Retiro Completo");
		st.setType("T");
		st.setStatus("V");
		service.insertServiceTransaction(st);
		
	}
	
	@Test
	public void getInformationServiceTransactionByIdTest(){
		ServiceTransaction st = new ServiceTransaction();
		st = service.getInformationServiceTransactionById("Dep");
		Assert.assertNotNull("No existe la transaccion",st);
		st.toString();
	}
	
}
