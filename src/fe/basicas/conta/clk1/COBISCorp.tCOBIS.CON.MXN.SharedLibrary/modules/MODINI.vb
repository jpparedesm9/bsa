Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.COBISExplorer.Preferences
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODINI
    Public Structure RegistroTOK
        Dim Token As String
        Dim Valor As String
        Public Shared Function CreateInstance() As RegistroTOK
            Dim result As New RegistroTOK
            result.Token = String.Empty
            result.Valor = String.Empty
            Return result
        End Function
    End Structure

    Public Const CGFORMATOFECHA As String = "mm/dd/yyyy"
    Public ARCHIVOINI As String = ""
    Public Preferencias(,) As String
    Public Formato_Fecha(,) As String
    Public VGFecha_SP As String = ""
    Public VGFecha_Pref As String = ""
    Public Seccion As New System.Collections.Generic.Dictionary(Of String, String)
    Public VGGrabar As String = ""
    Public PathUnico As String = ""

    Function Abrir_Archivo(ByRef Filename As String) As Integer
        Dim FNum As Integer = 0
        Try
            FNum = FileSystem.FreeFile()
            FileSystem.FileOpen(FNum, Filename, OpenMode.Input)
            Return FNum
        Catch
            Return 0
        End Try
    End Function

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

    Sub Escribir_ini(ByRef Filename As String)
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

    Sub Forma_Preferencias()
        'FPreferencias.gr_preferencias.Rows = Preferencias.GetUpperBound(0)
        'FPreferencias.gr_preferencias.Tag = Conversion.Str(Preferencias.GetUpperBound(0))
        'FPreferencias.gr_preferencias.ColWidth(0) = 15 * 120
        'FPreferencias.gr_preferencias.ColWidth(1) = 30 * 120
        'For i As Integer = 1 To Preferencias.GetUpperBound(0)
        '	FPreferencias.gr_preferencias.Row = i - 1
        '	FPreferencias.gr_preferencias.Col = 0
        '	FPreferencias.gr_preferencias.CtlText = Preferencias(i, 1)
        '	FPreferencias.gr_preferencias.Col = 1
        '	FPreferencias.gr_preferencias.CtlText = Preferencias(i, 2)
        'Next i
    End Sub

    Function Get_Preferencia(ByRef Token As String) As String
        Get_Preferencia = COBISPreferencesAdmin.ReadINIPreference("CONTA", " PREFERENCIAS", Token)
    End Function

    Sub Iniciar_Preferencias(ByRef Filename As String)
        ReDim Formato_Fecha(3, 2)
        Formato_Fecha(1, 1) = "dd/mm/yyyy"
        Formato_Fecha(2, 1) = "mm/dd/yyyy"
        Formato_Fecha(3, 1) = "yyyy/mm/dd"
        Formato_Fecha(1, 2) = "103"
        Formato_Fecha(2, 2) = "101"
        Formato_Fecha(3, 2) = "111"
        ReDim Preferencias(33, 2)
        Preferencias(1, 1) = "FILIAL"
        Preferencias(2, 1) = "OFICINA"
        Preferencias(3, 1) = "ROL"
        Preferencias(4, 1) = "SERVIDOR"
        Preferencias(5, 1) = "TERMINAL"
        Preferencias(6, 1) = "USUARIO"
        Preferencias(7, 1) = "FORMATO-FECHA"
        Preferencias(8, 1) = "DEBUG"
        Preferencias(9, 1) = "ARCHIVO-DEBUG"
        Preferencias(10, 1) = "VERSION"
        Preferencias(11, 1) = "PATH-DESTINO"
        Preferencias(12, 1) = "PATH-EXCEL"
        Preferencias(13, 1) = "PATH-SALDOS"
        Preferencias(14, 1) = "DIRECCION-SERVIDOR"
        Preferencias(15, 1) = "LOGIN-TRANSFERENCIA"
        Preferencias(16, 1) = "ARCHIVO-TRANSFERENCIA"
        Preferencias(17, 1) = "EJECUTABLE-TRANSFERENCIA"
        Preferencias(18, 1) = "RANGO-COTIZACIONES"
        Preferencias(19, 1) = "EJECUTABLE-IMPRESION"
        Preferencias(20, 1) = "EJECUTABLE-EDICION"
        Preferencias(21, 1) = "GRABAR-LOCAL"
        Preferencias(22, 1) = "INTERVALO-GRABAR"
        Preferencias(23, 1) = "OUT-LINE"
        Preferencias(24, 1) = "PATH-BALANCES"
        Preferencias(25, 1) = "PATH-ANALITICOS"
        Preferencias(26, 1) = "PATH-GENERALES"
        Preferencias(27, 1) = "PATH-DECLARACIONES"
        Preferencias(28, 1) = "ENCRIPTAMIENTO"
        Preferencias(29, 1) = "PATH-CERTIFICADOS1"
        Preferencias(30, 1) = "PATH-CERTIFICADOS2"
        Preferencias(31, 1) = "PATH-ANEXOS"
        Preferencias(32, 1) = "PATH-PROVISIONES"
        Preferencias(33, 1) = "VERSION-MODULO"
        Dim FNum As Integer = Abrir_Archivo(Filename)
        If FNum > 0 Then
            Preferencias(1, 2) = Buscar_Token(FNum, "FILIAL")
            Preferencias(2, 2) = Buscar_Token(FNum, "OFICINA")
            Preferencias(3, 2) = Buscar_Token(FNum, "ROL")
            Preferencias(4, 2) = Buscar_Token(FNum, "SERVIDOR")
            Preferencias(5, 2) = Buscar_Token(FNum, "TERMINAL")
            Preferencias(6, 2) = Buscar_Token(FNum, "USUARIO")
            Preferencias(7, 2) = Buscar_Token(FNum, "FORMATO-FECHA")
            If Preferencias(7, 2) = "" Then
                Preferencias(7, 2) = "yyyy/mm/dd"
            End If
            Preferencias(8, 2) = Buscar_Token(FNum, "DEBUG")
            If Preferencias(8, 2) = "" Then
                Preferencias(8, 2) = "N"
            End If
            Preferencias(9, 2) = Buscar_Token(FNum, "ARCHIVO-DEBUG")
            If Preferencias(9, 2) = "" Then
                Preferencias(9, 2) = "segurid.dbg"
            End If
            Preferencias(10, 2) = Buscar_Token(FNum, "VERSION")
            If Preferencias(10, 2) = "" Then
                Preferencias(10, 2) = "N"
            End If
            Preferencias(11, 2) = Buscar_Token(FNum, "PATH-DESTINO")
            If Preferencias(11, 2) = "" Then
                Preferencias(11, 2) = "/home/cobis/"
            End If
            Preferencias(12, 2) = Buscar_Token(FNum, "PATH-EXCEL")
            If Preferencias(12, 2) = "" Then
                Preferencias(12, 2) = "c:\msoffice\excel\excel.exe"
            End If
            Preferencias(13, 2) = Buscar_Token(FNum, "PATH-SALDOS")
            If Preferencias(13, 2) = "" Then
                Preferencias(13, 2) = "c:\cobissrc\conta\cobcon01.xls"
            End If
            Preferencias(14, 2) = Buscar_Token(FNum, "DIRECCION-SERVIDOR")
            If Preferencias(14, 2) = "" Then
                Preferencias(14, 2) = "192.188.45.120"
            End If
            Preferencias(15, 2) = Buscar_Token(FNum, "LOGIN-TRANSFERENCIA")
            If Preferencias(15, 2) = "" Then
                Preferencias(15, 2) = "cobis"
            End If
            Preferencias(16, 2) = Buscar_Token(FNum, "ARCHIVO-TRANSFERENCIA")
            If Preferencias(16, 2) = "" Then
                Preferencias(16, 2) = "Transfer.txt"
            End If
            Preferencias(17, 2) = Buscar_Token(FNum, "EJECUTABLE-TRANSFERENCIA")
            If Preferencias(17, 2) = "" Then
                Preferencias(17, 2) = PathUnico & "\Transfer.bat"
            End If
            Preferencias(18, 2) = Buscar_Token(FNum, "RANGO-COTIZACIONES")
            Preferencias(19, 2) = Buscar_Token(FNum, "EJECUTABLE-IMPRESION")
            Preferencias(20, 2) = Buscar_Token(FNum, "EJECUTABLE-EDICION")
            Preferencias(21, 2) = Buscar_Token(FNum, "GRABAR-LOCAL")
            If Preferencias(21, 2) = "" Then
                Preferencias(21, 2) = "N"
            End If
            VGGrabar = Preferencias(21, 2)
            Preferencias(22, 2) = Buscar_Token(FNum, "INTERVALO-GRABAR")
            Preferencias(23, 2) = Buscar_Token(FNum, "OUT-LINE")
            Preferencias(24, 2) = Buscar_Token(FNum, "PATH-BALANCES")
            If Preferencias(24, 2) = "" Then
                Preferencias(24, 2) = PathUnico & "\cobcon01.xls"
            End If
            Preferencias(25, 2) = Buscar_Token(FNum, "PATH-ANALITICOS")
            If Preferencias(25, 2) = "" Then
                Preferencias(25, 2) = PathUnico & "\cobcon02.xls"
            End If
            Preferencias(26, 2) = Buscar_Token(FNum, "PATH-GENERALES")
            If Preferencias(26, 2) = "" Then
                Preferencias(26, 2) = PathUnico & "\cobcon03.xls"
            End If
            Preferencias(27, 2) = Buscar_Token(FNum, "PATH-DECLARACIONES")
            If Preferencias(27, 2) = "" Then
                Preferencias(27, 2) = PathUnico & "\declaraciones.xls"
            End If
            Preferencias(28, 2) = Buscar_Token(FNum, "ENCRIPTAMIENTO")
            If Preferencias(28, 2) = "" Then
                Preferencias(28, 2) = "N"
            End If
            Preferencias(29, 2) = Buscar_Token(FNum, "PATH-CERTIFICADOS1")
            If Preferencias(29, 2) = "" Then
                Preferencias(29, 2) = PathUnico & "\certificados1.xls"
            End If
            Preferencias(30, 2) = Buscar_Token(FNum, "PATH-CERTIFICADOS2")
            If Preferencias(30, 2) = "" Then
                Preferencias(30, 2) = PathUnico & "\certificados2.xls"
            End If
            Preferencias(31, 2) = Buscar_Token(FNum, "PATH-ANEXOS")
            If Preferencias(31, 2) = "" Then
                Preferencias(31, 2) = PathUnico & "\anexos.xls"
            End If
            Preferencias(32, 2) = Buscar_Token(FNum, "PATH-PROVISIONES")
            If Preferencias(32, 2) = "" Then
                Preferencias(32, 2) = PathUnico & "\provisiones.xls"
            End If
            Preferencias(33, 2) = Buscar_Token(FNum, "VERSION-MODULO")
            If Preferencias(33, 2) = "" Then
                Preferencias(33, 2) = "1.0000"
            End If
            FileSystem.FileClose(FNum)
            PMCargar_FechaSP(Preferencias(7, 2))
        End If
    End Sub

    'Sub Set_Forma_Preferencia(ByRef Token As String, ByRef Valor As String)
    '	For i As Integer = 0 To Preferencias.GetUpperBound(0) - 1
    '		FPreferencias.gr_preferencias.Row = i
    '		FPreferencias.gr_preferencias.Col = 0
    '		If FPreferencias.gr_preferencias.CtlText = Token Then
    '			FPreferencias.gr_preferencias.Col = 1
    '			FPreferencias.gr_preferencias.CtlText = Valor
    '		End If
    '	Next i
    'End Sub

    Sub Set_Preferencia(ByRef Token As String, ByRef Valor As String)
        For i As Integer = 1 To Preferencias.GetUpperBound(0)
            If Preferencias(i, 1) = Token Then
                Select Case Token
                    Case "DEBUG", "ARCHIVO-DEBUG", "VERSION"
                End Select
                Preferencias(i, 2) = Valor
            End If
        Next i
    End Sub
End Module


