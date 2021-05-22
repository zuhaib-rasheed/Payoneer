//
//  PaymentProviderTableViewCell.swift
//  Payoneer
//
//  Created by Zuhaib Rasheed on 11.05.21.
//

import UIKit

class PaymentProviderTableViewCell: UITableViewCell {
    
    static let identifier = "PaymentProviderTableViewCell"
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var providerName: UILabel!
    @IBOutlet weak var providerImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        clipsToBounds = true
        parentView.layer.cornerRadius = 5.0
        parentView.layer.shadowColor = UIColor.lightGray.cgColor
        parentView.layer.shadowOpacity = 0.7
        parentView.layer.shadowOffset = .zero
        parentView.layer.shadowRadius = 3.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(name: String, imageURL: URL?) {
        providerName.text = name
        guard let url = imageURL else { return }
        loadImage(url: url)
    }
    
    private func loadImage(url: URL) {
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                return
            }
            DispatchQueue.main.async {
                self?.providerImage.image = UIImage(data: data)
            }
        }.resume()
    }
}
