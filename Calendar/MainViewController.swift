//
//  ViewController.swift
//  Calendar
//
//  Created by Lubos Ilcik on 10/11/2018.
//  Copyright © 2018 Touch4It s.r.o. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBAction func didTapCalendar() {
        let calendarVC = UIStoryboard(name: "CalendarMonthViewController", bundle: nil).instantiateViewController(withIdentifier: "CalendarMonthViewController")
        show(calendarVC, sender: self)
    }

}

