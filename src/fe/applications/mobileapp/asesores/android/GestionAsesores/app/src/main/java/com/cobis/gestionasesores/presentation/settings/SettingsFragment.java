package com.cobis.gestionasesores.presentation.settings;

import android.os.Bundle;
import android.preference.Preference;
import android.preference.PreferenceFragment;
import android.preference.PreferenceManager;
import android.support.annotation.Nullable;
import android.view.View;

import com.bayteq.libcore.LibCore;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.presentation.changepin.ChangePinActivity;
import com.cobis.gestionasesores.presentation.comments.CommentActivity;

/**
 * Created by jescudero on 01/09/2017.
 */

public class SettingsFragment extends PreferenceFragment implements SettingsContract.SettingsView {

    private SettingsContract.SettingsPresenter mPresenter;
    private static final String PREF_COMMENTS = "pref_comments";
    private static final String PREF_CHANGE_PIN = "pref_change_pin";

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        addPreferencesFromResource(R.xml.preferences);
    }

    @Override
    public void setPresenter(SettingsContract.SettingsPresenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        PreferenceManager preferenceManager = getPreferenceManager();
        Preference commentsPref = preferenceManager.findPreference(PREF_COMMENTS);
        commentsPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener() {
            @Override
            public boolean onPreferenceClick(Preference preference) {
                startActivity(CommentActivity.newIntent(LibCore.getApplicationContext()));
                return true;
            }
        });
        Preference changePinPref = preferenceManager.findPreference(PREF_CHANGE_PIN);
        changePinPref.setOnPreferenceClickListener(new Preference.OnPreferenceClickListener(){

            @Override
            public boolean onPreferenceClick(Preference preference) {
                startActivity(ChangePinActivity.newIntent(LibCore.getApplicationContext()));
                return true;
            }
        });
    }
}
