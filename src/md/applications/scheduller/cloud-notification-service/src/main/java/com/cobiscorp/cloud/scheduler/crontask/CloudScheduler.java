package com.cobiscorp.cloud.scheduler.crontask;

import java.awt.Color;
import java.awt.Frame;
import java.awt.TextArea;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import org.apache.log4j.Logger;
import org.quartz.CronTrigger;
import org.quartz.JobDetail;
import org.quartz.Scheduler;
import org.quartz.SchedulerException;
import org.quartz.impl.StdSchedulerFactory;

import com.cobiscorp.cloud.scheduler.dto.Job;
import com.cobiscorp.cloud.scheduler.impl.SchedulerConfiguration;
import com.cobiscorp.cloud.scheduler.utils.MessageManager;

public class CloudScheduler extends Thread {

	private static final Logger logger = Logger.getLogger(CloudScheduler.class);
	private Job job;
	private static Scheduler scheduler;
	private static Frame frame = new Frame();
	private static TextArea tmp = new TextArea();
	private static String param = "";

	public CloudScheduler(Job job) {
		this.job = job;
	}

	public void run() {
		JobDetail jobDetail;
		CronTrigger trigger;
		try {

			jobDetail = new JobDetail(String.valueOf(job.getJobName().trim()), Scheduler.DEFAULT_GROUP, Class.forName(job.getJobClass().trim()));
			trigger = new CronTrigger("ActivityTrigger" + job.getId().trim(), Scheduler.DEFAULT_GROUP, String.valueOf(job.getJobName().trim()), Scheduler.DEFAULT_GROUP,
					job.getCronExpression().trim());
			scheduler.scheduleJob(jobDetail, trigger);
			scheduler.start();
		} catch (Exception ex) {
			logger.error("ERROR in run: " + ex);
		}

	}

	public static void main(String[] args) throws SchedulerException, ParseException, InterruptedException, Exception {
		try {
			String mode = "";
			final SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			logger.debug(MessageManager.getString("CLOUDSCHEDULER.003", ""));

			if (args != null && args.length > 0) {
				mode = args[0];
				param = mode;
			}
			if ("console".equalsIgnoreCase(mode)) {
				System.out.println(MessageManager.getString("CLOUDSCHEDULER.003", format.format(Calendar.getInstance().getTime())));
			} else if ("graphic".equalsIgnoreCase(mode) || mode.equals("")) {
				frame.addWindowListener(new WindowAdapter() {
					public void windowClosing(WindowEvent e) {
						try {
							tmp.append("\n" + MessageManager.getString("CLOUDSCHEDULER.009", format.format(Calendar.getInstance().getTime())));
							logger.debug(MessageManager.getString("CLOUDSCHEDULER.009", ""));
							sleep(2000);
						} catch (InterruptedException e1) {
							logger.error(e1.getMessage());
						}
						System.exit(0);
					}
				});

				tmp = new TextArea(MessageManager.getString("CLOUDSCHEDULER.003", format.format(Calendar.getInstance().getTime()), 0, 0) + new File(".").getAbsolutePath());				
				tmp.setBackground(Color.BLACK);
				tmp.setForeground(Color.WHITE);
				tmp.setEditable(false);
				frame.add(tmp);
				frame.setTitle("COBISCorp SchedulerApp - Client");
				frame.setSize(500, 250);
				frame.setVisible(true);
			}

			scheduler = new StdSchedulerFactory().getScheduler();

			SchedulerConfiguration schedulerConf = new SchedulerConfiguration();
			List<Job> jobs = schedulerConf.execSchedulerJobClient();
			if (jobs == null || jobs.size() == 0) {

				throw new NullPointerException(MessageManager.getString("CLOUDSCHEDULER.008"));
			}
			for (Job job : jobs) {
				(new CloudScheduler(job)).start();
			}
		} catch (NullPointerException e) {
			logger.error(e.getMessage());
			printError(param, e.getMessage());
			sleep(2000);
			System.exit(0);
		} catch (Exception e) {
			logger.error(MessageManager.getString("CLOUDSCHEDULER.006"), e);
			printError(param, e.getMessage());
			sleep(2000);
			System.exit(0);
		}
	}

	private static void printError(String arg, String msg) {
		String mode = "";
		if (arg != null)
			if ("console".equalsIgnoreCase(mode)) {
				logger.error(MessageManager.getString("CLOUDSCHEDULER.010", msg));
			} else if ("graphic".equalsIgnoreCase(mode) || mode.equals("")) {
				tmp.append("\n" + MessageManager.getString("CLOUDSCHEDULER.010", msg));
			}
	}

}
