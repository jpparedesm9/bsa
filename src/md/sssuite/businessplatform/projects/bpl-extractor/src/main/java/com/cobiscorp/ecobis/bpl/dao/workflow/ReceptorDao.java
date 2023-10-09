package com.cobiscorp.ecobis.bpl.dao.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;

public interface ReceptorDao {

	/**
	 * Recupera los Receptor por idStep
	 * 
	 * @return
	 */
	List<Receptor> findReceptorByStep(Integer idStep);

}
