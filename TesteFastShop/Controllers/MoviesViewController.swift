//
//  MoviesViewController.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit


class MoviesViewController: UIViewController {

    
    @IBOutlet weak var labelGenreTitle: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    var movies: [Movie]?
    
    let movieCell = "MovieCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        getMovie()
    }
    
    func getMoviesByGenrer(genrerId: Int) {
        let handler = ObjectHandler<MovieList>().onComplete {
            print("complete")
            }.onSuccess { (response: MovieList?) in
                if response != nil {
                    self.movies = response?.movies
                    self.collectionView.reloadData()
                }
            }.onFailure { (error) in
        }
        let movieService = MovieService()
        movieService.getMovieListByGenrer(handler: handler, genrerId: genrerId)
    }
    
    func getMovie() {
        let userDefaults = UserDefaults.standard
        if let genrerId = userDefaults.object(forKey: "genreId") as? Int {
            getMoviesByGenrer(genrerId: genrerId)
        } else {
            getMoviesByGenrer(genrerId: 12)
        }
        if let genrerName = userDefaults.object(forKey: "genreName") as? String {
            self.labelGenreTitle.text = genrerName
        }
    }
    
    func configureView() {
        let genresBtn = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(genresClikedMethod))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = genresBtn
        self.view.backgroundColor = UIColor.black
        navigationController?.navigationBar.barTintColor = UIColor.black
        collectionView.register(UINib(nibName: movieCell, bundle: nil), forCellWithReuseIdentifier: movieCell)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.labelGenreTitle.text = "Most Popular"
        self.labelGenreTitle.textColor = UIColor.white
    }
    
    
   @objc func genresClikedMethod() {
    let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
    let resultViewController = storyBoard.instantiateViewController(withIdentifier: "GenresView") as! GenresViewController
    self.present(resultViewController, animated:true, completion:nil)
    
    }
}

extension MoviesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if movies != nil {
            return (movies?.count)!
        }
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: movieCell, for: indexPath) as! MovieCell
        
        if let movie = movies?[indexPath.row] {
            if let image = movie.posterPath {
                cell.posterImageView.downloadedFrom(link: "https://image.tmdb.org/t/p/w500/" + image, contentMode: .scaleAspectFit)
            }

        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = movies?[indexPath.row] {
            let detailsViewController = storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController
            detailsViewController?.movie = movie
            navigationController?.pushViewController(detailsViewController!, animated: true)
        }
    }
}

