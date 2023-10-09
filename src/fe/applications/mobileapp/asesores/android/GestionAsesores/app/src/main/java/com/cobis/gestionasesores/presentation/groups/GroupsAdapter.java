package com.cobis.gestionasesores.presentation.groups;

import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.cobis.gestionasesores.R;
import com.cobis.gestionasesores.data.models.Group;
import com.cobis.gestionasesores.utils.ResourcesUtil;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

/**
 * Created by mnaunay on 06/16/2017.
 */

public class GroupsAdapter extends RecyclerView.Adapter<GroupsAdapter.ViewHolder> {
    private List<Group> mData;
    private OnItemClickListener mListener;

    public GroupsAdapter(List<Group> data, OnItemClickListener listener) {
        mData = data;
        mListener = listener;
    }

    @Override
    public ViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View view = LayoutInflater.from(parent.getContext()).inflate(R.layout.holder_group, parent, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(ViewHolder holder, int position) {
        holder.bind(mData.get(position), mListener);
    }

    @Override
    public int getItemCount() {
        return mData.size();
    }

    public void replace(List<Group> groups) {
        mData = groups;
        notifyDataSetChanged();
    }

    public void clear() {
        mData.clear();
        notifyDataSetChanged();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder {
        @BindView(R.id.text_title)
        TextView mTextTitle;
        @BindView(R.id.text_number_members)
        TextView mNumberMembersText;
        @BindView(R.id.text_action)
        TextView mActionTextView;

        @BindView(R.id.img_sync_status)
        ImageView mSyncStatusImg;

        public ViewHolder(View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }

        public void bind(final Group group, final OnItemClickListener listener) {
            mTextTitle.setText(group.getName());
            itemView.setOnClickListener(new View.OnClickListener() {
                @Override
                public void onClick(View v) {
                    listener.onItemClick(group);
                }
            });

            mNumberMembersText.setText(itemView.getContext().getString(R.string.groups_number_members_format, group.getMembers() != null ? group.getMembers().size() : 0));

            int imgSyncStatus = ResourcesUtil.getSyncStatusResource(group.getStatus());
            if (imgSyncStatus > 0) {
                mSyncStatusImg.setImageResource(imgSyncStatus);
            } else {
                mSyncStatusImg.setVisibility(View.INVISIBLE);
            }

            if(group.getAction() != null){
                mActionTextView.setText(group.getAction().getFullDescription());
                mActionTextView.setVisibility(View.VISIBLE);
            }else{
                mActionTextView.setVisibility(View.GONE);
            }
        }
    }

    public interface OnItemClickListener {
        void onItemClick(Group item);
    }
}
