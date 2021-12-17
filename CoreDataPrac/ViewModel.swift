//
//  ViewModel.swift
//  CoreDataPrac
//
//  Created by 野中祐希 on 2021/12/17.
//

import SwiftUI
import CoreData

class ViewModel: ObservableObject {
    @Published var content = ""
    @Published var date = Date()
    @Published var isNewData = false
    @Published var updateItem: Task!
    
    /*
     新規登録として呼ばれた場合は、if文より下のコードが利用されCoreDataへとデータが書き込まれる
     データ書き込み後はSheetを隠し、次回の登録に向けタスク内容とスケジュール内容を初期化する
     更新として呼ばれた場合は、if文内のコードが利用され、編集後のデータが書き込まれる
     データ書き込み後は、新規登録同様に関係データを初期化する
     */
    func writeData(context: NSManagedObjectContext) {
        if updateItem != nil {
            updateItem.date = date
            updateItem.content = content
            try! context.save()
            
            updateItem = nil
            isNewData.toggle()
            content = ""
            date = Date()
            return
        }
        
        let newTask = Task(context: context)
        newTask.date = date
        newTask.content = content
        
        do {
            try context.save()
            isNewData.toggle()
            content = ""
            date = Date()
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    /*
     すでに登録されているデータを編集するために利用する
     元となるデータをあらかじめ表示する形で、登録用のsheetを表示する
     書き込みは、上記で紹介した登録用のメソッドを利用する
     */
    func EditItem(item:Task) {
        updateItem = item
        
        date = item.date!
        content = item.content!
        isNewData.toggle()
    }
}
