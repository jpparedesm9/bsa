package com.cobiscorp.ecobis.customer.services.test;

import java.util.Properties;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.ecobis.customer.bl.impl.CustomerManagerImpl;

public class CustomerTest {
	private static ILogger logger = LogFactory.getLogger(CustomerTest.class);

	//static ICustomerRest customer;
	static EntityManager em;

	@Test
	public void test1() {
		try {
			logger.logDebug("test1");
			em.getTransaction().begin();
		/*
			TestRequest request = new TestRequest();
			TestResponse response = Customer.test1(request);
			Assert.assertNotNull("response is null", response);
			Assert.assertEquals("", "Tran Ok", response.getMessage());
		*/
			em.getTransaction().commit();
		} catch(Exception ex) {
			logger.logError(ex);
			em.getTransaction().rollback();
		}
	}

	@Before
	public void pseudoBlueprintContainerInit() {
		logger.logDebug("pseudoBlueprintContainerInit");

		//customer = new CustomerImpl();
		CustomerManagerImpl CustomerManager = new CustomerManagerImpl();
		//customer.setCustomer(CustomerManager);

		Properties props = new Properties();

		props.put("openjpa.Log", "DefaultLevel=WARN,SQL=TRACE");
		props.put("openjpa.ConnectionDriverName",
				"com.sybase.jdbc3.jdbc.SybDriver");
		props.put("openjpa.ConnectionURL", "jdbc:sybase:Tds:VMP01TEC13:5000");
		props.put("openjpa.ConnectionUserName", "sa");
		props.put("openjpa.ConnectionPassword", "cobis");

		EntityManagerFactory factory = Persistence.createEntityManagerFactory(
				"TestUnit", props);
		em = factory.createEntityManager();

		//acctDao.setEntityManager(em);
	}

	@After
	public void pseudoBlueprintContainerClose() {
		logger.logDebug("pseudoBlueprintContainerClose");
		em.close();
	}

}
