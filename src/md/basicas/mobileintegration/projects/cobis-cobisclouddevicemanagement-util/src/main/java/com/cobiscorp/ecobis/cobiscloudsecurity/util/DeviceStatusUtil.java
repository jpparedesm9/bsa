package com.cobiscorp.ecobis.cobiscloudsecurity.util;

import com.cobiscorp.cobis.commons.exceptions.COBISInfrastructureRuntimeException;

import java.lang.reflect.Array;

/**
 * @author Fernando Abad
 */
public class DeviceStatusUtil {

    private DeviceStatusUtil() {
    }


    public static DeviceStatus getDeviceStatus(String status) {
        char statusChar = status.charAt(0);
        DeviceStatus deviceStatus = null;
        switch (statusChar) {
            case  'P': deviceStatus = DeviceStatus.PRE_REGISTERED;
                break;
            case 'R': deviceStatus = DeviceStatus.REGISTERED;
                break;
            case 'L': deviceStatus = DeviceStatus.LOCK;
                break;
            case 'U': deviceStatus = DeviceStatus.UNSUSCRIBED;
                break;

            default: throw new COBISInfrastructureRuntimeException("device status not found");

        }
        return deviceStatus;

    }
}
