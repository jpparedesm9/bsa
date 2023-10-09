package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class DisbursementIncome {

	public static final String EN_DSBUSETIO368 = "EN_DSBUSETIO368";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "DisbursementIncome";
	
	
	public static final Property<String> ISGROUP = new Property<String>("isGroup", String.class, false);
	
	public static final Property<Integer> OPERATIONNUMBER = new Property<Integer>("operationNumber", Integer.class, false);
	
	public static final Property<Integer> GROUPID = new Property<Integer>("groupId", Integer.class, false);
	
	public static final Property<String> ACCOUNT = new Property<String>("Account", String.class, false);
	
	public static final Property<String> OBSERVATIONS = new Property<String>("Observations", String.class, false);
	
	public static final Property<BigDecimal> BALANCEOPERATION = new Property<BigDecimal>("BalanceOperation", BigDecimal.class, false);
	
	public static final Property<BigDecimal> CURRENTBALANCE = new Property<BigDecimal>("CurrentBalance", BigDecimal.class, false);
	
	public static final Property<String> DISBURSEMENTFORM = new Property<String>("DisbursementForm", String.class, false);
	
	public static final Property<String> DESCRIPTION = new Property<String>("Description", String.class, false);
	
	public static final Property<String> OFFICE = new Property<String>("Office", String.class, false);
	
	public static final Property<Double> DISBURSEMENTVALUE = new Property<Double>("DisbursementValue", Double.class, false);
	
	public static final Property<String> IMPOFFICE = new Property<String>("ImpOffice", String.class, false);
	
	public static final Property<Integer> DISBURSEMENTID = new Property<Integer>("DisbursementId", Integer.class, false);
	
	public static final Property<Integer> CLIENTID = new Property<Integer>("ClientID", Integer.class, false);
	
	public static final Property<Double> DISBURSEMENTVALUEDEC = new Property<Double>("DisbursementValueDec", Double.class, false);
	
	public static final Property<Double> QUOTATION = new Property<Double>("Quotation", Double.class, false);
	
	public static final Property<String> COMMENT = new Property<String>("Comment", String.class, false);
	
	public static final Property<String> TQUOTATIONOP = new Property<String>("TQuotationOP", String.class, false);
	
	public static final Property<String> TQUOTATIONDS = new Property<String>("TQuotationDS", String.class, false);
	
	public static final Property<BigDecimal> QUOTATIONOP = new Property<BigDecimal>("QuotationOP", BigDecimal.class, false);
	
	public static final Property<String> CURRENCYOP = new Property<String>("CurrencyOP", String.class, false);
	
	public static final Property<String> CURRENCY = new Property<String>("Currency", String.class, false);
	
	public static final Property<Integer> SEQUENTIAL = new Property<Integer>("Sequential", Integer.class, false);
	
	public static final Property<String> OPERATIONID = new Property<String>("OperationId", String.class, false);
	
	public static final Property<BigDecimal> VALUEML = new Property<BigDecimal>("ValueMl", BigDecimal.class, false);
	
	public static final Property<String> CREDITTYPE = new Property<String>("creditType", String.class, false);

	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
