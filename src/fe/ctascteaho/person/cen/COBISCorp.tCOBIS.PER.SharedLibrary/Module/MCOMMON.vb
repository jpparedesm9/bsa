Option Strict Off
Option Explicit On
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MCOMMON
    Public VGResourceManager As String = "PERResourceManager" 'COBISMigrator: Coincide con Enteprise Library
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

    'Public VGEmpresa As Empresa = Empresa.CreateInstance()
    Public Const SC_SCREENSAVE As Integer = &HF140
    Public Declare Function PostMessage Lib "user32" Alias "PostMessageA" (ByVal hwnd As Integer, ByVal wMsg As Integer, ByVal wParam As Integer, ByVal lParam As Integer) As Integer

    Function PLInitModule(ByVal PStep As Integer) As Boolean
        Dim VTMonto As Integer
        VGMap = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.MAPN()
        sqlconn = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.SQLConn()
        VGTransacciones = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.AuthorizedTransactions()

        VGFilial = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Filial
        VGOficina = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Office
        VGRol = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Role
        VGLogin = COBISCorp.eCOBIS.Commons.Security.Context.tCOBISContext.Principal.Identity.Name

        Dim CENPref As eCOBIS.COBISExplorer.Preferences.COBISExplorerPreferences = eCOBIS.COBISExplorer.Preferences.COBISPreferencesAdmin.GetPreference(GetType(eCOBIS.COBISExplorer.Preferences.COBISExplorerPreferences))
        Dim CENCultura As eCOBIS.COBISExplorer.Preferences.General.COBISGeneralSection = CENPref.Sections(FMLoadResString(1941))

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
        VGProducto = "PERSON"
        Dim Valores(20) As String

        Dim VTR1 As Integer
        Dim VTArreglo(20) As String
        PLInitModule = True

        If PStep = -1 Or PStep = 0 Then
            ARCHIVOINI = VGPathResouces & "\PERSON.ini"
            VGLogTransacciones = VGPathResouces & "\LogTran.txt"
            VGProducto = ""
            VGCorreo = False
            VGTIMERMAIL = 5000
            VGTeclaAyuda = 116
            Iniciar_Preferencias(ARCHIVOINI)
            'VGFormatoFecha = Get_Preferencia("FORMATO-FECHA")
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
            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_funcionario", False, FMLoadResString(1942)) Then 'JSA 01102012 INC13140
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
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, serverName, "cobis", "sp_fechapro", True, FMLoadResString(1535)) Then
                PMMapeaVariable(sqlconn, VGFechaProceso)
                PMChequea(sqlconn)
                PLInitModule = True
            Else
                PMChequea(sqlconn)
                PLInitModule = False
            End If


        End If

        Dim VTMoneda(2, 150) As String

        If PStep = 3 Or PStep = 0 Then

            ' Carga de parámetros iniciales para cuentas corrientes
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "78")
            PMPasoValores(sqlconn, "@i_prod", 0, SQLVARCHAR, "CTE")
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)

            If FMTransmitirRPC(sqlconn, "", "cobis", "sp_cons_param_inicio", False, "") Then
                ReDim VTArreglo(11)
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                If VTR1 <> 0 Then
                    VGLongCtaCte = Val(VTArreglo(1))
                    VGPesosCtaCte = VTArreglo(2)
                    VGModuloCtaCte = Val(VTArreglo(3))
                    VGMascaraCtaCte = VTArreglo(4)
                    If VTArreglo(5) = "N" Then
                        VGDecimales = "#,##0"
                    Else
                        VGDecimales = "#,##0.00"
                    End If
                    VGNivelMaximo = VTArreglo(6)
                    VGNumGCtaCte = Val(VTArreglo(7))
                    VGCtaGerencia = VTArreglo(8)
                    VGFecha = VTArreglo(9)
                    VGCodBanco = VTArreglo(10)
                    '  Pone VGfecha en formato de preferencias
                    VGFecha = FMConvFecha((VTArreglo(9)), CGFormatoBase, VGFormatoFecha$)
                    VTMonto = VTArreglo(11)
                    If IsNumeric(VTMonto) Then
                        VGMontoVerCheque@ = CDec(VTMonto)
                    End If
                Else
                    MsgBox(FMLoadResString(9106), 0 + 16, FMLoadResString(501312))
                    PMLogOff()
                    Exit Function
                End If
            Else
                PMChequea(sqlconn)
                MsgBox(FMLoadResString(9106), 0 + 16, FMLoadResString(501312))
                PMLogOff()
                Exit Function
            End If
            '--
            ' Carga de parámetros iniciales para cuentas de ahorros
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "78")
            PMPasoValores(sqlconn, "@i_prod", 0, SQLVARCHAR, "AHO")
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            If FMTransmitirRPC(sqlconn, "", "cobis", "sp_cons_param_inicio", False, "") Then
                'ReDim VGPrefijo_cta(3, 300) As String  'lgra (3,100)
                VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
                FMMapeaMatriz(sqlconn, VTMoneda) 'JSA
                'VGMaxPrefijos = FMMapeaMatriz(sqlconn, VGPrefijo_cta())
                PMMapeaVariable(sqlconn, VGCteAbanks)
                PMMapeaVariable(sqlconn, VGCodPais)
                PMMapeaVariable(sqlconn, VGManejaNdNc)
                PMMapeaVariable(sqlconn, VGLineaPend)
                PMChequea(sqlconn)
                If VTR1 <> 0 Then
                    VGLongCtaAho = Val(VTArreglo(1))
                    VGPesosCtaAho = VTArreglo(2)
                    VGModuloCtaAho = Val(VTArreglo(3))
                    VGMascaraCtaAho = VTArreglo(4)
                    If VTArreglo(5) = "N" Then 'JSA
                        VGDecimales = "#,##0"
                    Else
                        VGDecimales = "#,##0.00"
                    End If
                    VGNumGCtaAho = Val(VTArreglo(7))
                    VGFecha = VTArreglo(9) 'JSA
                    'Pone VGfecha en formato de preferencias
                    VGFecha = FMConvFecha((VTArreglo(9)), CGFormatoBase, VGFormatoFecha) 'JSA
                Else
                    MsgBox(FMLoadResString(509168), 0 + 16, FMLoadResString(1472))
                    PMLogOff()
                    ''Unload Me
                    Exit Function
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "78")
                PMPasoValores(sqlconn, "@i_prod", 0, SQLVARCHAR, "AHO")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_consulta", 0, SQLVARCHAR, "S")
                If FMTransmitirRPC(sqlconn, "", "cobis", "sp_cons_param_inicio", False, "") Then
                    ReDim VGPrefijo_cta(3, 2000)
                    VGMaxPrefijos = FMMapeaMatriz(sqlconn, VGPrefijo_cta)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    MsgBox(FMLoadResString(509168), 0 + 16, FMLoadResString(1472))
                    PMLogOff()
                    Exit Function
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If

    End Function

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

