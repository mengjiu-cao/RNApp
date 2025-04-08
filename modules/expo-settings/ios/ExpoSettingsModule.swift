import ExpoModulesCore

public class ExpoSettingsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoSettings")

    Events("onChange")

    Function("setFiat") { (theme: FiatType) -> Void in
      UserDefaults.standard.set(theme.rawValue, forKey:"fiat-key")
      sendEvent("onChange", [
        "fiat-key": theme.rawValue
      ])
    }

    Function("getFiat") { () -> String in
      UserDefaults.standard.string(forKey: "fiat-key") ?? FiatType.USD.rawValue
    }
  }

  enum FiatType: String, Enumerable {
    case USD
    case HKD
  }
}
