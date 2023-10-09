package com.cobiscorp.ecobis.cobiscloudrenapo.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientRequest;
import com.cobiscorp.ecobis.cobiscloudbiometric.bsl.dto.RenapoClientResponse;

public interface IOrchestationRenapoService {
	RenapoClientResponse renapoQueryByDetail(RenapoClientRequest renapoClientRequest) throws Exception;
}
