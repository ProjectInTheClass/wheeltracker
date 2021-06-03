//
//  RecordViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit
import Charts

class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return pushDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = String(pushDatas[indexPath.row].calorie)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var stepsButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var kalButton: UIButton!
    @IBOutlet weak var time: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    
    // createdAt, distance, duration, pushCount, calorie
    
    
    
    // 가로축. x, y, z
    
    var dayAxis = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
     
        let dataCalendar = $0.createdAt
    
     
        if Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)! < 7 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0.createdAt
        
    }
    
    var weekAxis = pushDatas.sorted(by:{$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
        
        if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)! < 5 {
            return true
        } else {
            return false
        }
    
    }.reduce([PushData](), { result, item in
        var arr = result
        if(arr.count == 0){
            arr.append(item)
            return arr
        }
        let lastCalender = arr[arr.count - 1].createdAt
        let elementCalender = item.createdAt

        
        if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: lastCalender) == Calendar.current.ordinality(of: .weekOfYear, in: .year, for: elementCalender){
            arr[arr.count - 1] += item
        }
        else{
            arr.append(item)
        }
        
        return arr
    }).map{ (v:PushData)-> (Int?, Int?, Int?) in
        
        let dataCalendar = Calendar.current.dateComponents([.month, .weekOfYear, .weekOfMonth], from: v.createdAt)
        
        if(dataCalendar.weekOfYear != nil && dataCalendar.weekOfMonth != nil && dataCalendar.month != nil){
            return (dataCalendar.weekOfYear!, dataCalendar.weekOfMonth, dataCalendar.month)
        }
        return (0, 0, 0)

    }
    
    var monthAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    
    
    //data들
    
    var day = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
        let nowCalendar = Date()
        
     
        let dataCalendar = $0.createdAt
        
     
        if Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)! < 7 {
            return true
        } else {
            return false
        }
    
    }.map{
        $0
    }
    
    
    var week = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            let nowCalendar = Date()
            
         
            let dataCalendar = $0.createdAt
            
         
            if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)! < 5 {
                return true
            } else {
                return false
            }
        
        }.reduce([PushData](), { result, item in
            var arr = result
            if(arr.count == 0){
                arr.append(item)
                return arr
            }
            let lastCalender = arr[arr.count - 1].createdAt
            let elementCalender = item.createdAt

            
            if Calendar.current.ordinality(of: .weekOfYear, in: .year, for: lastCalender) == Calendar.current.ordinality(of: .weekOfYear, in: .year, for: elementCalender){
                arr[arr.count - 1] += item
            }
            else{
                arr.append(item)
            }
            
            return arr
        })
        
    var month = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            let nowCalendar = Date()
            
         
            let dataCalendar = $0.createdAt
            
         
            if Calendar.current.ordinality(of: .month, in: .year, for: nowCalendar)! - Calendar.current.ordinality(of: .month, in: .year, for: dataCalendar)! < 12 {
                return true
            } else {
                return false
            }
        
        }.reduce([PushData](), { result, item in
            var arr = result
            
            if(arr.count == 0){
                arr.append(item)
                return arr
            }
            
            let lastCalender = arr[arr.count - 1].createdAt
            let elementCalender = item.createdAt
            
            if Calendar.current.ordinality(of: .month, in: .year, for: lastCalender) == Calendar.current.ordinality(of: .month, in: .year, for: elementCalender){
                arr[arr.count - 1] += item
            }
            else{
                arr.append(item)
            }
            
            return arr
            
        })
    
    
   
    
    //ToDo : 각 날짜의 달을 받아와서 같은 달이면 값을 더해야해 어떻게 해야할까?
    
    var selectedValues = [Double]()
    var selectedshow = [String]()
    var dayWeekMonth = ""
    var pushDistanceCalorieDuration = ""
    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lineChartView.noDataText = "데이터가 없습니다."
        lineChartView.noDataFont = .systemFont(ofSize: 20)
        lineChartView.noDataTextColor = .lightGray
        
        selectedValues = day.map{
            i in Double(i.pushCount)
        }
        
        let dayString = dayAxis.map{
            dayToString(date: $0)
        }
        selectedshow = dayString
        pushDistanceCalorieDuration = "push"
        dayWeekMonth = "day"
        setChart(dataPoint: selectedshow, values: selectedValues, name: "")
        
        
        
        //table view
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        

    }
    
    
    
    func dayToString(date: Date)->String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        return dateFormatter.string(from: date)
    }
    
    func weekToString(now: (Int?, Int?, Int?)) -> String{
        
        
        
        //let nowCalendar = Calendar.current.dateComponents([.month], from: Date())
        var returnString = ""
        
        returnString = String(now.2!) + "." + String(now.1!) + "주"
     
        
        return returnString
        
    }
    

    
    func setChart(dataPoint: [String], values: [Double], name: String){
        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        //selectedValues = selectedValues[0...dataPoint.count]


        for i in 0..<values.count{

            let dataEntry = ChartDataEntry(x: Double(i), y: Double(selectedValues[i]))
        
            lineChartEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineChartEntries, label:name)
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        lineChartView.doubleTapToZoomEnabled = false
        
        //차트색
        chartDataSet.colors = [NSUIColor.blue]
        //데이터 삽입
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
        
        //x축 레이블 위치 수정
        lineChartView.xAxis.labelPosition = .bottom
        //x축 레이블 포맷 지정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoint)
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        

        
        
    }
        
    
    @IBAction func showLineChart(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Day"{
            let dayString = dayAxis.map{
                dayToString(date: $0)
            }
            selectedshow = dayString
            dayWeekMonth = "day"
            if pushDistanceCalorieDuration == "push"{
                selectedValues = day.map{
                    i in Double(i.pushCount)
                }
                
            }else if pushDistanceCalorieDuration == "distance"{
                selectedValues = day.map{
                    i in i.distance
                }
                
            }else if pushDistanceCalorieDuration == "calorie"{
                selectedValues = day.map{
                    i in i.calorie
                }
                
            }else if pushDistanceCalorieDuration == "duration"{
                selectedValues = day.map{
                    i in i.duration
                }
                
            }
            
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Week"{
            

            let weekString = weekAxis.map{i in
                weekToString(now: i)
                
            }
            let noDup = Set(weekString)
            selectedshow = Array(noDup).sorted()
            //selectedshow = weekAxis
            dayWeekMonth = "week"
            if pushDistanceCalorieDuration == "push"{
                selectedValues = week.map{
                    i in Double(i.pushCount)
                }
                
            }else if pushDistanceCalorieDuration == "distance"{
                selectedValues = week.map{
                    i in i.distance
                }
                
            }else if pushDistanceCalorieDuration == "calorie"{
                selectedValues = week.map{
                    i in i.calorie
                }
                
            }else if pushDistanceCalorieDuration == "duration"{
                selectedValues = week.map{
                    i in i.duration
                }
                
            }
            
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        } else if sender.titleLabel?.text == "Month"{

            
            let a = monthAxis[0..<month.count]
            print("a : ", a)
            selectedshow = Array(a)
            print("selectedshow", monthAxis)
            //selectedshow = monthAxis
            dayWeekMonth = "month"
            if pushDistanceCalorieDuration == "push"{
                selectedValues = month.map{
                    i in Double(i.pushCount)
                }
                
            }else if pushDistanceCalorieDuration == "distance"{
                selectedValues = month.map{
                    i in i.distance
                }
                
            }else if pushDistanceCalorieDuration == "calorie"{
                selectedValues = month.map{
                    i in i.calorie
                }
                
            }else if pushDistanceCalorieDuration == "duration"{
                selectedValues = month.map{
                    i in i.duration
                }
                
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
            
        }
        
        
        
    
    }
    @IBAction func selectValue(_ sender: UIButton) {
        
        
        if sender.titleLabel?.text == "걸음수"{
            pushDistanceCalorieDuration = "push"
            if dayWeekMonth == "day"{
                selectedValues = day.map{
                    i in Double(i.pushCount)
                }
                
            }else if dayWeekMonth == "week"{
                selectedValues = week.map{
                    i in Double(i.pushCount)
                }
                
            }else if dayWeekMonth == "month"{
                selectedValues = month.map{
                    i in Double(i.pushCount)
                }
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name:"")
            
        }else if sender.titleLabel?.text == "거리"{
            pushDistanceCalorieDuration = "distance"
            if dayWeekMonth == "day"{
                selectedValues = day.map{
                    i in i.distance
                }
                
            }else if dayWeekMonth == "week"{
                selectedValues = week.map{
                    i in i.distance
                }
                
            }else if dayWeekMonth == "month"{
                selectedValues = month.map{
                    i in i.distance
                }
            }
            
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "칼로리"{
            pushDistanceCalorieDuration = "calorie"
            if dayWeekMonth == "day"{
                selectedValues = day.map{
                    i in i.calorie
                }
                
            }else if dayWeekMonth == "week"{
                selectedValues = week.map{
                    i in i.calorie
                }
                
            }else if dayWeekMonth == "month"{
                selectedValues = month.map{
                    i in i.calorie
                }
            }
    
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }else if sender.titleLabel?.text == "시간"{
            pushDistanceCalorieDuration = "duration"
            if dayWeekMonth == "day"{
                selectedValues = day.map{
                    i in i.duration
                }
                
            }else if dayWeekMonth == "week"{
                selectedValues = week.map{
                    i in i.duration
                }
                
            }else if dayWeekMonth == "month"{
                selectedValues = month.map{
                    i in i.duration
                }
            }
            setChart(dataPoint: selectedshow, values: selectedValues, name: "")
            
        }
        
    }
    

}
