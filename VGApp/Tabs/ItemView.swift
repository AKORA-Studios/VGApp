//
//  ItemView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import UIKit

class Itemview: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ItemsCell.self, forCellReuseIdentifier: ItemsCell.identifier)
        return table
    }()
    
    var models = [Section2]()
    var list: ShoppingList?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.models = []
        configure();
        self.tableView.reloadData();
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        if #available(iOS 15.0, *) {
                  let appearence =  UITabBarAppearance()
                  appearence.configureWithDefaultBackground()
                  self.tabBarController?.tabBar.scrollEdgeAppearance = appearence
                  let appearence2 =  UINavigationBarAppearance()
                  appearence2.configureWithDefaultBackground()
                  self.navigationController?.navigationBar.scrollEdgeAppearance = appearence2
        }
        
        self.navigationItem.rightBarButtonItem?.tintColor = .systemOrange
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Neues Item", style: .plain, target: self, action: #selector(createItem))
        
        update()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    func update() {
        self.list = CoreData.getLastLlist()
        if(self.list != nil) {
            self.navigationItem.title = "Übersicht"
        } else {
            self.navigationItem.title = "Keine Liste vorhanden"
        }
        self.models = []
        configure();
        self.tableView.reloadData();
    }
    
    @objc func createItem(_ sender:UIButton) {
        Util.createItem(list!)
        update()
    }

    //MARK: Table Config
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    { return models[section].options.count}
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let section = models[section]
        return section.title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexpath: IndexPath) -> UITableViewCell{
        let model = models[indexpath.section].options[indexpath.row]
        
        switch model.self{
        case .itemCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ItemsCell.identifier, for: indexpath) as? ItemsCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let type = models[indexPath.section].options[indexPath.row]
        
        switch type.self{
        case .itemCell(let model):
            model.selectHandler()
        }
    }
    
    func configure(){
        if(self.list == nil) { return}
        let itemArray = CoreData.getListItems(list!)!
        if(itemArray.count == 0) { return}
        
        var arr: [ItemSectionOption] = []
        //listArray = listArray.sorted{$0.date! > $1.date!}
        
        for item in itemArray {
            arr.append(.itemCell(model: ItemOption(title: item.name!, subtitle: item.number!, selectHandler: {
                print("hi")
            })))
        }
        models.append(Section2(title: "Items", options: arr))
        
        models.append(Section2(title: "Bearbeiten", options: [.itemCell(model: ItemOption(title: "Alle Löschen", subtitle: "", selectHandler: {
            Util.deleteAllItems(self.list!)
            self.update()
        }))]))
        
    }
}

