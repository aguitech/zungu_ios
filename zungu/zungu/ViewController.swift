//
//  ViewController.swift
//  zungu
//
//  Created by Giovanni Aranda on 01/09/16.
//  Copyright © 2016 Giovanni Aranda. All rights reserved.
//

import UIKit

class ViewController: UIPageViewController, UIPageViewControllerDataSource{
    
    let preferences = NSUserDefaults.standardUserDefaults()
    let currentLevelKey = "arrayUsuario"
    
    
    
    var arrPageTitle: NSArray = NSArray()
    var arrPagePhoto: NSArray = NSArray()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.arrPageTitle = ["Encuentra el mejor veterinario para el cuidado de tu mascota","Adopta un amigo y cuida de él,ubica la mascota ideal para ti","Administra el perfil de tu mascota y compártelo con familiares y amigos","Forma parte de nuestra red veterinaria y encuentra todos los servicios que tu mascota necesita."]
        self.arrPagePhoto = ["gif1","gif2","gif3","gif1"]
        
        self.dataSource = self
        
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.Forward, animated: false, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if preferences.objectForKey(currentLevelKey) == nil {
            //  Doesn't exist
        } else {
            
            //let currentLevel = preferences.objectForKey(currentLevelKey)
            let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
            
            let nextViewController = storyBoard.instantiateViewControllerWithIdentifier("HomeView") as! HomeController
            self.presentViewController(nextViewController, animated:true, completion:nil)
            
            
            return
        }
        

    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerBeforeViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PagePantalla2Controller = viewController as! PagePantalla2Controller
        var index = pageContent.pageIndex
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(pageViewController: UIPageViewController, viewControllerAfterViewController viewController: UIViewController) -> UIViewController?
    {
        let pageContent: PagePantalla2Controller = viewController as! PagePantalla2Controller
        var index = pageContent.pageIndex
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1
        if (index == arrPageTitle.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index)
    }
    
    func getViewControllerAtIndex(index: NSInteger) -> PagePantalla2Controller
    {
        // Create a new view controller and pass suitable data.
        let pageContentViewController = self.storyboard?.instantiateViewControllerWithIdentifier("PageContentViewController") as! PagePantalla2Controller
        pageContentViewController.titleIndex = "\(arrPageTitle[index])"
        pageContentViewController.imageFIle = "\(arrPagePhoto[index])"
        pageContentViewController.pageIndex = index
        return pageContentViewController
    }
    
}


