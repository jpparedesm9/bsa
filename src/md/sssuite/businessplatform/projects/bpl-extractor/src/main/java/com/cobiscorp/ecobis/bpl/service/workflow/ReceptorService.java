package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Receptor;

public interface ReceptorService {

	/**
	 * Recupera los Receptor por idStep
	 * 
	 * @return
	 */
	List<Receptor> findReceptorByStep(Integer idStep);

}
