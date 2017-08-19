//
//  ChooseAvatarVC.swift
//  Smack
//
//  Created by Khoa Nguyen on 8/19/17.
//  Copyright © 2017 Khoa. All rights reserved.
//

import UIKit
protocol ChooseAvatarDelegate {
    func getImage(img: String)
}

class ChooseAvatarVC: UIViewController {
    @IBOutlet weak var segment: UISegmentedControl!

    var delegate: ChooseAvatarDelegate?
    var CURRENT_AVATAR_TYPE = "dark"
    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collectionView.dataSource = self
        collectionView.delegate = self
      
    }

    @IBAction func back_TouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
        
    }
   
    @IBAction func segment_ChangeValue(_ sender: Any) {
        if segment.selectedSegmentIndex == 0 {
            CURRENT_AVATAR_TYPE = "dark"
        }else {
            CURRENT_AVATAR_TYPE = "light"
        }
        collectionView.reloadData()
    }
    
}

extension ChooseAvatarVC: UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 28
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "avatarCell", for: indexPath)
        
        let avatar = UIImage(named: "\(CURRENT_AVATAR_TYPE)\(indexPath.row)")
        let imageView = UIImageView(image: avatar)
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.8
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        cell.addSubview(imageView)
        return cell
    }
}

extension ChooseAvatarVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        delegate?.getImage(img: "\(CURRENT_AVATAR_TYPE)\(indexPath.row)")
        
        dismiss(animated: true, completion: nil)
        
    }
}


extension ChooseAvatarVC: UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 4
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width / 4 - 12
        return CGSize(width: width, height: width)
    }
    
   
}

