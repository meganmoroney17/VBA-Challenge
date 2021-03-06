VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
END
Attribute VB_Name = "Sheet1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = True
Sub VBAChallenge()

Dim ticker As String
Dim tickernumber As Integer
Dim year_open As Double
Dim year_close As Double
Dim yearly_change As Double
Dim percent_change As Double
Dim total_stock_volume As Double
Dim greatpctincrease As Double
Dim greatpctincrease_ticker As String
Dim greatpctdecrease As Double
Dim greatpctdecrease_ticker As String
Dim greatest_stock_volume As Double
Dim greatest_stock_volume_ticker As String


For Each ws In Worksheets
    lastrow = ws.Cells(Rows.Count, "A").End(xlUp).Row

    ws.Range("I1").Value = "Ticker"
    ws.Range("J1").Value = "Yearly Change"
    ws.Range("K1").Value = "Percent Change"
    ws.Range("L1").Value = "Total Stock Volume"

    tickernumber = 0
    ticker = ""
    yearly_change = 0
    year_open = 0
    percent_change = 0
    total_stock_volume = 0
    
    For i = 2 To lastrow
    
        ticker = Cells(i, 1).Value
        
        If year_open = 0 Then
            year_open = Cells(i, 3).Value
        End If
        
        total_stock_volume = total_stock_volume + Cells(i, 7).Value
        
        If Cells(i + 1, 1).Value <> ticker Then
            tickernumber = tickernumber + 1
            Cells(tickernumber + 1, 9) = ticker
            
            year_close = Cells(i, 6)
            
            yearly_change = year_close - year_open
            
            Cells(tickernumber + 1, 10).Value = yearly_change
            
            If yearly_change > 0 Then
                Cells(tickernumber + 1, 10).Interior.ColorIndex = 4
            ElseIf yearly_change < 0 Then
                Cells(tickernumber + 1, 10).Interior.ColorIndex = 3
            Else
                Cells(tickernumber + 1, 10).Interior.ColorIndex = 6
            End If
            
            
            If year_open = 0 Then
                percent_change = 0
            Else
                percent_change = (yearly_change / year_open)
            End If
            
            Cells(tickernumber + 1, 11).Value = Format(percent_change, "Percent")
            
            
            year_open = 0
            Cells(tickernumber + 1, 12).Value = total_stock_volume
            total_stock_volume = 0
        End If
        
    Next i
    
'Challenge Section
    Range("O2").Value = "Greatest % Increase"
    Range("O3").Value = "Greatest % Decrease"
    Range("O4").Value = "Greatest Total Volume"
    Range("P1").Value = "Ticker"
    Range("Q1").Value = "Value"
    
    lastrow = ws.Cells(Rows.Count, "I").End(xlUp).Row
    
    greatpctincrease = Cells(2, 11).Value
    greatpctincrease_ticker = Cells(2, 9).Value
    greatpctdecrease = Cells(2, 11).Value
    greatpctdecrease_ticker = Cells(2, 9).Value
    greatest_stock_volume = Cells(2, 12).Value
    greatest_stock_volume_ticker = Cells(2, 9).Value
    
    For i = 2 To lastrow
    
        If Cells(i, 11).Value > greatpctincrease Then
            greatpctincrease = Cells(i, 11).Value
            greatpctincrease_ticker = Cells(i, 9).Value
        End If
    
        If Cells(i, 11).Value < greatpctdecrease Then
            greatpctdecrease = Cells(i, 11).Value
            greatpctdecrease_ticker = Cells(i, 9).Value
        End If
        
        If Cells(i, 12).Value > greatest_stock_volume Then
            greatest_stock_volume = Cells(i, 12).Value
            greatest_stock_volume_ticker = Cells(i, 9).Value
        End If
        
    Next i
    
    Range("P2").Value = Format(greatpctincrease_ticker, "Percent")
    Range("Q2").Value = Format(greatpctincrease, "Percent")
    Range("P3").Value = Format(greatpctdecrease_ticker, "Percent")
    Range("Q3").Value = Format(greatpctdecrease, "Percent")
    Range("P4").Value = greatest_stock_volume_ticker
    Range("Q4").Value = greatest_stock_volume
    
Next ws


End Sub
