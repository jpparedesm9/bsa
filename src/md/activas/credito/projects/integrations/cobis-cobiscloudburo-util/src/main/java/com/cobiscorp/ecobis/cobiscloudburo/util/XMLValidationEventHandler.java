package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;

import javax.xml.bind.ValidationEvent;
import javax.xml.bind.ValidationEventHandler;

/**
 * Created by pclavijo on 12/07/2017.
 */
public class XMLValidationEventHandler implements ValidationEventHandler {
    private static ILogger logger = LogFactory.getLogger(XMLValidationEventHandler.class);
    private static final String className = "[XMLValidationEventHandler]";

    @Override
    public boolean handleEvent(ValidationEvent event) {
        StringBuilder sb = new StringBuilder();
        sb.append("\nEVENT");
        sb.append("\n\tSEVERITY: ");
        sb.append(event.getSeverity());
        sb.append("\n\tMESSAGE: ");
        sb.append(event.getMessage());
        sb.append("\n\tLINKED EXCEPTION: ");
        sb.append(event.getLinkedException());
        sb.append("\nLOCATOR");
        sb.append("\n\tLINE NUMBER: ");
        sb.append(event.getLocator().getLineNumber());
        sb.append("\n\tCOLUMN NUMBER: ");
        sb.append(event.getLocator().getColumnNumber());
        sb.append("\n\tOFFSET: ");
        sb.append(event.getLocator().getOffset());
        sb.append("\n\tOBJECT: ");
        sb.append(event.getLocator().getObject());
        sb.append("\n\tNODE: ");
        sb.append(event.getLocator().getNode());
        sb.append("\n\tURL: ");
        sb.append(event.getLocator().getURL());
        if (logger.isDebugEnabled()) {
            logger.logError("XML Validation error: " + sb);
        }
        return false;
    }
}
