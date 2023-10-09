package com.cobiscorp.ecobis.fpm.catalogs.service.impl;

import java.util.List;

import org.junit.Before;
import org.junit.Ignore;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.util.Assert;

import com.cobiscorp.cobisv.commons.context.CobisContext;
import com.cobiscorp.cobisv.commons.context.CobisSession;
import com.cobiscorp.cobisv.commons.context.ContextRepository;
import com.cobiscorp.cobisv.commons.context.Server;
import com.cobiscorp.ecobis.fpm.bo.Catalog;
import com.cobiscorp.ecobis.fpm.catalogs.service.ICatalogManager;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class CatalogManagerTest {

	@Autowired
	private ICatalogManager service;

	@Before
	public void init() throws Exception {
		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Test
	public void testGetCatalogsByName() {
		List<Catalog> catalogs = service.getCatalogsByName("cl_sexo");		
		Assert.notNull(catalogs);
	}

	@Test
	public void testGetAllCurrencies() {
		List<Catalog> catalogs = service.getAllCurrencies();		
		Assert.notNull(catalogs);
	}

	@Test
	public void testGetCatalog() {
		Catalog catalog = service.getCatalog("cl_sector_neg", "COMR");		
		Assert.notNull(catalog);
	}

	@Test
	public void testManageCatalogTest() {
		Catalog newCatalog = new Catalog("NEW", "NEW CATALOG");
		service.createCatalog("ca_toperacion", newCatalog);
		Catalog catalogInsert = service.getCatalog("ca_toperacion", "NEW");
		Assert.notNull(catalogInsert, "Catálogo ha sido creado");
		service.deleteCatalog("ca_toperacion", newCatalog);		
	}

}
