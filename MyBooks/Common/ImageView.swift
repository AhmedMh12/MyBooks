//
//  ImageView.swift
//  MyBooks
//
//  Created by MacBook Pro on 1/4/2022.
//

import Foundation
import UIKit
import SDWebImage

public class ImageView: UIImageView {
    
    let activity = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    var downloadImageCompletion: SDWebImageQueryCompletedBlock?
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(self.activity)
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        self.activity.frame = self.bounds;
    }
    
    public func setImageFromUrl(urlString: String, placeHolder: UIImage? = nil) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        let options: SDWebImageOptions = [
            .continueInBackground,
            .highPriority,
            .progressiveDownload,
            .refreshCached,
            .retryFailed
        ]
        self.image = placeHolder
        self.startLoader()
        
        self.sd_setImage(
            with: url,
            placeholderImage: placeHolder,
            options: options) { [weak self] (image, _, _, _) in
                guard let this = self else { return }
                this.stopLoader()
        }
    }
    
    private func startLoader() {
        activity.isHidden = false
        activity.startAnimating()
    }
    
    private func stopLoader() {
        activity.isHidden = true
        activity.stopAnimating()
    }
}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
