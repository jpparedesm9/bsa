Attribute VB_Name = "Module1"
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Function FMDateAdd(Fecha As String, Intervalo As String, Numero As Long, Formato As String) As String
'*********************************************************
'Objetivo:  Dada una Fecha en un Formato dado suma a la
'           Fecha un x numero de intervalos y retorna
'           la fecha resultante
'           Los formatos soportados son:
'               mm/dd/yyyy
'               dd/mm/yyyy
'               yyyy/mm/dd
'Input:     Fecha       string con la fecha
'           Intervalo   string que indica el intervalo
'                       de tiempo a sumarse
'                       "y" = años
'                       "m" = meses
'                       "d" = dias
'           Numero      número de intervalos a sumarle a la
'                       fecha (2 años, 1 mes, 34 dias)
'           Formato     formato en el que está la fecha
'Output:    FMDateAdd   Fecha resultante
'                       "" si existe un error
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'15/Jul/94  M.Davila            Emisión Inicial
'*********************************************************
Dim Vtp1%
Dim VTp2%
Dim VTm$
Dim VTd$
Dim VTa$
Dim vtanios%
Dim vtresiduo%
Dim vtmes%
Dim VTFecha0$
Dim vtdias&
Dim vtanio&
Dim vtbis%
Dim vtdias2&
Dim vtdiasmes%
Dim VTFecha$
    'verificar el formato de la fecha
    If Not FMVerFormato(Fecha, Formato) Then
        FMDateAdd = ""
        Exit Function
    End If
    'extraigo los valores de año, mes, dia de la fecha
    Vtp1% = InStr(1, Fecha, "/")
    If Vtp1% = 0 Then
        FMDateAdd$ = ""
        Exit Function
    End If
    VTp2% = InStr(Vtp1% + 1, Fecha, "/")
    If VTp2% = 0 Then
        FMDateAdd$ = ""
        Exit Function
    End If
    Select Case Formato
    Case "mm/dd/yyyy"
        VTm$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTd$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "dd/mm/yyyy"
        VTd$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "yyyy/mm/dd"
        VTa$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTd$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case Else
        MsgBox "Formato: " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMDateAdd = ""
        Exit Function
    End Select
    'Cálculo de la fecha resultante de acuerdo al tipo de Intervalo
    Select Case Intervalo
    Case "y"
        If Val(VTa$) + Numero <= 9999 Then
            VTa$ = Str$(Val(VTa$) + Numero)
        Else
            MsgBox "Fecha Resultante Fuera de Rango", 16, "FMDateAdd"
            FMDateAdd = ""
            Exit Function
        End If
    Case "m"
        'determinar el número de años que resultan de los meses
        'a añadirse a la fecha
        vtanios% = Numero \ 12
        If Val(VTa$) + vtanios% <= 9999 Then
            'calculo el año resultante
            If vtanios% >= 1 Then
'FIXIT: Replace 'Str' function with 'Str$' function                                        FixIT90210ae-R9757-R1B8ZE
                VTa$ = Str$(Val(VTa$) + vtanios%)
            End If
            'calculo el mes resultante
            vtresiduo% = Numero Mod 12
            If vtresiduo% > 0 Then
                vtmes% = Val(VTm$) + vtresiduo%
                If vtmes% > 12 Then
                    If Val(VTa$) + 1 <= 9999 Then
'FIXIT: Replace 'Str' function with 'Str$' function                                        FixIT90210ae-R9757-R1B8ZE
                        VTa$ = Str$(Val(VTa$) + 1)
                        vtmes% = vtmes% - 12
                    Else
                        MsgBox "Fecha Resultante Fuera de Rango", 16, "FMDateAdd"
                        FMDateAdd = ""
                        Exit Function
                    End If
                End If
            VTm$ = Str$(vtmes%)
            End If
        Else
            MsgBox "Fecha Resultante Fuera de Rango", 16, "FMDateAdd"
            FMDateAdd = ""
            Exit Function
        End If
    Case "d"
        'calculo la diferencia en dias entre Fecha y 01/01/1753
        Select Case Formato
        Case "mm/dd/yyyy"
            VTFecha0$ = "01/01/1753"
        Case "dd/mm/yyyy"
            VTFecha0$ = "01/01/1753"
        Case "yyyy/mm/dd"
            VTFecha0$ = "1753/01/01"
        End Select
        vtdias& = FMDateDiff("d", VTFecha0$, Fecha, Formato)
        vtdias& = vtdias& + Numero
        vtanio& = 1753
        Do While vtdias& >= 366
            If (vtanio& Mod 4) = 0 Then
                If (vtanio& Mod 100 = 0) And (vtanio& Mod 400 <> 0) Then
                    vtbis% = False
                Else
                    vtbis% = True
                End If
            Else
                vtbis% = False
            End If
            If vtbis% Then
                vtdias& = vtdias& - 366
            Else
                vtdias& = vtdias& - 365
            End If
            vtanio& = vtanio& + 1
        Loop
        If (vtanio& Mod 4) = 0 Then
            If (vtanio& Mod 100 = 0) And (vtanio& Mod 400 <> 0) Then
                vtbis% = False
            Else
                vtbis% = True
            End If
        Else
            vtbis% = False
        End If
        If Not vtbis% And vtdias& = 365 Then
            vtdias& = vtdias& - 365
            vtanio& = vtanio& + 1
        End If
        If vtanio& > 9999 Then
            MsgBox "Fecha Resultante Fuera de Rango", 16, "FMDateAdd"
            FMDateAdd = ""
            Exit Function
        End If
        VTa$ = Str$(vtanio&)
        If vtdias& = 0 Then
            VTm$ = "01"
            VTd$ = "01"
        Else
            vtdias& = vtdias& + 1
            vtdias2& = 0
            vtmes% = 0
            Do While vtdias2& < vtdias&
                vtmes% = vtmes% + 1
                Select Case vtmes%
                Case 1, 3, 5, 7, 8, 10, 12
                    vtdiasmes% = 31
                Case 4, 6, 9, 11
                    vtdiasmes% = 30
                Case 2
                    If vtbis% Then
                        vtdiasmes% = 29
                    Else
                        vtdiasmes% = 28
                    End If
                End Select
                If vtdias& - vtdias2& <= vtdiasmes% Then
                    VTd$ = Str$(vtdias& - vtdias2&)
                    VTm$ = Str$(vtmes%)
                    vtdias2& = vtdias&
                Else
                    vtdias2& = vtdias2& + vtdiasmes%
                End If
            Loop
        End If
    Case Else
        MsgBox "Intervalo: " + Intervalo + " NO Soportado", 16, "FMDateAdd"
        FMDateAdd$ = ""
        Exit Function
    End Select
    'correspondencia de dias
    If Val(VTd$) > 28 Then
        Select Case Val(VTm$)
        Case 4, 6, 9, 11
            If Val(VTd$) > 30 Then
                VTd$ = "30"
            End If
        Case 2
            If (Val(VTa$) Mod 4) = 0 Then
                If ((Val(VTa$) Mod 100) = 0) And ((Val(VTa$) Mod 400) <> 0) Then
                    VTd$ = "28"
                Else
                    VTd$ = "29"
                End If
            Else
                VTd$ = "28"
            End If
        End Select
    End If
    'formatear resultados
    VTd$ = Trim$(VTd$)
    VTm$ = Trim$(VTm$)
    VTa$ = Trim$(VTa$)

    If Len(VTd$) = 1 Then
        VTd$ = "0" + VTd$
    End If
    If Len(VTm$) = 1 Then
        VTm$ = "0" + VTm$
    End If
    'poner fecha resultante en Formato
    Select Case Formato
    Case "mm/dd/yyyy"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTm$ & "/" & VTd$ & "/" & VTa$
    Case "dd/mm/yyyy"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTd$ & "/" & VTm$ & "/" & VTa$
    Case "yyyy/mm/dd"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTa$ & "/" & VTm$ & "/" & VTd$
    Case Else
        MsgBox "Formato Destino: " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMDateAdd = ""
        Exit Function
    End Select
    FMDateAdd$ = VTFecha$
End Function

Function FMConvFecha(Fecha As String, FormatoA As String, FormatoB As String) As String
'*********************************************************
'Objetivo:  Dado un string que es una fecha, cambia el formato
'           de fecha de FormatoA a FormatoB
'           Formatos soportados:
'               mm/dd/yy  ;  mm/dd/yyyy
'               dd/mm/yy  ;  dd/mm/yyyy
'               yy/mm/dd  ;  yyyy/mm/dd
'Input:     Fecha       es el string con la fecha
'           FormatoA    string con formato original
'           FormatoB    string con formato destino
'Output:    FMConvFecha string convertido de formato
'                       si no hay forma de convertir retorna ""
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'19/Abr/94  M.Davila            Emisión Inicial
'*********************************************************
Dim VTa$, VTm$, VTd$    'substring con año, mes, día
Dim Vtp1%, VTp2%        'posiciones de "/"
Dim VTFecha$            'auxiliar para la fecha
Dim VT%
Dim Formato As String
    'verificamos que Fecha de acuerdo a FormatoA sea valida
    VT% = FMVerFormato(Fecha, FormatoA)
    If Not VT% Then
        FMConvFecha$ = ""
        Exit Function
    End If
    'extraigo los valores de año, mes, dia de la fecha
    Vtp1% = InStr(1, Fecha, "/")
    If Vtp1% = 0 Then
        FMConvFecha$ = ""
        Exit Function
    End If
    VTp2% = InStr(Vtp1% + 1, Fecha, "/")
    If VTp2% = 0 Then
        FMConvFecha$ = ""
        Exit Function
    End If
    Select Case FormatoA
    Case "mm/dd/yy"
        VTm$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTd$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "mm/dd/yyyy"
        VTm$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTd$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "dd/mm/yy"
        VTd$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "dd/mm/yyyy"
        VTd$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "yy/mm/dd"
        VTa$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTd$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "yyyy/mm/dd"
        VTa$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTd$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case Else
        MsgBox "Formato Origen: " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMConvFecha = ""
        Exit Function
    End Select
    'Convertimos fecha a nuevo formato
    Select Case FormatoB
    Case "mm/dd/yy"
        If Len(VTa$) = 4 Then
            VTa$ = Mid$(VTa$, 3, 2)
        End If
        VTFecha$ = VTm$ & "/" & VTd$ & "/" & VTa$
    Case "mm/dd/yyyy"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTm$ & "/" & VTd$ & "/" & VTa$
    Case "dd/mm/yy"
        If Len(VTa$) = 4 Then
            VTa$ = Mid$(VTa$, 3, 2)
        End If
        VTFecha$ = VTd$ & "/" & VTm$ & "/" & VTa$
    Case "dd/mm/yyyy"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTd$ & "/" & VTm$ & "/" & VTa$
    Case "yy/mm/dd"
        If Len(VTa$) = 4 Then
            VTa$ = Mid$(VTa$, 3, 2)
        End If
        VTFecha$ = VTa$ & "/" & VTm$ & "/" & VTd$
    Case "yyyy/mm/dd"
        If Len(VTa$) = 2 Then
            VTa$ = "19" + VTa$
        End If
        VTFecha$ = VTa$ & "/" & VTm$ & "/" & VTd$
    Case Else
        MsgBox "Formato Destino: " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMConvFecha = ""
        Exit Function
    End Select
    FMConvFecha$ = VTFecha$
End Function

Function FMDateDiff(Intervalo As String, Fecha1 As String, Fecha2 As String, Formato As String) As Long
'*********************************************************
'Objetivo:  Dados dos strings tipo fecha, calcula la dife-
'           rencia en años entre las dos fechas
'           Fecha1 debe ser menor a Fecha2
'           Los formatos soportados son:
'               mm/dd/yy  ;  mm/dd/yyyy
'               dd/mm/yy  ;  dd/mm/yyyy
'               yy/mm/dd  ;  yyyy/mm/dd
'Input:     Fecha1      string con la primera fecha
'           Fecha2      string con la segunda fecha
'           Formato     string con el formato que tienen las fechas
'           Intervalo   string que indica el intervalo
'                       de tiempo entre las dos fechas
'                       "y" = años (completos)
'                       "m" = meses
'                       "d" = dias
'Output:    FMDateDiff  intervalo entre las dos fechas.
'                       > 0 si Fecha1 < Fecha2
'                       < 0 si Fecha1 > Fecha2
'                       = 0 si Fecha1 = Fecha2 o Error
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'19/Abr/94  M.Davila            Emisión Inicial
'*********************************************************

Dim VTm1$, VTd1$, VTa1$        'para capturar mes, dia y año de fecha1
Dim VTm2$, VTd2$, VTa2$        'para capturar mes, dia y año de fecha2
Dim VTp11%, VTp12%             'posicion de los dos "/"
Dim VTp21%, VTp22%             'posicion de los dos "/"
'! removed Dim VTaa&
Dim VTdd&, VTmm& 'intervalos en dias, meses y años
Dim VT%
Dim i%
Dim vtbis%
    'Verificar que las fechas sean correctas
    VT% = FMVerFormato(Fecha1, Formato)
    If Not VT% Then
        FMDateDiff& = 0
        Exit Function
    End If
    VT% = FMVerFormato(Fecha2, Formato)
    If Not VT% Then
        FMDateDiff& = 0
        Exit Function
    End If
    
    VTp11% = InStr(1, Fecha1, "/")
    If VTp11% = 0 Then
        FMDateDiff& = 0
        Exit Function
    End If
    VTp12% = InStr(VTp11% + 1, Fecha1, "/")
    If VTp12% = 0 Then
        FMDateDiff& = 0
        Exit Function
    End If
    VTp21% = InStr(1, Fecha2, "/")
    If VTp21% = 0 Then
        FMDateDiff& = 0
        Exit Function
    End If
    VTp22% = InStr(VTp21% + 1, Fecha2, "/")
    If VTp22% = 0 Then
        FMDateDiff& = 0
        Exit Function
    End If
    'extraigo los substrings de mes dia y año
    Select Case Formato
    Case "mm/dd/yy"
        VTm1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTd1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTa1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTa1$ = "19" + VTa1$
        VTm2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTd2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTa2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
        VTa2$ = "19" + VTa2$
    Case "mm/dd/yyyy"
        VTm1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTd1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTa1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTm2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTd2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTa2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
    Case "dd/mm/yy"
        VTd1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTm1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTa1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTa1$ = "19" + VTa1$
        VTd2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTm2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTa2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
        VTa2$ = "19" + VTa2$
    Case "dd/mm/yyyy"
        VTd1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTm1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTa1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTd2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTm2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTa2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
    Case "yy/mm/dd"
        VTa1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTm1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTd1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTa1$ = "19" + VTa1$
        VTa2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTm2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTd2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
        VTa2$ = "19" + VTa2$
    Case "yyyy/mm/dd"
        VTa1$ = Mid$(Fecha1, 1, VTp11% - 1)
        VTm1$ = Mid$(Fecha1, VTp11% + 1, VTp12% - VTp11% - 1)
        VTd1$ = Mid$(Fecha1, VTp12% + 1, Len(Fecha1))
        VTa2$ = Mid$(Fecha2, 1, VTp21% - 1)
        VTm2$ = Mid$(Fecha2, VTp21% + 1, VTp22% - VTp21% - 1)
        VTd2$ = Mid$(Fecha2, VTp22% + 1, Len(Fecha2))
    Case Else
        MsgBox "Formato de Fecha " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMDateDiff& = 0
        Exit Function
    End Select
    ' ** ENCONTRAR EL INTERVALO ENTRE LAS DOS FECHAS
    Select Case Intervalo
    Case "y"
        'encontrar cual es la fecha mayor
        If Val(VTa1$) < Val(VTa2$) Then   'Fecha1 < Fecha2
            'comparar los meses
            If Val(VTm1$) < Val(VTm2$) Then
                FMDateDiff& = Val(VTa2$) - Val(VTa1$)
            Else
                If Val(VTm1$) > Val(VTm2$) Then
                    FMDateDiff& = Val(VTa2$) - Val(VTa1$) - 1
                Else
                    'meses iguales, comparar dias
                    If Val(VTd1$) <= Val(VTd2$) Then
                        FMDateDiff& = Val(VTa2$) - Val(VTa1$)
                    Else
                        FMDateDiff& = Val(VTa2$) - Val(VTa1$) - 1
                    End If
                End If
            End If
        Else
            If Val(VTa1$) > Val(VTa2$) Then  'Fecha1 > Fecha2
                'comparar los meses
                If Val(VTm2$) < Val(VTm1$) Then
                    FMDateDiff& = -(Val(VTa1$) - Val(VTa2$))
                Else
                    If Val(VTm2$) > Val(VTm1$) Then
                        FMDateDiff& = -(Val(VTa1$) - Val(VTa2$) - 1)
                    Else
                        'meses iguales, comparar dias
                        If Val(VTd2$) <= Val(VTd1$) Then
                            FMDateDiff& = -(Val(VTa1$) - Val(VTa2$))
                        Else
                            FMDateDiff& = -(Val(VTa1$) - Val(VTa2$) - 1)
                        End If
                    End If
                End If
            Else
                'son fechas del mismo año
                FMDateDiff& = 0
            End If
        End If
    Case "m"
        'encontrar cual fecha es mayor
        If Val(VTa1$) < Val(VTa2$) Then   'Fecha1 < Fecha2
            'sumar los meses de años enteros
            VTmm& = (Val(VTa2$) - Val(VTa1$) - 1) * 12
            'sumar los meses del año en la Fecha1
            VTmm& = VTmm& + (12 - Val(VTm1$))
            'sumar los meses del año en la Fecha 2
            VTmm& = VTmm& + (Val(VTm2$) - 1)
            If Val(VTd1$) <= Val(VTd2$) Then
                VTmm& = VTmm& + 1
            End If
            FMDateDiff& = VTmm&
        Else
            If Val(VTa1$) > Val(VTa2$) Then  'Fecha1 > Fecha2
                'sumar los meses de años enteros
                VTmm& = (Val(VTa1$) - Val(VTa2$) - 1) * 12
                'sumar los meses del año en la Fecha2
                VTmm& = VTmm& + (12 - Val(VTm2$))
                'sumar los meses del año en la Fecha1
                VTmm& = VTmm& + (Val(VTm1$) - 1)
                If Val(VTd2$) <= Val(VTd1$) Then
                    VTmm& = VTmm& + 1
                End If
                FMDateDiff& = -VTmm&
            Else
                'son fechas del mismo año
                If Val(VTm1$) < Val(VTm2$) Then
                    'sumar meses enteros
                    VTmm& = Val(VTm2$) - Val(VTm1$) - 1
                    If Val(VTd1$) <= Val(VTd2$) Then
                        VTmm& = VTmm& + 1
                    End If
                    FMDateDiff& = VTmm&
                Else
                    If Val(VTm1$) > Val(VTm2$) Then
                        'sumar meses enteros
                        VTmm& = Val(VTm1$) - Val(VTm2$) - 1
                        If Val(VTd2$) <= Val(VTd1$) Then
                            VTmm& = VTmm& + 1
                        End If
                        FMDateDiff& = -VTmm&
                    Else
                        FMDateDiff& = 0
                    End If
                End If
            End If
        End If
    Case "d"
        VTdd& = 0
        'calcular la fecha mayor
        If Val(VTa1$) < Val(VTa2$) Then 'Fecha1 < Fecha2
            'calcular dias de años completos
            For i% = (Val(VTa1$) + 1) To (Val(VTa2$) - 1)
                If (i% Mod 4) = 0 Then
                    If (i% Mod 100 = 0) And (i% Mod 400 <> 0) Then
                        VTdd& = VTdd& + 365
                    Else
                        VTdd& = VTdd& + 366
                    End If
                Else
                    VTdd& = VTdd& + 365
                End If
            Next i%
            'calcular los dias en el año de Fecha 1
            If (Val(VTa1$) Mod 4) = 0 Then
                If (Val(VTa1$) Mod 100 = 0) And (Val(VTa1$) Mod 400 <> 0) Then
                    vtbis% = False
                Else
                    vtbis% = True
                End If
            Else
                vtbis% = False
            End If
            'en el mes de Fecha1
            Select Case Val(VTm1$)
            Case 1, 3, 5, 7, 8, 10, 12
                VTdd& = VTdd& + (31 - Val(VTd1$))
            Case 4, 6, 9, 11
                VTdd& = VTdd& + (30 - Val(VTd1$))
            Case 2
                If vtbis% Then
                    VTdd& = VTdd& + (29 - Val(VTd1$))
                Else
                    VTdd& = VTdd& + (28 - Val(VTd1$))
                End If
            End Select
            'el resto de dias
            For i% = Val(VTm1$) + 1 To 12
                Select Case i%
                Case 1, 3, 5, 7, 8, 10, 12
                    VTdd& = VTdd& + 31
                Case 4, 6, 9, 11
                    VTdd& = VTdd& + 30
                Case 2
                    If vtbis% Then
                        VTdd& = VTdd& + 29
                    Else
                        VTdd& = VTdd& + 28
                    End If
                End Select
            Next i%
            'calcular los dias en el año de Fecha 2
            If (Val(VTa2$) Mod 4) = 0 Then
                If (Val(VTa2$) Mod 100 = 0) And (Val(VTa2$) Mod 400 <> 0) Then
                    vtbis% = False
                Else
                    vtbis% = True
                End If
            Else
                vtbis% = False
            End If
            'en el mes de Fecha2
            VTdd& = VTdd& + Val(VTd2$)
            'en los meses anteriores
            For i% = 1 To Val(VTm2$) - 1
                Select Case i%
                Case 1, 3, 5, 7, 8, 10, 12
                    VTdd& = VTdd& + 31
                Case 4, 6, 9, 11
                    VTdd& = VTdd& + 30
                Case 2
                    If vtbis% Then
                        VTdd& = VTdd& + 29
                    Else
                        VTdd& = VTdd& + 28
                    End If
                End Select
            Next i%
            FMDateDiff& = VTdd&
        Else
            If Val(VTa1$) > Val(VTa2$) Then 'Fecha1 > Fecha2
                'calcular dias de años completos
                For i% = (Val(VTa2$) + 1) To (Val(VTa1$) - 1)
                    If (i% Mod 4) = 0 Then
                        If (i% Mod 100 = 0) And (i% Mod 400 <> 0) Then
                            VTdd& = VTdd& + 365
                        Else
                            VTdd& = VTdd& + 366
                        End If
                    Else
                        VTdd& = VTdd& + 365
                    End If
                Next i%
                'calcular los dias en el año de Fecha2
                If (Val(VTa2$) Mod 4) = 0 Then
                    If (Val(VTa2$) Mod 100 = 0) And (Val(VTa2$) Mod 400 <> 0) Then
                        vtbis% = False
                    Else
                        vtbis% = True
                    End If
                Else
                    vtbis% = False
                End If
                'en el mes de Fecha2
                Select Case Val(VTm2$)
                Case 1, 3, 5, 7, 8, 10, 12
                    VTdd& = VTdd& + (31 - Val(VTd2$))
                Case 4, 6, 9, 11
                    VTdd& = VTdd& + (30 - Val(VTd2$))
                Case 2
                    If vtbis% Then
                        VTdd& = VTdd& + (29 - Val(VTd2$))
                    Else
                        VTdd& = VTdd& + (28 - Val(VTd2$))
                    End If
                End Select
                'el resto de dias
                For i% = Val(VTm2$) + 1 To 12
                    Select Case i%
                    Case 1, 3, 5, 7, 8, 10, 12
                        VTdd& = VTdd& + 31
                    Case 4, 6, 9, 11
                        VTdd& = VTdd& + 30
                    Case 2
                        If vtbis% Then
                            VTdd& = VTdd& + 29
                        Else
                            VTdd& = VTdd& + 28
                        End If
                    End Select
                Next i%
                'calcular los dias en el año de Fecha1
                If (Val(VTa1$) Mod 4) = 0 Then
                    If (Val(VTa1$) Mod 100 = 0) And (Val(VTa1$) Mod 400 <> 0) Then
                        vtbis% = False
                    Else
                        vtbis% = True
                    End If
                Else
                    vtbis% = False
                End If
                'en el mes de Fecha1
                VTdd& = VTdd& + Val(VTd1$)
                'en los meses anteriores
                For i% = 1 To Val(VTm1$) - 1
                    Select Case i%
                    Case 1, 3, 5, 7, 8, 10, 12
                        VTdd& = VTdd& + 31
                    Case 4, 6, 9, 11
                        VTdd& = VTdd& + 30
                    Case 2
                        If vtbis% Then
                            VTdd& = VTdd& + 29
                        Else
                            VTdd& = VTdd& + 28
                        End If
                    End Select
                Next i%
                FMDateDiff& = -VTdd&
            Else
                ' años iguales
                If (Val(VTa1$) Mod 4) = 0 Then
                    If (Val(VTa1$) Mod 100 = 0) And (Val(VTa1$) Mod 400 <> 0) Then
                        vtbis% = False
                    Else
                        vtbis% = True
                    End If
                Else
                    vtbis% = False
                End If
                If Val(VTm1$) < Val(VTm2$) Then
                    'los dias que faltan del mes de Fecha1
                    Select Case Val(VTm1$)
                    Case 1, 3, 5, 7, 8, 10, 12
                        VTdd& = VTdd& + (31 - Val(VTd1$))
                    Case 4, 6, 9, 11
                        VTdd& = VTdd& + (30 - Val(VTd1$))
                    Case 2
                        If vtbis% Then
                            VTdd& = VTdd& + (29 - Val(VTd1$))
                        Else
                            VTdd& = VTdd& + (28 - Val(VTd1$))
                        End If
                    End Select
                    'los dias de meses completos entre Fecha1 y Fecha2
                    For i% = Val(VTm1$) + 1 To Val(VTm2$) - 1
                        Select Case i%
                        Case 1, 3, 5, 7, 8, 10, 12
                            VTdd& = VTdd& + 31
                        Case 4, 6, 9, 11
                            VTdd& = VTdd& + 30
                        Case 2
                            If vtbis% Then
                                VTdd& = VTdd& + 29
                            Else
                                VTdd& = VTdd& + 28
                            End If
                        End Select
                    Next i%
                    'los dias transcurridos del mes de Fecha2
                    VTdd& = VTdd& + Val(VTd2$)
                    FMDateDiff& = VTdd&
                Else
                    If Val(VTm1$) > Val(VTm2$) Then
                        'los dias que faltan del mes de Fecha2
                        Select Case Val(VTm2$)
                        Case 1, 3, 5, 7, 8, 10, 12
                            VTdd& = VTdd& + (31 - Val(VTd2$))
                        Case 4, 6, 9, 11
                            VTdd& = VTdd& + (30 - Val(VTd2$))
                        Case 2
                            If vtbis% Then
                                VTdd& = VTdd& + (29 - Val(VTd2$))
                            Else
                                VTdd& = VTdd& + (28 - Val(VTd2$))
                            End If
                        End Select
                        'los dias de meses completos entre Fecha1 y Fecha2
                        For i% = Val(VTm2$) + 1 To Val(VTm1$) - 1
                            Select Case i%
                            Case 1, 3, 5, 7, 8, 10, 12
                                VTdd& = VTdd& + 31
                            Case 4, 6, 9, 11
                                VTdd& = VTdd& + 30
                            Case 2
                                If vtbis% Then
                                    VTdd& = VTdd& + 29
                                Else
                                    VTdd& = VTdd& + 28
                                End If
                            End Select
                        Next i%
                        'los dias transcurridos del mes de Fecha1
                        VTdd& = VTdd& + Val(VTd1$)
                        FMDateDiff& = -VTdd&
                    Else
                        'año/mes iguales
                        VTdd& = Val(VTd2$) - Val(VTd1$)
                        FMDateDiff& = VTdd&
                    End If
                End If
            End If
        End If
    End Select
End Function

Function FMMascaraFecha(Formato As String) As String
'*********************************************************
'Objetivo:  Dado el string con el formato retorna la mascara
'           apropiada
'           Los formatos soportados son:
'               mm/dd/yy  ;  mm/dd/yyyy
'               dd/mm/yy  ;  dd/mm/yyyy
'               yy/mm/dd  ;  yyyy/mm/dd
'Input:     Formato     string con el formato de fecha
'           Intervalo   string que indica el intervalo
'                       de tiempo entre las dos fechas
'                       "y" = años (completos)
'                       "m" = meses
'                       "d" = dias
'Output:    FMMascaraFecha  mascara apropiada
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'22/Abr/94  M.Davila            Emisión Inicial
'*********************************************************
    Select Case Formato
    Case "yy/mm/dd", "mm/dd/yy", "dd/mm/yy"
        FMMascaraFecha = "##/##/##"
    Case "mm/dd/yyyy", "dd/mm/yyyy"
        FMMascaraFecha = "##/##/####"
    Case "yyyy/mm/dd"
        FMMascaraFecha = "####/##/##"
    Case Else
        FMMascaraFecha = ""
    End Select
End Function

Function FMVerFormato(Fecha As String, Formato As String) As Integer
'*********************************************************
'Objetivo:  Dado un string que es una fecha, verifica
'           que este en un formato dado.
'           Los formatos soportados son:
'               mm/dd/yy  ;  mm/dd/yyyy
'               dd/mm/yy  ;  dd/mm/yyyy
'               yy/mm/dd  ;  yyyy/mm/dd
'Input:     Fecha       es el string con la fecha
'           Formato     es un string con el formato a verificar
'Output:    FMVerFormato  True/False depende de si Fecha esta
'                           o no en Formato
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'19/Abr/94  M.Davila            Emisión Inicial
'*********************************************************

Dim VTm$, VTd$, VTa$        'para capturar mes, dia y año
Dim Vtp1%, VTp2%            'posicion de los dos "/"
    Vtp1% = InStr(1, Fecha, "/")
    If Vtp1% = 0 Then
        FMVerFormato% = False
        Exit Function
    End If
    VTp2% = InStr(Vtp1% + 1, Fecha, "/")
    If VTp2% = 0 Then
        FMVerFormato% = False
        Exit Function
    End If
    'extraigo los substrings de mes dia y año
    Select Case Formato
    Case "mm/dd/yy"
        VTm$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTd$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "mm/dd/yyyy"
        VTm$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTd$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "dd/mm/yy"
        VTd$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "dd/mm/yyyy"
        VTd$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTa$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case "yy/mm/dd"
        VTa$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTd$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
        VTa$ = "19" + VTa$
    Case "yyyy/mm/dd"
        VTa$ = Mid$(Fecha, 1, Vtp1% - 1)
        VTm$ = Mid$(Fecha, Vtp1% + 1, VTp2% - Vtp1% - 1)
        VTd$ = Mid$(Fecha, VTp2% + 1, Len(Fecha))
    Case Else
        MsgBox "Formato de Fecha " + Formato + " no soportado", 16, "Control Ingreso de Datos"
        FMVerFormato% = False
        Exit Function
    End Select
    'verificacion de la validez de mes dia y año
    If Val(VTa$) < 1753 Or Val(VTa$) > 9999 Then
        FMVerFormato% = False
        Exit Function
    End If
    If Val(VTm$) < 1 Or Val(VTm$) > 12 Then
        FMVerFormato% = False
        Exit Function
    End If
    If Val(VTd$) < 1 Then
        FMVerFormato% = False
        Exit Function
    End If
    Select Case Val(VTm$)
    Case 1, 3, 5, 7, 8, 10, 12
        If Val(VTd$) > 31 Then
            FMVerFormato% = False
            Exit Function
        End If
    Case 4, 6, 9, 11
        If Val(VTd$) > 30 Then
            FMVerFormato% = False
            Exit Function
        End If
    Case 2
        If (Val(VTa$) Mod 4) = 0 Then
            If ((Val(VTa$) Mod 100) = 0) And ((Val(VTa$) Mod 400) <> 0) Then
                If Val(VTd$) > 28 Then
                    FMVerFormato% = False
                    Exit Function
                End If
            Else
                If Val(VTd$) > 29 Then
                    FMVerFormato% = False
                    Exit Function
                End If
            End If
        Else
            If Val(VTd$) > 28 Then
                FMVerFormato% = False
                Exit Function
            End If
        End If
    End Select
    FMVerFormato% = True
End Function



