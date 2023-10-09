package com.cobiscorp.cloud.scheduler.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import org.apache.log4j.Logger;
import org.dom4j.io.SAXReader;

import com.cobiscorp.cloud.scheduler.dto.Job;
import com.cobiscorp.cloud.scheduler.model.JobXml;
import com.cobiscorp.cloud.util.marshall.JaxbUtil;

public class SchedulerConfiguration {
	private static final Logger logger = Logger.getLogger(SchedulerConfiguration.class);
	private static final String JOBS_CONFIGURATION = "/notification/jobs-configuration.xml";

	public List<Job> execSchedulerJobClient() {
		List<Job> jobs = new ArrayList<Job>();
		try {
			JaxbUtil<JobXml> jxb = new JaxbUtil<JobXml>();
			String filePath = System.getProperty("user.dir") + JOBS_CONFIGURATION;
			logger.debug("Path: " + filePath);
			File file = new File(filePath);
			JobXml jobXml = jxb.deserialization(file, new JobXml());
			return jobXml.getJobs();
		} catch (Exception ex) {
			logger.error("SchedulerConfiguration Error:" + ex);
		}
		return jobs;
	}

}
