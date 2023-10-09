package com.cobiscorp.test;

import org.junit.rules.ExternalResource;

/**
 * Class that setup configuration before and after, any expensive resource must be allocated and deallocated here
 * 
 * @author fabad
 *
 */
public class SetUpTestEnvironment extends ExternalResource {
	/**
	 * This method must be call from every test in annotation: @BeforeClass of the test
	 */
	public static void setUp() {
		if (System.getProperty("testPropertyFile") == null) {
			System.setProperty("testPropertyFile", "developer1.properties");
		}
		// System.setProperty("testPropertyFile","developer-frank.properties");
		System.out.println("setting up environment with: " + System.getProperty("testPropertyFile"));
		// el targetId local es null porque no aplica para mainstreet y no debe ejecutarse nada con eso
	}

	@Override
	protected void after() {
		System.out.println("clossing setupenvironment");
	}

	@Override
	protected void before() throws Throwable {
		setUp();
	}

}
