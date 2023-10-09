package com.cobiscorp.cloud.scheduler.model;

import java.util.List;

import javax.xml.bind.annotation.XmlRootElement;

import com.cobiscorp.cloud.scheduler.dto.Job;

@XmlRootElement
public class JobXml{

	private List<Job> jobs;

	public List<Job> getJobs() {
		return jobs;
	}

	public void setJobs(List<Job> jobs) {
		this.jobs = jobs;
	}

}
