package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;

import org.apache.log4j.Logger;
import org.springframework.context.ApplicationContext;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessVersionDao;
import com.cobiscorp.ecobis.bpl.extractor.repository.RuleRepository;
import com.cobiscorp.ecobis.bpl.rules.engine.model.Rule;
import com.cobiscorp.ecobis.bpl.rules.engine.model.TaskView;
import com.cobiscorp.ecobis.bpl.service.rules.TaskViewService;
import com.cobiscorp.ecobis.bpl.service.workflow.AddresseeService;
import com.cobiscorp.ecobis.bpl.service.workflow.ApprovalExceptionService;
import com.cobiscorp.ecobis.bpl.service.workflow.HierarchyService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessActivityService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessService;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessVariableService;
import com.cobiscorp.ecobis.bpl.service.workflow.StepService;
import com.cobiscorp.ecobis.bpl.util.RuleQueryManager;
import com.cobiscorp.ecobis.bpl.util.SeqnosProcedureManager;
import com.cobiscorp.ecobis.bpl.util.workflow.ProcessVersionProcedureManager;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Addressee;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ApprovalException;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.DocumentType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Hierarchy;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Link;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.MappingVariableProcess;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Process;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessType;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVariable;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Step;

public class ProcessServiceImpl implements ProcessService {

	private ProcessDao processDao;
	private ProcessVersionDao processVersionDao;
	private ProcessVariableService processVariableService;
	private ProcessActivityService processActivityService;
	private StepService stepService;
	private TaskViewService taskViewService;
	private AddresseeService addresseeService;
	private HierarchyService hierarchyService;
	private ApprovalExceptionService approvalExceptionService;

	static Logger log = Logger.getLogger(ProcessServiceImpl.class);

	/**
	 * @return the processDao
	 */
	public ProcessDao getProcessDao() {
		return processDao;
	}

	/**
	 * @param processDao
	 *            the processDao to set
	 */
	public void setProcessDao(ProcessDao processDao) {
		this.processDao = processDao;
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

	/**
	 * @return the processVariableService
	 */
	public ProcessVariableService getProcessVariableService() {
		return processVariableService;
	}

	/**
	 * @param processVariableService
	 *            the processVariableService to set
	 */
	public void setProcessVariableService(ProcessVariableService processVariableService) {
		this.processVariableService = processVariableService;
	}

	public StepService getStepService() {
		return stepService;
	}

	public void setStepService(StepService stepService) {
		this.stepService = stepService;
	}

	public ProcessActivityService getProcessActivityService() {
		return processActivityService;
	}

	public void setProcessActivityService(ProcessActivityService processActivityService) {
		this.processActivityService = processActivityService;
	}

	public TaskViewService getTaskViewService() {
		return taskViewService;
	}

	public void setTaskViewService(TaskViewService taskViewService) {
		this.taskViewService = taskViewService;
	}

	/**
	 * @return the addresseeService
	 */
	public AddresseeService getAddresseeService() {
		return addresseeService;
	}

	/**
	 * @param addresseeService
	 *            the addresseeService to set
	 */
	public void setAddresseeService(AddresseeService addresseeService) {
		this.addresseeService = addresseeService;
	}

	public HierarchyService getHierarchyService() {
		return hierarchyService;
	}

	public void setHierarchyService(HierarchyService hierarchyService) {
		this.hierarchyService = hierarchyService;
	}

	public ApprovalExceptionService getApprovalExceptionService() {
		return approvalExceptionService;
	}

	public void setApprovalExceptionService(ApprovalExceptionService approvalExceptionService) {
		this.approvalExceptionService = approvalExceptionService;
	}

	public Process findAndSave(ProcessVersion processVersion, ApplicationContext context, DriverManagerDataSource dataSource) throws Exception {

		// Declaro la clase para ejecutar el seqnos
		SeqnosProcedureManager seqnos = new SeqnosProcedureManager(dataSource);
		RuleRepository ruleRepository = context.getBean(RuleRepository.class);
		ProcessVersion findProcessVersion = null;
		boolean isNuevo = false;
		Process process = null;

		try {

			// Busco el process en base al nombre
			process = processDao.findByName(processVersion.getProcess().getName());
			log.debug("1ProcessServiceImpl---------------------------------------->" + process);
			// Si es diferente de null lo busco caso contrario creo uno nuevo
			if (process != null) {
				log.debug("2ProcessServiceImpl---------------------------------------->" + process.getName());
				// Busco la version en produccion,la anterior o la de
				// construccion
				findProcessVersion = processVersionDao.findLastVesionProcess(process.getIdProcess());
				// Elimina la version en construccion
				if (findProcessVersion != null && findProcessVersion.getStatus().equals("CON")) {
					log.debug("4ProcessServiceImpl---------------------------------------->" + findProcessVersion.getStatus());
					ProcessVersionProcedureManager processVersionProcedureManager = new ProcessVersionProcedureManager(dataSource);
					processVersionProcedureManager.execute(findProcessVersion.getProcess().getIdProcess(), findProcessVersion.getVersionProcess(), 'D');
					// processVersionProcedureManager
					processDao.flush();
					process = processDao.findByName(processVersion.getProcess().getName());
					log.debug("5ProcessServiceImpl---------------------------------------->" + process.getListProcessVersion().size());

				}
				log.debug("6ProcessServiceImpl---------------------------------------->" + findProcessVersion);

			} else {

				isNuevo = true;
				log.debug("7ProcessServiceImpl---------------------------------------->");
				// Crea el nuevo proceso
				process = new Process();
				String nemonic = processVersion.getProcess().getNemonic();
				if (nemonic == null) {
					nemonic = "P_" + String.valueOf(Math.random() * 100000);
					nemonic = nemonic.substring(0, nemonic.indexOf("."));
					log.debug("nemonic-------------------->" + nemonic);
				}
				process.setNemonic(nemonic);
				process.setIdProcess(seqnos.execute("wf_proceso"));
				process.setConsole(processVersion.getProcess().getConsole());
				process.setCost(processVersion.getProcess().getCost());
				process.setDescription(processVersion.getProcess().getDescription());
				process.setEffectiveTime(processVersion.getProcess().getEffectiveTime());
				process.setEmail(processVersion.getProcess().getEmail());
				process.setIdCompany(processVersion.getProcess().getIdCompany());
				process.setListProcessVersion(new ArrayList<ProcessVersion>());
				process.setName(processVersion.getProcess().getName());
				process.setNotification(processVersion.getProcess().getNotification());
				process.setProcessTypeList(new ArrayList<ProcessType>());
				process.setProduct(processVersion.getProcess().getProduct());
				process.setReturnMode(processVersion.getProcess().getReturnMode());
				process.setSms(processVersion.getProcess().getSms());
				process.setStandardTime(processVersion.getProcess().getStandardTime());
				process.setStatus(processVersion.getProcess().getStatus());
				process.setTemplate(processVersion.getProcess().getTemplate());
				process.setThread(processVersion.getProcess().getThread());
				process.setVersion(new Short("1"));

				log.debug("8ProcessServiceImpl---------------------------------------->");
				// Crea el tipo del proceso
				for (ProcessType processType : processVersion.getProcess().getProcessTypeList()) {
					log.debug("9ProcessServiceImpl---------------------------------------->");
					ProcessType processTypeNew = new ProcessType();
					processTypeNew.setProcess(process);
					processTypeNew.setProcessType(processType.getIdProcessType().getProcessType());
					process.getProcessTypeList().add(processTypeNew);
					log.debug("10ProcessServiceImpl---------------------------------------->");
				}

			}

			log.debug("11ProcessServiceImpl---------------------------------------->");
			ProcessVersion processVersionNew = new ProcessVersion();
			processVersionNew.setProcess(process);
			processVersionNew.setStatus("CON");
			processVersionNew.setActivationDate(processVersion.getActivationDate());
			processVersionNew.setCreationDate(processVersion.getCreationDate());
			processVersionNew.setHierarchyList(new ArrayList<Hierarchy>());
			processVersionNew.setHistoryInformation(processVersion.getHistoryInformation());
			processVersionNew.setLinkList(new ArrayList<Link>());
			processVersionNew.setMappingVariableProcessList(new ArrayList<MappingVariableProcess>());
			processVersionNew.setProcessVariableList(new ArrayList<ProcessVariable>());
			processVersionNew.setStepList(new ArrayList<Step>());
			processVersionNew.setAddresseeList(new ArrayList<Addressee>());
			processVersionNew.setProcessActivityList(new ArrayList<ProcessActivity>());
			processVersionNew.setTaskViewList(new ArrayList<TaskView>());

			log.debug("12ProcessServiceImpl---------------------------------------->");

			// Seteo la version de proceso que se va a tomar
			if (findProcessVersion == null) {
				log.debug("13ProcessServiceImpl---------------------------------------->" + findProcessVersion);
				processVersionNew.setVersionProcess(new Short("1"));
			} else {
				log.debug("14ProcessServiceImpl---------------------------------------->" + findProcessVersion);
				if (findProcessVersion.getStatus().equals("CON")) {
					processVersionNew.setVersionProcess(findProcessVersion.getVersionProcess());
					log.debug("12ProcessServiceImpl---------------------------------------->" + findProcessVersion);
				} else {
					Integer version = findProcessVersion.getVersionProcess() + new Short("1");
					processVersionNew.setVersionProcess(Short.valueOf("" + version));
					log.debug("15ProcessServiceImpl---------------------------------------->" + findProcessVersion + "-" + version);
				}
			}

			log.debug("16ProcessServiceImpl---------------------------------------->");
			// Se contyuye el destinatario
			addresseeService.buildAdressee(processVersion, processVersionNew, dataSource, context);

			log.debug("17ProcessServiceImpl---------------------------------------->");
			for (Step step : processVersion.getStepList()) {
				log.debug("18ProcessServiceImpl---------------------------------------->");
				Step newStep = new Step();
				newStep.setProcessVersion(processVersionNew);
				newStep.setIdProcess(process.getIdProcess());
				newStep.setVersion(processVersionNew.getVersionProcess());
				newStep = stepService.saveStep(step, newStep, processVersion, context, dataSource);
				processVersionNew.getStepList().add(newStep);
				log.debug("19ProcessServiceImpl---------------------------------------->");
			}

			log.debug("20ProcessServiceImpl---------------------------------------->");
			processVersionNew = processActivityService.setProcessActivity(processVersion, processVersionNew, dataSource);
			log.debug("21ProcessServiceImpl---------------------------------------->");
			// processVersionNew =
			// linkService.setLinkToProcessVersion(processVersion,
			// processVersionNew);
			processVersionNew = taskViewService.setTaskViewToProcessVersion(processVersion, processVersionNew, dataSource);
			log.debug("22ProcessServiceImpl---------------------------------------->");
			processVersionNew = hierarchyService.setHierarchyToProcessVersion(processVersion, processVersionNew, dataSource);
			log.debug("23ProcessServiceImpl---------------------------------------->");
			processVersionNew.setIdProcessVersion(new IdProcessVersion(process.getIdProcess(), processVersionNew.getVersionProcess()));
			log.debug("24ProcessServiceImpl---------------------------------------->");
			processVariableService.buildProcessVariable(processVersion, processVersionNew, dataSource);
			log.debug("25ProcessServiceImpl---------------------------------------->");

			process.getListProcessVersion().add(processVersionNew);

			for (Addressee addressee : processVersion.getAddresseeList()) {
				log.debug("OldAddresse_process-------->" + addressee.getIdProcess());
				log.debug("OldAddresse_version-------->" + addressee.getVersionProcess());
				log.debug("OldAddresse_activit-------->" + addressee.getIdActivity());
			}

			for (Addressee addressee : processVersionNew.getAddresseeList()) {
				log.debug("NewAddresse_process-------->" + addressee.getIdProcess());
				log.debug("NewAddresse_version-------->" + addressee.getVersionProcess());
				log.debug("NewAddresse_activit-------->" + addressee.getIdActivity());
			}

			log.debug("26ProcessServiceImpl---------------------------------------->");
			// Inserto el proceso caso contrario lo actualizo
			if (isNuevo) {
				log.debug("27ProcessServiceImpl---------------------------------------->");
				process = processDao.insert(process);
			} else {
				log.debug("28ProcessServiceImpl---------------------------------------->");
				process = processDao.update(process);
			}

		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo findAndSave", ex);
			throw new Exception(ex);
		}

		return process;
	}

	public Process findByName(String name) {
		return processDao.findByName(name);
	}
}
