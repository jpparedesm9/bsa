package com.cobiscorp.cobis.busin.model;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.math.BigDecimal;
import com.cobiscorp.designer.api.Property;

public class GeneralData {

	public static final String EN_GENERADAT921 = "EN_GENERADAT921";
	
	public static final String VERSION = "1.0.0";
	
	public static final String ENTITY_NAME = "GeneralData";
	
	
	public static final Property<String> OPERATIONTYPE = new Property<String>("OperationType", String.class, false);
	
	public static final Property<BigDecimal> CURRENCY = new Property<BigDecimal>("Currency", BigDecimal.class, false);
	
	public static final Property<BigDecimal> AMOUNT = new Property<BigDecimal>("Amount", BigDecimal.class, false);
	
	public static final Property<Double> RATE = new Property<Double>("Rate", Double.class, false);
	
	public static final Property<Date> DATEVALUEHOME = new Property<Date>("DateValueHome", Date.class, false);
	
	public static final Property<Date> VALUEENDDATE = new Property<Date>("ValueEndDate", Date.class, false);
	
	public static final Property<Date> EXPIRATIONFIRSTQUOTA = new Property<Date>("ExpirationFirstQuota", Date.class, false);
	
	public static final Property<String> LOANTYPE = new Property<String>("loanType", String.class, false);
	
	public static final Property<String> SECTORNEG = new Property<String>("sectorNeg", String.class, false);
	
	public static final Property<String> PAYMENTFRECUENCYNAME = new Property<String>("paymentFrecuencyName", String.class, false);
	
	public static final Property<String> VINCULADO = new Property<String>("vinculado", String.class, false);
	
	public static final Property<String> SYMBOLCURRENCY = new Property<String>("symbolCurrency", String.class, false);
	
	public static final Property<String> PRODUCTTYPENAME = new Property<String>("productTypeName", String.class, false);
	
	public static final Property<String> MNEMONICCURRENCY = new Property<String>("mnemonicCurrency", String.class, false);
	
	public static final List<Property<?>> getPks() {
		List<Property<?>> pks = new ArrayList<Property<?>>();
		return pks;
	}

}
