package com.gophertainment.gophertainmentandroid.activities;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.widget.EditText;

import com.gophertainment.gophertainmentandroid.R;

public class MainActivity extends AppCompatActivity {

    // UI Layout Widgets Declaration
    EditText mSearchString = (EditText) findViewById(R.id.searchStringET);

    // RecyclerView Instance
    RecyclerView mResultRecyclerView = (RecyclerView) findViewById(R.id.resultRecyclerView);
    // RecyclerView Manager Instance
    RecyclerView.LayoutManager mLayoutManager;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        // RecyclerView SetUp
        mResultRecyclerView.setHasFixedSize(true);

        mLayoutManager = new LinearLayoutManager(this);
        mResultRecyclerView.setLayoutManager(mLayoutManager);




        mSearchString.setHint(R.string.search_hint);




    }
}
