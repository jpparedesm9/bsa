Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module modoffli
    Public VGOnline As Integer = 0
    Public VGSaip As String = ""

    Sub FMCerrarFormas()
        Application.DoEvents()
        SendKeys.Send("{Esc}")
        SendKeys.Send("{Esc}")
        Do While True
            ' If Form.ActiveForm.Text <> FPrincipal.Text Then
            Form.ActiveForm.Close()
            'Else
            Exit Do
            'End If
        Loop
    End Sub

    Function FMActivaMenuSaip(ByVal parStatus As Integer) As Integer
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(" Capturando transacciones SAIP...")
        'FPrincipal.mnuLogon.Enabled = False
        'FPrincipal.mnuLogoff.Enabled = True
        'FPrincipal.mnuPassword.Enabled = False
        'FPrincipal.mnuAhorros.Enabled = False
        'FPrincipal.mnuReCamara.Enabled = False
        'FPrincipal.mnuBloquear.Enabled = True
        'FPrincipal.mnuadmin.Enabled = False
    End Function

    Function FMActivaMenu(ByVal parStatus As Integer) As Integer
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(" Capturando transacciones...")
        'FPrincipal.mnuLogon.Enabled = False
        'FPrincipal.mnuLogoff.Enabled = True
        'FPrincipal.mnuPassword.Enabled = True
        'FPrincipal.mnuAhorros.Enabled = True
        'FPrincipal.mnuReCamara.Enabled = True
        'FPrincipal.mnuBloquear.Enabled = True
        'FPrincipal.mnuadmin.Enabled = True
        'PMMenuSeguridad(FPrincipal.mnuTranctaaho(4))
        'PMMenuSeguridad(FPrincipal.mnuTranctaaho(6))
        'PMMenuSeguridad(FPrincipal.mnuTranAho1(0))
        'PMMenuSeguridad(FPrincipal.mnuTranAho1(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho1(2))
        'PMMenuSeguridad(FPrincipal.mnuTranAho1(3))
        'PMMenuSeguridad(FPrincipal.mnuTranAho2(0))
        'PMMenuSeguridad(FPrincipal.mnuTranAho2(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho3(0))
        'PMMenuSeguridad(FPrincipal.mnuTranAho3(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho6(0))
        'PMMenuSeguridad(FPrincipal.mnuTranAho6(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(0))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(2))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(3))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(5))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(6))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(7))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(8))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(9))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(14))
        'PMMenuSeguridad(FPrincipal.mnuTranAho7(15))
        'PMMenuSeguridad(FPrincipal.mnuTranAho8(1))
        'PMMenuSeguridad(FPrincipal.mnuTranAho8(2))
        'For i As Integer = 0 To 4
        '    PMMenuSeguridad(FPrincipal.mnuTranRemesas(i))
        'Next i
        'PMMenuSeguridad(FPrincipal.mnuAdmin0(0))
        'PMMenuSeguridad(FPrincipal.mnuAdmin0(1))
        'PMMenuSeguridad(FPrincipal.mnuAdmin0(6))
        'PMMenuSeguridad(FPrincipal.mnuAdmin3(7))
        'PMMenuSeguridad(FPrincipal.mnuAdmin3(8))
        'PMMenuSeguridad(FPrincipal.mnuadmin4(8))
        'PMMenuSeguridad(FPrincipal.mnuAdmin5(9))
        'PMMenuSeguridad(FPrincipal.mnuadmin6(10))
        'PMMenuSeguridad(FPrincipal.mnuadmin6(11))
        'If VGSaip = "S" Then
        '    PMMenuSeguridad(FPrincipal.mnuAdmin7(2))
        'Else
        '    FPrincipal.mnuAdmin7(1).Available = False
        '    FPrincipal.mnuAdmin7(2).Available = False
        'End If
        'PMMenuSeguridad(FPrincipal.mnuAdmin0(1))
        'PMMenuSeguridad(FPrincipal.mnuTotales(0))
        'PMMenuSeguridad(FPrincipal.mnuTotales(1))
        'PMMenuSeguridad(FPrincipal.mnuTotales(2))
        'PMMenuSeguridad(FPrincipal.mnuTotales(3))
        'PMMenuSeguridad(FPrincipal.mnuTotales(4))
        'PMMenuSeguridad(FPrincipal.mnuMtoEquiv)
        Return True
    End Function

    Function FMGetMail(ByVal parServer As String) As Integer
        Dim VTArreglo1(20) As String
        Dim VTarreglo2(50) As String
        If FMTransmitirRPC(sqlconn, parServer, "cobis", "sp_mail", False, "") Then
            FMMapeaArreglo(sqlconn, VTArreglo1)
            FMMapeaArreglo(sqlconn, VTarreglo2)
            PMChequea(sqlconn)
            If VTArreglo1(1).Trim() <> "N" Then
                If VTarreglo2(1).Trim() = "I" Then
                    If VTarreglo2(2).Trim() = "[L:]0" Then
                        If VGOnline Then
                            COBISMessageBox.Show(FMLoadResString(509193), My.Application.Info.ProductName)
                            VGOnline = False
                            FMCerrarFormas()
                            FMActivaMenuSaip(True)
                            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(509194))
                        End If
                        Exit Function
                    End If
                    If VTarreglo2(2).Trim() = "[L:]1" Then
                        COBISMessageBox.Show(FMLoadResString(509195), My.Application.Info.ProductName)
                        FMCerrarFormas()
                        FMActivaMenu(False)
                        If Not VGOnline And VGSaip = "S" Then
                            Select Case FMRecLogin(ServerName)
                                Case True
                                    VGOnline = True
                                Case Else
                                    VGOnline = False
                                    COBISMessageBox.Show(FMLoadResString(509196), FMLoadResString(501312), COBISMessageBox.COBISButtons.OK)
                                    PMLogOff()
                                    Exit Function
                            End Select
                        End If
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(509197))
                        Exit Function
                    End If
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Function

    Function FMRecLogin(ByVal parServer As String) As Integer
        Dim VTMensaje As String = ""
        Dim VGTerminal As String = ""
        Dim VTTemporal As Integer = 0
        PMPasoValores(sqlconn, "@i_server", 0, SQLVARCHAR, ServerNameLocal)
        PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, VGLogin)
        PMPasoValores(sqlconn, "@i_terminal", 0, SQLVARCHAR, VGTerminal)
        PMPasoValores(sqlconn, "@i_office", 0, SQLINT4, VGOficina)
        PMPasoValores(sqlconn, "@i_role", 0, SQLINT1, VGRol)
        PMPasoValores(sqlconn, "@i_campwd", 0, SQLINT1, "1")
        PMPasoValores(sqlconn, "@o_campwd", 1, SQLINT1, "")
        If FMTransmitirRPC(sqlconn, parServer, "master", "sp_reclogin", False, FMLoadResString(509198) & VGLogin & FMLoadResString(509199)) Then
            PMMapeaVariable(sqlconn, VTMensaje)
            PMChequea(sqlconn)
            COBISMessageBox.Show(VTMensaje, My.Application.Info.ProductName)
            VTTemporal = CInt(FMRetParam(sqlconn, 1))
            If VTTemporal = StringsHelper.ToDoubleSafe("1") Then
                'FGenerales.Visible = False
                PMCambioPassword(sqlconn, ServerName, ServerNameLocal, VGLogin, CInt(VGFilial), CInt(VGOficina))
                PMLogOff()
                Exit Function
            End If
            Return True
        Else
            PMChequea(sqlconn)
            Return False
        End If
    End Function

    Function FMGetServer() As String
        If VGOnline Then
            Return ServerName
        Else
            Return ServerNameLocal
        End If
    End Function
End Module


