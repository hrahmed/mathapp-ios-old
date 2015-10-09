//
//  ViewController.swift
//  mathapp
//
//  Created by ahmha02 on 2014-10-29.
//  Copyright (c) 2014 Haroon Ahmed. All rights reserved.
//

import UIKit
//#import <ca-maa-ios-sdk-1.0.0/CAMDOReporter.h>


class ViewController: UIViewController {
    @IBOutlet weak var portTextField: UITextField!
    @IBOutlet weak var hostTextField: UITextField!
    @IBOutlet weak var value1TextField: UITextField!
    @IBOutlet weak var resultTextField: UITextField!
    @IBOutlet weak var value2TextField: UITextField!
    @IBOutlet weak var operationSegmentControl: UISegmentedControl!
    
    //iniitialize variables
    var host = "localhost"
    var port = "8080"
    var operation: String = "add"
    var urlString: String = "unknown"
    
    
    @IBAction func calculateButton(sender: AnyObject) {

        //get port and host
        host = hostTextField.text as NSString
        port = portTextField.text as NSString
        
        
        //get operation and values
        var value1String = value1TextField.text as NSString
        var value2String = value2TextField.text as NSString
        var index = operationSegmentControl.selectedSegmentIndex
        
        if index == 0 {
            operation = "add"
        } else if index == 1 {
            operation = "subtract"
        } else if index == 2 {
            operation = "multiply"
        } else if index == 3 {
            operation = "divide"
        } else {
            operation = "error"
        }
        
        
        urlString = "http://\(host):\(port)/MathProxy/rest/hello/math?operation=\(operation)&value1=\(value1String)&value2=\(value2String)"
        
        println("*** URL2 is: \(urlString)")
        
        
        executeSimpleOperation()
        
        
    }
    
    func executeSimpleOperation () {
        
        CAMDOReporter.sharedInstance().startApplicationTransaction(operation)

        var url = NSURL(string: urlString)
        var request = NSURLRequest(URL: url!)
        
        var response: NSURLResponse? = nil
        var error: NSError? = nil
        
        var reply: NSData? = nil
        
        reply = NSURLConnection.sendSynchronousRequest(request, returningResponse:&response, error:&error)
        
        if reply != nil {
            let results = NSString(data:reply!,encoding:NSUTF8StringEncoding)
            
            println(results)
            
            var data : NSData! = results?.dataUsingEncoding(NSUTF8StringEncoding)
            var mathResult = parseJson(data)
            
            println("Result is: \(mathResult)")
            resultTextField.text = mathResult.stringValue
        } else {
            
            //NSLog("Result was unknown")
            resultTextField.text = "unknown"
        }
        
      CAMDOReporter.sharedInstance().stopApplicationTransaction()

    }

    
    func parseJson (jsonString: NSData) -> NSNumber {
        var result: Int = 0
        
        var jsonError: NSError?
        let jsonData: NSData = jsonString
        
        let jsonDict = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as NSDictionary
        
        if let unwrappedError = jsonError {
            println("json error: \(unwrappedError)")
        } else {
            result = jsonDict.valueForKeyPath("result") as Int
        }
        
        println("JSON parsed result is: \(result)")
        return result
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

