package com.cobiscorp.ecobis.cobiscloudsynchronization.bsl.serv.impl;

import com.cobiscorp.cobis.commons.log.ILogger;
import org.apache.logging.log4j.LoggingException;

import java.io.PrintWriter;
import java.io.StringWriter;

/**
 * Created by farid on 8/1/2017.
 */
public class SynchronizationUtil {
    public static void logException(ILogger logger, Exception e){
        if (logger.isErrorEnabled()) {
            StringWriter sw = new StringWriter();
            e.printStackTrace(new PrintWriter(sw));
            String exceptionDetails = sw.toString();
            logger.logError(exceptionDetails);
        }
    }
}
