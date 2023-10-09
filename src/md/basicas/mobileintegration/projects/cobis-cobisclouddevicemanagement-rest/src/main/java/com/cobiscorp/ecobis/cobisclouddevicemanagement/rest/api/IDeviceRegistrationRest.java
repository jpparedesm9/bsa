package com.cobiscorp.ecobis.cobisclouddevicemanagement.rest.api;

import javax.servlet.http.HttpServletRequest;
import javax.ws.rs.core.Context;

public interface IDeviceRegistrationRest{
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  register (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceRegistrationRequest aDeviceRegistrationRequest,
  @Context HttpServletRequest httpRequest);
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  reportAsLost (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest);
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  tmpClear (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest);
   com.cobiscorp.cobis.web.services.commons.model.ServiceResponse  unsuscribe (
  com.cobiscorp.ecobis.cobisclouddevicemanagement.bsl.dto.DeviceIdentification aDeviceIdentification,
  @Context HttpServletRequest httpRequest);
}
