package com.cobiscorp.cobis.assets.commons.constants;

public interface ServiceId {
	// GROUP SERVICES
	final static String QUERY_PAYMENT_METHODS = "RegularizePayments.Catalogs.OpGetPaymentMethods";// cob_cartera..sp_qr_producto
	final static String QUERY_OBJETED_PAYMENTS = "RegularizePayments.ObjetedPayments.GetAllObjetedPayments";
	final static String INSERT_OBJETED_PAYMENTS = "RegularizePayments.ObjetedPayments.InsertObjetedPayments";
	final static String REGULARIZE_PAYMENTS = "RegularizePayments.ObjetedPayments.OpRegularizePayments";

}
