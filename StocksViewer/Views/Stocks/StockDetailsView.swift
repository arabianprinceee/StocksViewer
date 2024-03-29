//
//  StockDetailsView.swift
//  StocksViewer
//
//  Created by Анас Бен Мустафа on 3/21/21.
//

import SwiftUI

struct StockDetailsView: View {
    
    @EnvironmentObject var stockData: StocksData
    @ObservedObject var webService = WebService()
    @State var points: [Double] = []
    @State var dayButtonChosen: Bool = true
    @State var weekButtonChosen: Bool = false
    @State var monthButtonChosen: Bool = false
    @State var yearButtonChosen: Bool = false
    @State var stock: Stock
    @State var minValueOfPrice: String = "-"
    @State var averageValueOfPrice: String = "-"
    @State var maxValueOfPrice: String = "-"
    @State var chartColor: Color = Color.red
    @State var news: [News] = []
    @State var companyHasNews: Bool = true
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            
            VStack {
                
                Rectangle()
                    .foregroundColor(Color.white.opacity(0.5))
                    .background(Color.white.opacity(0.5))
                    .frame(width: 125, height: 4, alignment: .center)
                    .cornerRadius(8)
                    .padding()
                
                // Верхняя панель
                HStack {
                    Text("\(stock.symbol ?? "")".uppercased())
                        .foregroundColor(.white)
                        .font(.title)
                        .bold()
                    
                    Text("\(stock.description ?? "")")
                        .foregroundColor(Color.white.opacity(0.5))
                        .font(.subheadline)
                        .lineLimit(1)
                        .padding(.top, 8)
                    
                    Spacer()
                }
                .padding([.leading, .trailing])
                
                Divider()
                    .background(Color.white)
                    .padding([.leading, .trailing])
                    .padding(.top, -4)
                
                if (stockData.isInternetAvailible) {
                    ScrollView {
                        
                        //
                        // Блок кнопок над графиком с временными интервалами
                        //
                        HStack (spacing: 32) {
                            
                            if (dayButtonChosen) {
                                HStack {
                                    Text("1Д")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: 35)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(5)
                            } else {
                                HStack {
                                    Text("1Д")
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    self.weekButtonChosen = false
                                    self.monthButtonChosen = false
                                    self.yearButtonChosen = false
                                    self.dayButtonChosen.toggle()
                                    webService.getChartDataForStock(for: "Day", symbol: stock.symbol!) { res in
                                        self.points = res
                                        minValueOfPrice = NSString(format: "%.2f", points.min() ?? "") as String
                                        maxValueOfPrice = NSString(format: "%.2f", points.max() ?? "") as String
                                        averageValueOfPrice = NSString(format: "%.2f", (((points.max() ?? 0.0) + (points.min() ?? 0.0)) / 2.0)) as String
                                        self.chartColor = (self.points.last ?? 0.0) - (self.points.first ?? 0.0) >= 0.0 ? Color.green : Color.red
                                    }
                                }
                            }
                            
                            if (weekButtonChosen) {
                                HStack {
                                    Text("1Н")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: 35)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(5)
                            } else {
                                HStack {
                                    Text("1Н")
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    self.dayButtonChosen = false
                                    self.monthButtonChosen = false
                                    self.yearButtonChosen = false
                                    self.weekButtonChosen.toggle()
                                    webService.getChartDataForStock(for: "Week", symbol: stock.symbol!) { res in
                                        self.points = res
                                        minValueOfPrice = NSString(format: "%.2f", points.min() ?? "") as String
                                        maxValueOfPrice = NSString(format: "%.2f", points.max() ?? "") as String
                                        averageValueOfPrice = NSString(format: "%.2f", (((points.max() ?? 0.0) + (points.min() ?? 0.0)) / 2.0)) as String
                                        self.chartColor = (self.points.last ?? 0.0) - (self.points.first ?? 0.0) >= 0.0 ? Color.green : Color.red
                                    }
                                }
                            }
                            
                            if (monthButtonChosen) {
                                HStack {
                                    Text("1М")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: 35)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(5)
                            } else {
                                HStack {
                                    Text("1М")
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    self.dayButtonChosen = false
                                    self.weekButtonChosen = false
                                    self.yearButtonChosen = false
                                    self.monthButtonChosen.toggle()
                                    webService.getChartDataForStock(for: "Month", symbol: stock.symbol!) { res in
                                        self.points = res
                                        minValueOfPrice = NSString(format: "%.2f", points.min() ?? "") as String
                                        maxValueOfPrice = NSString(format: "%.2f", points.max() ?? "") as String
                                        averageValueOfPrice = NSString(format: "%.2f", (((points.max() ?? 0.0) + (points.min() ?? 0.0)) / 2.0)) as String
                                        self.chartColor = (self.points.last ?? 0.0) - (self.points.first ?? 0.0) >= 0.0 ? Color.green : Color.red
                                    }
                                }
                            }
                            
                            if (yearButtonChosen) {
                                HStack {
                                    Text("1Г")
                                        .foregroundColor(.white)
                                }
                                .frame(width: 40, height: 35)
                                .background(Color.white.opacity(0.3))
                                .cornerRadius(5)
                            } else {
                                HStack {
                                    Text("1Г")
                                        .foregroundColor(.white)
                                }
                                .onTapGesture {
                                    self.dayButtonChosen = false
                                    self.weekButtonChosen = false
                                    self.monthButtonChosen = false
                                    self.yearButtonChosen.toggle()
                                    webService.getChartDataForStock(for: "Year", symbol: stock.symbol!) { res in
                                        self.points = res
                                        minValueOfPrice = NSString(format: "%.2f", points.min() ?? "") as String
                                        maxValueOfPrice = NSString(format: "%.2f", points.max() ?? "") as String
                                        averageValueOfPrice = NSString(format: "%.2f", (((points.max() ?? 0.0) + (points.min() ?? 0.0)) / 2.0)) as String
                                        self.chartColor = (self.points.last ?? 0.0) - (self.points.first ?? 0.0) >= 0.0 ? Color.green : Color.red
                                    }
                                }
                            }
                            Spacer()
                        }
                        .padding([.leading, .trailing, .top])
                        
                        //
                        // График
                        //
                        VStack (spacing: 32) {
                            HStack {
                                Text("График \("\(stock.symbol ?? "")".uppercased()) за выбранный период")
                                    .foregroundColor(Color.white.opacity(0.6))
                                Spacer()
                            }
                            HStack {
                                
                                VStack (alignment: .trailing) {
                                    Text("\(maxValueOfPrice)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white.opacity(0.6))
                                    Spacer()
                                    Text("\(averageValueOfPrice)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white.opacity(0.6))
                                    Spacer()
                                    Text("\(minValueOfPrice)")
                                        .font(.caption2)
                                        .foregroundColor(Color.white.opacity(0.6))
                                }
                                
                                LightChartView(data: points,
                                               type: .line,
                                               visualType: .filled(color: chartColor, lineWidth: 2),
                                               offset: 0.03,
                                               currentValueLineType: .dash(color: Color.white.opacity(0.5), lineWidth: 1, dash: [2]))
                                    .onAppear() {
                                        webService.getChartDataForStock(for: "Day", symbol: stock.symbol!) { res in
                                            self.points = res
                                            minValueOfPrice = NSString(format: "%.2f", points.min() ?? "") as String
                                            maxValueOfPrice = NSString(format: "%.2f", points.max() ?? "") as String
                                            averageValueOfPrice = NSString(format: "%.2f", (((points.max() ?? 0.0) + (points.min() ?? 0.0)) / 2.0)) as String
                                            self.chartColor = (self.points.last ?? 0.0) - (self.points.first ?? 0.0) >= 0.0 ? Color.green : Color.red
                                        }
                                    }
                            }
                        }
                        .padding()
                        .frame(height: 250)
                        
                        HStack {
                            Text("Основные показатели, \("\(stock.symbol ?? "")".uppercased())")
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                        }
                        .padding([.top, .leading, .trailing])
                        
                        CompanyIndicatorsView(stock: self.stock)
                        
                        HStack {
                            Text("Новости недели, \("\(stock.symbol ?? "")".uppercased())")
                                .foregroundColor(Color.white.opacity(0.6))
                            Spacer()
                        }
                        .padding([.leading, .trailing])
                        
                        if (companyHasNews) {
                            NewsListView(news: news)
                                .onAppear() {
                                    webService.getCompanyNews(symbol: stock.symbol ?? "") { response in
                                        self.news = response
                                        if (self.news.count == 0) {
                                            self.companyHasNews = false
                                        }
                                    }
                                }
                        } else {
                            VStack {
                                Spacer()
                                Text("К сожалению, новости компании \(stock.symbol ?? "-") отсутсвуют.")
                                    .foregroundColor(Color.white.opacity(0.5))
                                    .font(.caption2)
                                Spacer()
                            }
                            .frame(height: 150)
                            .padding()
                        }
                    }
                } else {
                    VStack {
                        Spacer()
                        Text("Детальная информация по \(self.stock.symbol ?? "-") недоступна. Проверьте подключение к интернету и попробуйте снова.")
                            .foregroundColor(Color.white.opacity(0.5))
                            .font(.callout)
                            .multilineTextAlignment(.center)
                        Spacer()
                    }
                    .padding()
                }
                
                Spacer()
            }
        }
    }
}
