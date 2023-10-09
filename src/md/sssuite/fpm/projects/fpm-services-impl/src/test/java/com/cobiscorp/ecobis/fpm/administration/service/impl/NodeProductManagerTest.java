package com.cobiscorp.ecobis.fpm.administration.service.impl;

import java.util.List;

import junit.framework.Assert;

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
import com.cobiscorp.ecobis.fpm.administration.service.INodeProductManager;
import com.cobiscorp.ecobis.fpm.model.NodeTypeCategory;
import com.cobiscorp.ecobis.fpm.operation.service.IBankingProductManager;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class NodeProductManagerTest {
	@Autowired
	private INodeProductManager nodeProductService;
	@Autowired
	private IBankingProductManager bankingService;
	@Autowired


	@Before
	public void init() throws Exception {

		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", ""));
		ContextRepository.setContext(context);
	}

	@Test
	public void testgetCategoriesByGroup()
	{
		List<NodeTypeCategory> categoryList = nodeProductService.getCategoriesByGroup(3l);
		Assert.assertNotNull(categoryList);
	
	}
}
	
