package com.cobis.gestionasesores;

import android.support.test.runner.AndroidJUnit4;

import com.cobis.gestionasesores.infrastructure.jwt.JWT;

import org.junit.Test;
import org.junit.runner.RunWith;

import java.util.Date;

import static org.hamcrest.CoreMatchers.equalTo;
import static org.hamcrest.CoreMatchers.instanceOf;
import static org.hamcrest.MatcherAssert.assertThat;
import static org.hamcrest.core.Is.is;
import static org.hamcrest.core.IsNull.notNullValue;


/**
 * Created by mnaunay on 22/08/2017.
 */

@RunWith(AndroidJUnit4.class)
public class JWTTest {

    @Test
    public void shouldGetStringToken() throws Exception {
        JWT jwt = new JWT("eyJhbGciOiJIUzUxMiJ9.eyJkZXZpY2VJZCI6IjU0NTQ1NDQiLCJzZXNzaW9uSWQiOiJJRDo0NjdDNDY3RTdCN0MzNDQ0N0I3QzQ2N0UzNDMwNDYzNDdCMzQ0NjY1NDYzQjQ2N0I3QjM0NjM0NDYzN0MzNDQ0NzA0NDNCNDQ1NTQ2N0I1NTM0NDQ0NDY1N0I1NTdDNjUiLCJjaGFubmVsIjoyMCwidXNlciI6ImFkbXVzZXIiLCJleHAiOjE1MDM0NjQ0MDB9.-hcVItxiNCugQQLiFw_7SNYkpedckdKNT2b8kkDmBuX82Mjy9DJE1aN8LgBMehP4NH4RcYRARbo9eRQcMaXz5g");
        assertThat(jwt, is(notNullValue()));
        assertThat(jwt.toString(), is(notNullValue()));
        assertThat(jwt.toString(), is("eyJhbGciOiJIUzUxMiJ9.eyJkZXZpY2VJZCI6IjU0NTQ1NDQiLCJzZXNzaW9uSWQiOiJJRDo0NjdDNDY3RTdCN0MzNDQ0N0I3QzQ2N0UzNDMwNDYzNDdCMzQ0NjY1NDYzQjQ2N0I3QjM0NjM0NDYzN0MzNDQ0NzA0NDNCNDQ1NTQ2N0I1NTM0NDQ0NDY1N0I1NTdDNjUiLCJjaGFubmVsIjoyMCwidXNlciI6ImFkbXVzZXIiLCJleHAiOjE1MDM0NjQ0MDB9.-hcVItxiNCugQQLiFw_7SNYkpedckdKNT2b8kkDmBuX82Mjy9DJE1aN8LgBMehP4NH4RcYRARbo9eRQcMaXz5g"));
    }

    @Test
    public void shouldGetSessionId(){
        JWT jwt = new JWT("eyJhbGciOiJIUzUxMiJ9.eyJkZXZpY2VJZCI6IjU0NTQ1NDQiLCJzZXNzaW9uSWQiOiJJRDo0NjdDNDY3RTdCN0MzNDQ0N0I3QzQ2N0UzNDMwNDYzNDdCMzQ0NjY1NDYzQjQ2N0I3QjM0NjM0NDYzN0MzNDQ0NzA0NDNCNDQ1NTQ2N0I1NTM0NDQ0NDY1N0I1NTdDNjUiLCJjaGFubmVsIjoyMCwidXNlciI6ImFkbXVzZXIiLCJleHAiOjE1MDM0NjQ0MDB9.-hcVItxiNCugQQLiFw_7SNYkpedckdKNT2b8kkDmBuX82Mjy9DJE1aN8LgBMehP4NH4RcYRARbo9eRQcMaXz5g");
        assertThat(jwt, is(notNullValue()));
        assertThat(jwt.getId(),is("ID:467C467E7B7C34447B7C467E343046347B344665463B467B7B346344637C344470443B4455467B55344444657B557C65"));
    }

    @Test
    public void shouldGetExpirationTime() throws Exception {
        JWT jwt = new JWT("eyJhbGciOiJIUzUxMiJ9.eyJkZXZpY2VJZCI6IjU0NTQ1NDQiLCJzZXNzaW9uSWQiOiJJRDo0NjdDNDY3RTdCN0MzNDQ0N0I3QzQ2N0UzNDMwNDYzNDdCMzQ0NjY1NDYzQjQ2N0I3QjM0NjM0NDYzN0MzNDQ0NzA0NDNCNDQ1NTQ2N0I1NTM0NDQ0NDY1N0I1NTdDNjUiLCJjaGFubmVsIjoyMCwidXNlciI6ImFkbXVzZXIiLCJleHAiOjE1MDM0NjQ0MDB9.-hcVItxiNCugQQLiFw_7SNYkpedckdKNT2b8kkDmBuX82Mjy9DJE1aN8LgBMehP4NH4RcYRARbo9eRQcMaXz5g");
        assertThat(jwt, is(notNullValue()));
        assertThat(jwt.getExpiresAt(), is(instanceOf(Date.class)));
        long ms = 1503464400L * 1000;
        Date expectedDate = new Date(ms);
        assertThat(jwt.getExpiresAt(), is(notNullValue()));
        assertThat(jwt.getExpiresAt(), is(equalTo(expectedDate)));
    }

    @Test
    public void shouldTokenExpiredTime() throws Exception {
        JWT jwt = new JWT("eyJhbGciOiJIUzUxMiJ9.eyJkZXZpY2VJZCI6IjU0NTQ1NDQiLCJzZXNzaW9uSWQiOiJJRDo0NjdDNDY3RTdCN0MzNDQ0N0I3QzQ2N0UzNDMwNDYzNDdCMzQ0NjY1NDYzQjQ2N0I3QjM0NjM0NDYzN0MzNDQ0NzA0NDNCNDQ1NTQ2N0I1NTM0NDQ0NDY1N0I1NTdDNjUiLCJjaGFubmVsIjoyMCwidXNlciI6ImFkbXVzZXIiLCJleHAiOjE1MDM0NjQ0MDB9.-hcVItxiNCugQQLiFw_7SNYkpedckdKNT2b8kkDmBuX82Mjy9DJE1aN8LgBMehP4NH4RcYRARbo9eRQcMaXz5g");
        assertThat(jwt, is(notNullValue()));
        assertThat(jwt.getExpiresAt(), is(instanceOf(Date.class)));
        assertThat(jwt.isExpired(24),is(Boolean.TRUE));
    }
}

