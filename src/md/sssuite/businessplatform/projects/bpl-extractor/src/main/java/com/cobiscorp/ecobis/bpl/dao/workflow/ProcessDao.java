package com.cobiscorp.ecobis.bpl.dao.workflow;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;

public interface ProcessDao {

	Process insert(Process process);

	Process findByName(String name);

	Process update(Process process);
	
	void flush();

}
