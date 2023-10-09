Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.eCOBIS.COBISExplorer.Preferences
Public Module MODINI
    Public Structure RegistroTOK
        Dim Token As String
        Dim valor As String
        Public Shared Function CreateInstance() As RegistroTOK
            Dim result As New RegistroTOK
            result.Token = String.Empty
            result.valor = String.Empty
            Return result
        End Function
    End Structure

    Public ARCHIVOINI As String = ""
    Public Preferencias(,) As String
    Public Seccion() As RegistroTOK = Nothing

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


    Function Get_Preferencia(ByRef Token As String) As String
        Get_Preferencia = COBISPreferencesAdmin.ReadINIPreference("PERSON", "PREFERENCIAS", Token)
    End Function

    Sub Iniciar_Preferencias(ByRef Filename As String)
        ReDim formato_fecha(3, 2)
        formato_fecha(1, 1) = "dd/mm/yyyy"
        formato_fecha(2, 1) = "mm/dd/yyyy"
        formato_fecha(3, 1) = "yyyy/mm/dd"
        formato_fecha(1, 2) = "103"
        formato_fecha(2, 2) = "101"
        formato_fecha(3, 2) = "111"
        ReDim Preferencias(10, 2)
        Preferencias(1, 1) = "FILIAL"
        Preferencias(2, 1) = "OFICINA"
        Preferencias(3, 1) = "ROL"
        Preferencias(4, 1) = "SERVIDOR"
        Preferencias(5, 1) = "TERMINAL"
        Preferencias(6, 1) = "USUARIO"
        Preferencias(7, 1) = "FORMATO-FECHA"
        Preferencias(8, 1) = "DEBUG"
        Preferencias(9, 1) = "ARCHIVO-LOG"
        Preferencias(10, 1) = "MONEDA"
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
                Preferencias(9, 2) = VGPath & "\logtran.txt" 'JCA
            End If
            Preferencias(10, 2) = Buscar_Token(FNum, "MONEDA")
            FileSystem.FileClose(FNum)
        End If
        'TBA 09/06/2016 Consulta de VGMoneda
        Dim VTAParametro(15) As String
        VTAParametro = CargaParametro("CMNAC", "ADM")
        VGMoneda = VTAParametro(5)
    End Sub

    ' Sub Set_Preferencia(ByRef Token As String, ByRef valor As String)
    '    For i As Integer = 1 To Preferencias.GetUpperBound(0)
    '        If Preferencias(i, 1) = Token Then
    '           Select Case Token
    '              Case "DEBUG"
    '                   If sqlconn > 0 Then
    '                       If valor = "S" Then
    '                           PMDebug(sqlconn, True)
    '                           VGDebug = True
    '                       Else
    '                           PMDebug(sqlconn, False)
    '                           VGDebug = False
    '                       End If
    '                  End If
    '              Case "MONEDA"
    '                  VGMoneda = valor
    '              Case "ARCHIVO-LOG"
    '                  VGLogTransacciones = valor
    '          End Select
    '          Preferencias(i, 2) = valor
    '      End If
    '  Next i
    ' End Sub

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

    Function CargaParametro(nemonico As String, producto As String) As String()
        Dim VLParametro(15) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, nemonico)
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, producto)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(1940)) Then
            FMMapeaArreglo(sqlconn, VLParametro)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
        Return VLParametro
    End Function

End Module


