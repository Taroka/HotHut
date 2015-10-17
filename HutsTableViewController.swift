//
//  HutsTableViewController.swift
//  HotHut
//
//  Created by Sunny Chiu on 10/15/15.
//  Copyright © 2015 com.ching. All rights reserved.
//

import UIKit

class HutsTableViewController: PFQueryTableViewController {

    let cellIdentifier:String = "Cell"
    
    override init(style: UITableViewStyle, className: String!)
    {
        super.init(style: style, className: className)
        
        self.pullToRefreshEnabled = true
        self.paginationEnabled = false
        self.objectsPerPage = 25
        
        self.parseClassName = className
        
        self.tableView.rowHeight = 350
        self.tableView.allowsSelection = false
    }
    
    required init(coder aDecoder:NSCoder)  
    {
        fatalError("NSCoding not supported")  
    }

    override func viewDidLoad() {
        tableView.registerNib(UINib(nibName: "HutsTableViewCell", bundle: nil), forCellReuseIdentifier: cellIdentifier)
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func queryForTable() -> PFQuery {
        var query:PFQuery = PFQuery(className:self.parseClassName!)
        
        if(objects?.count == 0)
        {
            query.cachePolicy = PFCachePolicy.CacheThenNetwork
        }
        
        query.orderByAscending("name")
        
        return query
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath, object: PFObject?) -> PFTableViewCell? {
        
        var cell:HutsTableViewCell? = tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? HutsTableViewCell
        
        if(cell == nil) {
            cell = NSBundle.mainBundle().loadNibNamed("HutsTableViewCell", owner: self, options: nil)[0] as? HutsTableViewCell
        }
        
        cell?.parseObject = object
        
        if let pfObject = object {
            cell?.hutNameLabel?.text = pfObject["name"] as? String
            
            var votes:Int? = pfObject["votes"] as? Int
            if votes == nil {
                votes = 0
            }
            cell?.hutVotesLabel?.text = "\(votes!) votes"
            
            var credit:String? = pfObject["cc_by"] as? String
            if credit != nil {
                cell?.hutCreditLabel?.text = "\(credit!) / CC 2.0"
            }
            
            cell?.hutImageView?.image = nil
            if var urlString:String? = pfObject["url"] as? String {
                var url:NSURL? = NSURL(string: urlString!)
                
                if var url:NSURL? = NSURL(string: urlString!) {
                    var error:NSError?
                    var request:NSURLRequest = NSURLRequest(URL: url!, cachePolicy: NSURLRequestCachePolicy.ReturnCacheDataElseLoad, timeoutInterval: 5.0)
                    
                    NSOperationQueue.mainQueue().cancelAllOperations()
                    
                    NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: {
                        (response:NSURLResponse!, imageData:NSData!, error:NSError!) -> Void in
                        
                        (cell?.hutImageView?.image = UIImage(data: imageData))!
                        
                    })
                }
            }
            
        }
        
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based applihution, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
