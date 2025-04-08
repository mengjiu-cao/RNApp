package expo.modules.settings

import android.content.Context
import android.content.SharedPreferences
import androidx.core.os.bundleOf
import expo.modules.kotlin.modules.Module
import expo.modules.kotlin.modules.ModuleDefinition
import expo.modules.kotlin.types.Enumerable

class ExpoSettingsModule : Module() {
  override fun definition() = ModuleDefinition {
    Name("ExpoSettings")

    Events("onChange")

    Function("setFiat") { theme: FiatType ->
      getPreferences().edit().putString("fiat-key", theme.value).commit()
      this@ExpoSettingsModule.sendEvent("onChange", bundleOf("value" to theme.value))
    }

    Function("getFiat") {
      return@Function getPreferences().getString("fiat-key", FiatType.USD.value)
    }
  }

  private val context
  get() = requireNotNull(appContext.reactContext)

  private fun getPreferences(): SharedPreferences {
    return context.getSharedPreferences(context.packageName + ".settings", Context.MODE_PRIVATE)
  }
}

enum class FiatType(val value: String) : Enumerable {
  USD("USD"),
  HKD("HKD"),
}
