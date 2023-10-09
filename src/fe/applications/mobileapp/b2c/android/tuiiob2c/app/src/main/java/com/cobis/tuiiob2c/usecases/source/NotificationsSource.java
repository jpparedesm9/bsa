package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.BaseModel;
import com.cobis.tuiiob2c.data.models.requests.MessageRequest;

public interface NotificationsSource {

    BaseModel responseMessage(MessageRequest messageRequest);
}
