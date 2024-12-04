//
//  ViewController.swift
//  APIDateFormattingProgramatically
//
//  Created by Srikanth Kyatham on 12/3/24.
//

import UIKit

class ViewController: UIViewController {
    
    let url = "https://swapi.py4e.com/api/people/1/"
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setUpLabel()
        fetchData()
    }
    func setUpLabel() {
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20)
            ])
    }
    
    func fetchData() {
        Network.sharedInstance.getData(from: url) { person in
            DispatchQueue.main.async {
                guard let person else { return }
                self.updateUI(with: person )
            }
        }
    }
    
    func updateUI(with person: PersonModel) {
        let text = """
                    Name: \(person.name ?? "N/A")
                    height: \(person.height ?? "N/A")
                    mass: \(person.mass ?? "N/A")
                    Hair Color: \(person.hair_color ?? "N/A")
                    Skin Color: \(person.skin_color ?? "N/A")
                    Created: \(formatDate(person.created))
                    Edited: \(formatDate(person.edited))
                    """
        label.text = text
    }
    
    func formatDate(_ dateString: String?, from format: String = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", to outputFormat: String = "dd/MM/yyyy") -> String {
        guard let dateString = dateString else { return "Invalid date" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        
        if let date = dateFormatter.date(from: dateString) {
            dateFormatter.dateFormat = outputFormat
            return dateFormatter.string(from: date)
        } else {
            return "Invalid date"
        }
    }

}

