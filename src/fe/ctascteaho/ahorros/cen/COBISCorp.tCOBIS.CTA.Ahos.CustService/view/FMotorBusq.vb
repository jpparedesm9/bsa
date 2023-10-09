Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.QueryMovements
Imports COBISCorp.tCOBIS.CTA.Ahos.Query
Imports COBISCorp.tCOBIS.CTA.Ahos.QueryBalances
Imports COBISCorp.tCOBIS.CTA.Ahos.BackOfficeProcesses
Imports COBISCorp.tCOBIS.CTA.Ahos.Correspondents
Imports COBISCorp.tCOBIS.CTA.Ahos.AccountsAdmCatalogs

Partial Public Class FMotorBusqClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Const F5 As Integer = 116
    Dim VLProdbanc As String = ""
    Dim VLCategoria As String = ""
    Dim VLTipoEnte As String = ""
    Dim VLNumDoc As String = ""
    Dim VLTitularidad As String = ""
    Dim VLTipoTran As String = ""
    Dim VLProdBancBloq As String = ""
    Dim VLCliente As String = ""

    Dim VTFila As Integer = 0
    Public VLArgument As String = ""
    Dim VLTieneCtasMig As String 'Variable para almacenar el parametro que indica si el sistema tiene ctas. migradas

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_5.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Me.TSBotones.Focus()

        Select Case Index
            Case 0
                PLBuscar(False)
            Case 1
                PLBuscar(True)
            Case 5
                PLEscoger()
            Case 2
                PLLimpiar()
            Case 4
                Me.Dispose()
                Me.Close()
        End Select
    End Sub

    Private Sub FMotorBusq_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        VLArgument = Me.GetPageArgumentsByName("OP")

        If VLTieneCtasMig = "S" Then
            'Si el sistema tiene cuentas migradas (parametro CTAMIG), se visualiza el filtro de cuenta migrada 
            Label2.Left = 468 : Label2.Top = 27
            txtCliente.Left = 526 : txtCliente.Top = 24
            mskCuentaMig.Visible = True
            lblCtaMig.Visible = True
        Else
            'Ocultar filtro de cuenta migrada 
            mskCuentaMig.Visible = False
            lblCtaMig.Visible = False
            Label2.Left = 219 : Label2.Top = 27
            txtCliente.Left = 286 : txtCliente.Top = 24
        End If
    End Sub

    Public Sub PLInicializar()
        VGCB = False
        mskCuenta.Mask = VGMascaraCtaAho

        'Obtener el parametro que indica si el sistema tiene cuentas migradas
        CargaParametros(1579, "Q", 3, "AHO", "CTAMIG", 3)
        VLTieneCtasMig = IIf(VGOcucol = "", "N", VGOcucol)
    End Sub

    Private Sub FMotorBusq_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        VGCB = True
    End Sub

    Private Sub grdCuentas_ClickEvent(sender As Object, e As EventArgs) Handles grdCuentas.ClickEvent
        PMLineaG(grdCuentas)
        PMMarcaFilaCobisGrid(grdCuentas, grdCuentas.Row)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509033)) 'Listado de Cuentas
    End Sub

    Private Sub grdCuentas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCuentas.DblClick
        PMMarcaFilaCobisGrid(grdCuentas, grdCuentas.Row)
        PLEscoger()
    End Sub

    Private Sub txtCliente_Change(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCliente.Change
        Me.PLLimpiarDatos()
    End Sub

    Private Sub txtCliente_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles txtCliente.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode <> F5 Then
            Exit Sub
        End If
        txtCliente.Text = ""
        'DLL CLIENTES
        VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        Dim FBuscarCliente = New COBISCorp.tCOBIS.BClientes.FBuscarClienteClass()
        VGFBusCliente = New COBISCorp.tCOBIS.BClientes.BuscarClientes()
        FBuscarCliente.optCliente(1).Enabled = True
        FBuscarCliente.optCliente(0).Checked = True
        FBuscarCliente.ShowPopup(Me)
        FBuscarCliente.optCliente(1).Enabled = True
        VGBusqueda = VGFBusCliente.PMRetornaCliente()
        txtCliente.Text = VGBusqueda(1)
        PMChequea(sqlconn)
    End Sub

    Private Sub PLBuscar(ByRef VTAnadir As Integer)
        If txtCliente.Text = "" And mskCuenta.ClipText = "" And mskCuentaMig.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508754), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) ' " Debe ingresar al menos una de las 2 condiciones"
            mskCuenta.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_ctaint", 0, SQLINT2, "0")
        If VTAnadir Then
            grdCuentas.Col = 1
            VTFila = grdCuentas.Row
            grdCuentas.Row = 1
            If grdCuentas.Rows <= 2 And grdCuentas.CtlText = "" Then
                Exit Sub
            End If
            grdCuentas.Row = VTFila
            grdCuentas.Row = grdCuentas.Rows - 1
            grdCuentas.Col = 12
            PMPasoValores(sqlconn, "@i_ctaint", 0, SQLINT2, grdCuentas.CtlText)
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
        PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, txtCliente.Text)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_cta_mig", 0, SQLVARCHAR, mskCuentaMig.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, Convert.ToString(Me.Tag))
        If VLArgument = "Reactivacion_de_Cuentas" Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
        End If
        If VLArgument = "Reapertura_de_Cuentas" Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "C")
        End If
        If VLArgument = "Activacion_de_Cuentas_con_Autorizacion" Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "G")
        End If
        If VLArgument = "Liberacion_de_Cupo_Corresponsal" Or
            VLArgument = "Cancelacion_CuentaCB" Then
            PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
            PMMapeaGrid(sqlconn, grdCuentas, VTAnadir)
            PMMapeaTextoGrid(grdCuentas)
            PMAnchoColumnasGrid(grdCuentas)
            PMChequea(sqlconn)
            cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdCuentas.Tag)) = 20
        Else
            PMChequea(sqlconn)
            txtCliente.Text = ""
            mskCuentaMig.Text = ""
            mskCuenta.Mask = VGMascaraCtaAho
            mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
            mskCuenta.Focus()
        End If
        grdCuentas.Row = 1
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502827)) 'Busqueda de Registros
    End Sub

    Private Sub PLEscoger()
        Dim VLEstado As String = String.Empty
        Dim VTR As Integer = 0
        Dim VTArreglo() As String = Nothing

        grdCuentas.Col = 1
        VTFila = grdCuentas.Row
        grdCuentas.Row = 1
        If grdCuentas.Rows <= 2 And grdCuentas.CtlText = "" Then
            Exit Sub
        End If
        grdCuentas.Row = VTFila

        Select Case VLArgument
            Case "Bloqueo_de_Movimientos"
                FTran211.Close()
                grdCuentas.Col = 1
                FTran211.mskCuenta.Mask = VGMascaraCtaAho
                FTran211.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran211.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Bloqueo_de_Valor_a_ctas_aho"
                FTran217.Close()
                grdCuentas.Col = 1
                FTran217.mskCuenta.Mask = VGMascaraCtaAho
                FTran217.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                grdCuentas.Col = 9
                VLClienteb = grdCuentas.CtlText


                FTran217.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Desbloqueo_de_Movimientos"
                FTran212.Close()
                grdCuentas.Col = 1
                FTran212.mskCuenta.Mask = VGMascaraCtaAho
                FTran212.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran212.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Desbloqueo_de_valor_en_cta"
                FTran218.Close()
                grdCuentas.Col = 1
                FTran218.mskCuenta.Mask = VGMascaraCtaAho
                FTran218.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran218.Text = FMLoadResString(509513)
                FTran218.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Reactivacion_de_Cuentas"
                FTran203.Close()
                grdCuentas.Col = 1
                VGCuenta = grdCuentas.CtlText
                grdCuentas.Col = 16
                VLEstado = grdCuentas.CtlText
                grdCuentas.Col = 6
                VLCliente = grdCuentas.CtlText
                If VLEstado = "P" Then
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, VLCliente)
                    PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "N")
                    grdCuentas.Col = 11
                    PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, grdCuentas.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                        ReDim VTArreglo(20)
                        FMMapeaArreglo(sqlconn, VTArreglo)
                        VLTitularidad = "I"
                        PMChequea(sqlconn)
                        VTR = grdCuentas.Rows - 1
                        For i As Integer = 1 To VTR
                            VGTipoDoc = ""
                            VLNumDoc = ""
                            VLTipoTran = ""
                            grdCuentas.Row = i
                            VLTipoTran = "203"
                            grdCuentas.Col = 7
                            VGTipoDoc = grdCuentas.CtlText
                            grdCuentas.Col = 8
                            VLNumDoc = grdCuentas.CtlText
                            VLTipoTran = "203"
                            FMRegistraHuellaAValidar(VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran)
                        Next i
                        VLTipoTran = "203"
                        FMVerificaHuella(VGCuenta, VLTipoTran)
                        If VGRegistraHuellaAValidar Then
                            grdCuentas.Col = 1
                            FTran203.mskCuenta.Mask = VGMascaraCtaAho
                            FTran203.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                            FTran203.Show(Me)
                            SendKeys.Send("{TAB}")
                        Else
                            Exit Sub
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Else
                    PMChequea(sqlconn)
                    grdCuentas.Col = 1
                    FTran203.mskCuenta.Mask = VGMascaraCtaAho
                    FTran203.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                    FTran203.Show(Me)
                    SendKeys.Send("{TAB}")
                End If
            Case "Cancelacion_CuentaCB"
                FTran214.Close()
                grdCuentas.Col = 1
                VGCB = True
                FTran214.Text = "CB"
                FTran214.mskCuenta.Mask = VGMascaraCtaAho
                FTran214.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran214.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Consulta_BloqueoValores_En_Las_Cuentas"
                FTran216.Close()
                grdCuentas.Col = 1
                FTran216.mskCuenta.Mask = VGMascaraCtaAho
                FTran216.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran216.mskCuenta.Enabled = False
                FTran216.Show(Me)
            Case "Consulta_de_Bloqueo_de_Movimientos"
                FTran245.Close()
                grdCuentas.Col = 1
                FTran245.mskCuenta.Mask = VGMascaraCtaAho
                FTran245.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran245.mskCuenta.Enabled = False
                FTran245.Show(Me)
            Case "Consulta_de_Saldos_y_Promedios"
                Ftran220.Close()
                grdCuentas.Col = 1
                Ftran220.mskCuenta.Mask = VGMascaraCtaAho
                Ftran220.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                Ftran220.mskCuenta.Enabled = False
                Ftran220.Show(Me)
            Case "Consulta_General"
                FTran235.Close()
                grdCuentas.Col = 1
                FTran235.mskCuenta.Mask = VGMascaraCtaAho
                FTran235.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran235.mskCuenta.Enabled = False
                FTran235.Show(Me)
            Case "Consulta_de_Movimientos"
                FTran232.Close()
                grdCuentas.Col = 1
                FTran232.mskCuenta.Mask = VGMascaraCtaAho
                FTran232.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran232.mskCuenta.Enabled = False
                FTran232.Show(Me)
            Case "Consulta_de_Valores_en_Suspenso"
                FTran247.Close()
                grdCuentas.Col = 1
                FTran247.mskCuenta.Text = grdCuentas.CtlText
                FTran247.mskCuenta.Enabled = False
                grdCuentas.Col = 9
                FTran247.lblDescripcion(0).Text = grdCuentas.CtlText
                FTran247.Show(Me)
            Case "Consulta_de_Detalle_de_Calculo_de_Intereses"
                FTran343.Close()
                grdCuentas.Col = 1
                FTran343.mskCuenta.Text = grdCuentas.CtlText
                FTran343.mskCuenta.Enabled = False
                grdCuentas.Col = 9
                FTran343.lblDescripcion(0).Text = grdCuentas.CtlText
                FTran343.Show(Me)
            Case "Consulta_de_Extracto_de_Cuenta_de_Ahorros"
                FTran234.Close()
                grdCuentas.Col = 1
                FTran234.mskCuenta.Mask = VGMascaraCtaAho
                FTran234.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                grdCuentas.Col = 6
                FTran234.Lblcli.Text = grdCuentas.CtlText
                FTran234.Show(Me)
            Case "Extracto_de_Cuenta_de_Ahorros_sin_Costo"
                FTran223.Close()
                grdCuentas.Col = 1
                FTran223.mskCuenta.Mask = VGMascaraCtaAho
                FTran223.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                grdCuentas.Col = 6
                FTran223.Lblcli.Text = grdCuentas.CtlText
                FTran223.mskCuenta.Enabled = False
                FTran223.Show(Me)
            Case "Consulta_de_Canje_por_Cuenta"
                FTran096.Close()
                grdCuentas.Col = 1
                FTran096.mskCuenta.Mask = VGMascaraCtaAho
                FTran096.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran096.mskCuenta.Enabled = False
                FTran096.Show(Me)


            Case "Actualizacion_de_Cuentas_de_Ahorro"
                FTran202.Close()
                grdCuentas.Col = 1
                FTran202.mskCuenta.Mask = VGMascaraCtaAho
                FTran202.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran202.mskCuenta.Enabled = False
                FTran202.VLCuentaV = "AC"
                FTran202.Show(Me)
            Case "Activacion_de_Cuentas_con_Autorizacion"
                grdCuentas.Col = 11
                If grdCuentas.CtlText = "A" Then
                    COBISMessageBox.Show(FMLoadResString(508778), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Cuenta de Ahorros ya se encuentra activa'
                    Exit Sub
                End If
                If grdCuentas.CtlText = "N" Then
                    COBISMessageBox.Show(FMLoadResString(508779), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Cuenta de Ahorros se encuentra anulada. No se puede activar
                    Exit Sub
                End If
                If grdCuentas.CtlText <> "G" Then
                    COBISMessageBox.Show(FMLoadResString(508780), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Cuenta de Ahorros no se encuentra en estado de ingreso
                    Exit Sub
                End If
                FTran437.Close()
                grdCuentas.Col = 1
                FTran437.mskCuenta.Mask = VGMascaraCtaAho
                FTran437.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran437.Text = FMLoadResString(508430) '"Activación de Cuenta sin Depósito Inicial"
                FTran437.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Reapertura_de_Cuentas"
                FTran204.Close()
                grdCuentas.Col = 1
                FTran204.mskCuenta.Mask = VGMascaraCtaAho
                FTran204.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran204.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Cancelacion_de_Cuentas"
                FTran214.Close()
                grdCuentas.Col = 1
                FTran214.Text = "CC"
                FTran214.mskCuenta.Mask = VGMascaraCtaAho
                FTran214.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                grdCuentas.Col = 9
                VLClienteb = grdCuentas.CtlText
                FTran214.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Cobro_de_Valores_en_Suspenso"
                FTran303.Close()
                grdCuentas.Col = 1
                FTran303.mskCuenta.Mask = VGMascaraCtaAho
                FTran303.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran303.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Liberacion_de_Cupo_Corresponsal"
                FTran303.Close()
                grdCuentas.Col = 1
                VGCB = True
                FTran303.Text = "Liberación de Cupo CB Red Posicionada"
                FTran303.mskCuenta.Mask = VGMascaraCtaAho
                FTran303.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                grdCuentas.Col = 9
                FTran303.lblDescripcion(0).Text = grdCuentas.CtlText
                FTran303.Show(Me)
                SendKeys.Send("{TAB}")
            Case "Consulta_de_Saldos"
                FTran230.Close()
                grdCuentas.Col = 1
                FTran230.mskCuenta.Mask = VGMascaraCtaAho
                FTran230.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran230.mskCuenta.Enabled = False
                FTran230.Show(Me)
            Case "Liberacion_Anticipada_de_Canje"
                FTran098.Close()
                grdCuentas.Col = 11
                If (grdCuentas.CtlText <> "G") Then
                    grdCuentas.Col = 1
                    FTran098.mskCuenta.Mask = VGMascaraCtaAho
                    FTran098.mskCuenta.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                    FTran098.Show(Me)
                    SendKeys.Send("{TAB}")
                Else
                    COBISMessageBox.Show(FMLoadResString(509134), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Case "Marcacion_Servicios"
                grdCuentas.Col = 1
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, grdCuentas.CtlText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                    ReDim VTArreglo(20)
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    VLTitularidad = VTArreglo(4)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    Exit Sub
                End If
                grdCuentas.Col = 1
                FTran433.Mskcuentadb.Mask = VGMascaraCtaAho
                FTran433.Mskcuentadb.Text = FMMascara(grdCuentas.CtlText, VGMascaraCtaAho)
                FTran433.Mskcuentadb.Enabled = False
                FTran433.lblTitularidad.Text = VLTitularidad
                FTran433.lblFila.Text = CStr(grdCuentas.Row)
                FTran433.Show(Me)
            Case "Cuentas_con_Caracteristicas_Especiales"
                FTran096.Close()
                grdCuentas.Col = 1
                VGCuenta = grdCuentas.CtlText
                grdCuentas.Col = 2
                VLProdbanc = grdCuentas.CtlText
                grdCuentas.Col = 15
                VLCategoria = grdCuentas.CtlText
                grdCuentas.Col = 16
                VLTipoEnte = grdCuentas.CtlText
                PLBuscar_marca()
            Case "Relacion_Cuentas_a_Canales"
                FRelCtaCanal.Close()
                grdCuentas.Col = 1
                VGCuenta = grdCuentas.CtlText
                grdCuentas.Col = 16
                VLEstado = grdCuentas.CtlText
                If VLEstado = "C" Then
                    COBISMessageBox.Show(FMLoadResString(2606), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"Cuenta de Persona Jurídica. No puede relacionarse a un canal "
                    Exit Sub
                End If
                grdCuentas.Col = 2
                VLProdbanc = grdCuentas.CtlText
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, VLProdbanc)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(2249)) Then
                    PMMapeaVariable(sqlconn, VLProdBancBloq)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VLProdBancBloq = ""
                End If
                If VLProdBancBloq <> "" Then
                    COBISMessageBox.Show(FMLoadResString(2613), FMLoadResString(2604), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation) '"Producto Bancario bloqueado y/o excluido no puede relacionarse con canales"
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                    ReDim VTArreglo(20)
                    FMMapeaArreglo(sqlconn, VTArreglo)
                    VLTitularidad = VTArreglo(4)
                    PMChequea(sqlconn)
                    VTR = grdCuentas.Rows - 1
                    For i As Integer = 1 To VTR
                        VGTipoDoc = ""
                        VLNumDoc = ""
                        VLTipoTran = ""
                        grdCuentas.Row = i
                        VLTipoTran = "1610"
                        grdCuentas.Col = 7
                        VGTipoDoc = grdCuentas.CtlText
                        grdCuentas.Col = 8
                        VLNumDoc = grdCuentas.CtlText
                        VLTipoTran = "1610"
                        FMRegistraHuellaAValidar(VGTipoDoc, VLNumDoc, VLTitularidad, VGCuenta, VLTipoTran)
                    Next i
                    If VLTitularidad = "CONJUNTA" Then
                        COBISMessageBox.Show(FMLoadResString(2605), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"Cuenta con Titularidad Conjunta. No puede relacionarse a un canal "
                        Exit Sub
                    Else
                        VLTipoTran = "1610"
                        FMVerificaHuella(VGCuenta, VLTipoTran)
                        If VGRegistraHuellaAValidar Then
                            FRelCtaCanal.Show(Me)
                        Else
                            Exit Sub
                        End If
                    End If
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Private Sub PLLimpiar()
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        mskCuentaMig.Text = ""
        txtCliente.Text = ""
        PMLimpiaG(grdCuentas)
    End Sub

    Private Sub PLBuscar_marca()
        Dim VLParametro(15, 2) As String
        Dim VTCambiaCategoria As String = ""
        Dim VTContractual As String = ""
        Dim VLProdfinal As String = ""
        Dim VLParametriza As String = ""
        Dim VLActiva As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHCT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2624)) Then '" Ok... Consulta de tipo de bloqueo de terminal"
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(6, 1) = VLProdbanc Then
                VGContractual = "S"
            Else
                VGContractual = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "PAHPR")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2624)) Then '" Ok... Consulta de tipo de bloqueo de terminal"
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(6, 1) = VLProdbanc Then
                VGProgresivo = "S"
            Else
                VGProgresivo = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "CAMCAT")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, "AHO")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2624)) Then '" Ok... Consulta de tipo de bloqueo de terminal"
            FMMapeaMatriz(sqlconn, VLParametro)
            PMChequea(sqlconn)
            If VLParametro(3, 1) = VLCategoria Then
                VTCambiaCategoria = "S"
            Else
                VTCambiaCategoria = "N"
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, CStr(734))
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, VLCategoria)
        PMPasoValores(sqlconn, "@i_prodban", 0, SQLVARCHAR, VLProdbanc)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipoente", 0, SQLCHAR, VLTipoEnte)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGCuenta)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mto_aho_contractual", True, FMLoadResString(2625)) Then ' Ok... Consulta Marca Contractual
            PMMapeaVariable(sqlconn, VTContractual)
            PMMapeaVariable(sqlconn, VLProdfinal)
            PMMapeaVariable(sqlconn, VLParametriza)
            PMMapeaVariable(sqlconn, VLActiva)
            PMChequea(sqlconn)
            If VLActiva = "S" Then
                If StringsHelper.ToDoubleSafe(VLParametriza) <> 0 Or VTCambiaCategoria = "S" Then
                    VGcategoria = VLCategoria
                    VGprofinal = VLProdfinal
                    VGOrigen = "1"
                    Ftran434.Show(Me)
                Else
                    COBISMessageBox.Show(FMLoadResString(2626) & " " & VLProdfinal & " " & FMLoadResString(2627) & " " & VLCategoria & " ", FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"No existe parametrizacion para el Producto Final "
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508755) & " " & VGCuenta & " " & FMLoadResString(508756), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"La Cuenta "  ' " no tiene caracteristicas Especiales "
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub mskCuenta_Enter(sender As Object, e As EventArgs) Handles mskCuenta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509031)) 'Número de cuenta
    End Sub

    Private Sub txtCliente_Enter(sender As Object, e As EventArgs) Handles txtCliente.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509032)) 'Codigo Cliente [F5] Ayuda
    End Sub

    Private Sub grdCuentas_Enter(sender As Object, e As EventArgs) Handles grdCuentas.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509033))  'Listado de Cuentas
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
        TSBEscoger.Enabled = _cmdBoton_5.Enabled
        TSBEscoger.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave
        If VLArgument = "Reactivacion_de_Cuentas" Then
            Exit Sub
        End If
        If VLArgument = "Reapertura_de_Cuentas" Then
            Exit Sub
        End If
        If Not VLPaso Then
            If mskCuenta.ClipText <> "" Then
                If FMChequeaCtaAho(mskCuenta.ClipText) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    If VLArgument = "Liberacion_de_Cupo_Corresponsal" Or VLArgument = "Cancelacion_CuentaCB" Then
                        PMPasoValores(sqlconn, "@i_corresponsal", 0, SQLCHAR, "S")
                    End If
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(502622) & " [" & mskCuenta.Text & "]") Then
                        'PMMapeaObjeto(sqlconn, lblDescripcion(0))
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdCuentas)
                    Else
                        mskCuenta.Focus()
                        PMChequea(sqlconn)
                        'VLPaso = False
                        Exit Sub
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    mskCuenta.Mask = VGMascaraCtaAho
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    mskCuenta.Focus()
                    Exit Sub
                End If
            End If
        End If
        VLPaso = True
    End Sub

    Private Sub mskCuenta_TextChanged(sender As Object, e As EventArgs) Handles mskCuenta.TextChanged
        VLPaso = False
        Me.PLLimpiarDatos()
    End Sub

    Private Sub mskCuentaMig_Enter(sender As Object, e As EventArgs) Handles mskCuentaMig.Enter
        mskCuentaMig.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509559))  'Número de la cuenta migrada
    End Sub

    Private Sub mskCuentaMig_KeyPress(sender As Object, e As KeyPressEventArgs) Handles mskCuentaMig.KeyPress
        If e.KeyChar <> Chr(8) Then
            If InStr("0123456789", e.KeyChar) = 0 Then
                e.KeyChar = ""
            End If
        End If
    End Sub

    Private Sub mskCuentaMig_TextChanged(sender As Object, e As EventArgs) Handles mskCuentaMig.TextChanged
        Me.PLLimpiarDatos()
    End Sub

    Private Sub PLLimpiarDatos()
        PMLimpiaG(grdCuentas)
        Me._cmdBoton_1.Enabled = False
        Me.PLTSEstado()
    End Sub
End Class


