package com.cobiscorp.ecobis.bpl.service.workflow.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.springframework.jdbc.datasource.DriverManagerDataSource;

import com.cobiscorp.ecobis.bpl.dao.workflow.ActivityDao;
import com.cobiscorp.ecobis.bpl.dao.workflow.ProcessActivityDao;
import com.cobiscorp.ecobis.bpl.service.workflow.ProcessActivityService;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.Activity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.IdProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessActivity;
import com.cobiscorp.ecobis.bpl.workflow.engine.model.ProcessVersion;

public class ProcessActivityServiceImpl implements ProcessActivityService {

	static Logger log = Logger.getLogger(ProcessActivityServiceImpl.class);

	private ProcessActivityDao processActivityDao;
	private ActivityDao activityDao;

	/**
	 * @return the processActivityDao
	 */
	public ProcessActivityDao getProcessActivityDao() {
		return processActivityDao;
	}

	public ActivityDao getActivityDao() {
		return activityDao;
	}

	public void setActivityDao(ActivityDao activityDao) {
		this.activityDao = activityDao;
	}

	/**
	 * @param processActivityDao
	 *            the processActivityDao to set
	 */
	public void setProcessActivityDao(ProcessActivityDao processActivityDao) {
		this.processActivityDao = processActivityDao;
	}

	public List<ProcessActivity> findProcessActivityByProcessVersion(Integer idProcess, Short versionProcess) {
		return processActivityDao.findProcessActivityByProcessVersion(idProcess, versionProcess);
	}

	public ProcessVersion setProcessActivity(ProcessVersion processVersion, ProcessVersion newProcessversion, DriverManagerDataSource dataSource)
			throws Exception {
		List<ProcessActivity> newProcessActivityList = new ArrayList<ProcessActivity>();
		List<ProcessActivity> processActivityList = processVersion.getProcessActivityList();
		try {
			log.debug("ProcessActivityList:" + processVersion.getProcessActivityList());
			if (processVersion.getProcessActivityList() != null) {
				for (ProcessActivity processActivity : processActivityList) {
					log.debug("ProcessActivity" + processActivity.getAssociatedFunction());
					ProcessActivity newProcessActivity = new ProcessActivity();
					newProcessActivity.setAssociatedFunction(processActivity.getAssociatedFunction());
					newProcessActivity.setCost(processActivity.getCost());
					newProcessActivity.setEffectiveTime(processActivity.getEffectiveTime());
					newProcessActivity.setInstaceExecution(processActivity.getInstaceExecution());
					newProcessActivity.setOperativeHelp(processActivity.getOperativeHelp());
					newProcessActivity.setStandardTime(processActivity.getStandardTime());
					newProcessActivity.setSuspend(processActivity.getSuspend());
					newProcessActivity.setToleranceMargin(processActivity.getToleranceMargin());
					newProcessActivity.setVersionProcess(newProcessversion.getVersionProcess());
					log.debug("Activity: " + processActivity.getActivity());
					Activity activity = activityDao.findAndSaveActivity(processActivity.getActivity(), dataSource);
					log.debug("Activity 2: " + activity.getIdActivity());
					log.debug("Activity in PA:" + processActivity.getAssociatedFunction());
					newProcessActivity.setActivity(null);
					newProcessActivity.setIdActivity(activity.getIdActivity());
					newProcessActivity.setIdProcess(newProcessversion.getProcess().getIdProcess());
					newProcessActivity.setProcessVersion(newProcessversion);
					newProcessActivity.setIdProcessActivity(new IdProcessActivity(activity.getIdActivity(), newProcessversion.getProcess()
							.getIdProcess(), newProcessversion.getVersionProcess()));
					newProcessActivityList.add(newProcessActivity);
				}
			}
			newProcessversion.setProcessActivityList(newProcessActivityList);
		} catch (Exception ex) {
			log.error("Error al ejecutar el metodo setProcessActivity:", ex);
			throw ex;
		}
		return newProcessversion;
	}

}
