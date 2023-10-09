package com.cobiscorp.cloud.scheduler.service;

import java.text.ParseException;

import org.boris.winrun4j.AbstractService;
import org.boris.winrun4j.EventLog;
import org.boris.winrun4j.ServiceException;
import org.quartz.SchedulerException;

import com.cobiscorp.cloud.scheduler.crontask.CloudScheduler;
import org.apache.log4j.Logger;

public class Launcher extends AbstractService {

	private static final Logger logger = Logger.getLogger(Launcher.class);

	public int serviceMain(String[] args) throws ServiceException {
		try {
			int count = 0;
			init(args, true);
			while (!this.shutdown) {
				try {
					Thread.sleep(1000);
				} catch (InterruptedException e) {
					logger.error(e.getMessage(), e);
					EventLog.report("Scheduler Service", EventLog.ERROR, e.getMessage());
				}

				if (++count % 10 == 0)
					EventLog.report("Scheduler Service", EventLog.INFORMATION, "Ping");
			}

		} catch (Exception e1) {
			logger.error(e1.getMessage(), e1);
			EventLog.report("Scheduler Service", EventLog.ERROR, e1.getMessage());
		}
		return 0;
	}

	private static void init(String[] args, boolean serviceMode) throws ServiceException {
		try {
			CloudScheduler.main(args);
		} catch (SchedulerException e) {
			EventLog.report("SchedulerException", EventLog.ERROR, e.getMessage());
			logger.error("SchedulerException at init method: " + e);
		} catch (ParseException e) {
			EventLog.report("ParseException", EventLog.ERROR, e.getMessage());
			logger.error("ParseException at init method: " + e);
		} catch (InterruptedException e) {
			EventLog.report("InterruptedException", EventLog.ERROR, e.getMessage());
			logger.error("InterruptedException at init method: " + e);
		} catch (Exception e) {
			EventLog.report("Exception", EventLog.ERROR, e.getMessage());
			logger.error("Exception at init method: " + e);
		}
	}
}
