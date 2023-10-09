package com.cobiscorp.ecobis.bpl.service.workflow;

import java.util.List;

import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public interface AddresseeService {

	/**
	 * Recupera el ProcessActivity por idProcess, version y idActivity
	 * 
	 * @return
	 */
	List<Addressee> findAddresseeByProcessVersion(Integer idProcess, Short versionProcess);

	void buildAdressee(ProcessVersion processVersionOrigin, ProcessVersion processVersioDestination, DriverManagerDataSource dataSource,
			ApplicationContext context) throws Exception;

	void updateAddress(Process process, ProcessVersion processVersion, ProcessVersion searchedProcessVersion) throws Exception;

}
