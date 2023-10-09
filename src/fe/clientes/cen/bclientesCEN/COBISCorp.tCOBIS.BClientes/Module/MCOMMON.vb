Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.eCOBIS.COBISExplorer.Preferences

Public Module MCOMMON
    Public VGResourceManager As String = "BCLIResourceManager" 'COBISMigrator: Coincide con Enteprise Library
    Private flagStarted As Boolean = False
    Public ARCHIVOINI As String = ""
    Public Preferencias(,) As String
    '  Public Seccion() As RegistroTOK = Nothing

    Public Sub MCOMMONLoad()
        If Not flagStarted Then
            PLInitModule(0)
            flagStarted = True
        End If
    End Sub
    Public Const WM_SYSCOMMAND As Integer = &H112S
    Public Const SC_SCREENSAVE As Integer = &HF140
    Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer

    'Public Sub PMBloquearPantalla(ByVal parHwd As Integer)
    '    PostMessage(parHwd, WM_SYSCOMMAND, SC_SCREENSAVE, 0)
    'End Sub

    Public Function FMInitMap(ByRef parHelpLine As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parTrnLine As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoL As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoT As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoR As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parFocoP As COBISCorp.Framework.UI.Components.COBISPanel, ByRef parLogFile As String) As Integer
        Dim VTHelpLine As COBISCorp.Framework.UI.Components.COBISPanel = parHelpLine
        Dim VTTrnLine As COBISCorp.Framework.UI.Components.COBISPanel = parTrnLine
        Dim VTFocoL As COBISCorp.Framework.UI.Components.COBISPanel = parFocoL
        Dim VTFocoT As COBISCorp.Framework.UI.Components.COBISPanel = parFocoT
        Dim VTFocoR As COBISCorp.Framework.UI.Components.COBISPanel = parFocoR
        Dim VTFocoP As COBISCorp.Framework.UI.Components.COBISPanel = parFocoP
        Return VGMap.FMInitMap32(VTHelpLine, VTTrnLine, VTFocoL, VTFocoT, VTFocoR, VTFocoP, parLogFile)
    End Function

    Function PLInitModule(ByVal PStep As Integer) As Boolean
        VGMap = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.MAPN()
        SqlConn = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.SQLConn()
        VGTransacciones = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizedTransactions()

        VGFilial = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Filial
        VGOficina = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Office
        VGrol = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Role
        VGLogin = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Identity.Name

        Dim CENPref As eCOBIS.COBISExplorer.Preferences.COBISExplorerPreferences = eCOBIS.COBISExplorer.Preferences.COBISPreferencesAdmin.GetPreference(GetType(eCOBIS.COBISExplorer.Preferences.COBISExplorerPreferences))
        Dim CENCultura As eCOBIS.COBISExplorer.Preferences.General.COBISGeneralSection = CENPref.Sections("General")

        VGFormatoFecha = CENCultura.CultureSection.FormatoFecha.ToLower

        VGFormatoFechaStr = CENCultura.CultureSection.FormatoFecha

        Select Case VGFormatoFechaStr.ToLower
            Case "dd/mm/yyyy"
                VGFormatoFechaInt = 103
            Case "mm/dd/yyyy"
                VGFormatoFechaInt = 101
            Case "yyyy/mm/dd"
                VGFormatoFechaInt = 111
            Case "dd-mm-yyyy"
                VGFormatoFechaInt = 105
        End Select


        Dim terminal As String = COBISCorp.eCOBIS.COBISExplorer.SharedObjectManager.SharedObjectManager.UserInfo.Terminal

        Dim serverName As String = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizationServers(0).Name

        VGPathResouces = (GetType(MCOMMON)).Assembly.Location()
        VGPathResouces = VGPathResouces.Substring(0, VGPathResouces.LastIndexOf("\")) & "\Resource\"

        Dim Valores(20) As String

        Dim VTR As Integer

        PLInitModule = True

        If PStep = -1 Or PStep = 0 Then
            ARCHIVOINI = VGPathResouces & "BCLI.ini"
            VGLogTransacciones = VGPathResouces & "\LogTran.txt"
            VGProducto = ""
            VGCorreo = False
            VGTIMERMAIL = 5000
            VGTeclaAyuda = 116
            Iniciar_Preferencias(ARCHIVOINI)
            VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
            PMCargar_FechaSP(VGFormatoFecha)

            ServerNameLocal = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizationServers(0).Name 'JSA 01102012 INC13140
            VGLogin = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Identity.Name
            serverName = ""
            Password = ""
            VGUsuario = ""
            VGUsuarioNombre = ""
        End If

        If PStep = 1 Or PStep = 0 Then
            PMPasoValores(SqlConn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "1577")
            PMPasoValores(SqlConn, "@i_tipo", 0, SQLCHAR, "L")
            PMPasoValores(SqlConn, "@i_login", 0, SQLVARCHAR, VGLogin)

            ReDim Valores(2)
            If FMTransmitirRPC(SqlConn, serverName, "cobis", "sp_funcionario", False, "") Then 'JSA 01102012 INC13140
                VTR = FMMapeaArreglo(SqlConn, Valores)
                PMChequea(SqlConn)
                '  PMEmpresa()
                VGUsuario = Valores(1)
                VGUsuarioNombre = Valores(2)
                PLInitModule = True
            Else
                PLInitModule = False
            End If
        End If

        If PStep = 2 Or PStep = 0 Then
            PMPasoValores(SqlConn, "@t_trn", 0, SQLINT2, "15168")
            PMPasoValores(SqlConn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(SqlConn, serverName, "cobis", "sp_fechapro", True, " Ok ... Consulta Fecha de proceso") Then
                PMMapeaVariable(SqlConn, VGFechaProceso)
                PMChequea(SqlConn)
                PLInitModule = True
            Else
                PLInitModule = False
            End If

        End If

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
                Preferencias(9, 2) = VGPath & "\logtran.txt"
            End If
            Preferencias(10, 2) = Buscar_Token(FNum, "MONEDA")
            FileSystem.FileClose(FNum)
        End If
    End Sub


    Function Get_Preferencia(ByRef Token As String) As String
        Get_Preferencia = COBISPreferencesAdmin.ReadINIPreference("BCLI", " PREFERENCIAS", Token)
    End Function

    Sub PMCargar_FechaSP(ByRef Formato As String)
        Dim VGFecha_Pref As String = ""
        For i As Integer = 1 To formato_fecha.GetUpperBound(0)
            If formato_fecha(i, 1) = Formato Then
                VGFecha_SP = formato_fecha(i, 2)
                VGFecha_Pref = Formato
            End If
        Next
    End Sub

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

End Module

