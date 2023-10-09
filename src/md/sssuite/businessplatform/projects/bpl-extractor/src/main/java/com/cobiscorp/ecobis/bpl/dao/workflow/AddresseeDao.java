package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;

public interface AddresseeDao {

	/**
	 * Recupera el Addressee por idProcess, version y idActivity
	 * 
	 * @return
	 */
	List<Addressee> findAddresseeByProcessVersion(Integer idProcess, Short versionProcess);

	Addressee findAddresseeByProcessVersionActivity(Integer idProcess, Short versionProcess, String nameActivity);

	void update(Addressee addressee);

}
