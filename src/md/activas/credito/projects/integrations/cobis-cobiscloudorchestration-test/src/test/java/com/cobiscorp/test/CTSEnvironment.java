package com.cobiscorp.test;

/**
 * Keeps CTS configuration to database, MQ, web port
 * 
 * @author fabad
 * 
 */
public abstract class CTSEnvironment extends com.cobiscorp.test.utils.CTSEnvironment {

	public static Integer COBIS_ROLE_C = Integer.parseInt(getEnvProp().getProperty("cobis.role", "20"));

	public static String TCPH_HOST = getEnvProp().getProperty("tcph.host");
	public static String TCPH_HOST_ISO = getEnvProp().getProperty("tcph.host.iso");
	public static Integer TCPH_PORT_ISO = Integer.parseInt(getEnvProp().getProperty("tcph.port.iso", "2414"));
	public static Integer TCPH_PORT_X11 = Integer.parseInt(getEnvProp().getProperty("tcph.port.x11", "2414"));

	public static String bvLogin = getEnvProp().getProperty("bv.login", "testCts");
	public static String bvLoginType = getEnvProp().getProperty("bv.login.type", "P");
	public static String bvLoginNumDoc = getEnvProp().getProperty("bv.login.numdoc", "0");
	public static String bvPassword = getEnvProp().getProperty("bv.password", "FC0CFD1CC67BFB20552868E2F474A09213669D15E2BE6083E504A969B69CC94B");
	public static String bvCulture = getEnvProp().getProperty("bv.culture", "ES_EC");
	public static String bvTerminalIp = getEnvProp().getProperty("bv.terminal.ip");
	public static String bvServer = getEnvProp().getProperty("bv.server", "CTSSRV");
	public static String bvWebServer = getEnvProp().getProperty("bv.webserver");
	public static Integer bvEnte = Integer.parseInt(getEnvProp().getProperty("bv.ente", "0"));
	public static Integer bvEnteMis = Integer.parseInt(getEnvProp().getProperty("bv.ente.mis", "0"));
	public static Integer bvService = Integer.parseInt(getEnvProp().getProperty("bv.service", "1"));

	public static String bvAccCtaCteNumber = getEnvProp().getProperty("bv.acc.ctacte.number", "0");
	public static Integer bvAccCtaCteType = Integer.parseInt(getEnvProp().getProperty("bv.acc.ctacte.type", "3"));
	public static Integer bvAccCtaCteCurrencyId = Integer.parseInt(getEnvProp().getProperty("bv.acc.ctacte.currencyid", "0"));

	public static String bvAccCtaAhoNumber = getEnvProp().getProperty("bv.acc.ctaaho.number", "0");
	public static Integer bvAccCtaAhoType = Integer.parseInt(getEnvProp().getProperty("bv.acc.ctaaho.type", "4"));
	public static Integer bvAccCtaAhoCurrencyId = Integer.parseInt(getEnvProp().getProperty("bv.acc.ctaaho.currencyid", "0"));

	public static String bvAccDpfNumber = getEnvProp().getProperty("bv.acc.dpf.number", "0");
	public static Integer bvAccDpfType = Integer.parseInt(getEnvProp().getProperty("bv.acc.dpf.type", "14"));
	public static Integer bvAccDpfCurrencyId = Integer.parseInt(getEnvProp().getProperty("bv.acc.dpf.currencyid", "0"));

	public static String bvAccCarNumber = getEnvProp().getProperty("bv.acc.car.number", "0");
	public static Integer bvAccCarType = Integer.parseInt(getEnvProp().getProperty("bv.acc.car.type", "7"));
	public static Integer bvAccCarCurrencyId = Integer.parseInt(getEnvProp().getProperty("bv.acc.car.currencyid", "0"));

	public static String bvAccCexNumber = getEnvProp().getProperty("bv.acc.cex.number", "0");
	public static Integer bvAccCexType = Integer.parseInt(getEnvProp().getProperty("bv.acc.cex.type", "9"));
	public static Integer bvAccCexCurrencyId = Integer.parseInt(getEnvProp().getProperty("bv.acc.cex.currencyid", "0"));

	public static String bvAccTarNumber = getEnvProp().getProperty("bv.acc.tar.number", "0");

	public static String bvProcessDate = getEnvProp().getProperty("bv.process.date", "10/01/2013");
	
	public static String ATM_CORE_TYPE = getEnvProp().getProperty("atm.coretype", "COBIS");

}

