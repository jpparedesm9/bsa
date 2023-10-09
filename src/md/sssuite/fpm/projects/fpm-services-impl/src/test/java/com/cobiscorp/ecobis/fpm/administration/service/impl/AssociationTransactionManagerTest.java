package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.administration.service.IAssociationTransactionManager;
import com.cobiscorp.ecobis.fpm.administration.service.IServiceTransactionManager;
import com.cobiscorp.ecobis.fpm.model.ServiceTransaction;
import com.cobiscorp.ecobis.fpm.model.TransactionChannelBase;
@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml", "/META-INF/spring/test-cts-persistence-context.xml", "/META-INF/spring/test-cts-tx-context.xml" })
public class AssociationTransactionManagerTest {

	@Autowired
	private IAssociationTransactionManager associationTransactionManager;
	@Autowired
	private IServiceTransactionManager service;

	@Test
	public void deleteTransactionChannelBaseTest() {
		Boolean respuesta = associationTransactionManager.deleteTransactionChannelBase((long) 1);
		Assert.assertTrue(respuesta);
	}

	@Test
	public void insertTransactionChannelBaseTest() {
		TransactionChannelBase transactionChannelBase = new TransactionChannelBase();
		ServiceTransaction st = new ServiceTransaction();
		st = service.getInformationServiceTransactionById("Dep");
		transactionChannelBase.setServiceTransaction(st);
		transactionChannelBase.setChannel("ATM");
		Long respuesta = associationTransactionManager.insertTransactionChannelBase(transactionChannelBase);
		Assert.assertTrue(respuesta > 0);
	}

	@Test
	public void getInformationServiceTransactionByIdTest() {
		List<TransactionChannelBase> respuesta = associationTransactionManager.getTransactionChannelBaseByServicetransactionId("Dep2", (long) 5502);
		System.out.println("***************************************");
		System.out.println(respuesta);
		System.out.println("***************************************");
		Assert.assertNotNull(respuesta);
	}
	
}
