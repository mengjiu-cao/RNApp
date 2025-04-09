package expo.modules.settings

import android.content.Context
import android.content.Intent
import android.content.SharedPreferences
import androidx.core.os.bundleOf
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.kotlin.types.Enumerable
// import org.greenrobot.eventbus

const val CLIPBOARD_CHANGED_EVENT_NAME = "onClipboardChanged"

class ExpoSettingsModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoSettings")

    Events("onChange")

    Function("setFiat") { theme: FiatType ->
      // getPreferences().edit().putString("fiat-key", theme.value).commit()
      // this@ExpoSettingsModule.sendEvent("onChange", bundleOf("value" to theme.value))
    }

    Function("getFiat") {
      return@Function getPreferences().getString("fiat-key", FiatType.USD.value)
    }

      Function("toSettingPage") {
        val intent = Intent("com.anonymous.RNApp.setting11")
        intent.flags = Intent.FLAG_ACTIVITY_NEW_TASK
        context.startActivity(intent)
    }
  }

  private val context
  get() = requireNotNull(appContext.reactContext)

  private fun getPreferences(): SharedPreferences {
    return context.getSharedPreferences(context.packageName + ".settings", Context.MODE_PRIVATE)
  }

  // private val clipboardManager: ClipboardManager?
  //   get() = appContext.reactContext?.getSystemService(Context.CLIPBOARD_SERVICE) as? ClipboardManager

  // private val listener = ClipboardManager.OnPrimaryClipChangedListener {
  //   clipboardManager?.primaryClipDescription?.let { clip ->
  //     this@ClipboardModule.sendEvent(
  //       CLIPBOARD_CHANGED_EVENT_NAME,
  //       bundleOf(
  //         "contentTypes" to availableContentTypes(clip)
  //       )
  //     )
  //   }
  // }
}

enum class FiatType(val value: String) : Enumerable {
  USD("USD"),
  HKD("HKD"),
}
