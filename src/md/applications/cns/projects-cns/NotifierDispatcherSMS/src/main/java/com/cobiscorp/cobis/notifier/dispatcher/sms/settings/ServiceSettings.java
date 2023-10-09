package com.cobiscorp.cobis.notifier.dispatcher.sms.settings;

public class ServiceSettings {

	private int workerThreadsNumber = 1;

	public int getWorkerThreadsNumber() {
		return workerThreadsNumber;
	}

	public void setWorkerThreadsNumber(int workerThreadsNumber) {
		this.workerThreadsNumber = workerThreadsNumber;
	}
}
