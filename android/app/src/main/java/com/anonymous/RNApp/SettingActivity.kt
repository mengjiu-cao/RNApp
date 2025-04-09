package com.anonymous.RNApp

import android.content.Context
import android.content.SharedPreferences
import android.os.Bundle
import android.view.View
import android.widget.ImageView
import android.widget.TextView
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AlertDialog
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import expo.modules.settings.FiatType
import androidx.core.content.edit

class SettingActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        enableEdgeToEdge()
        setContentView(R.layout.activity_setting)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val lblTitle = findViewById<View>(R.id.displayCurrency) as TextView
        lblTitle.text = getPreferences().getString("fiat-key", FiatType.USD.value)

        val backBtn = findViewById<View>(R.id.backBtn) as ImageView
        backBtn.setOnClickListener {
            finish()
        }

        val fiatView = findViewById<View>(R.id.fiatView)
        fiatView.setOnClickListener {
            val builder = AlertDialog.Builder(this)
            builder.setTitle("Display Currency")
            builder.setMessage("switch your display currency?")
            builder.setNeutralButton("Confirm") { dialog, _ ->
                var next = FiatType.USD.value
                if (lblTitle.text == FiatType.USD.value) {
                    next = FiatType.HKD.value
                }

                getPreferences().edit {
                    putString("fiat-key", next)
                }
                lblTitle.text = next
                dialog.dismiss()
            }
            builder.setNegativeButton("Cancel") { dialog, _ -> dialog.dismiss() }
            val alert = builder.create()
            alert.show()
        }

    }

    fun getPreferences(): SharedPreferences {
        return this.getSharedPreferences(this.packageName + ".settings", Context.MODE_PRIVATE)
    }

//    override fun onOptionsItemSelected(item: MenuItem): Boolean {
//        if (item.itemId == android.R.id.home) {
//            onBackPressed()
//            return true
//        }
//        return super.onOptionsItemSelected(item)
//    }
}