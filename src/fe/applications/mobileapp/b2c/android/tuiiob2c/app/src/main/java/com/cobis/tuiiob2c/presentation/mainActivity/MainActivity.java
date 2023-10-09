package com.cobis.tuiiob2c.presentation.mainActivity;

import android.os.Bundle;
import android.support.design.widget.BottomNavigationView;
import android.support.v4.app.Fragment;
import android.support.v7.app.AppCompatActivity;

import com.cobis.tuiiob2c.R;
import com.cobis.tuiiob2c.presentation.mainActivity.home.HomeFragment;
import com.cobis.tuiiob2c.presentation.mainActivity.notifications.NotificationsFragment;
import com.cobis.tuiiob2c.presentation.mainActivity.settings.SettingsFragment;

import java.util.ArrayList;
import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MainActivity extends AppCompatActivity {

    @BindView(R.id.navigation)
    BottomNavigationView navigation;
    List<Fragment> fragments = new ArrayList<>();

    private BottomNavigationView.OnNavigationItemSelectedListener mOnNavigationItemSelectedListener = item -> {
        switch (item.getItemId()) {
            case R.id.navigation_home:
                getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragments.get(0)).commit();
                return true;
            case R.id.navigation_notifications:
                getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragments.get(1)).commit();
                return true;
            case R.id.navigation_config:
                getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragments.get(2)).commit();
                return true;
        }
        return false;
    };

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        ButterKnife.bind(this);

        navigation.setOnNavigationItemSelectedListener(mOnNavigationItemSelectedListener);
        fragments.add(HomeFragment.newInstance());
        fragments.add(NotificationsFragment.newInstance());
        fragments.add(SettingsFragment.newInstance());

        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragments.get(0)).commit();
    }
}
