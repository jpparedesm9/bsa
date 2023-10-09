package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.junit.Assert;
import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.cobisv.commons.exceptions.BusinessException;
import com.cobiscorp.ecobis.fpm.administration.service.ICompanyManager;
import com.cobiscorp.ecobis.fpm.bo.CheckBankingProductConfiguration;
import com.cobiscorp.ecobis.fpm.model.Authorization;
import com.cobiscorp.ecobis.fpm.model.BankingProduct;
import com.cobiscorp.ecobis.fpm.model.BankingProductHistory;
import com.cobiscorp.ecobis.fpm.model.Company;
import com.cobiscorp.ecobis.fpm.model.CurrencyProduct;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.model.PolicyProduct;
import com.cobiscorp.ecobis.fpm.model.ProductProcess;
import com.cobiscorp.ecobis.fpm.model.ProductRule;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class BankingProductManagerTest {
	@Autowired
	private IBankingProductManager service;
	@Autowired
	private ICompanyManager companyService;

	@Before
	public void init() throws Exception {
		String id = "154654614365";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}
	
	@Test
	public void testGetBankingProductById() {
		BankingProduct bp = service.getBankingProductById("ML");
		Assert.assertNotNull(bp);
	}

	@Test
	public void testGetBankinProductsStructure() {
		List<BankingProduct> products = service.getBankinProductsStructure();
		Assert.assertNotNull(products);
		Assert.assertSame(false, products.isEmpty());
	}

	@Test
	public void getBankinProductsApprovedStructureTest() {
		List<BankingProduct> products = service
				.getBankinProductsApprovedStructure();
		Assert.assertNotNull(products);
		Assert.assertNotSame(products.size(), 0);
	}
	@Test
	public void testCreateBankingProductHistory() {

		BankingProductHistory bankingProductHistory = new BankingProductHistory();
	//	bankingProductHistory=service.getLatestHistorical("ML");
		//bankingProductHistory.setId(2000);
		bankingProductHistory.setSystemDateId(new Date());
		bankingProductHistory.setProductId("ML");

		Long id = service.createBankingProductHistory(bankingProductHistory,
				Constants.CATALOGS.AUTHORIZATION_STATUS_CATALOG.APRROVED);
	}

	@Test
	public void testCreateBankingProduct() {
		long companyId = 0;
		try {
			BankingProduct bpRoot = service
					.getBankingProductBasicInformationById(Constants.ROOT_BANKING_PRODUCT_ID);
			companyId = bpRoot.getCompany().getId();
		} catch (BusinessException e) {
			// create the root product
			companyId = companyService.createCompany("Principal", -1l,
					"Principal descripción");
			Assert.assertNotSame(companyId, 0);
		}
		// create the product second level
		BankingProduct bp = new BankingProduct();
		NodeTypeCategory category = new NodeTypeCategory();
		category.setId(200);
		Company company = new Company();
		company.setId(companyId);
		bp.setId("PRODUCT2");
		bp.setName("PRODUCT 2");
		bp.setParentnode(Constants.ROOT_BANKING_PRODUCT_ID);
		bp.setNodeTypeCategory(category);
		bp.setCompany(company);
		service.createBankingProduct(bp);

		// Create the third level
		bp = new BankingProduct();
		category.setId(300);
		bp.setId("PRODUCT3");
		bp.setName("PRODUCT 3");
		bp.setParentnode("PRODUCT2");
		bp.setNodeTypeCategory(category);
		bp.setCompany(company);
		service.createBankingProduct(bp);

		// Create the fourth level
		bp = new BankingProduct();
		category.setId(400);
		bp.setId("PRODUCT4");
		bp.setName("PRODUCT 4");
		bp.setParentnode("PRODUCT3");
		bp.setNodeTypeCategory(category);
		bp.setCompany(company);
		service.createBankingProduct(bp);

		// Create the fifth level
		bp = new BankingProduct();
		category.setId(200);
		bp.setId("PRODUCT5");
		bp.setName("PRODUCT 5");
		bp.setParentnode("PRODUCT4");
		bp.setNodeTypeCategory(category);
		bp.setCompany(company);
		bp.setProcesses(new ArrayList<ProductProcess>());
		bp.setRules(new ArrayList<ProductRule>());
		bp.setAuthorization(new Authorization());
		bp.getAuthorization().setStatus(Constants.NO);
		bp.setStartDate(new Date("11/11/2011"));
		bp.setExpirationDate(new Date("11/12/2011"));
		bp.setSubstantiation("justificacion 1");	

		ProductProcess pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow1");
		pp.setProcessId("ORI");
		pp.setGeneric(Constants.YES);
		bp.getProcesses().add(pp);
		pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow2");
		pp.setProcessId("REF");
		pp.setGeneric(Constants.NO);
		bp.getProcesses().add(pp);
		pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow3");
		pp.setProcessId("RES");
		pp.setGeneric(Constants.YES);
		bp.getProcesses().add(pp);
		service.createBankingProduct(bp);

		// Find the create product
		BankingProduct bpf = service
				.getBankingProductBasicInformationById("PRODUCT5");
		// Assert that is the same that was created
		Assert.assertEquals(bp, bpf);
		
		testGetRelatedProcessByProduct();
		testManageCurrenciesByBankingProduct();
		testUpdateBankingProductInformation();
	}


	@Test
	public void testGetCategoryKeepDictionaryFromParents() {
		NodeTypeCategory category = service
				.getCategoryKeepDictionaryFromParents("ML");
		Assert.assertNotNull(category);
	}

	@Test
	public void getAndChangeRequestAuthorizationTest() {
		Boolean requestAuthorization = false;
		String bankingProductId = "ML";

		requestAuthorization = service
				.getRequestAuthorization(bankingProductId);
		Assert.assertFalse(requestAuthorization);

		if (!requestAuthorization) {
			service.changeRequestAuthorization(bankingProductId, true);
			service.changeProcessId(bankingProductId, "1010");
			requestAuthorization = service
					.getRequestAuthorization(bankingProductId);
			Assert.assertTrue(requestAuthorization);
		} else {
			service.changeRequestAuthorization(bankingProductId, false);
			service.changeProcessId(bankingProductId, "");
			requestAuthorization = service
					.getRequestAuthorization(bankingProductId);
			Assert.assertFalse(requestAuthorization);
		}
	}

	@Test
	public void applyChangeTest() {
		
		service.applyChange("VL");
		
	}

	@Test
	public void findChildrensForAuthorizationStateTest() {

		List<String> listOfName = service
				.findChildrensForAuthorizationState("BPROOT2");
		System.out.println(listOfName);

		List<String> listOfName2 = service
				.findChildrensForAuthorizationState("BPROOT2");
		System.out.println(listOfName2);
	}
	
	@Ignore
	public void checkCompleteBankingProductConfigurationTest() {
		CheckBankingProductConfiguration result = service
				.checkCompleteBankingProductConfiguration("ML");
		Assert.assertNotNull(result.isSuccess());		
	}
	
	@Test
	public void getProcessByProductTest() {
		List<ProductProcess> pp = service.getProcessByProduct("ML");
		System.out.println(pp);
		Assert.assertNotNull(pp);
	}

	public void testUpdateBankingProductInformation() {
		// Create the banking product to update
		BankingProduct bp = new BankingProduct();
		bp.setId("PRODUCT5");
		bp.setName("Name Changed");
		bp.setDescription("Description changed");
		bp.setStartDate(new Date("11/11/2011"));
		bp.setExpirationDate(new Date("11/12/2011"));
		bp.setSubstantiation("justificacion 2");	

		bp.setProcesses(new ArrayList<ProductProcess>());
		bp.setRules(new ArrayList<ProductRule>());

		// Update the processes
		ProductProcess pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow1ch");
		pp.setProcessId("ORI");
		pp.setGeneric(Constants.YES);
		pp.setIsNotGeneric(Constants.YES);
		pp.setCreditLine(Constants.YES);

		bp.getProcesses().add(pp);
		pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow2ch");
		pp.setProcessId("REF");
		pp.setGeneric(Constants.NO);
		bp.getProcesses().add(pp);
		pp = new ProductProcess();
		pp.setBankingProduct(bp);
		pp.setFlowId("flow3ch");
		pp.setProcessId("RES");
		pp.setGeneric(Constants.YES);
		bp.getProcesses().add(pp);
		// Update the banking product
		service.updateBankingProductInformation(bp);
		// search for the updated product
		BankingProduct bpf = service
				.getBankingProductBasicInformationById("PRODUCT5");
		// Assert the changes
		Assert.assertEquals(bpf.getName(), "Name Changed");
		Assert.assertEquals(bpf.getProcesses().get(0).getFlowId(), "flow1ch");
	}


	public void testManageCurrenciesByBankingProduct() {
		// Create a currency with one policy
		ArrayList<CurrencyProduct> currencies = new ArrayList<CurrencyProduct>();
		CurrencyProduct currency = new CurrencyProduct("PRODUCT5", "0",
				"PRODUCT3");
		currency.setOperation(Constants.INSERT_OPERATION);
		currency.setPolicyProducts(new ArrayList<PolicyProduct>());
		PolicyProduct policy = new PolicyProduct("PRODUCT3", "0", 123);
		policy.setName("Policy");
		policy.setOperation(Constants.INSERT_OPERATION);
		currency.getPolicyProducts().add(policy);
		currencies.add(currency);
		// Call the service
		service.manageCurrenciesByBankingProduct("PRODUCT5", currencies);
		// Test the creation
		List<CurrencyProduct> currenciesFounded = service
				.findAllCurrenciesAndPoliciesByProduct("PRODUCT5");
		System.out.println(currenciesFounded);
		// Test the currencies
		Assert.assertNotNull(currenciesFounded);
		Assert.assertNotSame(currenciesFounded.size(), 0);
		// Test the policies
		Assert.assertNotNull(currenciesFounded.get(0).getPolicyProducts());
		Assert.assertNotSame(currenciesFounded.get(0).getPolicyProducts()
				.size(), 0);
		// Delete a currency
		currency.setOperation(Constants.DELETE_OPERATION);
		currency.setPolicyProducts(new ArrayList<PolicyProduct>());
		currencies = new ArrayList<CurrencyProduct>();
		currencies.add(currency);
		service.manageCurrenciesByBankingProduct("PRODUCT3", currencies);
		// Test the creation
		currenciesFounded = service
				.findAllCurrenciesAndPoliciesByProduct("PRODUCT5");
		System.out.println("***Delete " + currenciesFounded);
		// Test if the service delete the currencies
		Assert.assertNotNull(currenciesFounded);
		System.out.println(currenciesFounded.size());
		Assert.assertSame(currenciesFounded.size(), 0);

		currency.setOperation(Constants.INSERT_OPERATION);
		// Call the service
		service.manageCurrenciesByBankingProduct("PRODUCT3", currencies);
		// Test the creation
		currenciesFounded = service
				.findAllCurrenciesAndPoliciesByProduct("PRODUCT5");
		System.out.println(currenciesFounded);
		// Test the currencies
		Assert.assertNotNull(currenciesFounded);
		Assert.assertNotSame(currenciesFounded.size(), 0);

	}


	public void testGetRelatedProcessByProduct() {
		// Search the related process
		List<String> process = service.getRelatedProcessByProduct("PRODUCT5");
		// Assert that exist
		Assert.assertNotNull(process);
		Assert.assertNotSame(process.size(), 0);
	}

	
	
	@Ignore
	public void testDeleteProduct() {
		service.deleteBankingProduct("SL");
	}

	@Test
	public void testfindAllBankingProductChildrenId(){
		List<BankingProduct> bpList = new ArrayList<BankingProduct>();
		bpList = service.findAllBankingProductChildrenId("CARTERA");
		Assert.assertNotNull(bpList);
	}
	
	@Test
	public void findBankingProductByModule(){
		List<BankingProduct> bpList = new ArrayList<BankingProduct>();
		bpList = service.findBankingProductByModule("CCA");
		Assert.assertNotNull(bpList);
	}


}
