Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports System.Windows.Forms

Public Module MCOMMON
    Public VGResourceManager As String = "CONTAMXResourceManager" 'COBISMigrator: Coincide con Enteprise Library
    Private flagStarted As Boolean = False
    Public VGPathResouces As String
    Dim VGLogTransacciones As String = ""
    Public Sub MCOMMONLoad()
        If Not flagStarted Then
            PLInitModule(0)
            flagStarted = True
        End If
    End Sub
    Public Const WM_SYSCOMMAND As Integer = &H112S
    Public Structure Empresa
        Dim Codigo As String
        Dim nombre As String
        Dim Mascara As String
        Dim Sinonimo As String
        Dim Moneda As String
        Public Shared Function CreateInstance() As Empresa
            Dim result As New Empresa
            result.Codigo = String.Empty
            result.nombre = String.Empty
            result.Mascara = String.Empty
            result.Sinonimo = String.Empty
            result.Moneda = String.Empty
            Return result
        End Function
    End Structure

    'Public VGEmpresa As Empresa = Empresa.CreateInstance()
    Public Const SC_SCREENSAVE As Integer = &HF140
    Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer

    Public Sub PMBloquearPantalla(ByVal parHwd As Integer)
        Dim PostMessage(,,,) As Object
        Dim tempAuxVar As Object = PostMessage(parHwd, WM_SYSCOMMAND, SC_SCREENSAVE, 0)
    End Sub

    Function PLInitModule(ByVal PStep As Integer) As Boolean
        VGMap = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.MAPN()
        sqlconn = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.SQLConn()
        VGTransacciones = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizedTransactions()

        VGFilial = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Filial
        VGOficina = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Office
        VGRol = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Role
        VGLogin = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Identity.Name
        LoginID = VGLogin

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
        VGPathResouces = VGPathResouces.Substring(0, VGPathResouces.LastIndexOf("\")) & "\Resources\"

        Dim VTR As Integer

        PLInitModule = True

        If PStep = -1 Or PStep = 0 Then
            ARCHIVOINI = VGPathResouces & "\conta.ini"
            VGLogTransacciones = VGPathResouces & "\LogTran.txt"
            VGProducto = "SUP"
            VGCorreo = False
            VGTIMERMAIL = 5000
            VGTeclaAyuda = 116
            Iniciar_Preferencias(ARCHIVOINI)
            'VGFormatoFecha = VGFormatoFecha
            PMCargar_FechaSP(VGFormatoFecha)

            ServerNameLocal = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizationServers(0).Name 'JSA 01102012 INC13140
            VGLogin = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Identity.Name
            serverName = ""
            Password = ""
            VGUsuario = ""
            VGUsuarioNombre = ""
        End If

        If PStep = 1 Or PStep = 0 Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1577")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "L")
            PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, VGLogin)

            ReDim Valores(2)
            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_funcionario", False, "") Then 'JSA 01102012 INC13140
                VTR = FMMapeaArreglo(sqlconn, Valores)
                PMChequea(sqlconn)
                PMEmpresa()
                VGUsuario = Valores(1)
                VGUsuarioNombre = Valores(2)
                PLInitModule = True
            Else
                PLInitModule = False
            End If
        End If

        If PStep = 2 Or PStep = 0 Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15168")
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_fechapro", True, " Ok ... Consulta Fecha de proceso") Then
                PMMapeaVariable(sqlconn, VGFechaProceso)
                PMChequea(sqlconn)
                PLInitModule = True
            Else
                PLInitModule = False
            End If
        End If
    End Function
End Module


