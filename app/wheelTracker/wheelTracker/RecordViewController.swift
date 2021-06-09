//
//  RecordViewController.swift
//  wheeltracker
//
//  Created by 한경수 on 2021/04/30.
//

import UIKit
import Charts

public var dayWeekMonth = ""
public var pushDistanceCalorieDuration = ""


public var selectedValues = [Double]()
public var selectedshow = [String]()
public var check = 0



class RecordViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    // tableview 설정
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return pushDatas.count
    }

    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(identifier: "UTC")
        
        let dateString = pushDatas.sorted(by: {$0.createdAt > $1.createdAt}).map{
            dateFormatter.string(from: $0.createdAt)
        }
        let calorie = pushDatas.sorted(by: {$0.createdAt > $1.createdAt}).map{
            $0.calorie
        }
        let distance = pushDatas.sorted(by: {$0.createdAt > $1.createdAt}).map{
            $0.distance
        }
        let duration = pushDatas.sorted(by: {$0.createdAt > $1.createdAt}).map{
            $0.duration
        }
        let pushCount = pushDatas.sorted(by: {$0.createdAt > $1.createdAt}).map{
            $0.pushCount
        }
        cell.textLabel?.font = .systemFont(ofSize: 16)
        cell.textLabel?.text = "[" + String(dateString[indexPath.row]) + "]\n" + "push : " + String(pushCount[indexPath.row]) + " distance : " + String(distance[indexPath.row]) + "\ncalorie : " + String(calorie[indexPath.row]) + " duration : " + String(duration[indexPath.row])
        
        let textColor =  #colorLiteral(red: 0.1520237625, green: 0.1570370793, blue: 0.06181135774, alpha: 0.7430436644)
        cell.textLabel!.textColor = textColor
        cell.textLabel!.lineBreakMode = .byWordWrapping
        cell.textLabel!.numberOfLines = 0

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    

 
    

    @IBOutlet var lineChartView: LineChartView!
    @IBOutlet weak var dayButton: UIButton!
    @IBOutlet weak var weekButton: UIButton!
    @IBOutlet weak var monthButton: UIButton!
    @IBOutlet weak var pushButton: UIButton!
    @IBOutlet weak var distanceButton: UIButton!
    @IBOutlet weak var calButton: UIButton!
    @IBOutlet weak var durationButton: UIButton!
    

    
    @IBOutlet weak var tableView: UITableView!
    let cellIdentifier: String = "cell"
    var dayAxis = [Date]()
    var weekAxis = [(Int?, Int?, Int?)].init()
    var monthAxis = [String]()
    var day = [PushData]()
    var week = [PushData]()
    var month = [PushData]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()
        
        
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
        


        let clickColor =  #colorLiteral(red: 0.8470588235, green: 0.8745098039, blue: 0.3098039216, alpha: 0.7430436644)

        
        pushButton.setTitleColor(clickColor, for: .normal)
        pushButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        
        dayButton.setTitleColor(clickColor, for: .normal)
        dayButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16.0)
        

    

    }
    // reloadData
    override func viewWillAppear(_ animated: Bool) {
        self.tableView.reloadData()
    
    }
    // update datas
    func UpdateUI(){
        
        // 가로축. x, y, z
  
        
        dayAxis = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            let nowCalendar = Date()
         
            let dataCalendar = $0.createdAt
            
            let now = Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)!
            let data = Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)!
            
            if now - data < 7  && now - data >= 0  && dataCalendar.isInThisYear{
                return true
            } else {
                return false
            }
        
        }.map{
            
            $0.createdAt
            
        }
        
        
        weekAxis = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            let nowCalendar = Date()
            
         
            let dataCalendar = $0.createdAt
            
            
            
            let now = Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)!
            let data = Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)!
 
            
            if now - data < 7  && dataCalendar.isInThisYear{
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
        
        monthAxis = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
        
        
        //data들
        
        day = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            
            let nowCalendar = Date()
            
         
            let dataCalendar = $0.createdAt
            
            let now = Calendar.current.ordinality(of: .day, in: .year, for: nowCalendar)!
            let data = Calendar.current.ordinality(of: .day, in: .year, for: dataCalendar)!

            if now - data < 7  && now - data >= 0 && dataCalendar.isInThisYear{
                return true
            } else {
                return false
            }
        
        }.map{
            $0
        }
        
        
        week = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
            let nowCalendar = Date()
                
             
            let dataCalendar = $0.createdAt
                
             
            let now = Calendar.current.ordinality(of: .weekOfYear, in: .year, for: nowCalendar)!
            let data = Calendar.current.ordinality(of: .weekOfYear, in: .year, for: dataCalendar)!

            if now - data < 7 && dataCalendar.isInThisYear{
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
            
        month = pushDatas.sorted(by: {$0.createdAt < $1.createdAt}).filter{
                let nowCalendar = Date()
                
             
                let dataCalendar = $0.createdAt
                
             
            let now = Calendar.current.ordinality(of: .month, in: .year, for: nowCalendar)!
            let data = Calendar.current.ordinality(of: .month, in: .year, for: dataCalendar)!

            if now - data < 12 && dataCalendar.isInThisYear {//&& dataCalendar.isInThisYear{
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
    

    
    //ToDo : 각 날짜의 달을 받아와서 같은 달이면 값을 더해야해 어떻게 해야할까?

    
    func setChart(dataPoint: [String], values: [Double], name: String){
        

        //데이터 생성
        var lineChartEntries = [ChartDataEntry]()
        
        //selectedValues = selectedValues[0...dataPoint.count]


        for i in 0..<values.count{

            let dataEntry = ChartDataEntry(x: Double(i), y: Double(selectedValues[i]))
        
            lineChartEntries.append(dataEntry)
        }
        
        let chartDataSet = LineChartDataSet(entries: lineChartEntries, label: nil)
        lineChartView.xAxis.forceLabelsEnabled = true
        lineChartView.xAxis.avoidFirstLastClippingEnabled = true
        lineChartView.legend.enabled = false
        
        
        // 선택 안되게
        chartDataSet.highlightEnabled = false
        // 줌 안되게
        lineChartView.doubleTapToZoomEnabled = false
        
        //let TimeColorString = [NSUIColor(cgColor: UIColor(hex: "#d8df4f").cgColor)]
        //dataSet.colors = TimeColorString
        
        let colorLiteral =  #colorLiteral(red: 0.8470588235, green: 0.8745098039, blue: 0.3098039216, alpha: 0.7430436644)
        let circleLiteral =  #colorLiteral(red: 0.9764705882, green: 0.8588235294, blue: 0.7254901961, alpha: 0.7430436644)
       
        //d8df4f
        //216, 223, 79
        //차트색
        chartDataSet.colors = [colorLiteral]
        chartDataSet.circleColors = [circleLiteral]
        chartDataSet.lineWidth = 5.0
        
        
        //데이터 삽입
        let chartData = LineChartData(dataSet: chartDataSet)
        lineChartView.data = chartData
        chartDataSet.label = nil
        lineChartView.xAxis.labelTextColor = UIColor(displayP3Red: 39/255, green: 40/255, blue: 19/255, alpha: 0.74)
        lineChartView.leftAxis.labelTextColor = UIColor(displayP3Red: 39/255, green: 40/255, blue: 19/255, alpha: 0.74)
        let textColor =  #colorLiteral(red: 0.1520237625, green: 0.1570370793, blue: 0.06181135774, alpha: 0.7430436644)
        lineChartView.data?.setValueTextColor(textColor)
        //x축 레이블 위치 수정
        lineChartView.xAxis.labelPosition = .bottom
        //x축 레이블 포맷 지정
        lineChartView.xAxis.valueFormatter = IndexAxisValueFormatter(values: dataPoint)
        lineChartView.rightAxis.enabled = false
        
        lineChartView.xAxis.setLabelCount(dataPoint.count, force: true)
        
        viewWillAppear(true)

        
        
    }
    
    // 일, 주, 월 선택
    @IBAction func showLineChart(_ sender: UIButton) {

        
        let clickColor =  #colorLiteral(red: 0.8470588235, green: 0.8745098039, blue: 0.3098039216, alpha: 0.8118578767)
        let defaultColor =  #colorLiteral(red: 0.5450980392, green: 0.4117647059, blue: 0.4941176471, alpha: 0.7430436644)
        let buttons = [dayButton, weekButton, monthButton]
        buttons.forEach {
            $0?.setTitleColor(($0 == sender) ? clickColor : defaultColor, for: .normal)
            $0?.titleLabel?.font = ($0 == sender) ? UIFont.boldSystemFont(ofSize: 16.0) : UIFont.systemFont(ofSize: 15.0)
        }
        
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
            
            selectedshow = Array(a)
            
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
    // push count, distance, calorie, duration 선택
    @IBAction func selectValue(_ sender: UIButton) {
        
        let clickColor =  #colorLiteral(red: 0.8470588235, green: 0.8745098039, blue: 0.3098039216, alpha: 0.7430436644)
        let defaultColor =  #colorLiteral(red: 0.5450980392, green: 0.4117647059, blue: 0.4941176471, alpha: 0.7430436644)
        let buttons = [pushButton, distanceButton, calButton, durationButton]
        buttons.forEach {
            $0?.setTitleColor(($0 == sender) ? clickColor : defaultColor, for: .normal)
            $0?.titleLabel?.font = ($0 == sender) ? UIFont.boldSystemFont(ofSize: 16.0) : UIFont.systemFont(ofSize: 15.0)
            
        }
        
        if sender.titleLabel?.text == "Push Count"{
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
  
            
        }else if sender.titleLabel?.text == "Distance"{
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
            
        }else if sender.titleLabel?.text == "Calorie"{
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

            
        }else if sender.titleLabel?.text == "Duration"{
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
