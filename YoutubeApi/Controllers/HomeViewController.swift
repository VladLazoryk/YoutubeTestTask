import UIKit


enum Sections: Int {
    case channels = 0
    case firstPlaylist = 1
    case secondPlaylist = 2
}


class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var showPlayerButton: UIButton!
    
    
     let sectionTitles: [String] = ["Channels", "First Play List", "Second Play List"]
    
    private let homeFeedTable: UITableView = {
           let table = UITableView(frame: .zero, style: .grouped)
           table.register(CollectionViewTableViewCell.self, forCellReuseIdentifier: CollectionViewTableViewCell.identifier)
           return table
       }()
    
    private func configureButton() {
        showPlayerButton.backgroundColor = Theme.Colors.pinkColor
        showPlayerButton.layer.cornerRadius = 20
        showPlayerButton.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    override func viewDidLoad() {
          super.viewDidLoad()
          view.backgroundColor = .systemBackground
          view.addSubview(homeFeedTable)
          homeFeedTable.delegate = self
          homeFeedTable.dataSource = self
          
          configureNavbar()
          
          headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 200))
          homeFeedTable.tableHeaderView = headerView
          configureHeroHeaderView()
          
      }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        homeFeedTable.frame = view.bounds
    }
    
    
    override func updateViewConstraints() {
        super.updateViewConstraints()
        
        tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        loadingView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        loadingView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        loadingView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        loadingView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
}

//MARK: Table view delegate and data source
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sectionTitles.count
    }
    
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as? CollectionViewTableViewCell else {
            return UITableViewCell()
    }
            
            cell.delegate = self

            switch indexPath.section {
            case Sections.channels.rawValue:
                APICaller.shared.getChannelData { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.firstPlaylist.rawValue:
                APICaller.shared.getPlaylistData { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            case Sections.secondPlaylist.rawValue:
                APICaller.shared.getPlaylistData { result in
                    switch result {
                    case .success(let titles):
                        cell.configure(with: titles)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            default:
                return UITableViewCell()

            }
            
            return cell
        }
        
    
        func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return 200
        }
        
        
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 40
        }
        
        func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
            guard let header = view as? UITableViewHeaderFooterView else {return}
            header.textLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
            header.textLabel?.frame = CGRect(x: header.bounds.origin.x + 20, y: header.bounds.origin.y, width: 100, height: header.bounds.height)
            header.textLabel?.textColor = .white
            header.textLabel?.text = header.textLabel?.text?.capitalizeFirstLetter()
        }
        
        func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
            return sectionTitles[section]
        }
        
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let defaultOffset = view.safeAreaInsets.top
            let offset = scrollView.contentOffset.y + defaultOffset
            
            navigationController?.navigationBar.transform = .init(translationX: 0, y: min(0, -offset))
        }
    }


extension HomeViewController: CollectionViewTableViewCellDelegate {
    func collectionViewTableViewCellDidTapCell(_ cell: CollectionViewTableViewCell, viewModel: TitlePreviewViewModel) {
        DispatchQueue.main.async { [weak self] in
            let vc = TitlePreviewViewController()
            vc.configure(with: viewModel)
            self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}





