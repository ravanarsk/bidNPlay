//
//  DashboardTab.swift
//  bidNPlay
//
//  Created by Ashin Asok on 04/12/24.
//

import UIKit

class DashboardTab: UITabBarController {

    fileprivate lazy var defaultTabBarHeight = { tabBar.frame.size.height }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.configureTab()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.setTabHeight()
    }

}

//MARK: Init View
extension DashboardTab{
    
    fileprivate func configureTab(){
        
        self.setViewController()
        self.tabBar.backgroundColor = CustomColor.bg2
        self.tabBar.barTintColor = .white
        self.tabBar.layer.borderWidth = 1
        self.tabBar.layer.borderColor = CustomColor.bg.cgColor
        self.tabBar.tintColor = CustomColor.button
        self.tabBar.layer.cornerRadius = 20
        self.tabBar.layer.masksToBounds = true
        self.tabBar.layer.maskedCorners = [
            .layerMaxXMinYCorner, .layerMinXMinYCorner
        ]
        
    }
    
    fileprivate func setTabHeight(){
        
        let newTabBarHeight = defaultTabBarHeight + 16.0
        var newFrame = tabBar.frame
        newFrame.size.height = newTabBarHeight
        newFrame.origin.y = view.frame.size.height - newTabBarHeight
        self.tabBar.frame = newFrame
        
    }
    
}

//MARK: Set View Controllers
extension DashboardTab{
    
    fileprivate func setViewController(){
        
        let tournamentVC = TournamentsVC.loadFromNib()
        let rankingVC = RankingVC.loadFromNib()
        let settingVC = SettingsVC.loadFromNib()
        
        let tab1 = UITabBarItem(
            title: "Matches",
            image: UIImage(systemName: "list.bullet.clipboard"),
            selectedImage: UIImage(systemName: "list.bullet.clipboard.fill")
        )
        let tab2 = UITabBarItem(
            title: "Rankings",
            image: UIImage(systemName: "globe.central.south.asia"),
            selectedImage: UIImage(systemName: "globe.central.south.asia.fill")
        )
        let tab3 = UITabBarItem(
            title: "Settings",
            image: UIImage(systemName: "gearshape"),
            selectedImage: UIImage(systemName: "gearshape.fill")
        )
        
        
        let navigationForMatches = UINavigationController(
            rootViewController: tournamentVC
        )
//        let navigationForRankings = UINavigationController(
//            rootViewController: rankingVC
//        )
        let navigationForSettings = UINavigationController(
            rootViewController: settingVC
        )
        
        navigationForMatches.tabBarItem = tab1
        //navigationForRankings.tabBarItem = tab2
        navigationForSettings.tabBarItem = tab3
        
        self.setViewControllers(
            [navigationForMatches,navigationForSettings],
            animated: true
        )
        
    }
    
}
