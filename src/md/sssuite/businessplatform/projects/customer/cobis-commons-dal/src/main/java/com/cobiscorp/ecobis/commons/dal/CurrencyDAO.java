package com.cobiscorp.ecobis.commons.dal;

import java.util.List;

import com.cobiscorp.ecobis.commons.dal.entities.Currency;

public interface CurrencyDAO {

	/**
	 * This method is used to obtain the currencies.
	 * @return A list of currencies.
	 */
	public abstract List<Currency> getAllCurrencies();

}
