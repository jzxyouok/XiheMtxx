//
//  MainViewController.swift
//  EasyCard
//
//  Created by echo on 2017/2/14.
//  Copyright © 2017年 羲和. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {
    
    var originImage: UIImage!
    
    // 返回按钮
    lazy var backButton: UIButton = {
        let _backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        _backButton.setTitleColor(UIColor.gray, for: .normal)
        _backButton.setImage(UIImage(named: "icon_back_a_25x25_"), for: .normal)
        _backButton.addTarget(self, action: #selector(back(sender:)), for: .touchUpInside)
        _backButton.contentHorizontalAlignment = .left
        return _backButton
    }()
    
    // 保存按钮
    lazy var saveButton: UIButton = {
        let _saveButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        _saveButton.setTitleColor(UIColor.gray, for: .normal)
        _saveButton.setImage(UIImage(named: "icon_download_white_16x16_"), for: .normal)
        _saveButton.addTarget(self, action: #selector(save(sender:)), for: .touchUpInside)
        _saveButton.contentHorizontalAlignment = .right
        _saveButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 5)
        return _saveButton
    }()
    
    // 撤销按钮
    lazy var undoButton: UIButton = {
        let _undoButton = UIButton(frame: CGRect(x: 0, y: 0, width: 60, height: 40))
        _undoButton.setTitleColor(UIColor.gray, for: .normal)
        _undoButton.setImage(UIImage(named: "btn_undo_30x30_"), for: .normal)
        _undoButton.addTarget(self, action: #selector(revoke(sender:)), for: .touchUpInside)
        return _undoButton
    }()
    
    // 恢复按钮
    lazy var redoButton: UIButton = {
        let _redoButton = UIButton(frame: CGRect(x: 60, y: 0, width: 60, height: 40))
        _redoButton.setImage(UIImage(named: "btn_redo_30x30_"), for: .normal)
        _redoButton.setTitleColor(UIColor.gray, for: .normal)
        _redoButton.addTarget(self, action: #selector(recover(sender:)), for: .touchUpInside)
        return _redoButton
    }()
    
    // 标题View
    lazy var titleView: UIView = {
        
        let _titleView = UIView(frame: CGRect(x: 0, y: 0, width: 120, height: 40))
        _titleView.backgroundColor = UIColor.clear
        return _titleView
    }()
    
    // scrollView
    lazy var imageScrollView: UIScrollView = {
        
        let _imageScrollView = UIScrollView(frame: CGRect(x: 0, y: 44, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 44 - 50))
        _imageScrollView.backgroundColor = UIColor.colorWithHexString(hex: "#2c2e30")
        _imageScrollView.alwaysBounceVertical = true
        _imageScrollView.alwaysBounceHorizontal = true
        return _imageScrollView
    }()
    
    // imageView
    lazy var imageView: UIImageView = {
        let _imageView = UIImageView(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.width))
        _imageView.backgroundColor = UIColor.white
        return _imageView
    }()
    
    lazy var toolBar: ToolBarView = {
        let sizeItem = ToolBarItemObject()
        sizeItem.imageName = "icon_meihua_frame_normal_30x30_"
        sizeItem.titleName = "编辑"
        sizeItem.action = {
            self.editImage()
        }
        
        let backgroundItem = ToolBarItemObject()
        backgroundItem.imageName = "icon_meihua_smart_normal_30x30_"
        backgroundItem.titleName = "背景"
        
        let textItem = ToolBarItemObject()
        textItem.imageName = "icon_meihua_word_normal_30x30_"
        textItem.titleName = "文字"
        
        let imageItem = ToolBarItemObject()
        imageItem.imageName = "icon_meihua_sticker_normal_30x30_"
        imageItem.titleName = "图片"
        
        let styleItem = ToolBarItemObject()
        styleItem.imageName = "ic_keyboard_normal_18x18_"
        styleItem.titleName = "排版"
        
        let _toolBar = ToolBarView(items: [sizeItem, backgroundItem, textItem, imageItem, styleItem])
        return _toolBar
    }()

    // MARK: - Override Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.view.backgroundColor = UIColor.white
        // 返回按钮
        self.navigationItem.leftItemsSupplementBackButton = true
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: self.backButton)
        // 保存按钮
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: self.saveButton)
        // 标题View - 撤销，恢复按钮
        self.titleView.addSubview(self.undoButton)
        self.titleView.addSubview(self.redoButton)
        self.navigationItem.titleView = self.titleView
        
        // 图片scrollView
        self.view.addSubview(self.imageScrollView)
        
        // imageView
        self.imageView.image = self.originImage
        self.imageView.frame = self.rectImageInScrollView()
        self.imageScrollView.addSubview(self.imageView)
        
        self.view.addSubview(self.toolBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Private Actions
    
    //将图片完整的放进scrollView中，并获取imageView.frame
    func rectImageInScrollView() -> CGRect {
        let imageBounds = self.imageScrollView.frame
        let imageRatio = self.originImage.size.width / self.originImage.size.height
        let viewRatio = imageBounds.size.width / imageBounds.size.height
        var size = CGSize.zero
        if imageRatio >= viewRatio {
            size = CGSize(width: imageBounds.size.width, height: imageBounds.size.width/imageRatio)
        }
        else {
            size = CGSize(width: imageBounds.size.height * imageRatio, height: imageBounds.size.height)
        }
        let origin = CGPoint(x: (imageBounds.size.width - size.width)/2, y: (imageBounds.size.height - size.height)/2)
        return CGRect(origin: origin, size: size)
    }
    
    // 返回
    func back(sender: UIButton) -> Void {
        self.dismiss(animated: true) { 
            
        }
    }
    
    // 保存
    func save(sender: UIButton) -> Void {
        
        self.dismiss(animated: true) {
            
        }
    }
    
    // 撤销
    func revoke(sender: UIButton) -> Void {
        
    }
    
    // 恢复
    func recover(sender: UIButton) -> Void {
        
    }
    
    // 编辑图片
    func editImage() -> Void {
        let editImageVC = EditImageViewController()
        self.present(editImageVC, animated: true) {
            
        }
    }
}