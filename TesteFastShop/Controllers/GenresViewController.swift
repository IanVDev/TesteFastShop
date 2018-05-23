//
//  GenresViewController.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 21/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit
import Alamofire

class GenresViewController: UIViewController {

    @IBOutlet weak var navBar: UINavigationBar!
    @IBOutlet weak var genresLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cancelButton: UIButton!
    
    private var genres: [Genre]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        getGenres()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func getGenres() {
        let handler = ObjectHandler<GenreList>().onComplete {
            print("complete")
            }.onSuccess { (response: GenreList?) in
                if response != nil {
                    self.genres = response?.genres
                    self.tableView.reloadData()
                }
            }.onFailure { (error) in
        }
        let movieService = MovieService()
        movieService.getGenres(handler: handler)
    }
    
    func configureView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        let genresBtn = UIBarButtonItem(title: "Genres", style: .plain, target: self, action: #selector(backClikedMethod))
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = genresBtn

    }
    

    @objc func backClikedMethod() {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: Extensions

extension GenresViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .none
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
            cell.selectionStyle = UITableViewCellSelectionStyle.none
            if let genre = genres?[indexPath.row] {
                let defaults = UserDefaults.standard
                defaults.set(genre.id, forKey: "genreId")
                defaults.set(genre.name, forKey: "genreName")
                dismiss(animated: true, completion: nil)
            }

        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if genres != nil {
            return (genres?.count)!
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customGenresCell", for: indexPath) as! CustomGenresTableViewCell

        if let genre = genres?[indexPath.row] {
            cell.setupCell(genre: genre)
        }
        
        return cell
    }

}
