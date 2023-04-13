//
//  TBVCell2.swift
//  Telephilia
//
//  Created by IPS-108 on 29/03/23.
//

import UIKit
import CoreAudio

class TBVCell2: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let api = apiCall()
    var movies : MovieGenre?
    

    @IBOutlet weak var collecView2: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collecView2.register(UINib(nibName: "CVCell2", bundle: nil), forCellWithReuseIdentifier: "Collection2")
        
        collecView2.delegate = self
        collecView2.dataSource = self
        
        api.movieGenre { [self] Genre in
            self.movies = Genre
            DispatchQueue.main.async {
                self.collecView2.reloadData() // reload the table view with the fetched data

            }
        }
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = UIScreen.main.bounds.width - 0
//        return CGSize(width: width, height: UICollectionView.main.bounds.height)
//    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let totalGenre = movies?.genres.count else {return 0}
        print(totalGenre)
        return totalGenre
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection2", for: indexPath) as! CVCell2
        
//        guard let movie = movies?.results[indexPath.row] else {
//            return UICollectionViewCell()
//        }
        guard let genre = movies?.genres[indexPath.row] else {
            return UICollectionViewCell()
        }
        print(genre.name)
        cell.gen.text = genre.name
        cell.layer.cornerRadius = 50
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        
        return cell
    }
    
}
