package com.cobiscorp.ecobis.fpm.administration.service.impl;

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
import com.cobiscorp.ecobis.fpm.administration.service.ICompanyManager;
import com.cobiscorp.ecobis.fpm.model.Company;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class CompanyManagerTest {

	@Autowired
	private ICompanyManager companyManager;
	
	private static long companyId;
	
	@Before
	public void init() throws Exception {

		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", ""));
		ContextRepository.setContext(context);
	}

	@Test
	public void testCreateCompany() {
		companyId = companyManager.createCompany("Test company", -1l, "Description");		
		Assert.assertNotSame(0l, companyId);
	}
	
	@Test
	public void testGetCompanyById() {		
		Company company = companyManager.getCompanyById(companyId);		
		Assert.assertNotNull(company);		
	}

	@Test
	public void testGetAllCompanies() {
		List<Company> companies = companyManager.getAllCompanies();
		Assert.assertNotSame(companies.size(), 0) ;
	}	
	
	@Test
	public void testUpdateCompany() {
		Company company = new Company();
		company.setId(companyId);
		company.setDescription("Change description");
		companyManager.updateCompany(company);
	}
	
	@Test
	public void testDeleteCompany() {
		long newCompany = companyManager.createCompany("Test company", companyId, "Description");
		companyManager.deleteCompany(newCompany);
	}
}
