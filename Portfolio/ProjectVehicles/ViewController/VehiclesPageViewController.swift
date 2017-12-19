//
//  VehiclesPageViewController.swift
//  Activity2
//
//  Created by MacStudent on 2017-10-27.
//  Copyright © 2017 Araceli Teixeira. All rights reserved.
//

import UIKit

class VehiclesPageViewController: UIPageViewController, UIPageViewControllerDataSource {

    var vehicleType = ""
    private var index = 0
    var vehicles: [Vehicle] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.dataSource = self
        self.setViewControllers([getViewControllerAtIndex(0)] as [UIViewController], direction: UIPageViewControllerNavigationDirection.forward, animated: true, completion: nil)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = -1
        if vehicleType == "Cars" {
            let pageContent: CarsViewController = viewController as! CarsViewController
            index = pageContent.pageIndex
        } else if vehicleType == "Trucks" {
            let pageContent: TrucksViewController = viewController as! TrucksViewController
            index = pageContent.pageIndex
        } else {
            fatalError("Vehicle type not found")
        }
        if ((index == 0) || (index == NSNotFound))
        {
            return nil
        }
        index -= 1
        return getViewControllerAtIndex(index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = -1
        if vehicleType == "Cars" {
            let pageContent: CarsViewController = viewController as! CarsViewController
            index = pageContent.pageIndex
        } else if vehicleType == "Trucks" {
            let pageContent: TrucksViewController = viewController as! TrucksViewController
            index = pageContent.pageIndex
        } else {
            fatalError("Vehicle type not found")
        }
        if (index == NSNotFound)
        {
            return nil;
        }
        index += 1
        if (index == vehicles.count)
        {
            return nil;
        }
        return getViewControllerAtIndex(index)
    }
    
    func getViewControllerAtIndex(_ index: NSInteger) -> UIViewController
    {
        // Create a new view controller and pass suitable data.
        if vehicleType == "Cars" {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "CarsViewController") as! CarsViewController
            pageContentViewController.car = vehicles[index] as! Car
            pageContentViewController.pageIndex = index
            return pageContentViewController
        } else if vehicleType == "Trucks" {
            let pageContentViewController = self.storyboard?.instantiateViewController(withIdentifier: "TrucksViewController") as! TrucksViewController
            pageContentViewController.truck = vehicles[index] as! Truck
            pageContentViewController.pageIndex = index
            return pageContentViewController
        } else {
            fatalError("Vehicle type not found")
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
