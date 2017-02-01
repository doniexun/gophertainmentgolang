package com.gophertainment.gophertainmentandroid.adapter;

import android.support.v7.widget.CardView;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import com.gophertainment.gophertainmentandroid.R;

/**
 * Created by dakshsharma on 1/31/17.
 */

public class CardAdapter  extends RecyclerView.Adapter<CardAdapter.CardViewHolder> {


    @Override
    public CardViewHolder onCreateViewHolder(ViewGroup parent, int viewType) {
        View cv = LayoutInflater.from(parent.getContext()).inflate(R.layout.card_layout, parent, false);
        CardViewHolder resultPoster = new CardViewHolder(cv);
        return resultPoster;
    }

    @Override
    public void onBindViewHolder(CardViewHolder resultViewHolder, int position) {
        resultViewHolder.mTitleTV.setText("Hello, World");
    }

    @Override
    public int getItemCount() {
        return 0;
    }

    // Connect Up the Card Layout to
    public static class CardViewHolder extends RecyclerView.ViewHolder {
        CardView mCardView;

        public ImageView mImageView;
        public TextView mTitleTV;
        public TextView mYearTV;

        public CardViewHolder(View item) {
            super(item);
            mCardView = (CardView) item.findViewById(R.id.posterCardView);
            mImageView = (ImageView) item.findViewById(R.id.posterCardImage);
            mTitleTV = (TextView) item.findViewById(R.id.posterCardTitle);
            mYearTV = (TextView) item.findViewById(R.id.posterCardYear);
        }

    }


}
