package com.cobiscorp.ecobis.customer.dal.impl;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;

import com.cobiscorp.ecobis.customer.dal.ClientDAO;
import com.cobiscorp.ecobis.customer.dal.entities.Client;
import com.cobiscorp.ecobis.customer.services.dtos.ClientDTO;

public class ClientDAOImpl extends BaseDAOImpl implements ClientDAO {

	@PersistenceContext(unitName = "customerT")
	public void setEntityManager(EntityManager entityManager) {
		this.entityManager = entityManager;
	}

	@Override
	public void createClient(ClientDTO client) {
		Client clientSave = new Client(client.getClient(), client
				.getProductDetail().getCode(), client.getRole(),
				client.getIdentification(), client.getDate());
		this.entityManager.persist(clientSave);
	}

}
