package com.cobiscorp.test;

import org.junit.runner.RunWith;
import org.junit.runners.Suite;
import org.junit.runners.Suite.SuiteClasses;

@RunWith(Suite.class)
@SuiteClasses({ 
    EnrollmentTest.class, 
    DisbursementTest.class, 
    LoanInfoTest.class, 
    LogoutTest.class, 
    MessagesTest.class,
    ParametersTest.class, 
    ResetPasswordTest.class, 
    SecurityTest.class 
    })
public class AllTests {

}
