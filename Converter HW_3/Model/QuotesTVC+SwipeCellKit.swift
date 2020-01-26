//
//  QuotesTVC+SwipeCellKit.swift
//  Pods
//
//  Created by Другов Родион on 25.11.2019.
//

import SwipeCellKit

extension QuotesTableViewController: SwipeTableViewCellDelegate {
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {

        let deleteAction = SwipeAction(style: .destructive,
                                       title: "Delete") { (action, indexPath) in
                                        self.quotes.remove(at: indexPath.row)
                                        self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
        return [deleteAction]
    }
}


