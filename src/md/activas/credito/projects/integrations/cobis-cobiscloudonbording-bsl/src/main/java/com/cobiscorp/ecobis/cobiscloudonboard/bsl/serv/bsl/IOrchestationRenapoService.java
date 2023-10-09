package com.cobiscorp.ecobis.cobiscloudonboard.bsl.serv.bsl;

import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientRequest;
import com.cobiscorp.ecobis.cobiscloudonboard.bsl.dto.RenapoClientResponse;

public interface IOrchestationRenapoService {
	RenapoClientResponse renapoQueryByCurp(RenapoClientRequest renapoClientRequest) throws Exception;
}
