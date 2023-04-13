
import UIKit
import AVFoundation

class TBVCell3: UITableViewCell, UICollectionViewDataSource, UICollectionViewDelegate {
    
    

    
    let api = apiCall()
    var movies : TopMovies?
    
    @IBOutlet weak var collecView3: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collecView3.register(UINib(nibName: "CVCell3", bundle: nil), forCellWithReuseIdentifier: "Collection3")
        
        collecView3.dataSource = self
        collecView3.delegate = self
        
        api.popularMovies { [self] Top in
            self.movies = Top
            DispatchQueue.main.async {
                self.collecView3.reloadData() // reload the table view with the fetched data
            }
        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let totalMovies = movies?.results.count
        else
        {return 0}
        print(totalMovies)
        return totalMovies
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Collection3", for: indexPath) as! CVCell3
        guard let movie = movies?.results[indexPath.row] else {
            return UICollectionViewCell()
        }
        let url = URL(string: "https://image.tmdb.org/t/p/original/\(movie.posterPath)")
        cell.imgView.kf.setImage(with: url)
        cell.rating.text = String(movie.voteAverage)
        
        //cell.lbl.text = "Demo"
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width - 40
        return CGSize(width: width, height: 400)
    }
    
}
