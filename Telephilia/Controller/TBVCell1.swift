//
//  TBVCell1.swift
//  Telephilia
//
//  Created by IPS-108 on 28/03/23.
//

import UIKit
import Kingfisher
import UPCarouselFlowLayout


class TBVCell1: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collecView: UICollectionView!
    
    let api = apiCall()
    var movies : MovieResults?

    var currentCellIndex = 0
    var timer: Timer?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        collecView.delegate = self
        collecView.dataSource = self
        let layout = UPCarouselFlowLayout()
        layout.scrollDirection = .horizontal
        layout.sideItemScale = 1.0
        layout.itemSize = CGSize(width: 350, height: 400)
        collecView.collectionViewLayout = layout
        
        api.latestMovies { [self] Result in
            self.movies = Result
            DispatchQueue.main.async {
                self.collecView.reloadData() // reload the table view with the fetched data
                
            }
        }
        timer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(slideNext), userInfo: nil, repeats: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let totalMovies = movies?.results.count else {return 0}
        print(totalMovies)
        return totalMovies
    }

//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection1", for: indexPath) as! CVCell
//        guard let movie = movies?.results[indexPath.row] else {
//            return UICollectionViewCell()
//        }
//        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movie.posterPath)")
//        cell.imgView.kf.setImage(with: url)
//        cell.layer.cornerRadius = 50
//        cell.layer.borderWidth = 1
//        cell.layer.borderColor = UIColor.black.cgColor
//        //cell.lbl.text = "Demo"
//        return cell
//    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection1", for: indexPath) as! CVCell
        guard let movie = movies?.results[indexPath.row] else {
            return UICollectionViewCell()
        }
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movie.posterPath)")
        cell.imgView.kf.setImage(with: url)
        cell.layer.cornerRadius = 50
        cell.layer.borderWidth = 1
        cell.layer.borderColor = UIColor.black.cgColor
        //cell.lbl.text = movie.title // Set the movie title in the label
        print(movie.originalTitle)
        
        // Add a tap gesture recognizer to the image view
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        cell.imgView.isUserInteractionEnabled = true
        cell.imgView.addGestureRecognizer(tapGestureRecognizer)
        return cell
    }

    // Function to handle the tap gesture recognizer on the movie image
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Get the index path of the cell that was tapped
        if let cell = tapGestureRecognizer.view?.superview?.superview as? CVCell, let indexPath = collecView.indexPath(for: cell) {
            // Get the movie at the tapped index path
            guard let movie = movies?.results[indexPath.row] else {
                return
            }
            // Display the movie name in an alert
            let alert = UIAlertController(title: "\(movie.title)", message: "\(movie.overview)", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width, height: 400)
    }

//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
//        }
//
//        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//            return 10
//        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc func slideNext(){
//        print("before:\(currentCellIndex)")
        if let totalMovies = movies?.results.count{
            if currentCellIndex <= totalMovies - 1 {
//                print("before + :\(currentCellIndex)")
                collecView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
                currentCellIndex = currentCellIndex + 1
//                print("\(currentCellIndex) <= 20")
            }
            else
            {
                currentCellIndex = 0
                collecView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
            }
        }
    }

}

