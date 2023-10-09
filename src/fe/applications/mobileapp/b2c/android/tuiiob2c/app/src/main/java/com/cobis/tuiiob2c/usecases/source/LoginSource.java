package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.responses.AuthResponse;
import com.cobis.tuiiob2c.data.models.requests.AuthRequest;

public interface LoginSource {

    AuthResponse auth(AuthRequest authRequest);
}
