package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVersionDao;
import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVersionService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class ProcessVersionServiceImpl implements ProcessVersionService {

	static Logger log = Logger.getLogger(ProcessVersionServiceImpl.class);

	private ProcessVersionDao processVersionDao;

	public List<ProcessVersion> findProductionProcessVersion() {
		List<ProcessVersion> processVersionList = new ArrayList<ProcessVersion>();
		for (ProcessVersion processVersion : processVersionDao.findProductionProcessVersion()) {

			ProcessVersion processVersionNew = new ProcessVersion();
			processVersionNew.setActivationDate(processVersion.getActivationDate());
			processVersionNew.setCreationDate(processVersion.getCreationDate());
			processVersionNew.setHierarchyList(new ArrayList<Hierarchy>());
			processVersionNew.setHistoryInformation(processVersion.getHistoryInformation());
			processVersionNew.setIdProcessVersion(processVersion.getIdProcessVersion());
			processVersionNew.setLinkList(new ArrayList<Link>());
			processVersionNew.setMappingVariableProcessList(new ArrayList<MappingVariableProcess>());
			processVersionNew.setProcessVariableList(new ArrayList<ProcessVariable>());
			processVersionNew.setStatus(processVersion.getStatus());
			processVersionNew.setStepList(new ArrayList<Step>());
			processVersionNew.setVersionProcess(processVersion.getVersionProcess());
			processVersionNew.setIdProcessVersion(processVersion.getIdProcessVersion());
			processVersionNew.setVersionProcess(processVersion.getVersionProcess());
			processVersionNew.setAddresseeList(new ArrayList<Addressee>());
			processVersionNew.setProcessActivityList(new ArrayList<ProcessActivity>());
			processVersionNew.setTaskViewList(new ArrayList<TaskView>());

			Process processNew = new Process();
			processNew.setConsole(processVersion.getProcess().getConsole());
			processNew.setCost(processVersion.getProcess().getCost());
			processNew.setDescription(processVersion.getProcess().getDescription());
			processNew.setEffectiveTime(processVersion.getProcess().getEffectiveTime());
			processNew.setEmail(processVersion.getProcess().getEmail());
			processNew.setIdCompany(processVersion.getProcess().getIdCompany());
			processNew.setIdProcess(processVersion.getProcess().getIdProcess());
			processNew.setListProcessVersion(new ArrayList<ProcessVersion>());
			processNew.setName(processVersion.getProcess().getName());
			processNew.setNotification(processVersion.getProcess().getNotification());
			processNew.setProcessTypeList(new ArrayList<ProcessType>());
			processNew.setProduct(processVersion.getProcess().getProduct());
			processNew.setReturnMode(processVersion.getProcess().getReturnMode());
			processNew.setSms(processVersion.getProcess().getSms());
			processNew.setStandardTime(processVersion.getProcess().getStandardTime());
			processNew.setStatus(processVersion.getProcess().getStatus());
			processNew.setTemplate(processVersion.getProcess().getTemplate());
			processNew.setThread(processVersion.getProcess().getThread());
			processNew.setVersion(processVersion.getProcess().getVersion());
			processNew.setNemonic(processVersion.getProcess().getNemonic());

			processVersionNew.setProcess(processNew);
			processVersionList.add(processVersionNew);
		}
		return processVersionList;
	}

	public ProcessVersion findProcessVersionById(Integer idProcess, Short versionProcess) throws Exception {
		return processVersionDao.findProcessVersionById(idProcess, versionProcess);
	}

	public ProcessVersion findLastVesionProcess(Integer idProcess) {
		return processVersionDao.findLastVesionProcess(idProcess);
	}

	/**
	 * @return the processVersionDao
	 */
	public ProcessVersionDao getProcessVersionDao() {
		return processVersionDao;
	}

	/**
	 * @param processVersionDao
	 *            the processVersionDao to set
	 */
	public void setProcessVersionDao(ProcessVersionDao processVersionDao) {
		this.processVersionDao = processVersionDao;
	}
}
