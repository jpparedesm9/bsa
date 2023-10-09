package com.cobiscorp.ecobis.customer.dal;

import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public interface ClientDAO {
	/**
	 * Create a Client in database
	 *
	 */
	public void createClient(ClientDTO client);
}
