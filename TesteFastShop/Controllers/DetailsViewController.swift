//
//  DetailsViewController.swift
//  TesteFastShop
//
//  Created by Vilhena Sorrentino, Ian on 18/05/18.
//  Copyright © 2018 Vilhena Sorrentino, Ian. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    let imageView = UIImageView()
    
    var movie: Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    // MARK: Configure View Methods
    func configureView() {
        let backButton = UIBarButtonItem()
        backButton.title = "Movies"
        self.navigationController!.navigationBar.topItem!.backBarButtonItem = backButton
        self.tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = 50
        tableView.contentInset = UIEdgeInsetsMake(300, 0, 0, 0)
        tableView.backgroundColor = UIColor.black
        imageView.frame = CGRect(x: 60, y: 60, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height)
        view.addSubview(imageView)
        if let image = movie?.posterPath {
            imageView.downloadedFrom(link: "https://image.tmdb.org/t/p/w500/" + image, contentMode: .scaleAspectFit)
        }
    }
}


    // MARK: Extensions

    extension DetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
        
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 8
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomDetailsTableViewCell
            switch indexPath.row % 8 {
            case 0:
                cell.titleLabel.text = movie?.originalTitle
                cell.titleLabel.numberOfLines = 3
                cell.titleLabel.textColor = UIColor.white
                cell.frame.size.height = 100
                cell.titleLabel.font = cell.titleLabel.font.withSize(30)
                cell.contentView.backgroundColor = UIColor.black
                self.tableView.rowHeight = 80.0
                cell.subTitleLabel.textColor = UIColor.black

            case 1:
                cell.titleLabel.text = "Information"
                cell.titleLabel.font = cell.titleLabel.font.withSize(25)
                cell.titleLabel.textColor = UIColor.brown
                cell.subTitleLabel.textColor = UIColor.black
                self.tableView.rowHeight = 60.0
                cell.titleLabel.font = UIFont.italicSystemFont(ofSize: cell.titleLabel.font.pointSize)
            case 2:
                cell.titleLabel.text = "Language"
                cell.titleLabel.textColor = UIColor.brown
                cell.subTitleLabel.text = movie?.originalLanguage
                cell.subTitleLabel.textColor = UIColor.white
                cell.contentView.backgroundColor = UIColor.black
                self.tableView.rowHeight = 60.0
            case 3:
                cell.titleLabel.text = "Rating"
                cell.titleLabel.textColor = UIColor.brown
                let popularityF = movie?.voteAverage
                let numberFormatter = NumberFormatter()
                numberFormatter.numberStyle = .decimal
                let popularity = numberFormatter.string(from: popularityF as! NSNumber)
                cell.subTitleLabel.text = popularity
                cell.subTitleLabel.textColor = UIColor.white
                cell.contentView.backgroundColor = UIColor.black
                self.tableView.rowHeight = 60.0
            case 4:
                cell.titleLabel.text = "Released"
                cell.titleLabel.textColor = UIColor.brown
                cell.subTitleLabel.text = movie?.releaseDate
                cell.subTitleLabel.textColor = UIColor.white
                self.tableView.rowHeight = 60.0
            case 5:
                cell.titleLabel.text = "Overview"
                cell.titleLabel.textColor = UIColor.brown
                cell.titleLabel.font = cell.titleLabel.font.withSize(25)
                cell.subTitleLabel.textColor = UIColor.black
                cell.titleLabel.font = UIFont.italicSystemFont(ofSize: cell.titleLabel.font.pointSize)
                self.tableView.rowHeight = 60.0
            case 6:
                cell.titleLabel.textColor = UIColor.black
                cell.subTitleLabel.textColor = UIColor.black
                self.tableView.rowHeight = 5.0
            default:
                cell.titleLabel.textColor = UIColor.black
                cell.subTitleLabel.textColor = UIColor.black
                cell.overviewLabel.text = movie?.overview
                cell.overviewLabel.textColor = UIColor.white
                self.tableView.rowHeight = UITableViewAutomaticDimension
                cell.overviewLabel.numberOfLines = 100
                cell.titleLabel.font = cell.titleLabel.font.withSize(18)

            }
            
            
            return cell
        }
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let y = 300 - (scrollView.contentOffset.y + 300)
            let height = min(max(y, 60), 400)
            imageView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: height)
            
            
        }
}
