package com.cobiscorp.ecobis.fpm.operation.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
import com.cobiscorp.ecobis.fpm.bo.GeneralParameterValueLog;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValues;
import com.cobiscorp.ecobis.fpm.model.GeneralParametersValuesHistory;
import com.cobiscorp.ecobis.fpm.operation.service.IGeneralParametersManager;
import com.cobiscorp.ecobis.fpm.service.commons.Constants;

@Ignore
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "/META-INF/spring/cts-context.xml",
		"/META-INF/spring/test-cts-persistence-context.xml",
		"/META-INF/spring/test-cts-tx-context.xml" })
public class GeneralParametersManagerTest {
	@Autowired
	private IGeneralParametersManager service;
	


	@Before
	public void init() throws Exception {
		String id = "1";
		CobisContext context = new CobisContext(new CobisSession(id, "b1",
				"c1", "ci1", "o1", id, "1", "t1", "s1", "1"), new Server("1",
				"s1", "04/26/2006"));
		ContextRepository.setContext(context);
	}

	@Ignore
	public void testGetChanges() {
		Map<String, List<GeneralParameterValueLog>> changes = service
				.getValuesChanges("ML");
		for (String key : changes.keySet()) {
			System.out.println(changes.get(key));
		}
		Assert.assertSame(true, changes.containsKey(Constants.BEFORE_VALUE));
		Assert.assertSame(true, changes.containsKey(Constants.AFTER_VALUE));
	}
	
	@Test
	public void testGetDate() throws ParseException {
		// Convert to date

		Date operationDate = new SimpleDateFormat("MM/dd/yyyy")
				.parse("05/08/2012 10:41:23.580");

		Date dateBankingProduct = service.getDateHistory(operationDate, "ML");

		// Assert.assertNotNull(dateBankingProduct);

	}
	
	@Test
	public void testGetValuesByBankingProduct() {
		List<GeneralParametersValues> gpvList = service
				.getValuesByBankingProduct("VL");
		Assert.assertNotNull(gpvList);
	}
	
	@Test
	public void testGetGeneralParameterValuesDescrption() {
		List<GeneralParametersValuesHistory> gphList = service.findGeneralParameterValuesDescription("ML", "Class Operation");
		System.out.println("size"+gphList.size());
		for(GeneralParametersValuesHistory gpvh : gphList){
			System.out.println("values"+gpvh.toString());
		}
		Assert.assertNotNull(gphList);
	}

}
