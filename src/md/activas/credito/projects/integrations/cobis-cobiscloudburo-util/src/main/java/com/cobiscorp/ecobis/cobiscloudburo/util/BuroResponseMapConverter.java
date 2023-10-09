package com.cobiscorp.ecobis.cobiscloudburo.util;

import com.cobiscorp.cobis.commons.log.ILogger;
import com.cobiscorp.cobis.commons.log.LogFactory;
import com.thoughtworks.xstream.converters.Converter;
import com.thoughtworks.xstream.converters.MarshallingContext;
import com.thoughtworks.xstream.converters.UnmarshallingContext;
import com.thoughtworks.xstream.io.HierarchicalStreamReader;
import com.thoughtworks.xstream.io.HierarchicalStreamWriter;

import java.util.AbstractMap;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by pclavijo on 13/07/2017.
 */
public class BuroResponseMapConverter implements Converter {
    private static ILogger logger = LogFactory.getLogger(BuroResponseMapConverter.class);
    private static final String className = "[BuroResponseMapConverter]";

    @Override
    public void marshal(Object source, HierarchicalStreamWriter writer, MarshallingContext context) {

    }

    @Override
    public Object unmarshal(HierarchicalStreamReader hierarchicalStreamReader, UnmarshallingContext unmarshallingContext) {
        if (logger.isDebugEnabled()) {
            logger.logDebug(className + "[unmarshal]");
        }
        return xmlToMap(hierarchicalStreamReader, hierarchicalStreamReader.getNodeName());
    }

    private Map<String, Object> xmlToMap(HierarchicalStreamReader reader, String parentNode) {
        Map<String, Object> map = new HashMap<String, Object>();
        int sequential = 0;

//        if (logger.isTraceEnabled()) {
//            logger.logTrace("parentNode: " + parentNode);
//        }

        while (reader.getNodeName().contentEquals(parentNode) && reader.hasMoreChildren()) {
            reader.moveDown();
//            if (logger.isTraceEnabled()) {
//                logger.logTrace("childNode: " + reader.getNodeName() + ":" + reader.getValue());
//            }
            if (reader.hasMoreChildren()) {
//                if (logger.isTraceEnabled()) {
//                    logger.logTrace("has internal children");
//                }
                Object objValue = xmlToMap(reader, reader.getNodeName());
                map.put(reader.getNodeName() + "_" + String.valueOf(sequential), objValue);
            } else {
//                if (logger.isTraceEnabled()) {
//                    logger.logTrace("has not internal children");
//                }
                map.put(reader.getNodeName(), reader.getValue());
            }
            reader.moveUp();
//            if (logger.isTraceEnabled()) {
//                logger.logTrace("nodeUp :" + reader.getNodeName());
//            }
            sequential++;
        }

//        if (logger.isTraceEnabled()) {
//            logger.logTrace("map[" + reader.getNodeName() + "]: " + map.toString());
//        }

        return map;
    }

    @Override
    public boolean canConvert(Class aClass) {
        return AbstractMap.class.isAssignableFrom(aClass);
    }
}
