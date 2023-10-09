package com.cobis.gestionasesores.data.source.remote;

import com.bayteq.libcore.util.DeviceUtils;
import com.cobis.gestionasesores.Constants;
import com.cobis.gestionasesores.data.models.requests.AuthRequest;
import com.cobis.gestionasesores.data.models.responses.AuthResponse;
import com.cobis.gestionasesores.data.repositories.AuthRepository;
import com.cobis.gestionasesores.data.source.AuthDataSource;

import org.junit.Test;

import static org.junit.Assert.assertNotNull;

/**
 * Created by jescudero on 23/08/2017.
 */

public class AuthTest {

    @Test
    public void login() throws Exception {
        AuthDataSource authDataSource = AuthRepository.getInstance();
        String deviceId = DeviceUtils.getSerialID();
        AuthRequest request = new AuthRequest(Constants.DEBUG_USER, Constants.DEBUG_PASSWORD,null,  deviceId, Constants.CHANNEL);
        AuthResponse response = authDataSource.login(request);
        if(response.isResult()){
            assertNotNull(response.getToken());
            assertNotNull(response.getOfficerName());
            assertNotNull(response.isProceedToCompleteRegistration());
        }
    }


}
