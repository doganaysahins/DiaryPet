//
//  CustomDatePicker.swift
//  CustomDatePickerDemo
//
//  Created by Thongchai Subsaidee on 29/9/21.
//

import SwiftUI


struct CustomDatePicker: View {
    
    @Binding var currentDate: Date
    @State var  currentMonth: Int = 0
    @State var selectedDate : Date = Date()
    @State var show = false
    @State var reminder = false
    @State var titleText = ""
    @State var doneButton : Bool = false
    @State var titleEvent = ""
    @State var descEvent = ""
    @State var selector = ""
    @State var selectedPet = UIImage()
    @State var isImageSelected = false
    
    @StateObject private var scViewModel = PetScheduledViewModel()
    @StateObject private var infoListVM = PetInformationViewModel()
    @Environment(\.defaultMinListRowHeight) var minRowHeight

    
    func deleteTodo(at offsets: IndexSet, data : [ScheduleInfo]) {
        offsets.forEach { index in
            let task = data[index]
            scViewModel.delete(task)
            
        }
        scViewModel.getEventsAll()
    }
    
//    func deleteTodos(at offsets: IndexSet, todoTasks : TodoInfo){
//        var lists = todoTasks.filter { task in
//            return isSameDay(date1: task.date, date2: currentDate)
//        }
//
//
//    }
    
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            
        
        VStack(spacing: 25) {
            
            var infos : [ScheduleInfo] = scViewModel.scheduledEvents.filter { task in
                return isSameDay(date1: task.scheduleDate, date2: currentDate)
            }
            
            
            // Days
            let days = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
            
            HStack(spacing: 20) {
                
                VStack(alignment: .leading, spacing: 10) {
                    Text(extraDate()[0])
                        .font(.caption)
                        .fontWeight(.semibold)
                    Text(extraDate()[1])
                        .font(.title.bold())
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        currentMonth -= 1
                    }
                } label: {
                    Image(systemName: "chevron.left")
                        .font(.title2 )
                }
                
                Button {
                    withAnimation {
                        currentMonth += 1
                    }
                } label: {
                    Image(systemName: "chevron.right")
                        .font(.title2)
                }

                
            }
            .padding(.horizontal)
            
            // Day View...
            HStack(spacing: 0) {
                ForEach(days, id: \.self) { day in
                        Text(day)
                        .font(.callout)
                        .fontWeight(.semibold)
                        .frame(maxWidth: .infinity)
                }
            }
            
            
            //Date
            // Lazy Grid..
            let columns = Array(repeating: GridItem(.flexible()), count: 7)
            
            LazyVGrid(columns: columns, spacing: 15) {
                ForEach(extractDate()) { value in
                  CardView(value: value)
                        .background(
                            Capsule()
                                .fill(Color("Purple"))
                                .padding(.horizontal, 8)
                                .opacity(isSameDay(date1: value.date, date2: currentDate) ? 1 : 0)
                        )
                        .onTapGesture {
                            currentDate = value.date
                            
                        }
                }
            }


            
            VStack(spacing: 15) {

                HStack{
                    
                    Text("Tasks")
                        .font(.title2.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.vertical , 20)
    //
                    
                    
                    Button {
                        self.show = true
                    } label: {
                        Image(systemName: "plus").foregroundColor(Color("Purple"))
                            
                    }
                }

                
               
//                if let tasks = infoListVM.tasks.filter({ task in
//
//                    return isSameDay(date1: task.date, date2: currentDate)
//                }) {
               
                    
              
                    List{
                        ForEach(infos, id : \.id) { allEvents in
                            
                           
                            
                            
                                ScheduleCardView(scheduleTitle: allEvents.scheduleTitle, scheduleDesc: allEvents.scheduleDesc, scheduleDate: allEvents.scheduleDate.formatted(date: .abbreviated, time: .omitted), selectedImage: selectedPet)
                            
//                                .background(
//
//
//
//                                        .opacity(0.5)
//                                        .cornerRadius(10)
//
//                                        .frame(maxWidth: .infinity)
//
//                                )
                            
                        }
                       
                        
                            
                        
                   
                        
                            
                            .onDelete { (indexSet) in

                                    self.deleteTodo(at: indexSet, data: infos)

                            }
                            
                            .listRowSeparator(.hidden)
   
                            
                            
                        
                    
  
                            
                    }.frame(minWidth: minRowHeight * 2
                        ,minHeight: minRowHeight * 8)
                        .listStyle(.plain)
                        


//                        .swipeActions(edge: .trailing , allowsFullSwipe: true) {
//                            Button {
//                                print("swiped")
//                            } label: {
//                                Image(systemName: "bell")
//                            }
//                            .tint(.yellow)
//
//
//
//                            Button {
//                                print("edited")
//                            } label: {
//                                Image(systemName: "square.and.pencil")
//                            }
//                            .tint(.blue)
//
//                            Button {
//
//
//                            } label: {
//                                Image(systemName: "trash.fill")
//                            }
//
//                            .tint(.red)
//
//                        }
                        
                        
            
                     

            }
            .padding()

            
        }
        }
        .onAppear(perform: {
            scViewModel.getEventsAll()
        })
        .sheet(isPresented: $show, content: {

            
            sheetBody


            
            
            
        })
        .onChange(of: currentMonth) { newValue in
            // update month
            currentDate = getCurrentMonth()
        }
    }
    
    @ViewBuilder
    func CardView(value: DateValue) -> some View {

        VStack {
            
            if value.day != -1 {
                
                if let task = scViewModel.scheduledEvents.first(where: { task in
                    return isSameDay(date1: task.scheduleDate, date2: value.date)
                }) {

                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: task.scheduleDate, date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)

                    Spacer()

                    Circle()
                        .fill(isSameDay(date1: task.scheduleDate, date2: currentDate) ? .white : Color("Pink") )
                        .frame(width: 8, height: 8)

                }else {
                    Text("\(value.day)")
                        .font(.title3.bold())
                        .foregroundColor(isSameDay(date1: value.date , date2: currentDate) ? .white : .primary)
                        .frame(maxWidth: .infinity)

                    Spacer()
                }

                
            }
        }
        .padding(.vertical, 9)
        .frame(height: 60, alignment: .top)
            
    }
    // Checking dates
    func isSameDay(date1: Date, date2: Date) -> Bool {

        
        return Calendar.current.isDate(date1, inSameDayAs: date2)
        
    }
    
    func convertToDateComp(selectedDate : Date) -> String{
        
        let cal = Calendar.current
        let datec = cal.dateComponents([.year,.month,.weekday,.day,.hour,.minute], from: selectedDate)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy 'at' HH:mm"
        
        return formatter.string(from: Calendar(identifier: .gregorian).date(from: datec)!)
        
        
    }
    
    
    // Extraing year and month for display
    func extraDate() -> [String] {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY MMMM"
        
        let date = formatter.string(from: currentDate)
         
        return date.components(separatedBy: " ")
    }
    
    func getCurrentMonth() -> Date {
        let calendar = Calendar.current
        
        // Getting Current month date
        guard let currentMonth = calendar.date(byAdding: .month, value: self.currentMonth, to: Date()) else {
            return Date()
        }
        
        return currentMonth
    }
    
    
    func extractDate() -> [DateValue] {
        
        let calendar = Calendar.current
        
        // Getting Current month date
        let currentMonth = getCurrentMonth()
        
        var days = currentMonth.getAllDates().compactMap { date -> DateValue in
            let day = calendar.component(.day, from: date)
            let dateValue =  DateValue(day: day, date: date)
            return dateValue
        }
        
        // adding offset days to get exact week day...
        let firstWeekday = calendar.component(.weekday, from: days.first?.date ?? Date())
        
        for _ in 0..<firstWeekday - 1 {
            days.insert(DateValue(day: -1, date: Date()), at: 0)
        }
        
        return days
    }
    
    var sheetBody : some View{
        return NavigationView{
            Form{
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
         
                        ForEach(infoListVM.tasks, id : \.id){petImages in
                            Image(uiImage: petImages.imagePet ?? UIImage())
                                .resizable()
                                .scaledToFill()
                                .clipShape(Circle())
                                
                                .frame(width: 100, height: 100, alignment: .center)
                                
                                .gesture(TapGesture().onEnded({ () in
                                    self.isImageSelected.toggle()
                                    self.selector = petImages.petID
                                    self.selectedPet = petImages.imagePet ?? UIImage()
                                    
                                }))
                                .overlay(
                                    VStack{
                                        Spacer()
                                        HStack{
                                            
                                        Spacer()
                                        Image(systemName: selector == petImages.petID ? "checkmark.circle.fill" : "")
                                            .foregroundColor(.green)
                                            .font(.largeTitle)
                                            
                                        }

                                    }
                                        
                                )
                                
                        }
                    
                    }
                      
                }
                
                
                Section("Title"){
                    TextField("Title", text: $titleEvent)
                }
                Section("Description"){
                    TextEditor(text: $descEvent)
                }
      
                Section("Time"){
                    DatePicker("Time", selection: $currentDate, displayedComponents: .hourAndMinute)
                        
                }
                
                Section("Remind Me"){
//                    Toggle("Remind Me", isOn: $infoListVM.reminder)
                }
                

                

                
                
                
                
                
                Button {
                    print("added")
                    print(selector)
                    let cl = Calendar.current
                    let dc = cl.dateComponents([.year,.month,.day,.weekday,.hour,.minute], from: currentDate)
                    
                    print(dc.year)
                    print(dc.month)
                    print(dc.day)
                    print(dc.weekday)
                    print(dc.hour)
                    print(dc.minute)

                    
                    print(convertToDateComp(selectedDate: currentDate))
                    
                    scViewModel.saveEvent(petID: selector, title: titleEvent, desc: descEvent, date: currentDate, reminder: reminder)
                  
                    scViewModel.getEventsAll()
                    self.show = false
                    

                    
                }
            
            
                label: {
                    Text("Add")
                }
                
                
            }.navigationBarTitle(Text(convertToDateComp(selectedDate:currentDate)), displayMode: .inline)
               
        
            
            
        
        }.onAppear {
            infoListVM.getAllTasks()
        }
        
      
            
       
       
        
    }
    
}

struct CustomDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension Date {
    
    func getAllDates() -> [Date] {
        
        let calendar = Calendar.current
        
        // geting start date
        let startDate = calendar.date(from: Calendar.current.dateComponents([.year, .month], from: self))!
        
        let range = calendar.range(of: .day, in: .month, for: startDate)
        
        
        // getting date...
        return range!.compactMap{ day -> Date in
            return calendar.date(byAdding: .day, value: day - 1 , to: startDate)!
        }
        
    }
    
    

    
    
}

