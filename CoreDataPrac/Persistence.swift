//
//  Persistence.swift
//  CoreDataPrac
//
//  Created by 野中祐希 on 2021/12/17.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "CoreDataPrac")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // この実装をエラーを適切に処理するコードに置き換える
                // fatelError()はアプリケーションにクラッシュログを生成して終了させるもの。この関数は開発中のみ使えるが出荷時には消す。

                /*
                エラーが発生する代表的な理由：
                * 親ディレクトリが存在しない、作成できない、または書き込みを許可しない
                * デバイスがロックされている場合、パーミッションまたはデータ保護により、永続ストアにアクセスできない
                * デバイスの容量が不足している
                * ストアを現在のモデルバージョンに移行することができなかった
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
