package com.cobis.gestionasesores.presentation.comments;

import android.content.Context;
import android.content.Intent;
import android.os.Bundle;
import android.support.annotation.Nullable;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.domain.usecases.SendCommentaryUserCase;
import com.cobis.gestionasesores.presentation.BaseActivity;

/**
 * Created by mnaunay on 10/08/2017.
 */

public class CommentActivity extends BaseActivity {

    CommentsContract.Presenter mPresenter;

    public static Intent newIntent(Context context){
        Intent intent = new Intent(context,CommentActivity.class);
        return intent;
    }

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_comment);
        CommentsFragment fragment = (CommentsFragment) getSupportFragmentManager()
                .findFragmentById(R.id.content_fragment);
        if (fragment == null) {
            fragment = CommentsFragment.newInstance();
            getSupportFragmentManager().beginTransaction().replace(R.id.content_fragment, fragment).commit();
        }
        mPresenter = new CommentsPresenter(fragment, new SendCommentaryUserCase());
    }

}
