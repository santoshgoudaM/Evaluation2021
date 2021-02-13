//
//  ViewController.swift
//  Evaluation2021
//
//  Created by Santoshgouda M on 12/02/21.
//  Copyright © 2021 Santoshgouda M. All rights reserved.
//

import UIKit



class HomeViewController: UIViewController, StoryBoarded {
     
    @IBOutlet weak var topTabBarCollectionView: UICollectionView!
    @IBOutlet weak var bottomTabBarCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var viewModel: HomeViewModel!
    var dataSource = [UIViewController]()

    override func viewDidLoad() {
        super.viewDidLoad()
        createDataSource()
        registerCells()
        setupSearchBar()
        bottomTabBarCollectionView.delegate = self
        topTabBarCollectionView.delegate = self
        bottomTabBarCollectionView.dataSource = self
        topTabBarCollectionView.dataSource = self
        topTabBarCollectionView.selectItem(at: IndexPath(item: 0, section: 0), animated: false, scrollPosition: .bottom)
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.topTabBarCollectionView.collectionViewLayout.invalidateLayout()
        self.bottomTabBarCollectionView.collectionViewLayout.invalidateLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setCollectionViewFlowLayout()
    }
    
    func createDataSource() {
          if let coordinator = self.viewModel.coordinator as? MainCoordinator {
              dataSource = coordinator.returnArrayOfVC()
          }
          setDelegate()
      }
    
    func setDelegate() {
        for viewController in dataSource {
            if let vc = viewController as? PhotoListViewController {
                self.viewModel.searchPhotoDelegate = vc.viewModel
            } else if let vc = viewController as? VideoListViewController {
                self.viewModel.searchVideoDelegate = vc.viewModel
            }
        }
    }
    
    func setupSearchBar() {
        searchBar.delegate = self
        self.searchBar.setImage(UIImage(named: "Search Icon"), for: .search, state: .normal)
    }
    
    func registerCells() {
         topTabBarCollectionView.register(UINib(nibName: "MenuBarCollectionViewCell", bundle: .main), forCellWithReuseIdentifier: "menuCell")
     }
    
    func setCollectionViewFlowLayout() {
    
        let bottomFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        bottomFlowLayout.scrollDirection = .horizontal
        bottomFlowLayout.minimumInteritemSpacing = 0.0
        bottomFlowLayout.minimumLineSpacing = 0.0
        self.bottomTabBarCollectionView?.collectionViewLayout = bottomFlowLayout
        
        let topFlowLayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        topFlowLayout.scrollDirection = .horizontal
        topFlowLayout.minimumInteritemSpacing = 0.0
        topFlowLayout.minimumLineSpacing = 0.0
        self.topTabBarCollectionView.collectionViewLayout = topFlowLayout
    }



}

extension HomeViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == topTabBarCollectionView   {
            return self.viewModel.topTabBarDataSource.count
        } else {
            return dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == topTabBarCollectionView {
            if indexPath.item == 2 {
                let cell = topTabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
                return cell
            }
            guard let cell = topTabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "menuCell", for: indexPath) as? MenuBarCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.titleLabel.text = self.viewModel.topTabBarDataSource[indexPath.item]
            return cell
        } else {
             let cell = bottomTabBarCollectionView.dequeueReusableCell(withReuseIdentifier: "viewCell", for: indexPath)
            let vc = dataSource[indexPath.item]
            displayViewController(viewController: vc, cell: cell)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == topTabBarCollectionView {
            return CGSize(width: topTabBarCollectionView.frame.width / 4, height: topTabBarCollectionView.frame.height - 10.0)
        } else {
            return self.bottomTabBarCollectionView?.bounds.size ?? CGSize.zero
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == topTabBarCollectionView {
            if indexPath.item == 2 {
                return
            } else if indexPath.item == 3 {
                self.bottomTabBarCollectionView.scrollToItem(at: IndexPath(item: indexPath.item - 1, section: 0), at: .centeredHorizontally, animated: true)
            } else {
                self.bottomTabBarCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            }
            
        }
    }
    
    
    func displayViewController(viewController: UIViewController, cell: UICollectionViewCell) {
        viewController.view.translatesAutoresizingMaskIntoConstraints = false
        viewController.beginAppearanceTransition(true, animated: true)
        cell.addSubview(viewController.view)
        viewController.endAppearanceTransition()
        self.addChild(viewController)
        viewController.didMove(toParent: self)
        viewController.view.rightAnchor.constraint(equalTo: cell.rightAnchor).isActive = true
        viewController.view.leftAnchor.constraint(equalTo: cell.leftAnchor).isActive = true
        viewController.view.topAnchor.constraint(equalTo: cell.topAnchor).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: cell.bottomAnchor).isActive = true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var index = Int(scrollView.contentOffset.x / self.view.frame.size.width)
        if index == 2 {
            index += 1
        }
        topTabBarCollectionView.selectItem(at: IndexPath(item: index, section: 0), animated: false, scrollPosition: .bottom)
    }
    
}

extension HomeViewController: UISearchBarDelegate {

    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.viewModel.searchVideoDelegate?.getSearchedKeyword(keyword: searchText)
        self.viewModel.searchPhotoDelegate?.getSearchedKeyword(keyword: searchText)
        
    }
    
}
