//
//  Images.swift
//  HomeForSale
//
//  Created by Yury Bely on 08.06.2022.
//

import Foundation
import UIKit

func downsample(imageAt imageURL: URL, to pointSize: CGSize, scale: CGFloat) -> UIImage {
    print("downsample \(imageURL.lastPathComponent); size: \(pointSize); scale: \(scale)")
    let imageSourceOptions = [kCGImageSourceShouldCache: false] as CFDictionary
    let imageSource = CGImageSourceCreateWithURL(imageURL as CFURL, imageSourceOptions)!
    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
    let downsampleOptions =
    [kCGImageSourceCreateThumbnailFromImageAlways: true,
             kCGImageSourceShouldCacheImmediately: true,
       kCGImageSourceCreateThumbnailWithTransform: true,
              kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
    let downsampledImage =
    CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
    return UIImage(cgImage: downsampledImage)
}

func downsampleCGImageSource(_ imageSource: CGImageSource, to pointSize: CGSize, scale: CGFloat) -> UIImage {
    print("downsampleCGImageSource size: \(pointSize); scale: \(scale)")

    let maxDimensionInPixels = max(pointSize.width, pointSize.height) * scale
    let downsampleOptions =
    [kCGImageSourceCreateThumbnailFromImageAlways: true,
             kCGImageSourceShouldCacheImmediately: true,
       kCGImageSourceCreateThumbnailWithTransform: true,
              kCGImageSourceThumbnailMaxPixelSize: maxDimensionInPixels] as CFDictionary
    let downsampledImage = CGImageSourceCreateThumbnailAtIndex(imageSource, 0, downsampleOptions)!
    return UIImage(cgImage: downsampledImage)
}
