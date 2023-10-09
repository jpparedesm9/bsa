package com.cobis.gestionasesores.presentation.menu;

import android.app.ProgressDialog;
import android.content.Context;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.NonNull;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.design.widget.NavigationView;
import android.support.v4.view.GravityCompat;
import android.support.v4.widget.DrawerLayout;
import android.support.v7.app.ActionBar;
import android.support.v7.app.AlertDialog;
import android.support.v7.widget.Toolbar;
import android.view.MenuItem;
import android.view.View;
import android.widget.TextView;

import com.bayteq.libcore.util.StringUtils;
import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Session;
import com.cobis.gestionasesores.data.repositories.GroupRepository;
import com.cobis.gestionasesores.data.repositories.PersonRepository;
import com.cobis.gestionasesores.data.repositories.SimulationRepository;
import com.cobis.gestionasesores.data.repositories.TaskRepository;
import com.cobis.gestionasesores.domain.usecases.ComputeAmortizationTableUseCase;
import com.cobis.gestionasesores.domain.usecases.GetGroupsForCredit;
import com.cobis.gestionasesores.domain.usecases.GetGroupsUseCase;
import com.cobis.gestionasesores.domain.usecases.GetPersonsUseCase;
import com.cobis.gestionasesores.domain.usecases.GetTasksUseCase;
import com.cobis.gestionasesores.presentation.BaseActivity;
import com.cobis.gestionasesores.presentation.DefaultFragment;
import com.cobis.gestionasesores.presentation.applications.CreditAppFragment;
import com.cobis.gestionasesores.presentation.applications.CreditAppPresenter;
import com.cobis.gestionasesores.presentation.changepin.ChangePinActivity;
import com.cobis.gestionasesores.presentation.comments.CommentActivity;
import com.cobis.gestionasesores.presentation.groups.GroupsFragment;
import com.cobis.gestionasesores.presentation.groups.GroupsPresenter;
import com.cobis.gestionasesores.presentation.launcher.LauncherActivity;
import com.cobis.gestionasesores.presentation.people.PeopleFragment;
import com.cobis.gestionasesores.presentation.people.PeoplePresenter;
import com.cobis.gestionasesores.presentation.settings.SettingsActivity;
import com.cobis.gestionasesores.presentation.simulation.SimulationFragment;
import com.cobis.gestionasesores.presentation.simulation.SimulationPresenter;
import com.cobis.gestionasesores.presentation.synchronization.SynchronizationActivity;
import com.cobis.gestionasesores.presentation.synchronization.upload.UploadActivity;
import com.cobis.gestionasesores.presentation.tasks.TasksFragment;
import com.cobis.gestionasesores.presentation.tasks.TasksPresenter;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Private Menu Activity
 * Created by Miguel on 04/06/2017.
 */
public class MenuActivity extends BaseActivity implements MenuContract.View, NavigationView.OnNavigationItemSelectedListener {
    private static final int DEFAULT_MENU_POSITION = 0;

    @BindView(R.id.drawer_layout)
    DrawerLayout mDrawerLayout;
    @BindView(R.id.nav_view)
    NavigationView mNavigationView;

    private ProgressDialog progressLoading;
    private MenuContract.Presenter mPresenter;

    public static Intent newIntent(Context context) {
        Intent intent = new Intent(context, MenuActivity.class);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TASK);
        intent.addFlags(Intent.FLAG_ACTIVITY_CLEAR_TOP);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_menu);
        ButterKnife.bind(this);

        // Set up the toolbar.
        Toolbar toolbar = (Toolbar) findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        ActionBar ab = getSupportActionBar();
        ab.setHomeAsUpIndicator(R.drawable.ic_menu);
        ab.setDisplayHomeAsUpEnabled(true);

        // Set up the navigation drawer.
        mDrawerLayout.setStatusBarBackground(R.color.colorPrimaryDark);
        mNavigationView.setNavigationItemSelectedListener(this);

        new MenuPresenter(this);
        mPresenter.start();
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        switch (item.getItemId()) {
            case android.R.id.home:
                mDrawerLayout.openDrawer(GravityCompat.START);
                return true;
        }
        return super.onOptionsItemSelected(item);
    }

    @Override
    public void onBackPressed() {
        showLogoutWarning();
    }

    private void showLogoutWarning() {
        new AlertDialog.Builder(this).setTitle(R.string.logout_title)
                .setMessage(R.string.logout_message)
                .setCancelable(false)
                .setPositiveButton(R.string.logout_title, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialog, int which) {
                        if (mPresenter != null) {
                            mPresenter.onOptionLogoutClick();
                        }
                    }
                }).setNegativeButton(R.string.action_cancel, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                dialog.dismiss();
            }
        }).show();
    }

    @Override
    public void setPresenter(MenuContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void showCustomersFragment() {
        PeopleFragment fragment = PeopleFragment.newInstance();
        showTitle(R.string.people_title, true);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        new PeoplePresenter(fragment, new GetPersonsUseCase(PersonRepository.getInstance()));
    }

    @Override
    public void showGroupsFragment() {
        GroupsFragment fragment = GroupsFragment.newInstance();
        showTitle(R.string.groups_title, false);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        new GroupsPresenter(fragment, GroupsPresenter.Mode.MODE_ADD, new GetGroupsUseCase(GroupRepository.getInstance()), new GetGroupsForCredit(GroupRepository.getInstance()));
    }

    @Override
    public void showApplicationsFragment() {
        CreditAppFragment fragment = CreditAppFragment.newInstance();
        showTitle(R.string.credit_app_title, true);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        new CreditAppPresenter(fragment);
    }

    @Override
    public void showSimulationFragment() {
        SimulationFragment fragment = SimulationFragment.newInstance();
        showTitle(R.string.simulation_title, false);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        new SimulationPresenter(fragment, new ComputeAmortizationTableUseCase(SimulationRepository.getInstance()));
    }

    @Override
    public void showSynchronizationActivity(boolean isForcedOpen) {
        startActivity(SynchronizationActivity.newIntent(this, isForcedOpen));
    }

    @Override
    public void showUploadActivity() {
        startActivity(UploadActivity.newIntent(this));
    }

    @Override
    public void selectDefaultMenuOption() {
        MenuItem menuItem = mNavigationView.getMenu().getItem(DEFAULT_MENU_POSITION);
        menuItem.setChecked(true);
        onNavigationItemSelected(menuItem);
    }

    @Override
    public void showTaskFragment() {
        TasksFragment fragment = TasksFragment.newInstance();
        showTitle(R.string.tasks_title, true);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        new TasksPresenter(fragment, new GetTasksUseCase(TaskRepository.getInstance()));
    }

    @Override
    public void showSessionInfo(Session session) {
        ((TextView) mNavigationView.getHeaderView(0).findViewById(R.id.text_account_name)).setText(StringUtils.nullToString(session.getOfficerName()));
    }

    @Override
    public void showCommentsActivity() {
        startActivity(CommentActivity.newIntent(getBaseContext()));
    }

    @Override
    public void logout() {
        startActivity(LauncherActivity.newIntent(this));
        finish();
    }

    @Override
    public void navigateToChangePin() {
        startActivity(ChangePinActivity.newIntent(this));
    }

    @Override
    public void showSyncDialog(int itemCount) {
        new AlertDialog.Builder(this).setTitle(R.string.sync_title)
                .setMessage(getResources().getQuantityString(R.plurals.synchronization_pending_items_question, itemCount, itemCount))
                .setCancelable(false)
                .setNegativeButton(android.R.string.cancel, null)
                .setPositiveButton(R.string.sync_title, new DialogInterface.OnClickListener() {
                    @Override
                    public void onClick(DialogInterface dialogInterface, int i) {
                        mPresenter.onOpenUploadClick();
                    }
                }).create().show();
    }

    @Override
    public void showLoading() {
        hideLoading();
        progressLoading = new ProgressDialog(this);
        progressLoading.setMessage(getString(R.string.synchronization_loading_item_count_msg));
        progressLoading.setCancelable(false);
        progressLoading.setCanceledOnTouchOutside(false);
        progressLoading.show();
    }

    @Override
    public void hideLoading() {
        if (progressLoading != null && progressLoading.isShowing()) {
            progressLoading.dismiss();
            progressLoading = null;
        }
    }

    @Override
    public void navigateToSettings() {
        startActivity(SettingsActivity.newIntent(this));
    }

    @Override
    public void showDefaultFragment() {
        showTitle(R.string.app_name, false);
        getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, DefaultFragment.newInstance()).commit();
    }

    @Override
    public void closeDrawer() {
        if (mDrawerLayout != null) {
            mDrawerLayout.closeDrawers();
        }
    }

    private void showTitle(@StringRes int title, boolean isCustom) {
        getSupportActionBar().setDisplayShowTitleEnabled(!isCustom);
        if (isCustom) {
            getToolbar().findViewById(R.id.spinner_nav).setVisibility(View.VISIBLE);
        } else {
            getToolbar().findViewById(R.id.spinner_nav).setVisibility(View.GONE);
            getSupportActionBar().setTitle(title);
        }
    }

    @Override
    public boolean onNavigationItemSelected(@NonNull MenuItem item) {
        switch (item.getItemId()) {
            case R.id.list_people:
                mPresenter.onDrawerOptionCustomerClick();
                break;
            case R.id.list_group:
                mPresenter.onDrawerOptionGroupClick();
                break;
            case R.id.list_credit_app:
                mPresenter.onDrawerOptionApplicationClick();
                break;
            case R.id.list_simulation:
                mPresenter.onDrawerOptionSimulationClick();
                break;
            case R.id.list_logout:
                showLogoutWarning();
                break;
            case R.id.list_tasks:
                mPresenter.onDrawerOptionTaskClick();
                break;
            case R.id.list_settings:
                mPresenter.onDrawerOptionSettingsClick();
                break;
            case R.id.list_sync:
                mPresenter.onDrawerOptionSynchronizationClick();
                break;
            default:
                mPresenter.onDrawerOptionDefaultClick();
                break;
        }
        setTitle(item.getTitle());
        return true;
    }
}
