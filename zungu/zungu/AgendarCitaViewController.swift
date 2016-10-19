//
//  AgendarCitaViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 27/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class AgendarCitaViewController: UIViewController,UIPickerViewDelegate,UIPickerViewDataSource {

    @IBOutlet weak var doctoresSelect: UITextField!
    var ArrayList = [[String: String]]()
    let pickerView = UIPickerView()
    var idvet:Int?
    var idDoctor = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        pickerView.delegate = self
        pickerView.backgroundColor = UIColor.whiteColor()
        
        
        doctoresSelect.inputView = pickerView
        
        let toolBar = UIToolbar(frame: CGRectMake(0, self.view.frame.size.height/6, self.view.frame.size.width, 40.0))
        toolBar.layer.position = CGPoint(x: self.view.frame.size.width/2, y: self.view.frame.size.height-20.0)
        
        toolBar.barStyle = UIBarStyle.BlackTranslucent
        
        toolBar.tintColor = UIColor.whiteColor()
        
        toolBar.backgroundColor = UIColor.grayColor()
        
        let defaultButton = UIBarButtonItem(title: "Default", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(self.tappedToolBarBtn))
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: #selector(self.donePressed))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.FlexibleSpace, target: self, action: nil)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width / 3, height: self.view.frame.size.height))
        
        label.font = UIFont(name: "Helvetica", size: 12)
        
        label.backgroundColor = UIColor.clearColor()
        
        label.textColor = UIColor.whiteColor()
        
        label.text = "Selecciona uno"
        
        label.textAlignment = NSTextAlignment.Center
        
        let textBtn = UIBarButtonItem(customView: label)
        
        toolBar.setItems([defaultButton,flexSpace,textBtn,flexSpace,doneButton], animated: true)
        
        doctoresSelect.inputAccessoryView = toolBar
        
        

        // Do any additional setup after loading the view.
    }
    
    func cargaDatos(){
        let url = NSURL(string: "http://hyperion.init-code.com/zungu/app/doctores.php?vet=\(idvet!)")
        let task = NSURLSession.sharedSession().dataTaskWithURL(url!) { (data, response, error) in
            if error != nil{
                
                print(error)
                
            }else{
                if let jsonResult = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers){
                    
                    //self.ArrayList = [[String: String]]()
                    if let items = jsonResult as? [[String: String]]{
                        
                        for item in items{
                            self.ArrayList.append((item))
                        }
                        
                    }
                    dispatch_async(dispatch_get_main_queue(), {
                      
                        self.pickerView.reloadAllComponents()
                        
                        return
                    })
                    
                }
            }
        }
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ArrayList.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ArrayList[row]["nombre"]
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        doctoresSelect.text = ArrayList[row]["nombre"]
        idDoctor = Int(ArrayList[row]["id_doctor"]!)!
    }
    
    func tappedToolBarBtn(sender: UIBarButtonItem) {
        
        doctoresSelect.text = "Doctor / Doctora"
        
        doctoresSelect.resignFirstResponder()
    }
    
    func donePressed(sender: UIBarButtonItem) {
        
        doctoresSelect.resignFirstResponder()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
