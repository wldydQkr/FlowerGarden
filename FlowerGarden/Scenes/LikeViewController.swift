//
//  LikeViewController.swift
//  FlowerGarden
//
//  Created by 박지용 on 2022/09/13.
//

import UIKit

class LikeViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let cellMarginSize: CGFloat = 10.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self

    }

}

extension LikeViewController: UICollectionViewDelegate {
    
}

extension LikeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LikeCollectionViewCell", for: indexPath) as? LikeCollectionViewCell
        
        return cell ?? UICollectionViewCell()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = LikeDetailViewController()
        present(vc, animated: true)
    }
    
    
}

extension LikeViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: LikeCollectionViewCell.height)
    }
    
}
