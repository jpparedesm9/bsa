Option Strict Off
Option Explicit On
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
public Module MCOMMON
    Public VGResourceManager As String = "RECResourceManager" 'COBISMigrator: Coincide con Enteprise Library
    Private flagStarted As Boolean = False
    Dim WithEvents UserInfo As COBISCorp.eCOBIS.COBISExplorer.Commons.DTO.COBISUserInfo

    Public Sub Disconnect(ByVal sender As Object, ByVal e As EventArgs) Handles UserInfo.Disconnected
        flagStarted = False
        RemoveHandler UserInfo.Disconnected, AddressOf Disconnect
    End Sub
    Public Sub MCOMMONLoad()
        If Not flagStarted Then
            PLInitModule(0)
            flagStarted = True
            AddHandler UserInfo.Disconnected, AddressOf Disconnect
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

    Public Const SC_SCREENSAVE As Integer = &HF140
    Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer

    Public Sub PMBloquearPantalla(ByVal parHwd As Integer)
        PostMessage(parHwd, WM_SYSCOMMAND, SC_SCREENSAVE, 0)
    End Sub

    Function PLInitModule(ByVal PStep As Integer) As Boolean
        Dim VTArreglo(10) As String
        Dim VTMoneda(2, 150) As String 'JSA       
        'Dim VTMoneda() As String = Nothing        
        VGMap = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.MAPN()
        sqlconn = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.SQLConn()
        'VGTransacciones = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizedTransactions()
        VGFilial = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Filial
        VGOficina = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Office
        VGRol = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Role
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
        Dim serverName As String = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizationServers(0).Name

        VGPathResouces = (GetType(MCOMMON)).Assembly.Location()
        VGPathResouces = VGPathResouces.Substring(0, VGPathResouces.LastIndexOf("\")) & "\Resource\"
        VGPath = VGPathResouces

        Dim Valores(20) As String

        PLInitModule = True

        If PStep = -1 Or PStep = 0 Then
            'ARCHIVOINI = VGPathResouces & "\CTA.ini"
            'VGLogTransacciones = VGPathResouces & "\LogTran.txt"
            VGProducto = ""
            VGCorreo = False
            VGTIMERMAIL = 5000
            VGTeclaAyuda = 116
            'Iniciar_Preferencias(ARCHIVOINI)
            VGPath = VGPathResouces
            If VGFormatoFecha = "" Then
                VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
                PMCargar_FechaSP(VGFormatoFecha)
            End If
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


            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_funcionario", False, "") Then 'JSA 01102012 INC13140
                FMMapeaArreglo(sqlconn, Valores)
                PMChequea(sqlconn)
                '  PMEmpresa()
                VGUsuario = Valores(1)
                VGUsuarioNombre = Valores(2)
                PLInitModule = True
            Else
                PMChequea(sqlconn)
                PLInitModule = False
            End If
        End If

        If PStep = 2 Or PStep = 0 Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15168")
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFormatoFechaInt) 'VGFecha_SP)
            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_fechapro", True, FMLoadResString(509167)) Then
                PMMapeaVariable(sqlconn, VGFechaProceso)
                PMChequea(sqlconn)
                PLInitModule = True
            Else
                PMChequea(sqlconn)
                PLInitModule = False
            End If

        End If
        FMSeguridad()
        cmbMoneda()
        'PLDatosContabilidad()
    End Function
    Sub cmbMoneda()
        Dim VTArreglo(10) As String
        Dim VTR1 As Integer
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "78")
        PMPasoValores(sqlconn, "@i_prod", 0, SQLVARCHAR, "CTE")
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        If FMTransmitirRPC(sqlconn, "", "cobis", "sp_cons_param_inicio", False, "") Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            If VTR1% <> 0 Then
                If VTArreglo(5) = "N" Then
                    VGDecimales$ = "#,##0"
                Else
                    VGDecimales$ = "#,##0.00"
                End If
                VGCtaGerencia = VTArreglo(8)
            Else
                COBISMessageBox.Show(FMLoadResString(9106), 0 + 16, FMLoadResString(500989))
                PMLogOff()
                Exit Sub
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(9106), 0 + 16, FMLoadResString(500989))
            PMLogOff()
            Exit Sub
        End If

    End Sub

    Private Sub PMDireccionPath()
        Try
            PathUnico = "" 'cp.CreaDirectorios(My.Application.Info.DirectoryPath, My.Application.Info.AssemblyName, "TADMIN.INI")
            If PathUnico = "" Then
                PathUnico = My.Application.Info.DirectoryPath
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show("Error: " & excep.Message, FMLoadResString(9974))
            PathUnico = My.Application.Info.DirectoryPath
        End Try
    End Sub

    Private Sub PLDatosContabilidad()
        Dim VTMoneda As String = ""
        Dim VTNombre As String = ""
        Dim VTNiveles(30) As String
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6030")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
        PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, VGFilial)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, FMLoadResString(509254)) Then
            PMMapeaVariable(sqlconn, VTNombre)
            FMMapeaArreglo(sqlconn, VTNiveles)
            PMMapeaVariable(sqlconn, VGMascaraConta)
            PMMapeaVariable(sqlconn, VTMoneda)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Function FLAbrirArchivo(ByRef Filename As String) As Integer
        Try
            Dim VTFNum As Integer = 0
            VTFNum = FileSystem.FreeFile()
            FileSystem.FileOpen(VTFNum, Filename, OpenMode.Input)
            Return VTFNum
        Catch
            Return 0
        End Try
    End Function

End Module


