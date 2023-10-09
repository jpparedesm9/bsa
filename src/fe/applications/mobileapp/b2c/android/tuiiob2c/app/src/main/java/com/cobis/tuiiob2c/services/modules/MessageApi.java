package com.cobis.tuiiob2c.services.modules;

import com.cobis.tuiiob2c.data.models.MessagePin;
import com.cobis.tuiiob2c.data.models.requests.MessageRequest;

import retrofit2.Call;
import retrofit2.http.Body;
import retrofit2.http.PUT;

public interface MessageApi {

    @PUT("messages/execute")
    Call<Void> answerMessage(@Body MessageRequest messageRequest);

    @PUT("messages/execute")
    Call<Void> answerMessagePin(@Body MessagePin messagePin);
}
