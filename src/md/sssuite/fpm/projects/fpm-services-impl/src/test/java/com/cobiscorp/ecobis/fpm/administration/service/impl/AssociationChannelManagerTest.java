package com.cobiscorp.ecobis.fpm.administration.service.impl;


import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.administration.service.IAssociationChannelManager;
import com.cobiscorp.ecobis.fpm.administration.service.IAssociationTransactionManager;
import com.cobiscorp.ecobis.fpm.administration.service.IPaymentTypeFieldsManager;
import com.cobiscorp.ecobis.fpm.model.ChannelPaymentBase;
import com.cobiscorp.ecobis.fpm.model.PaymentType;
import com.cobiscorp.ecobis.fpm.model.TransactionChannelBase;
@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml", "/META-INF/spring/test-cts-persistence-context.xml", "/META-INF/spring/test-cts-tx-context.xml" })
public class AssociationChannelManagerTest {

	@Autowired
	private IAssociationChannelManager associationChannelManager;
	@Autowired
	private IAssociationTransactionManager associationTransactionManager;
	@Autowired
	private IPaymentTypeFieldsManager paymentTypeFieldsManager;

	@Test
	public void deleteTransactionChannelBaseTest() {
		Boolean respuesta = associationChannelManager.deleteChannelPaymentBase((long) 1);
		Assert.assertTrue(respuesta);
		System.out.println("***************************************\nEXITO AL BORRAR\n***************************************");
	}
	
	@Test
	public void insertTransactionChannelBaseTest() {
		ChannelPaymentBase transactionChannelBase = new ChannelPaymentBase();
		List<TransactionChannelBase> rspTCB = associationTransactionManager.getTransactionChannelBaseByServicetransactionId("Dep2", (long) 5502);
		transactionChannelBase.setTransactionChannelBase(rspTCB.get(0));
		PaymentType ptf = paymentTypeFieldsManager.getPaymentTypeById("NDAHO");
		transactionChannelBase.setPaymentType(ptf);
		Long respuesta = associationChannelManager.insertChannelPaymentBase(transactionChannelBase);
		Assert.assertTrue(respuesta > 0);
		System.out.println("***************************************\nEXITO AL INSERTAR\n***************************************");
	}

	@Test
	public void getInformationServiceTransactionByIdTest() {
		System.out.println("***************************************");
		List<ChannelPaymentBase> respuesta = associationChannelManager.getByTransactionChannelBaseId((long) 2);
		for (ChannelPaymentBase iterator : respuesta) {
			System.out.println(iterator);
		}
		System.out.println("***************************************");
	}

}
