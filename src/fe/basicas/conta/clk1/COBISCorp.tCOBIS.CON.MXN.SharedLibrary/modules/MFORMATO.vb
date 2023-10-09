Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MFORMATO
    Function FMConvFecha(ByRef fecha As String, ByRef FormatoA As String, ByRef FormatoB As String) As String
        Dim VT As Integer = 0
        Dim Formato As String = ""
        Dim VTm As String = String.Empty
        Dim VTa As String = String.Empty
        Dim VTd As String = String.Empty
        Dim VTFecha As String = ""
        VT = FMVerFormato(fecha, FormatoA)
        If Not VT Then
            Return ""
        End If
        Dim Vtp1 As Integer = (fecha.IndexOf("/"c) + 1)
        If Vtp1 = 0 Then
            Return ""
        End If
        Dim VTp2 As Integer = Strings.InStr(Vtp1 + 1, fecha, "/")
        If VTp2 = 0 Then
            Return ""
        End If
        Select Case FormatoA
            Case "mm/dd/yy"
                VTm = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTd = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "mm/dd/yyyy"
                VTm = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTd = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case "dd/mm/yy"
                VTd = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "dd/mm/yyyy"
                VTd = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case "yy/mm/dd"
                VTa = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTd = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "yyyy/mm/dd"
                VTa = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTd = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case Else
                COBISMessageBox.Show("Formato Origen: " & Formato & " no soportado", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Return ""
        End Select
        Select Case FormatoB
            Case "mm/dd/yy"
                If VTa.Length = 4 Then
                    VTa = Strings.Mid(VTa, 3, 2)
                End If
                VTFecha = VTm & "/" & VTd & "/" & VTa
            Case "mm/dd/yyyy"
                If VTa.Length = 2 Then
                    VTa = "19" & VTa
                End If
                VTFecha = VTm & "/" & VTd & "/" & VTa
            Case "dd/mm/yy"
                If VTa.Length = 4 Then
                    VTa = Strings.Mid(VTa, 3, 2)
                End If
                VTFecha = VTd & "/" & VTm & "/" & VTa
            Case "dd/mm/yyyy"
                If VTa.Length = 2 Then
                    VTa = "19" & VTa
                End If
                VTFecha = VTd & "/" & VTm & "/" & VTa
            Case "yy/mm/dd"
                If VTa.Length = 4 Then
                    VTa = Strings.Mid(VTa, 3, 2)
                End If
                VTFecha = VTa & "/" & VTm & "/" & VTd
            Case "yyyy/mm/dd"
                If VTa.Length = 2 Then
                    VTa = "19" & VTa
                End If
                VTFecha = VTa & "/" & VTm & "/" & VTd
            Case Else
                COBISMessageBox.Show("Formato Destino: " & Formato & " no soportado", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Return ""
        End Select
        Return VTFecha
    End Function

    Function FMDateDiff(ByRef Intervalo As String, ByRef Fecha1 As String, ByRef Fecha2 As String, ByRef Formato As String) As Integer
        Dim result As Integer = 0
        Dim VTbis As Integer = 0
        Dim VT As Integer = 0
        Dim VTd1 As String = String.Empty
        Dim VTm1 As String = String.Empty
        Dim VTa1 As String = String.Empty
        Dim VTd2 As String = String.Empty
        Dim VTm2 As String = String.Empty
        Dim VTa2 As String = String.Empty
        Dim VTdd As Integer = 0
        Dim VTmm As Integer = 0
        VT = FMVerFormato(Fecha1, Formato)
        If Not VT Then
            Return 0
        End If
        VT = FMVerFormato(Fecha2, Formato)
        If Not VT Then
            Return 0
        End If
        Dim VTp11 As Integer = (Fecha1.IndexOf("/"c) + 1)
        If VTp11 = 0 Then
            Return 0
        End If
        Dim VTp12 As Integer = Strings.InStr(VTp11 + 1, Fecha1, "/")
        If VTp12 = 0 Then
            Return 0
        End If
        Dim VTp21 As Integer = (Fecha2.IndexOf("/"c) + 1)
        If VTp21 = 0 Then
            Return 0
        End If
        Dim VTp22 As Integer = Strings.InStr(VTp21 + 1, Fecha2, "/")
        If VTp22 = 0 Then
            Return 0
        End If
        Select Case Formato
            Case "mm/dd/yy"
                VTm1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTd1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTa1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTa1 = "19" & VTa1
                VTm2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTd2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTa2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
                VTa2 = "19" & VTa2
            Case "mm/dd/yyyy"
                VTm1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTd1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTa1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTm2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTd2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTa2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
            Case "dd/mm/yy"
                VTd1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTm1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTa1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTa1 = "19" & VTa1
                VTd2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTm2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTa2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
                VTa2 = "19" & VTa2
            Case "dd/mm/yyyy"
                VTd1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTm1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTa1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTd2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTm2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTa2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
            Case "yy/mm/dd"
                VTa1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTm1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTd1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTa1 = "19" & VTa1
                VTa2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTm2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTd2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
                VTa2 = "19" & VTa2
            Case "yyyy/mm/dd"
                VTa1 = Strings.Mid(Fecha1, 1, VTp11 - 1)
                VTm1 = Strings.Mid(Fecha1, VTp11 + 1, VTp12 - VTp11 - 1)
                VTd1 = Strings.Mid(Fecha1, VTp12 + 1, Fecha1.Length)
                VTa2 = Strings.Mid(Fecha2, 1, VTp21 - 1)
                VTm2 = Strings.Mid(Fecha2, VTp21 + 1, VTp22 - VTp21 - 1)
                VTd2 = Strings.Mid(Fecha2, VTp22 + 1, Fecha2.Length)
            Case Else
                COBISMessageBox.Show("Formato de Fecha " & Formato & " no soportado", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Return 0
        End Select
        Select Case Intervalo
            Case "y"
                If Conversion.Val(VTa1) < Conversion.Val(VTa2) Then
                    If Conversion.Val(VTm1) < Conversion.Val(VTm2) Then
                        result = CInt(Conversion.Val(VTa2) - Conversion.Val(VTa1))
                    Else
                        If Conversion.Val(VTm1) > Conversion.Val(VTm2) Then
                            result = CInt(Conversion.Val(VTa2) - Conversion.Val(VTa1) - 1)
                        Else
                            If Conversion.Val(VTd1) <= Conversion.Val(VTd2) Then
                                result = CInt(Conversion.Val(VTa2) - Conversion.Val(VTa1))
                            Else
                                result = CInt(Conversion.Val(VTa2) - Conversion.Val(VTa1) - 1)
                            End If
                        End If
                    End If
                Else
                    If Conversion.Val(VTa1) > Conversion.Val(VTa2) Then
                        If Conversion.Val(VTm2) < Conversion.Val(VTm1) Then
                            result = CInt(-(Conversion.Val(VTa1) - Conversion.Val(VTa2)))
                        Else
                            If Conversion.Val(VTm2) > Conversion.Val(VTm1) Then
                                result = CInt(-(Conversion.Val(VTa1) - Conversion.Val(VTa2) - 1))
                            Else
                                If Conversion.Val(VTd2) <= Conversion.Val(VTd1) Then
                                    result = CInt(-(Conversion.Val(VTa1) - Conversion.Val(VTa2)))
                                Else
                                    result = CInt(-(Conversion.Val(VTa1) - Conversion.Val(VTa2) - 1))
                                End If
                            End If
                        End If
                    Else
                        result = 0
                    End If
                End If
            Case "m"
                If Conversion.Val(VTa1) < Conversion.Val(VTa2) Then
                    VTmm = CInt((Conversion.Val(VTa2) - Conversion.Val(VTa1) - 1) * 12)
                    VTmm = CInt(VTmm + (12 - Conversion.Val(VTm1)))
                    VTmm = CInt(VTmm + (Conversion.Val(VTm2) - 1))
                    If Conversion.Val(VTd1) <= Conversion.Val(VTd2) Then
                        VTmm += 1
                    End If
                    result = VTmm
                Else
                    If Conversion.Val(VTa1) > Conversion.Val(VTa2) Then
                        VTmm = CInt((Conversion.Val(VTa1) - Conversion.Val(VTa2) - 1) * 12)
                        VTmm = CInt(VTmm + (12 - Conversion.Val(VTm2)))
                        VTmm = CInt(VTmm + (Conversion.Val(VTm1) - 1))
                        If Conversion.Val(VTd2) <= Conversion.Val(VTd1) Then
                            VTmm += 1
                        End If
                        result = -VTmm
                    Else
                        If Conversion.Val(VTm1) < Conversion.Val(VTm2) Then
                            VTmm = CInt(Conversion.Val(VTm2) - Conversion.Val(VTm1) - 1)
                            If Conversion.Val(VTd1) <= Conversion.Val(VTd2) Then
                                VTmm += 1
                            End If
                            result = VTmm
                        Else
                            If Conversion.Val(VTm1) > Conversion.Val(VTm2) Then
                                VTmm = CInt(Conversion.Val(VTm1) - Conversion.Val(VTm2) - 1)
                                If Conversion.Val(VTd2) <= Conversion.Val(VTd1) Then
                                    VTmm += 1
                                End If
                                result = -VTmm
                            Else
                                result = 0
                            End If
                        End If
                    End If
                End If
            Case "d"
                VTdd = 0
                If Conversion.Val(VTa1) < Conversion.Val(VTa2) Then
                    For i As Integer = (Conversion.Val(VTa1) + 1) To (Conversion.Val(VTa2) - 1)
                        If (i Mod 4) = 0 Then
                            If (i Mod 100 = 0) And (i Mod 400 <> 0) Then
                                VTdd += 365
                            Else
                                VTdd += 366
                            End If
                        Else
                            VTdd += 365
                        End If
                    Next i
                    If (Conversion.Val(VTa1) Mod 4) = 0 Then
                        VTbis = Not ((Conversion.Val(VTa1) Mod 100 = 0) And (Conversion.Val(VTa1) Mod 400 <> 0))
                    Else
                        VTbis = False
                    End If
                    Select Case Conversion.Val(VTm1)
                        Case 1, 3, 5, 7, 8, 10, 12
                            VTdd = CInt(VTdd + (31 - Conversion.Val(VTd1)))
                        Case 4, 6, 9, 11
                            VTdd = CInt(VTdd + (30 - Conversion.Val(VTd1)))
                        Case 2
                            If VTbis Then
                                VTdd = CInt(VTdd + (29 - Conversion.Val(VTd1)))
                            Else
                                VTdd = CInt(VTdd + (28 - Conversion.Val(VTd1)))
                            End If
                    End Select
                    For i As Integer = Conversion.Val(VTm1) + 1 To 12
                        Select Case i
                            Case 1, 3, 5, 7, 8, 10, 12
                                VTdd += 31
                            Case 4, 6, 9, 11
                                VTdd += 30
                            Case 2
                                If VTbis Then
                                    VTdd += 29
                                Else
                                    VTdd += 28
                                End If
                        End Select
                    Next i
                    If (Conversion.Val(VTa2) Mod 4) = 0 Then
                        VTbis = Not ((Conversion.Val(VTa2) Mod 100 = 0) And (Conversion.Val(VTa2) Mod 400 <> 0))
                    Else
                        VTbis = False
                    End If
                    VTdd = CInt(VTdd + Conversion.Val(VTd2))
                    For i As Integer = 1 To Conversion.Val(VTm2) - 1
                        Select Case i
                            Case 1, 3, 5, 7, 8, 10, 12
                                VTdd += 31
                            Case 4, 6, 9, 11
                                VTdd += 30
                            Case 2
                                If VTbis Then
                                    VTdd += 29
                                Else
                                    VTdd += 28
                                End If
                        End Select
                    Next i
                    result = VTdd
                Else
                    If Conversion.Val(VTa1) > Conversion.Val(VTa2) Then
                        For i As Integer = (Conversion.Val(VTa2) + 1) To (Conversion.Val(VTa1) - 1)
                            If (i Mod 4) = 0 Then
                                If (i Mod 100 = 0) And (i Mod 400 <> 0) Then
                                    VTdd += 365
                                Else
                                    VTdd += 366
                                End If
                            Else
                                VTdd += 365
                            End If
                        Next i
                        If (Conversion.Val(VTa2) Mod 4) = 0 Then
                            VTbis = Not ((Conversion.Val(VTa2) Mod 100 = 0) And (Conversion.Val(VTa2) Mod 400 <> 0))
                        Else
                            VTbis = False
                        End If
                        Select Case Conversion.Val(VTm2)
                            Case 1, 3, 5, 7, 8, 10, 12
                                VTdd = CInt(VTdd + (31 - Conversion.Val(VTd2)))
                            Case 4, 6, 9, 11
                                VTdd = CInt(VTdd + (30 - Conversion.Val(VTd2)))
                            Case 2
                                If VTbis Then
                                    VTdd = CInt(VTdd + (29 - Conversion.Val(VTd2)))
                                Else
                                    VTdd = CInt(VTdd + (28 - Conversion.Val(VTd2)))
                                End If
                        End Select
                        For i As Integer = Conversion.Val(VTm2) + 1 To 12
                            Select Case i
                                Case 1, 3, 5, 7, 8, 10, 12
                                    VTdd += 31
                                Case 4, 6, 9, 11
                                    VTdd += 30
                                Case 2
                                    If VTbis Then
                                        VTdd += 29
                                    Else
                                        VTdd += 28
                                    End If
                            End Select
                        Next i
                        If (Conversion.Val(VTa1) Mod 4) = 0 Then
                            VTbis = Not ((Conversion.Val(VTa1) Mod 100 = 0) And (Conversion.Val(VTa1) Mod 400 <> 0))
                        Else
                            VTbis = False
                        End If
                        VTdd = CInt(VTdd + Conversion.Val(VTd1))
                        For i As Integer = 1 To Conversion.Val(VTm1) - 1
                            Select Case i
                                Case 1, 3, 5, 7, 8, 10, 12
                                    VTdd += 31
                                Case 4, 6, 9, 11
                                    VTdd += 30
                                Case 2
                                    If VTbis Then
                                        VTdd += 29
                                    Else
                                        VTdd += 28
                                    End If
                            End Select
                        Next i
                        result = -VTdd
                    Else
                        If (Conversion.Val(VTa1) Mod 4) = 0 Then
                            VTbis = Not ((Conversion.Val(VTa1) Mod 100 = 0) And (Conversion.Val(VTa1) Mod 400 <> 0))
                        Else
                            VTbis = False
                        End If
                        If Conversion.Val(VTm1) < Conversion.Val(VTm2) Then
                            Select Case Conversion.Val(VTm1)
                                Case 1, 3, 5, 7, 8, 10, 12
                                    VTdd = CInt(VTdd + (31 - Conversion.Val(VTd1)))
                                Case 4, 6, 9, 11
                                    VTdd = CInt(VTdd + (30 - Conversion.Val(VTd1)))
                                Case 2
                                    If VTbis Then
                                        VTdd = CInt(VTdd + (29 - Conversion.Val(VTd1)))
                                    Else
                                        VTdd = CInt(VTdd + (28 - Conversion.Val(VTd1)))
                                    End If
                            End Select
                            For i As Integer = Conversion.Val(VTm1) + 1 To Conversion.Val(VTm2) - 1
                                Select Case i
                                    Case 1, 3, 5, 7, 8, 10, 12
                                        VTdd += 31
                                    Case 4, 6, 9, 11
                                        VTdd += 30
                                    Case 2
                                        If VTbis Then
                                            VTdd += 29
                                        Else
                                            VTdd += 28
                                        End If
                                End Select
                            Next i
                            VTdd = CInt(VTdd + Conversion.Val(VTd2))
                            result = VTdd
                        Else
                            If Conversion.Val(VTm1) > Conversion.Val(VTm2) Then
                                Select Case Conversion.Val(VTm2)
                                    Case 1, 3, 5, 7, 8, 10, 12
                                        VTdd = CInt(VTdd + (31 - Conversion.Val(VTd2)))
                                    Case 4, 6, 9, 11
                                        VTdd = CInt(VTdd + (30 - Conversion.Val(VTd2)))
                                    Case 2
                                        If VTbis Then
                                            VTdd = CInt(VTdd + (29 - Conversion.Val(VTd2)))
                                        Else
                                            VTdd = CInt(VTdd + (28 - Conversion.Val(VTd2)))
                                        End If
                                End Select
                                For i As Integer = Conversion.Val(VTm2) + 1 To Conversion.Val(VTm1) - 1
                                    Select Case i
                                        Case 1, 3, 5, 7, 8, 10, 12
                                            VTdd += 31
                                        Case 4, 6, 9, 11
                                            VTdd += 30
                                        Case 2
                                            If VTbis Then
                                                VTdd += 29
                                            Else
                                                VTdd += 28
                                            End If
                                    End Select
                                Next i
                                VTdd = CInt(VTdd + Conversion.Val(VTd1))
                                result = -VTdd
                            Else
                                VTdd = CInt(Conversion.Val(VTd2) - Conversion.Val(VTd1))
                                result = VTdd
                            End If
                        End If
                    End If
                End If
        End Select
        Return result
    End Function

    Function FMMascaraFecha(ByRef Formato As String) As String
        Select Case Formato
            Case "yy/mm/dd", "mm/dd/yy", "dd/mm/yy"
                Return "##/##/##"
            Case "mm/dd/yyyy", "dd/mm/yyyy"
                Return "##/##/####"
            Case "yyyy/mm/dd"
                Return "####/##/##"
            Case Else
                Return ""
        End Select
    End Function

    Function FMVerFormato(ByRef fecha As String, ByRef Formato As String) As Integer
        Dim VTd As String = String.Empty
        Dim VTm As String = String.Empty
        Dim VTa As String = String.Empty
        Dim Vtp1 As Integer

        If fecha <> Nothing And fecha <> "" Then
            Vtp1 = (fecha.IndexOf("/"c) + 1)
        End If

        If Vtp1 = 0 Then
            Return False
        End If
        Dim VTp2 As Integer = Strings.InStr(Vtp1 + 1, fecha, "/")
        If VTp2 = 0 Then
            Return False
        End If
        Select Case Formato
            Case "mm/dd/yy"
                VTm = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTd = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "mm/dd/yyyy"
                VTm = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTd = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case "dd/mm/yy"
                VTd = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "dd/mm/yyyy"
                VTd = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTa = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case "yy/mm/dd"
                VTa = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTd = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
                VTa = "19" & VTa
            Case "yyyy/mm/dd"
                VTa = Strings.Mid(fecha, 1, Vtp1 - 1)
                VTm = Strings.Mid(fecha, Vtp1 + 1, VTp2 - Vtp1 - 1)
                VTd = Strings.Mid(fecha, VTp2 + 1, fecha.Length)
            Case Else
                COBISMessageBox.Show("Formato de Fecha " & Formato & " no soportado", "Control Ingreso de Datos", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Return False
        End Select
        If Conversion.Val(VTa) < 1753 Or Conversion.Val(VTa) > 9999 Then
            Return False
        End If
        If Conversion.Val(VTm) < 1 Or Conversion.Val(VTm) > 12 Then
            Return False
        End If
        If Conversion.Val(VTd) < 1 Then
            Return False
        End If
        Select Case Conversion.Val(VTm)
            Case 1, 3, 5, 7, 8, 10, 12
                If Conversion.Val(VTd) > 31 Then
                    Return False
                End If
            Case 4, 6, 9, 11
                If Conversion.Val(VTd) > 30 Then
                    Return False
                End If
            Case 2
                If (Conversion.Val(VTa) Mod 4) = 0 Then
                    If ((Conversion.Val(VTa) Mod 100) = 0) And ((Conversion.Val(VTa) Mod 400) <> 0) Then
                        If Conversion.Val(VTd) > 28 Then
                            Return False
                        End If
                    Else
                        If Conversion.Val(VTd) > 29 Then
                            Return False
                        End If
                    End If
                Else
                    If Conversion.Val(VTd) > 28 Then
                        Return False
                    End If
                End If
        End Select
        Return True
    End Function
End Module


