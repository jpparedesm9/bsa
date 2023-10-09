package com.cobis.tuiiob2c.usecases.source;

import com.cobis.tuiiob2c.data.models.requests.LoanInfoRequest;
import com.cobis.tuiiob2c.data.models.responses.LoanInfoResponse;
import com.cobis.tuiiob2c.data.models.responses.ParametersResponse;

public interface LoanSource {

    LoanInfoResponse getLoanInfo(LoanInfoRequest loanInfoRequest);

    ParametersResponse getParametersDispersion();
}
