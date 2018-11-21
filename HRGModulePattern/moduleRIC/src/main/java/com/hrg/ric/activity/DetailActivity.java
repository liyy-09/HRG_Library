package com.hrg.ric.activity;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.TextView;

import com.alibaba.android.arouter.facade.annotation.Route;
import com.hrg.ric.R;

@Route(path = "/ric/detail")
public class DetailActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.ric_activity_detail);

         int age = getIntent().getIntExtra("age", 1);

        TextView tv = (TextView) findViewById(R.id.ric_detail_tv);
        tv.setText("年龄：" + age);
    }
}
