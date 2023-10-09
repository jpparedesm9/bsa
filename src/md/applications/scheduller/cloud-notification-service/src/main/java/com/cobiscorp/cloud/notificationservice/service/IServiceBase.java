package com.cobiscorp.cloud.notificationservice.service;

import java.io.File;
import java.util.List;
import java.util.Map;

public interface IServiceBase {

	List<?> xmlToDTO(File inputData);

	Map<String, Object> setParameterToJasper(Object inputDto);

	List<?> setCollection(Object inputDto);

	Map<String, Object> setParameterToSendMail(Object inputDto);
}
