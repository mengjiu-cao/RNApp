import ExpoModulesCore

public let FIAT_CHANGED_EVENT_NAME = "FIAT_CHANGED_EVENT_NAME"

public class ExpoSettingsModule: Module {
  public func definition() -> ModuleDefinition {
    Name("ExpoSettings")

    Events("onChange")
      
      OnStartObserving {
        NotificationCenter.default.addObserver(
          self,
          selector: #selector(self.fiatChangedListener),
          name: Notification.Name(FIAT_CHANGED_EVENT_NAME),
          object: nil
        )
      }

      OnStopObserving {
        NotificationCenter.default.removeObserver(
          self,
          name: Notification.Name(FIAT_CHANGED_EVENT_NAME),
          object: nil
        )
      }

    Function("setFiat") { (theme: FiatType) -> Void in

    }

    Function("getFiat") { () -> String in
      UserDefaults.standard.string(forKey: "fiat-key") ?? FiatType.USD.rawValue
    }

    Function("toSettingPage") { () -> Void in
      NotificationCenter.default.post(name: Notification.Name("toSettingPage"), object: nil)
    }
  }

  enum FiatType: String, Enumerable {
    case USD = "USD"
    case HKD = "HKD"
  }
    
    @objc
    private func fiatChangedListener() {
        let fiat = UserDefaults.standard.string(forKey: "fiat-key") ?? FiatType.USD.rawValue
        sendEvent("onChange", [
          "value": fiat
        ])
    }
}
