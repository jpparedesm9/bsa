Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic

Public Module MODINI
    Structure RegistroTOK
        Dim Token As String
        Dim valor As String
        Public Shared Function CreateInstance() As RegistroTOK
            Dim result As New RegistroTOK
            result.Token = String.Empty
            result.valor = String.Empty
            Return result
        End Function
    End Structure

    Public PathUnico As String = ""
    Dim Preferencias(,) As String

    Function Abrir_Archivo(ByRef Filename As String) As Integer
        Dim FNum As String = ""
        Try
            FNum = CStr(FileSystem.FreeFile())
            FileSystem.FileOpen(CInt(FNum), Filename, OpenMode.Input)
            Return CInt(FNum)
        Catch
            Return 0
        End Try
    End Function
    Sub CargaParametros()
        Dim VLParametro(15, 2) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT4, "3")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "ADM")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CMNAC")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(509179)) Then
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            VGMoneda = VLParametro(4, 1)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If







    End Sub
    Function Buscar_Token(ByRef FileNum As Integer, ByRef Token As String) As String
        Dim pos1 As Integer = 0
        Dim VTLinea As String = ""
        FileSystem.Seek(FileNum, 1)
        Do Until FileSystem.EOF(FileNum)
            VTLinea = FileSystem.LineInput(FileNum)
            If (VTLinea.IndexOf("'"c) + 1) = 0 Then
                If VTLinea.IndexOf(Token) >= 0 Then
                    pos1 = (VTLinea.IndexOf("="c) + 1)
                    If pos1 > 0 Then
                        Return Strings.Mid(VTLinea, pos1 + 1, VTLinea.Length)
                    End If
                End If
            End If
        Loop
        Return ""
    End Function

    Sub Escribir_Ini(ByRef Filename As String)
        Dim Linea As String = ""
        Dim FNum As Integer = FileSystem.FreeFile()
        FileSystem.FileOpen(FNum, Filename, OpenMode.Output)
        If FNum > 0 Then
            Linea = "[PREFERENCIAS]"
            FileSystem.PrintLine(FNum, Linea)
            For i As Integer = 1 To Preferencias.GetUpperBound(0)
                Linea = Preferencias(i, 1) & "=" & Preferencias(i, 2)
                FileSystem.PrintLine(FNum, Linea)
            Next i
            FileSystem.FileClose(FNum)
        End If
    End Sub

    'Sub Forma_Preferencias()
    'FPreferencias.gr_preferencias.Rows = Preferencias.GetUpperBound(0)
    'FPreferencias.gr_preferencias.Tag = Conversion.Str(Preferencias.GetUpperBound(0))
    'FPreferencias.gr_preferencias.ColWidth(0) = 15 * 120
    'FPreferencias.gr_preferencias.ColWidth(1) = 30 * 120
    'For i As Integer = 1 To Preferencias.GetUpperBound(0)
    '    FPreferencias.gr_preferencias.Row = i - 1
    '    FPreferencias.gr_preferencias.Col = 0
    '    FPreferencias.gr_preferencias.CtlText = Preferencias(i, 1)
    '    FPreferencias.gr_preferencias.Col = 1
    '    FPreferencias.gr_preferencias.CtlText = Preferencias(i, 2)
    'Next i
    'End Sub

    Function Get_Preferencia(ByRef Token As String) As String
        For i As Integer = 1 To Preferencias.GetUpperBound(0)
            If Preferencias(i, 1) = Token Then
                Return Preferencias(i, 2)
            End If
        Next i
        Return ""
        ' Get_Preferencia = COBISPreferencesAdmin.ReadINIPreference("CTA", " PREFERENCIAS", Token)
    End Function

    Sub Iniciar_Preferencias(ByRef Filename As String)
        ReDim formato_fecha(3, 2)
        formato_fecha(1, 1) = FMLoadResString(509180)
        formato_fecha(2, 1) = FMLoadResString(509181)
        formato_fecha(3, 1) = FMLoadResString(509182)
        formato_fecha(1, 2) = FMLoadResString(509183)
        formato_fecha(2, 2) = FMLoadResString(509184)
        formato_fecha(3, 2) = FMLoadResString(509185)
        ReDim Preferencias(9, 2)
        Preferencias(1, 1) = FMLoadResString(509140)
        Preferencias(2, 1) = FMLoadResString(503213)
        Preferencias(3, 1) = FMLoadResString(508957)
        Preferencias(4, 1) = FMLoadResString(509186)
        Preferencias(5, 1) = FMLoadResString(503201)
        Preferencias(6, 1) = FMLoadResString(9017)
        Preferencias(7, 1) = FMLoadResString(509187)
        Preferencias(8, 1) = FMLoadResString(509188)
        Preferencias(9, 1) = FMLoadResString(509189)
        '  Preferencias(10, 1) = "MONEDA"
        Dim FNum As Integer = Abrir_Archivo(Filename)
        If FNum > 0 Then
            Preferencias(1, 2) = Buscar_Token(FNum, FMLoadResString(509140))
            Preferencias(2, 2) = Buscar_Token(FNum, FMLoadResString(503213))
            Preferencias(3, 2) = Buscar_Token(FNum, FMLoadResString(508957))
            Preferencias(4, 2) = Buscar_Token(FNum, FMLoadResString(509186))
            Preferencias(5, 2) = Buscar_Token(FNum, FMLoadResString(503201))
            Preferencias(6, 2) = Buscar_Token(FNum, FMLoadResString(9017))
            Preferencias(7, 2) = Buscar_Token(FNum, FMLoadResString(509187))
            If Preferencias(7, 2) = "" Then
                Preferencias(7, 2) = FMLoadResString(509182)
            End If

            VGFormatoFecha = Get_Preferencia(FMLoadResString(509187))
            Preferencias(8, 2) = Buscar_Token(FNum, FMLoadResString(509188))
            If Preferencias(8, 2) = "" Then
                Preferencias(8, 2) = "N"
            End If
            Preferencias(9, 2) = Buscar_Token(FNum, FMLoadResString(509189))
            If Preferencias(9, 2) = "" Then
                Preferencias(9, 2) = VGPath & "\logtran.txt"
            End If
            Preferencias(10, 2) = Buscar_Token(FNum, FMLoadResString(509190))
            FileSystem.FileClose(FNum)
        End If
        CargaParametros()
        CargaFormatoFecha()


    End Sub


    'Sub Set_Forma_Preferencia(ByRef Token As String, ByRef valor As String)
    '    For i As Integer = 0 To Preferencias.GetUpperBound(0) - 1
    '        FPreferencias.gr_preferencias.Row = i
    '        FPreferencias.gr_preferencias.Col = 0
    '        If FPreferencias.gr_preferencias.CtlText = Token Then
    '            FPreferencias.gr_preferencias.Col = 1
    '            FPreferencias.gr_preferencias.CtlText = valor
    '            Exit Sub
    '        End If
    '    Next i
    'End Sub

    Sub Set_Preferencia(ByRef Token As String, ByRef valor As String)
        For i As Integer = 1 To Preferencias.GetUpperBound(0)
            If Preferencias(i, 1) = Token Then
                Select Case Token
                    Case "DEBUG"
                        If sqlconn > 0 Then
                            If valor = "S" Then
                                PMDebug(sqlconn, True)
                                VGDebug = True
                            Else
                                PMDebug(sqlconn, False)
                                VGDebug = True
                            End If
                        End If
                        'Case "ARCHIVO-LOG"
                        'VGLogTransacciones = valor
                End Select
                Preferencias(i, 2) = valor
            End If
        Next i
    End Sub


End Module


