package com.cobiscorp.cobis.notifier.dispatcher.sms;

import java.util.Collection;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;
import java.util.concurrent.Future;
import java.util.concurrent.TimeUnit;

import com.cobiscorp.cobis.commons.components.ICOBISComponent;
import com.cobiscorp.cobis.commons.configuration.IConfigurationReader;
import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.cobiscorp.cobis.notifier.core.datasource.INotifierDataSource;
import com.cobiscorp.cobis.notifier.core.dispatcher.INotifierDispatcher;
import com.cobiscorp.cobis.notifier.core.dto.COBISNotification;
import com.cobiscorp.cobis.notifier.core.dto.Content;
import com.cobiscorp.cobis.notifier.dispatcher.sms.exceptions.InvalidContentException;
import com.cobiscorp.cobis.notifier.dispatcher.sms.service.MobileGatewayClient;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.DefaultSenderSettings;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.MobileGatewaySettings;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.ServiceSettings;
import com.cobiscorp.cobis.notifier.dispatcher.sms.settings.SettingsManager;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.*;

public class SmsDispatcher implements INotifierDispatcher, ICOBISComponent {

	private static ILogger logger = LogFactory.getLogger(SmsDispatcher.class);
	private IConfigurationReader reader;
	
	private ExecutorService dispatcherPool;
	
	private String logLevel;
	private MobileGatewaySettings mgSettings;
	private ServiceSettings serviceSettings;
	private DefaultSenderSettings senderSettings;
	
	@Override
	public void loadConfiguration(IConfigurationReader reader) {
		this.reader = reader;
		
		logger.logInfo("Loading SMSDispatcher configuration...");
		
		logLevel = SettingsManager.loadLogLevel(reader);
		mgSettings = SettingsManager.loadMobileGatewaySettings(reader);
		serviceSettings = SettingsManager.loadServiceSettings(reader);
		senderSettings = SettingsManager.loadDefaultSenderSettings(reader);
		
		logger.logInfo("Done");

		logger.logInfo("Initializing SMS Dispatcher Thread Pool... It will contain " + serviceSettings.getWorkerThreadsNumber() + " thread(s)...");
		dispatcherPool = Executors.newFixedThreadPool(serviceSettings.getWorkerThreadsNumber());
	}
	
	@Override
	public void sendMessage(Collection<Content> collectionToSend, INotifierDataSource dataSource) {
		List<Content> contents = new ArrayList<Content>();
		for (Content content : collectionToSend) {
			 Future<Boolean> future;
			 logger.logDebug("content: " + content.toString());
			try {
				MobileGatewayClient mgClient = new MobileGatewayClient(mgSettings, senderSettings, content, dataSource);
				
				future = dispatcherPool.submit(mgClient);
				
				content.setFuture(future);
                contents.add(content);
				
			} catch (InvalidContentException e) {
				logger.logError("Unable to create an MobileGatewayClient Thread because the supplied content was not valid.", e);
				logger.logError("The corresponding Notification will be marked as 'C - Cancelado por Error'. NotificationID:" + content.getNotification().getNotificationID());
				
				markMailWithError(dataSource, content, e);
			}
		}
				
		for (Content content: contents) {
            Future<Boolean> future = content.getFuture();
            try {

                Boolean response = future.get(1000, TimeUnit.SECONDS);

                if (logger.isDebugEnabled()) {
                    logger.logDebug(String.format("Mail sent success [%s]", response));
                }
            } catch (InterruptedException e) {
                logger.logError("Error of interrupted exception", e);
                markMailWithError(dataSource, content, e);
            } catch (ExecutionException e) {
                logger.logError("Error of execution exception", e);
                markMailWithError(dataSource, content, e);
            } catch (TimeoutException e) {
                logger.logError("Error by timeout", e);

                if (future == null) {
                    logger.logError("Instance thread future is null");
                } else {
                    future.cancel(true);

                    if (logger.isWarningEnabled()) {
                        logger.logWarning(String.format("Is thread cancelled [%s]", future.isCancelled()));
                    }
			}
                markMailWithError(dataSource, content, e);
            }
		}
		
	}
	
	public String getLogLevel() {
		return logLevel;
	}

	public void setLogLevel(String logLevel) {
		this.logLevel = logLevel;

		SettingsManager.updateLogLevel(reader, logLevel);
	}

	protected void activate() {
		logger.logInfo("Activando SMS Dispatcher");
	}
	
	/**
	 * Metodo del framework OSGI para liberar recursos
	 */
	protected void deactivate() {
    	logger.logInfo("Trying to release resources of SMS Dispatcher");
		this.shutdown();
    }
	
	/**
	 * Metodo que detiene e elimina los threads del pool.
	 */
	private void shutdown(){
		if(dispatcherPool != null){
			logger.logInfo("Shutting Down SMS dispatcher working threads...");
			try {
				dispatcherPool.shutdown();
				dispatcherPool.awaitTermination(5, TimeUnit.SECONDS);
				dispatcherPool.shutdownNow();
			} catch (InterruptedException e) {
				logger.logError("Interrupted exception received", e);
			}
		}
	}
	
    private void markMailWithError(INotifierDataSource dataSource, Content content, Exception e) {
	    logger.logError("The corresponding Notification will be marked as 'C - Cancelado por Error'. NotificationID:" + content.getNotification().getNotificationID());

	    COBISNotification notification = (COBISNotification) content.getNotification();
	    notification.setStatus("C"); // (C)ancelado por error
	    notification.setErrorInformation(e.getMessage().substring(0, 63));
        dataSource.updateNotificationStatus(notification);
    }
	 
}
