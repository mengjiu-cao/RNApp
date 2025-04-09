//
//  ViewExt.swift
//  RNDemo
//
//  Created by shutters on 2025/4/6.
//

import UIKit
import PinLayout
import Then

class InfoView: UIView {
  
  private let editIcon = UIImageView(image: UIImage(named: "edit"))
  private let headerIcon = UIImageView(image: UIImage(named: "image-header")).then {
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
  }

  private let titleLbl = UILabel(frame: .zero)
  private let downIcon = UIImageView(image: UIImage(named: "ic_down_gray"))
  private let bgView = UIView().then {
    $0.backgroundColor =  UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    $0.layer.cornerRadius = 4
    $0.layer.masksToBounds = true
  }
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    addSubview(headerIcon)
    addSubview(editIcon)
    
    addSubview(bgView)
    
    titleLbl.text = "Wallet 1"
    titleLbl.font = .boldSystemFont(ofSize: 16)
    titleLbl.textColor = UIColor.gray
    bgView.addSubview(titleLbl)
    
    bgView.addSubview(downIcon)
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    headerIcon.pin.topCenter(24).width(96).height(96)
    editIcon.pin.center(to: headerIcon.anchor.topRight)
    
    bgView.pin.below(of: headerIcon, aligned: .center).width(108).height(30).marginTop(16)
    titleLbl.pin.centerLeft(12).sizeToFit()
    downIcon.pin.centerRight(12).width(16).height(16)
    
  }
}

class AssetsSection: UIView {
  let tokensRow = NormalRow(_title: "Manage Tokens")
  let historyRow = NormalRow(_title: "Transaction History")
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    addSubview(tokensRow)
    addSubview(historyRow)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    tokensRow.pin.left().top().right().height(70)
    historyRow.pin.left().right().below(of: tokensRow).height(70)
  }
}

class AbountSection: UIView {
  let currencyRow = NormalRow(_title: "Version")
  let lang = NormalRow(_title: "Terms of Service")
  let appearance = NormalRow(_title: "Privacy Notice")
  let notif = NormalRow(_title: "Visit our website")

  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    addSubview(currencyRow)
    addSubview(lang)
    addSubview(appearance)
    addSubview(notif)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    currencyRow.pin.left().top().right().height(70)
    lang.pin.left().right().below(of: currencyRow).height(70)
    appearance.pin.left().right().below(of: lang).height(70)
    notif.pin.left().right().below(of: appearance).height(70)
  }
}

class SupportSection: UIView {
  let currencyRow = NormalRow(_title: "Help Center")
  let lang = NormalRow(_title: "New to DeFi")
  let appearance = NormalRow(_title: "Join Community")
  let notif = NormalRow(_title: "Give Feedback")

  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    addSubview(currencyRow)
    addSubview(lang)
    addSubview(appearance)
    addSubview(notif)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    currencyRow.pin.left().top().right().height(70)
    lang.pin.left().right().below(of: currencyRow).height(70)
    appearance.pin.left().right().below(of: lang).height(70)
    notif.pin.left().right().below(of: appearance).height(70)
  }
}

class AccountSection: UIView {
  var currencyRow: NormalRow?
  let lang = NormalRow(_title: "Language", _info: "English")
  let appearance = NormalRow(_title: "Appearance", _info: "Use Device Settings")
  let notif = NormalRow(_title: "Notifications")
  let closure: () -> Void
  let btn = UIButton()
  
  init(_closure: @escaping () -> Void) {
    closure = _closure
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    let fiat = "$" + (UserDefaults.standard.string(forKey: "fiat-key") ?? "USD")
    currencyRow = NormalRow(_title: "Display Currency", _info: fiat)
    addSubview(currencyRow!)
    
    addSubview(lang)
    addSubview(appearance)
    addSubview(notif)
    
    btn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
    addSubview(btn)
  }
  
  @objc func btnClick() {
    print("------------------")
    closure()
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    currencyRow!.pin.left().top().right().height(70)
    lang.pin.left().right().below(of: currencyRow!).height(70)
    appearance.pin.left().right().below(of: lang).height(70)
    notif.pin.left().right().below(of: appearance).height(70)
    
    btn.pin.left().top().right().height(70)
  }
}

class Web3ConnectionSection: UIView {
  let dapps = Normal2Row(_title: "Connected dApps", _info: "0 dApps", _subColor: UIColor(red: 99 / 255.0, green: 110 / 255.0, blue: 126 / 255.0, alpha: 1))
  let netRow = NormalRow(_title: "Networks & RPC")
  let approvalRow = NormalRow(_title: "Approvals")
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    addSubview(netRow)
    addSubview(approvalRow)
    addSubview(dapps)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    dapps.pin.left().top().right().height(70)
    netRow.pin.left().right().below(of: dapps).height(70)
    approvalRow.pin.left().right().below(of: netRow).height(70)
  }
}

class SecuritySection: UIView {
  let recoveryRow = RecoveryRow()
  let passcodeRow = Normal2Row(_title: "Change Passcode", _info: "You're protected")
  let faceRow = FaceIDRow()
  let authRow = AuthRow()
  let autoAppLock = Normal2Row(_title: "Auto App Lock", _info: "Auto-lock after 1 minute", _subColor: UIColor(red: 99 / 255.0, green: 110 / 255.0, blue: 126 / 255.0, alpha: 1))
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    backgroundColor = UIColor(red: 231.0 / 255.0, green: 237 / 255.0, blue: 242 / 255.0, alpha: 1)
    layer.cornerRadius = 12
    layer.masksToBounds = true
    
    addSubview(recoveryRow)
    addSubview(passcodeRow)
    addSubview(faceRow)
    addSubview(authRow)
    addSubview(autoAppLock)
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    recoveryRow.pin.left().top().right().height(70)
    passcodeRow.pin.left().right().below(of: recoveryRow).height(70)
    faceRow.pin.left().right().below(of: passcodeRow).height(70)
    authRow.pin.left().right().below(of: faceRow).height(70)
    autoAppLock.pin.left().right().below(of: authRow).height(70)
  }
}

class RecoveryRow: UIView {
  private let titleLbl = UILabel(frame: .zero)
  
  private let subTitleLbl = UILabel(frame: .zero)
  private let subIcon = UIImageView(image: UIImage(named: "check-circle-fill"))

  private let rightIcon = UIImageView(image: UIImage(named: "ic_right_icon"))
  private let bottomLine = UIView(frame: .zero)
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    titleLbl.text = "Recovery Phrase"
    titleLbl.font = .systemFont(ofSize: 14)
    titleLbl.textColor = .black
    addSubview(titleLbl)
    
    subTitleLbl.text = "Not backed up"
    subTitleLbl.textColor = UIColor(red: 99 / 255.0, green: 110 / 255.0, blue: 126 / 255.0, alpha: 1)
    subTitleLbl.font = .systemFont(ofSize: 12)
    addSubview(subTitleLbl)
    
    addSubview(subIcon)
    addSubview(rightIcon)
    
    bottomLine.backgroundColor = UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1)
    addSubview(bottomLine)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    titleLbl.pin.left(16).top(17).sizeToFit()
    subIcon.pin.topLeft(to: titleLbl.anchor.bottomLeft).width(14).height(14).marginTop(4)
    subTitleLbl.pin.after(of: subIcon, aligned: .center).sizeToFit().marginLeft(4)
    rightIcon.pin.centerRight().marginRight(20)
    bottomLine.pin.left().bottom().right().height(1)
  }
}


class Normal2Row: UIView {
  private let titleLbl = UILabel(frame: .zero)
  private let subTitleLbl = UILabel(frame: .zero)
  private let rightIcon = UIImageView(image: UIImage(named: "ic_right_icon"))
  private let bottomLine = UIView(frame: .zero)
  private let info: String?
  private let title: String?
  private let subColor: UIColor?
  
//
  init(_title: String, _info: String, _subColor: UIColor? = UIColor(red: 84 / 255.0, green: 204 / 255.0, blue: 185 / 255.0, alpha: 1)) {
    info = _info
    title = _title
    subColor = _subColor
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    titleLbl.text = title
    titleLbl.font = .systemFont(ofSize: 14)
    titleLbl.textColor = .black
    addSubview(titleLbl)
    
    subTitleLbl.text = info
    subTitleLbl.textColor = subColor
    subTitleLbl.font = .systemFont(ofSize: 12)
    addSubview(subTitleLbl)
    
    addSubview(rightIcon)
    
    bottomLine.backgroundColor = UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1)
    addSubview(bottomLine)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    titleLbl.pin.left(16).top(17).sizeToFit()
    subTitleLbl.pin.topLeft(to: titleLbl.anchor.bottomLeft).sizeToFit().marginTop(4)
    rightIcon.pin.centerRight().marginRight(20)
    bottomLine.pin.left().bottom().right().height(1)
  }
}

class NormalRow: UIView {
  private let titleLbl = UILabel(frame: .zero)
  private let subTitleLbl = UILabel(frame: .zero)
  private let rightIcon = UIImageView(image: UIImage(named: "ic_right_icon"))
  private let bottomLine = UIView(frame: .zero)
  private let info: String?
  private let title: String?
  
  init(_title: String, _info: String? = nil) {
    info = _info
    title = _title
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    titleLbl.text = title
    titleLbl.font = .systemFont(ofSize: 14)
    titleLbl.textColor = .black
    addSubview(titleLbl)
    
    subTitleLbl.text = info
    subTitleLbl.textColor = .black
    subTitleLbl.font = .systemFont(ofSize: 14)
    addSubview(subTitleLbl)
    
    addSubview(rightIcon)
    
    bottomLine.backgroundColor = UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1)
    addSubview(bottomLine)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    titleLbl.pin.centerLeft(16).sizeToFit()
    rightIcon.pin.centerRight().marginRight(20)
    subTitleLbl.pin.centerRight(40).sizeToFit()
    bottomLine.pin.left().bottom().right().height(1)
  }
}

class FaceIDRow: UIView {
  private let titleLbl = UILabel(frame: .zero)
  private let subTitleLbl = UILabel(frame: .zero)
  private let rightIcon = UISwitch().then {
    $0.isOn = true
  }
  private let bottomLine = UIView(frame: .zero)
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    titleLbl.text = "Enable Face ID"
    titleLbl.font = .systemFont(ofSize: 14)
    titleLbl.textColor = .black
    addSubview(titleLbl)
    
    subTitleLbl.text = "You're protected"
    subTitleLbl.textColor = UIColor(red: 84 / 255.0, green: 204 / 255.0, blue: 185 / 255.0, alpha: 1)
    subTitleLbl.font = .systemFont(ofSize: 12)
    addSubview(subTitleLbl)
    
    addSubview(rightIcon)
    
    bottomLine.backgroundColor = UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1)
    addSubview(bottomLine)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    titleLbl.pin.left(16).top(17).sizeToFit()
    subTitleLbl.pin.topLeft(to: titleLbl.anchor.bottomLeft).sizeToFit().marginTop(4)
    rightIcon.pin.centerRight().marginRight(20).sizeToFit()
    bottomLine.pin.left().bottom().right().height(1)
  }
}

class AuthRow: UIView {
  private let titleLbl = UILabel(frame: .zero)
  private let subTitleLbl = UILabel(frame: .zero)
  private let rightIcon = UIImageView(image: UIImage(named: "ic_right_icon"))
  private let infoIcon = UIImageView(image: UIImage(named: "info_tip"))
  private let bottomLine = UIView(frame: .zero)
  
  init() {
    super.init(frame: .zero)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupView() {
    titleLbl.text = "Enable 2-Factor Authentication"
    titleLbl.font = .systemFont(ofSize: 14)
    titleLbl.textColor = .black
    addSubview(titleLbl)
    
    subTitleLbl.text = "Add an extra layer of security"
    subTitleLbl.textColor = UIColor(red: 99 / 255.0, green: 110 / 255.0, blue: 126 / 255.0, alpha: 1)
    subTitleLbl.font = .systemFont(ofSize: 12)
    addSubview(subTitleLbl)
    
    addSubview(rightIcon)
    addSubview(infoIcon)
    
    bottomLine.backgroundColor = UIColor(red: 223 / 255.0, green: 229 / 255.0, blue: 236 / 255.0, alpha: 1)
    addSubview(bottomLine)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    titleLbl.pin.left(16).top(17).sizeToFit()
    subTitleLbl.pin.topLeft(to: titleLbl.anchor.bottomLeft).sizeToFit().marginTop(4)
    rightIcon.pin.centerRight().marginRight(20)
    infoIcon.pin.centerRight().marginRight(50).width(20).height(20)
    bottomLine.pin.left().bottom().right().height(1)
  }
}
