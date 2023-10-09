package com.cobiscorp.ecobis.cobiscloudsecurity.util;

import org.junit.Assert;
import org.junit.Test;

/**
 * Created by fervincent on 22/08/17.
 */
public class DeviceStatusUtilTest {

    @Test
    public void itShouldVerifyPreRegisterStatus() {

        Assert.assertTrue(DeviceStatus.PRE_REGISTERED.isProceedToCompleteRegistration());
        Assert.assertFalse(DeviceStatus.PRE_REGISTERED.isLock());
    }

    @Test
    public void itShouldVerifyRegisterStatus() {
        Assert.assertFalse(DeviceStatus.REGISTERED.isProceedToCompleteRegistration());
        Assert.assertFalse(DeviceStatus.REGISTERED.isLock());

    }
    @Test
    public void itShouldVerifyLockStatus() {
        Assert.assertFalse(DeviceStatus.LOCK.isProceedToCompleteRegistration());
        Assert.assertTrue(DeviceStatus.LOCK.isLock());

    }
    @Test
    public void itShouldVerifyUnsuscribedStatus() {
        Assert.assertFalse(DeviceStatus.UNSUSCRIBED.isProceedToCompleteRegistration());
        Assert.assertTrue(DeviceStatus.UNSUSCRIBED.isLock());

    }

    @Test
    public void itShouldReturnEnumFromString() {
        Assert.assertEquals(DeviceStatus.PRE_REGISTERED, DeviceStatusUtil.getDeviceStatus(DeviceStatus.PRE_REGISTERED.getStatus()));
        Assert.assertEquals(DeviceStatus.REGISTERED, DeviceStatusUtil.getDeviceStatus(DeviceStatus.REGISTERED.getStatus()));
        Assert.assertEquals(DeviceStatus.UNSUSCRIBED, DeviceStatusUtil.getDeviceStatus(DeviceStatus.UNSUSCRIBED.getStatus()));
        Assert.assertEquals(DeviceStatus.LOCK, DeviceStatusUtil.getDeviceStatus(DeviceStatus.LOCK.getStatus()));
    }



}
