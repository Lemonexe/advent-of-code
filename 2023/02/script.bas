Public Sub solve()
    Rmax = 12: Gmax = 13: Bmax = 14
    colMax = 10

    Dim wb As Workbook
    Set wb = Workbooks("solution.xlsm")
    Dim wsr As Worksheet
    Set wsr = wb.Worksheets("res1")
    Dim ws As Worksheet
    'Set ws = wb.Worksheets("training"): n = 5
    Set ws = wb.Worksheets("solution"): n = 100
    
    sum = 0

    wsr.Cells(1, 1).Value = "indices that are ok"
    
    For i = 1 To n
        idx = CInt(Mid(ws.Cells(i, 1), 6))
        isOk = True
        For j = 2 To colMax
            game = ws.Cells(i, j).Value
            cubes = Split(game, ", ")
            For k = 0 To ArrayLen(cubes) - 1
                aux = Split(cubes(k), " ")
                num = CInt(aux(0))
                clr = aux(1)
                If clr = "red" And num > Rmax Then
                    isOk = False
                ElseIf clr = "green" And num > Gmax Then
                    isOk = False
                ElseIf clr = "blue" And num > Bmax Then
                    isOk = False
                End If
            Next k
        Next j
        If isOk Then
            wsr.Cells(i + 1, 1).Value = idx
            sum = sum + idx
        End If
    Next i
    MsgBox sum
End Sub

Public Sub solve2()
    colMax = 10

    Dim wb As Workbook
    Set wb = Workbooks("solution.xlsm")
    Dim wsr As Worksheet
    Set wsr = wb.Worksheets("res2")
    Dim ws As Worksheet
    ' Set ws = wb.Worksheets("training"): n = 5
    Set ws = wb.Worksheets("solution"): n = 100
    
    sum = 0

    wsr.Range("A1:D1") = Array("max red", "max green", "max blue", "prod")
    
    For i = 1 To n
        idx = CInt(Mid(ws.Cells(i, 1), 6))
        maxR = 0
        maxG = 0
        maxB = 0
        For j = 2 To colMax
            game = ws.Cells(i, j).Value
            cubes = Split(game, ", ")
            For k = 0 To ArrayLen(cubes) - 1
                aux = Split(cubes(k), " ")
                num = CInt(aux(0))
                clr = aux(1)
                If clr = "red" And num > maxR Then
                    maxR = num
                ElseIf clr = "green" And num > maxG Then
                    maxG = num
                ElseIf clr = "blue" And num > maxB Then
                    maxB = num
                End If
            Next k
        Next j
        prod = maxR * maxG * maxB
        sum = sum + prod
        wsr.Cells(i + 1, 1).Value = maxR
        wsr.Cells(i + 1, 2).Value = maxG
        wsr.Cells(i + 1, 3).Value = maxB
        wsr.Cells(i + 1, 4).Value = prod
    Next i
    MsgBox sum
End Sub

Public Function ArrayLen(arr As Variant) As Integer
    ArrayLen = UBound(arr, 1) - LBound(arr, 1) + 1
End Function
