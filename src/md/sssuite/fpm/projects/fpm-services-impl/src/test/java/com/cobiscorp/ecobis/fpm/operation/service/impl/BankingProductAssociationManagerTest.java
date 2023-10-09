package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.List;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.ecobis.fpm.administration.service.IServiceTransactionManager;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.ServTranBankingProduct;
import com.cobiscorp.ecobis.fpm.model.ServiceTransaction;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductAssociationManager;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })

public class BankingProductAssociationManagerTest {
	@Autowired
	private IBankingProductAssociationManager service;
	@Autowired
	private IServiceTransactionManager servTrans;
	@Autowired
	private IBankingProductManager servBanking;
		
	
	@Test
	public void getTransactionsByBankingProductTest(){
		List<ServTranBankingProduct> tbp= service.getTransactionsByBankingProduct("pruebas1");		
		Assert.assertNotNull("No existen transacciones relacionadas al producto", tbp);
		tbp.toString();
	}
	
	@Test
	public void insertServTranBankingProductTest(){		
		ServiceTransaction st = servTrans.getInformationServiceTransactionById("Dep");
		BankingProduct bp = servBanking.getBankingProductById("pruebas1");
		ServTranBankingProduct stbp=new ServTranBankingProduct();
		stbp.setServicesTransactions(st);
		stbp.setBankingProduct(bp);		
		service.insertServTranBankingProduct(stbp);		
	}
	@Test
	public void deleteServTranBankingProductTest() {
		ServiceTransaction st = servTrans.getInformationServiceTransactionById("Dep");
		BankingProduct bp = servBanking.getBankingProductById("pruebas2");
		ServTranBankingProduct stbp=new ServTranBankingProduct();
		stbp.setServicesTransactions(st);
		stbp.setBankingProduct(bp);		
		service.deleteServTranBankingProduct(stbp);
	}
	
	@Test
	public void deleteServTranBankingProductByIdTest() {
		ServiceTransaction st = servTrans.getInformationServiceTransactionById("Dep");
		BankingProduct bp = servBanking.getBankingProductById("pruebas2");
		ServTranBankingProduct stbp=new ServTranBankingProduct();
		stbp.setServicesTransactions(st);
		stbp.setBankingProduct(bp);		
		service.deleteServTranBankingProductById(stbp.getSbp_id());
	}

}
