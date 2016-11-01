//
//  ViewController.swift
//  search
//
//  Created by 彭盛凇 on 2016/11/1.
//  Copyright © 2016年 huangbaoche. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cellID = "cellID"
    
    let allDataList:Array<String> = ["1","2","3","4","5","6","7","8","9","10","11","12","13","14","15"]   //数据源数组
    
    var resultDaraList:Array<String> = []   //搜索结果数组
    
    lazy var searchBar:UISearchBar = {
        
        let bar = UISearchBar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        bar.barStyle = .black                   //默认defalut
        
        bar.placeholder = "搜索"                 //提示文字
        
        bar.showsCancelButton = true            //显示右侧cancel按钮
        
        bar.showsScopeBar = true                //范围？

        bar.showsBookmarkButton = true          //显示testField右侧书签按钮
        
//        bar.showsSearchResultsButton = true     //显示testField右侧蓝色按钮
        
        bar.isSearchResultsButtonSelected = true
        
        bar.delegate = self
            
        return bar
        
    }()
    
    lazy var tableView: UITableView = {
       
        let tableview = UITableView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height), style: .plain)
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: self.cellID)
        
        tableview.showsVerticalScrollIndicator = false//隐藏 右侧滚动条
        
        tableview.delegate = self
        
        tableview.dataSource = self
        
        tableview.tableHeaderView = self.searchBar
        
        return tableview
        
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = true//恢复自定义，关闭系统自适应
        
        title = "我是title"
        
        resultDaraList = allDataList
        
        view.addSubview(tableView)
        
    }

}

extension ViewController: UISearchBarDelegate {
    @available(iOS 2.0, *)
    public func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {//开始编辑，如果返回NO，则不成为第一响应者（显示键盘）
        
        return true
        
    }// return NO to not become first responder
    
    @available(iOS 2.0, *)
    public func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {//当searchBar 开始编辑的时候
        
        if searchBar.text == "" {
            //开始编辑，清空数组，刷新tableview，在此方法中写和返回布尔值得方法中写，效果一样
            resultDaraList = allDataList
            tableView.reloadData()
        }else{//当搜索栏中有数据时，则不重置数据源，不刷新tableview
            
            return
        }
    
        
        
    }// called when text starts editing
    
    @available(iOS 2.0, *)
    public func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {//结束编辑，如果返回NO，则不 取消第一响应者（隐藏键盘）
        
        return true
        
    }// return NO to not resign first responder
    
    @available(iOS 2.0, *)
    public func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {//已经结束编辑
        
        if searchBar.text == "" {
            //结束编辑，更新数组为数据源，刷新tableview，在此方法中写和返回布尔值得方法中写，效果一样
            resultDaraList = allDataList
            tableView.reloadData()
        }else {//当搜索栏中有数据时，则不重置数据源，不刷新tableview
            return
        }
        
        
        
    }// called when text ends editing
    
    @available(iOS 2.0, *)
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {//当searchBar进行修改的时候（包括点击清除按钮）
        print(searchText)
        
        if searchText == "" {
            resultDaraList = allDataList
        }else {
            
            resultDaraList = []
            
            for string in allDataList {
                if string.lowercased().hasPrefix(searchText.lowercased()) {
                    resultDaraList.append(string)
                }
            }
        }
        
        tableView.reloadData()
        
    }// called when text changes (including clear)主要用这个！！！
    
    @available(iOS 3.0, *)
    public func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool{
        return true
    }// called before text changes 在searchBar进行修改（textDidChange之前调用）之前，如果返回no，则不会调用textDidChange，并且输入文字不会显示在searchBar中
    
    @available(iOS 2.0, *)
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {//当搜索按钮被点击时,（键盘中的搜索按钮）是否需要做操作，一般都是监测输入，下面tableview显示
        
    }// called when keyboard search button pressed
    
    @available(iOS 2.0, *)
    public func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {//当书签被点击时
        
    }// called when bookmark button pressed
    
    @available(iOS 2.0, *)
    public func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {//当取消按钮被点击时
        
        searchBar.text = ""
        searchBar.resignFirstResponder()//隐藏键盘
        //结束编辑，更新数组为数据源，刷新tableview，在此方法中写和返回布尔值得方法中写，效果一样
        resultDaraList = allDataList
        
        tableView.reloadData()
    }// called when cancel button pressed
    
    @available(iOS 3.2, *)
    public func searchBarResultsListButtonClicked(_ searchBar: UISearchBar) {//当搜索 结果被点击时
        
    }// called when search results button pressed
    
    @available(iOS 3.0, *)
    public func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {//当搜索索引被更改时
        
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
}

extension ViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultDaraList.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath)
        
        cell.textLabel?.text = resultDaraList[indexPath.row]
        
        return cell
        
    }
    
}
