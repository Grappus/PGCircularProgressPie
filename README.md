# PGCircularProgressPie
<img width="319" alt="screen shot 2017-11-27 at 9 39 46 am" src="https://user-images.githubusercontent.com/17314499/33250524-0ccae5e8-d357-11e7-8074-4a9ec3543f61.png">

## Usage
Just include PGCircularProgressBar.swift in your project.<br>Download the sample project and there are 4 methods written for each type of <b>ProgressBar</b>.<br>

### Features
1.You can make a pie chart with unlimited number of sections.All you have to do is just use the code below:<br>
``` swift
view_circularPieChart.setType(.centerFilled)
 func setScaleValue(_ s: CGFloat, numberOfPieCharts n: Int, pieChartData p: [PieChart])
 ```
 This method takes 3 parameters:<br>First is the scale factor i.e. the base percentage that will be used to fill up the pie chart.If you want to divide it between numbers 1 to 10 and draw 3 pie charts of value 5,2 and 3, then chart will fill by 50%,30% and 20% respectively.<br>
 2.Check the sample project for the rest of the methods.Its some straightforward stuff that doesn't need much explanation.
 
