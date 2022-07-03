//
//  LlistView.swift
//  VGApp
//
//  Created by Kiara on 10.02.22.
//

import UIKit

class ListView: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    private let tableView : UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(ListCell.self, forCellReuseIdentifier: ListCell.identifier)
        table.register(DeleteCell.self, forCellReuseIdentifier: DeleteCell.identifier)
        return table
    }()
    var models = [Section]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.models = []
        configure();
        self.tableView.reloadData();
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        self.navigationItem.title = "Einkaufsliste"
        
        self.navigationItem.rightBarButtonItem =  UIBarButtonItem(title: "Neue Liste", style: .plain, target: self, action: #selector(createList))
        
        if #available(iOS 15.0, *) {
            let appearence =  UITabBarAppearance()
            appearence.configureWithDefaultBackground()
            self.tabBarController?.tabBar.scrollEdgeAppearance = appearence
            let appearence2 =  UINavigationBarAppearance()
            appearence2.configureWithDefaultBackground()
            self.navigationController?.navigationBar.scrollEdgeAppearance = appearence2
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        update()
    }
    
    @objc func createList(_ sender:UIButton) {
        _ = Util.createNewList()
        update()
    }
    
    func update() {
        self.models = []
        configure();
        self.tableView.reloadData();
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
        case .listCell(let model):
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ListCell.identifier, for: indexpath) as? ListCell else {
                return UITableViewCell()
            }
            cell.configure(with: model)
            return cell
        
        case .deleteCell(let model):
                 guard let cell = tableView.dequeueReusableCell(withIdentifier: DeleteCell.identifier, for: indexpath) as? DeleteCell else {
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
        case .listCell(let model):
            model.selectHandler()
        case .deleteCell(let model):
            model.selectHandler()
        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Löschen", handler: {action, indexPath in
            let cell = tableView.cellForRow(at: indexPath) as! ListCell
            CoreDataStack.shared.managedObjectContext.delete(cell.listBase!)
            
            self.models[indexPath.section].options.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
            self.update()
        })
        return [deleteAction]
    }
    
    func configure(){
        var listArray = CoreData.getAlllLists()!
        
        var arr: [ListSectionOption] = []
        if (listArray.count < 1) {return;}
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "de")
        dateFormatter.dateFormat = "E dd.MM.yyyy, HH:mm"
        listArray = listArray.sorted{$0.date! > $1.date!}
        
        for list in listArray {
            arr.append(.listCell(model: ListOption(title: dateFormatter.string(from: list.date!), subtitle: String(list.items!.count), list: list, selectHandler: {
            })))
        }
        models.append(Section(title: "Listen", options: arr))
        
        
        models.append(Section(title: "Bearbeiten", options: [.deleteCell(model: DeleteOption(selectHandler: {
            Util.deleteAllLists()
            self.update()
        }))]))
    }
    
}
