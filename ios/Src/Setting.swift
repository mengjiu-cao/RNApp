//
//  Setting.swift
//  RNDemo
//
//  Created by shutters on 2025/4/6.
//

import UIKit

class SettingPage: UIViewController {
  enum FiatType: String {
    case USD = "USD"
    case HKD = "HKD"
  }
  
  let contentScrollView = UIScrollView()
  let info = InfoView()
  
  let securityLbl = UILabel().then {
    $0.text = "Security"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let securitySection = SecuritySection()
  
  let connectTipLbl = UILabel().then {
    $0.text = "Connect to Crypto.com App"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let connectTipBtn = UIButton(type: .custom).then {
    $0.setTitle("Connect to Crypto.com App", for: .normal)
    $0.titleLabel?.font = .boldSystemFont(ofSize: 16)
    let customBtnImage = UIImage(named: "logo")
    let newimage = customBtnImage?.resizedImage(sizeImage:CGSizeMake(24, 24))
    $0.setImage(newimage, for: .normal)
    $0.backgroundColor = UIColor(red: 28 / 255.0, green: 55 / 255.0, blue: 100 / 255.0, alpha: 1)
    $0.layer.cornerRadius = 8
    $0.layer.masksToBounds = true
  }
  
  let transferLbl = UILabel().then {
    $0.text = "Transfer coins easily between Crypto.com Onchain and the Crypto.com App."
    $0.textColor = .gray
    $0.numberOfLines = 0
    $0.font = .systemFont(ofSize: 14)
  }
  
  let readBtn = UIButton(type: .custom).then {
    $0.setTitle("Read More", for: .normal)
    $0.titleLabel?.font = .systemFont(ofSize: 16)
    $0.setTitleColor(.blue, for: .normal)
  }
  
  let assetLbl = UILabel().then {
    $0.text = "Assets"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let assetSection = AssetsSection()
  
  let web3ConnectionLbl = UILabel().then {
    $0.text = "Web3 connection"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let web3ConnectionSection = Web3ConnectionSection()
  
  let accountLbl = UILabel().then {
    $0.text = "Account"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  lazy var accountSection = AccountSection { [weak self] in
    print("AccountSection-----------------")
    self?.displayRate()
  }
  
  let supportLbl = UILabel().then {
    $0.text = "Support"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let supportSection = SupportSection()
  
  let aboutLbl = UILabel().then {
    $0.text = "About Crypto.com Onchain"
    $0.textColor = .gray
    $0.font = .systemFont(ofSize: 14)
  }
  
  let aboutSection = AbountSection()

  public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
    super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configFiat(fiat: FiatType) {
    UserDefaults.standard.setValue(fiat.rawValue, forKey: "fiat-key")
    UserDefaults.standard.synchronize()
    NotificationCenter.default.post(name: Notification.Name("FIAT_CHANGED_EVENT_NAME"), object: nil)
    
    self.dismiss(animated: true)
  }
  
  func displayRate() {
    // 1 实例化
    let alertSheet = UIAlertController(title: "Display Currency",
                                       message: "Select your preferred display currency. Your display currency is used to provide a fiat equivalence for your crypto balances",
                                       preferredStyle: UIAlertController.Style.actionSheet)
    // 2 命令（样式：退出Cancel，警告Destructive-按钮标题为红色，默认Default）
    let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
    let USDAction = UIAlertAction(title: "US Dollar(USD)", style: UIAlertAction.Style.default, handler: { [weak self] _ in
      self?.configFiat(fiat: .USD)
    })
    let HKDAction = UIAlertAction(title: "Hong Kong Dollar(HKD)", style: UIAlertAction.Style.default, handler: { [weak self] _ in
      self?.configFiat(fiat: .HKD)
    })
    alertSheet.addAction(cancelAction)
    alertSheet.addAction(USDAction)
    alertSheet.addAction(HKDAction)
    // 3 跳转
    self.present(alertSheet, animated: true, completion: nil)

  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    self.title = "Settings"
    let leftBarItem = UIBarButtonItem(image: UIImage(named: "icon_back"), style: .plain, target: self, action: #selector(leftBarBtnItemClick))
    navigationItem.leftBarButtonItem = leftBarItem
    
    view.backgroundColor = UIColor(red: 246 / 255.0, green: 247 / 255.0, blue: 248 / 255.0, alpha: 1)
    navigationController?.navigationBar.tintColor = .black
    
    view.addSubview(contentScrollView)
    contentScrollView.addSubview(info)
    contentScrollView.addSubview(securityLbl)
    contentScrollView.addSubview(securitySection)
    contentScrollView.addSubview(connectTipLbl)
    contentScrollView.addSubview(connectTipBtn)
    contentScrollView.addSubview(transferLbl)
    contentScrollView.addSubview(readBtn)
    
    contentScrollView.addSubview(assetLbl)
    contentScrollView.addSubview(assetSection)
    
    contentScrollView.addSubview(web3ConnectionLbl)
    contentScrollView.addSubview(web3ConnectionSection)
    
    contentScrollView.addSubview(accountLbl)
    contentScrollView.addSubview(accountSection)
    
    contentScrollView.addSubview(supportLbl)
    contentScrollView.addSubview(supportSection)
    
    contentScrollView.addSubview(aboutLbl)
    contentScrollView.addSubview(aboutSection)
        
  }
  
  public override func viewDidLayoutSubviews() {
    contentScrollView.pin.all()

    info.pin.left().top().right().height(190)
    securityLbl.pin.left(16).below(of: info).sizeToFit()
    securitySection.pin.left(16).right(16).below(of: securityLbl).height(70 * 5).marginTop(12)
    connectTipLbl.pin.topLeft(to: securitySection.anchor.bottomLeft).marginTop(20).sizeToFit()
    connectTipBtn.pin.left(16).right(16).below(of: connectTipLbl).height(54).marginTop(4)
    transferLbl.pin.topLeft(to: connectTipBtn.anchor.bottomLeft).right(16).marginTop(4).sizeToFit(.width)
    readBtn.pin.left(16).below(of: transferLbl).sizeToFit()
    
    assetLbl.pin.left(16).below(of: readBtn).marginTop(20).sizeToFit()
    assetSection.pin.left(16).right(16).below(of: assetLbl).height(70 * 2).marginTop(12)
    
    web3ConnectionLbl.pin.left(16).below(of: assetSection).marginTop(20).sizeToFit()
    web3ConnectionSection.pin.left(16).right(16).below(of: web3ConnectionLbl).height(70 * 3).marginTop(12)
    
    accountLbl.pin.left(16).below(of: web3ConnectionSection).marginTop(20).sizeToFit()
    accountSection.pin.left(16).right(16).below(of: accountLbl).height(70 * 4).marginTop(12)
    
    supportLbl.pin.left(16).below(of: accountSection).marginTop(20).sizeToFit()
    supportSection.pin.left(16).right(16).below(of: supportLbl).height(70 * 4).marginTop(12)
    
    aboutLbl.pin.left(16).below(of: supportSection).marginTop(20).sizeToFit()
    aboutSection.pin.left(16).right(16).below(of: aboutLbl).height(70 * 4).marginTop(12)
    
    contentScrollView.contentSize = CGSize(width: contentScrollView.frame.width, height: aboutSection.frame.maxY + 24)

  }
  
  @objc private func leftBarBtnItemClick() {
    self.dismiss(animated: true)
  }
  
}
