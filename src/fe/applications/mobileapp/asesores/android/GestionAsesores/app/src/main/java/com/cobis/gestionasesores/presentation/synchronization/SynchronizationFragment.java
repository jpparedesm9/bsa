package com.cobis.gestionasesores.presentation.synchronization;

import android.app.AlertDialog;
import android.os.Bundle;
import android.support.annotation.Nullable;
import android.support.annotation.StringRes;
import android.support.v4.app.Fragment;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.view.animation.Animation;
import android.view.animation.AnimationUtils;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.TextView;
import android.widget.Toast;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.presentation.synchronization.upload.UploadActivity;

import butterknife.BindView;
import butterknife.ButterKnife;
import butterknife.OnClick;

/**
 * A simple {@link Fragment} subclass.
 * Use the {@link SynchronizationFragment#newInstance} factory method to
 * create an instance of this fragment.
 */
public class SynchronizationFragment extends Fragment implements SynchronizationContract.View {

    @BindView(R.id.image_sync)
    ImageView mSyncPullImageView;
    @BindView(R.id.text_sync_up)
    TextView mSyncUpTextView;
    @BindView(R.id.image_sync_catalog)
    ImageView mSyncCatalogImageView;
    @BindView(R.id.text_sync_catalog)
    TextView mSyncCatalogTextView;
    @BindView(R.id.text_sync_down)
    TextView mSyncDownTextView;
    @BindView(R.id.btn_continue)
    Button mContinueBtn;

    private SynchronizationContract.Presenter mPresenter;

    public SynchronizationFragment() {
        // Required empty public constructor
    }

    /**
     * Use this factory method to create a new instance of
     * this fragment using the provided parameters.
     *
     * @return A new instance of fragment SynchronizationFragment.
     */
    public static SynchronizationFragment newInstance() {
        SynchronizationFragment fragment = new SynchronizationFragment();
        Bundle args = new Bundle();
        fragment.setArguments(args);
        return fragment;
    }

    @Override
    public void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container, Bundle savedInstanceState) {
        // Inflate the layout for this fragment
        return inflater.inflate(R.layout.fragment_synchronization, container, false);
    }

    @Override
    public void onViewCreated(View view, @Nullable Bundle savedInstanceState) {
        super.onViewCreated(view, savedInstanceState);
        ButterKnife.bind(this, view);
    }

    @Override
    public void setPresenter(SynchronizationContract.Presenter presenter) {
        mPresenter = presenter;
    }

    @Override
    public void onResume() {
        super.onResume();
        mPresenter.registerReceiver();
        mPresenter.start();
    }

    @Override
    public void onPause() {
        super.onPause();
        mPresenter.unregisterReceiver();
    }

    @OnClick(R.id.sync_up)
    public void onSynchronizeUp(View view) {
        mPresenter.startSyncUp();
    }

    @OnClick(R.id.sync_down)
    public void onSynchronizeDown(View view) {
        mPresenter.synchronizeDown();
    }

    @OnClick(R.id.sync_catalog)
    public void onSynchronizeCatalog(View view) {
        mPresenter.synchronizeCatalog();
    }

    @Override
    public void setSyncUpTime(@StringRes int message, Object... formatArgs) {
        mSyncUpTextView.setText(getString(message, formatArgs));
    }

    @Override
    public void setSyncDownTime(@StringRes int message, Object... formatArgs) {
        mSyncDownTextView.setText(getString(message, formatArgs));
    }

    @Override
    public void setSyncCatalogTime(@StringRes int message, Object... formatArgs) {
        mSyncCatalogTextView.setText(getString(message, formatArgs));
    }

    @Override
    public void showSyncDownloadError() {
        new AlertDialog.Builder(getContext())
                .setMessage(R.string.sync_dialog_download_generic_error)
                .setPositiveButton(R.string.action_accept, null)
                .setCancelable(false)
                .show();
    }

    @Override
    public void showSyncItemError(int errorId) {
        String message = errorId > 0 ? getString(R.string.sync_dialog_item_error, String.valueOf(errorId)) : getString(R.string.sync_dialog_download_generic_error);
        new AlertDialog.Builder(getContext())
                .setMessage(message)
                .setPositiveButton(R.string.action_accept, null)
                .setCancelable(false)
                .show();
    }

    @Override
    public synchronized void startSyncAnimation(@StringRes int message, Object... formatArgs) {
        if (!getActivity().isFinishing()) {
            Animation rotate = AnimationUtils.loadAnimation(getContext(), R.anim.shake_rotate);
            mSyncPullImageView.startAnimation(rotate);
            setSyncDownTime(message, formatArgs);
        }
    }

    @Override
    public void stopSyncAnimation(@StringRes int message, Object... formatArgs) {
        if (!getActivity().isFinishing()) {
            mSyncPullImageView.clearAnimation();
            setSyncDownTime(message, formatArgs);
        }
    }

    @Override
    public void showCatalogsSync() {
        if (!getActivity().isFinishing()) {
            mSyncCatalogTextView.setText(R.string.synchronization_catalog_sync_msg);
            Animation rotate = AnimationUtils.loadAnimation(getContext(), R.anim.refresh_rotate);
            mSyncCatalogImageView.startAnimation(rotate);
        }
    }

    @Override
    public void showCatalogsSynced(@StringRes int message, Object... formatArgs) {
        if (isAdded() && !getActivity().isFinishing()) {
            this.setSyncCatalogTime(message, formatArgs);
            mSyncCatalogImageView.clearAnimation();
        }
    }

    @Override
    public void showCatalogSyncError() {
        if (!getActivity().isFinishing()) {
            mSyncCatalogTextView.setText(R.string.synchronization_catalog_error_msg);
            mSyncCatalogImageView.clearAnimation();
        }
    }

    @Override
    public void startSyncUp() {
        startActivity(UploadActivity.newIntent(getContext()));
    }

    @Override
    public void showSyncRunning() {
        Toast.makeText(getContext(), getString(R.string.synchronization_sync_running), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void showRetryPlease() {
        Toast.makeText(getContext(), getString(R.string.synchronization_retry_please), Toast.LENGTH_SHORT).show();
    }

    @Override
    public void exit() {
        getActivity().finish();
    }

    @Override
    public void showContinue(boolean shouldShow,boolean tryAgain) {
        mContinueBtn.setVisibility(shouldShow ? View.VISIBLE : View.GONE);
        mContinueBtn.setText(tryAgain? R.string.sync_retry_btn: R.string.sync_finish_btn);

    }

    @OnClick(R.id.btn_continue)
    public void onClickContinue(View view) {
        mPresenter.onContinue();
    }

}
