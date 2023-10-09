Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary

Partial Public Class FRelCtaCanalClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VTCodigo As String = ""
    Dim VLTelCelular As String = ""
    Dim VLTelCelularold As String = ""
    Dim VLIdentificacion As String = ""
    Dim VLTarjetaDebito As String = ""
    Dim VLEstado As String = ""
    Dim VLCanal As String = ""
    Dim VLCuenta As String = ""
    Dim VLSecuencial As Integer = 0
    Dim VLSubtipo As String = ""
    Dim VLDescSubtipo As String = ""
    Dim VTNumeroMensaje As String = ""
    Dim VLRespuesta As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLCrear()
            Case 1
                PLActualizar()
            Case 2
                Me.Close()
            Case 3
                PLBuscar()
            Case 4
                PLLimpiar()
            Case 5
                PLEliminar()
        End Select
    End Sub

    Private Sub PLCrear()
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If txtTelCelular.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508722), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTelCelular.Focus()
            lblTelCelular(9).Text = ""
            Exit Sub
        End If
        If txtCanal.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508447), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCanal.Focus()
            lblDescCanal(0).Text = ""
            Exit Sub
        End If
        If txtTarjetaDebito.Text.Trim() <> "" And txtConfirmaTarjDeb.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtConfirmaTarjDeb.Focus()
            Exit Sub
        End If
        If txtConfirmaTarjDeb.Text.Trim() <> "" And txtTarjetaDebito.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508663), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTarjetaDebito.Focus()
            Exit Sub
        End If
        If txtCanal.Text = "TAR" Then
            If Strings.Len(txtTarjetaDebito.Text) < 16 Or Strings.Len(txtTarjetaDebito.Text) > 19 Then
                COBISMessageBox.Show(FMLoadResString(508628), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtTarjetaDebito.Text = ""
                txtConfirmaTarjDeb.Text = ""
                txtTarjetaDebito.Focus()
            End If
        End If
        If txtConfirmaTarjDeb.Text <> "" Then
            If txtTarjetaDebito.Text.Trim() <> txtConfirmaTarjDeb.Text.Trim() Then
                COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtConfirmaTarjDeb.Text = ""
                txtConfirmaTarjDeb.Focus()
            End If
        End If
        If grdPropietarios.Row < 1 Then
            grdPropietarios.Row = 1
        End If
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.CtlText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "744")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
        PMPasoValores(sqlconn, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Text)
        PMPasoValores(sqlconn, "@i_canal", 0, SQLVARCHAR, txtCanal.Text)
        PMPasoValores(sqlconn, "@i_tarj_debito", 0, SQLVARCHAR, txtTarjetaDebito.Text)
        PMPasoValores(sqlconn, "@i_confir_tarj_debito", 0, SQLVARCHAR, txtConfirmaTarjDeb.Text)
        PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508781)) Then
            PMChequea(sqlconn)
            VTNumeroMensaje = FmMapeaNumMensaje().Trim()
            If VTNumeroMensaje = "" Then
                COBISMessageBox.Show(FMLoadResString(508705), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            End If
            VGHabilita = "S"
        Else
            PMChequea(sqlconn)
            Exit Sub
        End If
        PLBuscar()
        PLLimpiar_Eliminar()
    End Sub

    Private Sub PLActualizar()
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501337), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Exit Sub
        End If
        If txtTelCelular.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508722), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTelCelular.Focus()
            lblTelCelular(9).Text = ""
            Exit Sub
        End If
        If txtCanal.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508447), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCanal.Focus()
            lblDescCanal(0).Text = ""
            Exit Sub
        End If
        If txtMotivo.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(508641), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtMotivo.Focus()
            lblDescMotivo.Text = ""
            Exit Sub
        End If
        If txtCanal.Text <> "CB" Then
            If txtConfirmaTarjDeb.Text <> "" Then
                If txtTarjetaDebito.Text.Trim() <> "" And txtConfirmaTarjDeb.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtConfirmaTarjDeb.Focus()
                    Exit Sub
                End If
                If txtConfirmaTarjDeb.Text.Trim() <> "" And txtTarjetaDebito.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(508663), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtConfirmaTarjDeb.Focus()
                    Exit Sub
                End If
            End If
        Else
            If txtMotivo.Text = "03" Then
                COBISMessageBox.Show(FMLoadResString(508640), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtMotivo.Text = ""
                lblDescMotivo.Text = ""
                txtMotivo.Focus()
                Exit Sub
            End If
        End If
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.CtlText
        grdRelacionCanal.Col = 7
        VLTelCelularold = grdRelacionCanal.CtlText
        TxtNuevaTarjeta.Text = ""
        If txtMotivo.Text = "03" And txtCanal.Text <> "CB" Then
            If lblRelEstado(3).Text <> "V" Then
                COBISMessageBox.Show(FMLoadResString(508622), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            FREEXPEDIR.Show(Me)
            FREEXPEDIR.txtTarjetaDebito.Text = ""
            FREEXPEDIR.txtConfirmaTarjDeb.Text = ""
        Else
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "745")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "U")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
            PMPasoValores(sqlconn, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Text)
            PMPasoValores(sqlconn, "@i_tel_celular_old", 0, SQLVARCHAR, VLTelCelularold)
            PMPasoValores(sqlconn, "@i_canal", 0, SQLVARCHAR, txtCanal.Text)
            PMPasoValores(sqlconn, "@i_tarj_debito", 0, SQLVARCHAR, txtTarjetaDebito.Text)
            PMPasoValores(sqlconn, "@i_confir_tarj_debito", 0, SQLVARCHAR, txtConfirmaTarjDeb.Text)
            PMPasoValores(sqlconn, "@i_motivo", 0, SQLVARCHAR, txtMotivo.Text)
            PMPasoValores(sqlconn, "@i_estado", 0, SQLVARCHAR, lblRelEstado(3).Text)
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508781)) Then
                PMChequea(sqlconn)
                VTNumeroMensaje = FmMapeaNumMensaje().Trim()
                If VTNumeroMensaje = "" Then
                    COBISMessageBox.Show(FMLoadResString(508704), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                End If
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
            PLBuscar()
            PLLimpiar_Eliminar()
            cmdResetClave.Enabled = False
            cmdBoton(0).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        If mskCuenta.ClipText <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(502622)) Then
                PMMapeaGrid(sqlconn, grdRelacionCanal, False)
                PMMapeaTextoGrid(grdRelacionCanal)
                PMChequea(sqlconn)
                cmdBoton(0).Enabled = True
                cmdBoton(1).Enabled = False
                cmdBoton(5).Enabled = False
                PLAjustaGrid(grdRelacionCanal, Me)
                PMAnchoColumnasGrid(grdRelacionCanal)
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
            grdRelacionCanal.Col = 0
            grdRelacionCanal.ColWidth(10) = 1
        Else
            COBISMessageBox.Show(FMLoadResString(508544), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            PLLimpiar()
            mskCuenta.Focus()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLEliminar()
        If VLIdentificacion <> "" Then
            grdPropietarios.Col = 1
            VTCodigo = grdPropietarios.CtlText
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "746")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Text)
            PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
            PMPasoValores(sqlconn, "@i_canal", 0, SQLVARCHAR, txtCanal.Text)
            PMPasoValores(sqlconn, "@i_tarj_debito", 0, SQLVARCHAR, txtTarjetaDebito.Text)
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo)
            grdRelacionCanal.Col = 1
            VLCanal = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 6
            VLCuenta = grdRelacionCanal.CtlText
            VLRespuesta = COBISMessageBox.Show(FMLoadResString(508523) & VLCanal & " para la cuenta " & VLCuenta & " ? ", FMLoadResString(500237), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
            If VLRespuesta = 2 Then
                Exit Sub
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508782)) Then
                PMChequea(sqlconn)
                VTNumeroMensaje = FmMapeaNumMensaje().Trim()
                If VTNumeroMensaje = "" Then
                    COBISMessageBox.Show(FMLoadResString(508703), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                End If
                PLBuscar()
                PLLimpiar_Eliminar()
                cmdBoton(1).Enabled = False
                cmdBoton(5).Enabled = False
                cmdResetClave.Enabled = False
                cmdBoton(0).Enabled = False
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(508698), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        PMLimpiaGrid(grdRelacionCanal)
        cmdBoton(0).Enabled = True
        cmdResetClave.Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(5).Enabled = False
        lblTelCelular(9).Text = ""
        lblRelEstado(3).Text = ""
        lblDescRelEstado(7).Text = ""
        txtTelCelular.Text = ""
        txtTarjetaDebito.Text = ""
        txtConfirmaTarjDeb.Text = ""
        txtCanal.Text = ""
        lblDescCanal(0).Text = ""
        txtMotivo.Text = ""
        lblDescMotivo.Text = ""
        txtMotivo.Enabled = False
        txtCanal.Enabled = True
        TxtNuevaTarjeta.Text = ""
        txtCanal.Focus()
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar_Eliminar()
        cmdBoton(0).Enabled = True
        cmdResetClave.Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(5).Enabled = False
        lblTelCelular(9).Text = ""
        lblRelEstado(3).Text = ""
        lblDescRelEstado(7).Text = ""
        txtTelCelular.Text = ""
        txtTarjetaDebito.Text = ""
        txtConfirmaTarjDeb.Text = ""
        txtCanal.Text = ""
        lblDescCanal(0).Text = ""
        txtMotivo.Text = ""
        lblDescMotivo.Text = ""
        txtMotivo.Enabled = False
        txtCanal.Enabled = True
        txtCanal.Focus()
        PLTSEstado()
    End Sub

    Private Sub cmdResetClave_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdResetClave.Click
        VLRespuesta = COBISMessageBox.Show(FMLoadResString(508548), FMLoadResString(508591), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
        If VLRespuesta = 2 Then
            Exit Sub
        End If
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.CtlText
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "748")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "V")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508781)) Then
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "749")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "P")
        PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Text)
        PMPasoValores(sqlconn, "@i_canal", 0, SQLVARCHAR, txtCanal.Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508781)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(508455), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(508647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PLLimpiar()
    End Sub

    Private Sub FRelCtaCanal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        cmbProducto.Items.Add("4 - CUENTA DE AHORROS")
        cmbProducto.SelectedIndex = 0
        mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
        mskCuenta.Enabled = False
        cmbProducto.Enabled = False
        txtTarjetaDebito.Enabled = False
        txtConfirmaTarjDeb.Enabled = False
        If cmbProducto.Text = "3 - CUENTA CORRIENTE" Then
            mskCuenta.Mask = VGMascaraCtaCte
        Else
            mskCuenta.Mask = VGMascaraCtaAho
        End If
        mskCuenta_Leave(mskCuenta, New EventArgs())
    End Sub

    Private Sub grdRelacionCanal_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRelacionCanal.Click
        If grdRelacionCanal.CtlText <> "" Then
            grdRelacionCanal.Col = 1
            VLCanal = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 4
            VLIdentificacion = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 6
            VGCuenta = grdRelacionCanal.CtlText
            mskCuenta.Mask = VGMascaraCtaAho
            mskCuenta.Text = FMMascara(VGCuenta, VGMascaraCtaAho)
            mskCuenta_Leave(mskCuenta, New EventArgs())
            txtTelCelular.Focus()
            grdRelacionCanal.Col = 7
            VLTelCelular = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 2
            VLEstado = Strings.Mid(grdRelacionCanal.CtlText, 1, 1)
            If VLEstado = "V" Then
                lblDescRelEstado(7).Text = "VIGENTE"
            Else
                lblDescRelEstado(7).Text = "ELIMINADO"
            End If
            grdRelacionCanal.Col = 8
            VLTarjetaDebito = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 1
            VLCanal = grdRelacionCanal.CtlText
            grdRelacionCanal.Col = 10
            VLSecuencial = CInt(grdRelacionCanal.CtlText)
            grdRelacionCanal.Col = 9
            grdRelacionCanal.Col = 14
            cmdBoton(0).Enabled = False
            lblTelCelular(9).Text = VLTelCelular
            txtTelCelular.Text = CStr(VLSecuencial)
            txtMotivo.Enabled = True
            txtCanal.Text = VLCanal
            txtCanal_Leave(txtCanal, New EventArgs())
            txtTarjetaDebito.Text = VLTarjetaDebito
            lblRelEstado(3).Text = VLEstado
            txtTarjetaDebito.Enabled = False
            txtConfirmaTarjDeb.Enabled = False
            txtCanal.Enabled = False
            PMBotonSeguridad(Me, 1)
            grdRelacionCanal.Col = 2
            VLEstado = Strings.Mid(grdRelacionCanal.CtlText, 1, 1)
            If VLEstado = "V" Then
                cmdBoton(1).Enabled = True
                cmdBoton(5).Enabled = True
            Else
                cmdBoton(1).Enabled = False
                cmdBoton(5).Enabled = False
            End If
            If txtCanal.Text = "CB" Then
                cmdBoton(1).Enabled = False
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        'If CInt(Strings.Mid(cmbProducto.Text, 1, 1)) = 3 Then
        ' COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" Número de la Cuenta Corriente")
        'Else
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
        'End If
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub FRelCtaCanal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPropietarios.DblClick
        grdPropietarios.Col = 1
        VTCodigo = grdPropietarios.CtlText
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2223))
    End Sub

    Private Sub lblRelEstado_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _lblRelEstado_3.Click
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508561))
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Try
            If CInt(Strings.Mid(cmbProducto.Text, 1, 1)) = 3 Then
                If mskCuenta.ClipText <> "" Then
                    If FMChequeaCtaCte(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblCuentaDesc(0))
                            PMMapeaObjeto(sqlconn, lblProdBanc(2))
                            PMMapeaObjeto(sqlconn, lblCategoria(1))
                            PMMapeaGrid(sqlconn, grdPropietarios, False)
                            PMMapeaTextoGrid(grdPropietarios)
                            PMAnchoColumnasGrid(grdPropietarios)
                            PMChequea(sqlconn)
                            cmdBoton(0).Enabled = True
                        Else
                            PMChequea(sqlconn)
                            cmdBoton_Click(cmdBoton(4), New EventArgs())
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        cmdBoton_Click(cmdBoton(4), New EventArgs())
                        Exit Sub
                    End If
                End If
            Else
                If mskCuenta.ClipText <> "" Then
                    If FMChequeaCtaAho(mskCuenta.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblCuentaDesc(0))
                            PMChequea(sqlconn)
                            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                                Dim VTArreglo(20) As String
                                FMMapeaArreglo(sqlconn, VTArreglo)
                                PMChequea(sqlconn)
                                lblProdBanc(2).Text = VTArreglo(2)
                                lblDescProdBanc(5).Text = VTArreglo(3)
                                lblCategoria(1).Text = VTArreglo(15)
                                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                                PMPasoValores(sqlconn, "@i_cons_cta", 0, SQLCHAR, "S")
                                PMPasoValores(sqlconn, "@i_tipo_cta", 0, SQLVARCHAR, "AHO")
                                PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
                                PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                                PMPasoValores(sqlconn, "@i_categoria", 0, SQLVARCHAR, lblCategoria(1).Text)
                                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2468)) Then
                                    PMMapeaObjeto(sqlconn, lblDescCategoria(6))
                                    PMChequea(sqlconn)
                                Else
                                    PMChequea(sqlconn)
                                End If
                            Else
                                PMChequea(sqlconn)
                            End If
                            cmdBoton(0).Enabled = True
                            PMLimpiaGrid(grdPropietarios)
                        Else
                            PMChequea(sqlconn)
                            cmdBoton_Click(cmdBoton(4), New EventArgs())
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        cmdBoton_Click(cmdBoton(4), New EventArgs())
                        Exit Sub
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "298")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_clientes_ah", True, FMLoadResString(2250)) Then
                        PMMapeaGrid(sqlconn, grdPropietarios, False)
                        PMMapeaTextoGrid(grdPropietarios)
                        PMAnchoColumnasGrid(grdPropietarios)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdPropietarios)
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        PLTSEstado()
    End Sub

    Private Sub txtCanal_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCanal.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2224))
    End Sub

    Private Sub txtCanal_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtCanal.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = 116 Then
            txtCanal.Text = ""
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "ah_canal_relcta")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCanal.Text = VGACatalogo.Codigo
                lblDescCanal(0).Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtCanal_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCanal.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCanal_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCanal.Leave
        If txtCanal.Text <> "" Then
            PMCatalogo("V", "ah_canal_relcta", txtCanal, lblDescCanal(0))
            If txtCanal.Text <> "" Then
                If txtCanal.Text = "CB" Then
                    txtTarjetaDebito.Text = ""
                    txtConfirmaTarjDeb.Text = ""
                    txtTarjetaDebito.Enabled = False
                    txtConfirmaTarjDeb.Enabled = False
                    txtMotivo.Text = ""
                    lblDescMotivo.Text = ""
                Else
                    txtMotivo.Text = ""
                    lblDescMotivo.Text = ""
                    txtTarjetaDebito.Enabled = True
                    txtConfirmaTarjDeb.Enabled = True

                End If
                If txtCanal.Text <> "CB" Then
                    txtMotivo.Text = ""
                    lblDescMotivo.Text = ""
                    cmdResetClave.Enabled = False
                    txtMotivo.Enabled = True
                    txtMotivo.Focus()
                Else
                    txtMotivo.Text = ""
                    lblDescMotivo.Text = ""
                    cmdResetClave.Enabled = True
                    txtMotivo.Enabled = False
                End If
            Else
                txtCanal.Focus()
            End If
        Else
            lblDescCanal(0).Text = ""
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtConfirmaTarjDeb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConfirmaTarjDeb.Enter
        If txtTarjetaDebito.Text <> "" And txtConfirmaTarjDeb.Text <> "" Then
            My.Computer.Clipboard.Clear()
            My.Computer.Clipboard.SetText("")
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2221))
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2221))
    End Sub

    Private Sub txtConfirmaTarjDeb_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtConfirmaTarjDeb.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        BorrarClipboard(Keycode, Shift, 0, False)
    End Sub

    Private Sub txtConfirmaTarjDeb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtConfirmaTarjDeb.Leave
        If txtConfirmaTarjDeb.Text <> "" Then
            If txtTarjetaDebito.Text.Trim() <> txtConfirmaTarjDeb.Text.Trim() Then
                COBISMessageBox.Show(FMLoadResString(508466), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtConfirmaTarjDeb.Text = ""
                txtConfirmaTarjDeb.Focus()
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtConfirmaTarjDeb_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtConfirmaTarjDeb.MouseDown
        Dim Button As Integer = CInt(eventArgs.Button)
        BorrarClipboard(0, 0, Button, True)
    End Sub

    Private Sub txtMotivo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtMotivo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2225))
    End Sub

    Private Sub txtMotivo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtMotivo.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = 116 Then
            txtMotivo.Text = ""
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_novedades_enroll")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtMotivo.Text = VGACatalogo.Codigo
                lblDescMotivo.Text = VGACatalogo.Descripcion
                SendKeys.Send("{TAB}")
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(2225), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTelCelular.Text = ""
            txtTelCelular.Focus()
        End If
    End Sub

    Private Sub txtMotivo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtMotivo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)

    End Sub

    Private Sub txtMotivo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtMotivo.Leave
        Dim VLProd As String = ""
        If txtMotivo.Text <> "" Then
            PMCatalogo("V", "re_novedades_enroll", txtMotivo, lblDescMotivo)
            If txtCanal.Text = "TAR" Then
                If txtMotivo.Text = "15" Then
                    grdRelacionCanal.Col = 15
                    VLSubtipo = grdRelacionCanal.CtlText
                Else
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4159")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
                    VLProd = Strings.Mid(cmbProducto.Text, 1, 1)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, VLProd)
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblProdBanc(2).Text)
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                    PMPasoValores(sqlconn, "@i_motivo", 0, SQLVARCHAR, txtMotivo.Text)
                    grdPropietarios.Col = 1
                    VTCodigo = grdPropietarios.CtlText
                    PMPasoValores(sqlconn, "@i_cliente", 0, SQLINT4, VTCodigo)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenimiento_std", True, FMLoadResString(508783)) Then
                        PMMapeaVariable(sqlconn, VLSubtipo)
                        PMMapeaVariable(sqlconn, VLDescSubtipo)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                    If VLSubtipo = "XXX" Then
                        COBISMessageBox.Show(FMLoadResString(508646) & lblDescProdBanc(5).Text, FMLoadResString(500591), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Else
                        If VLSubtipo <> "" Then
                            If txtMotivo.Text = "03" Then
                                COBISMessageBox.Show(FMLoadResString(508718) & VLDescSubtipo, FMLoadResString(500591), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                            End If
                            If txtMotivo.Text = "01" Then
                                COBISMessageBox.Show(FMLoadResString(508717) & VLDescSubtipo, FMLoadResString(500591), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                            End If
                        Else
                            COBISMessageBox.Show(FMLoadResString(508500), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        End If
                    End If
                End If
            End If
        Else
            lblDescMotivo.Text = ""
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub TxtNuevaTarjeta_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles TxtNuevaTarjeta.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        If TxtNuevaTarjeta.Text <> "" Then
            grdPropietarios.Col = 1
            VTCodigo = grdPropietarios.CtlText
            grdRelacionCanal.Col = 7
            VLTelCelularold = grdRelacionCanal.CtlText
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "745")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "U")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_cliente", 0, SQLVARCHAR, VTCodigo)
            PMPasoValores(sqlconn, "@i_tel_celular", 0, SQLVARCHAR, lblTelCelular(9).Text)
            PMPasoValores(sqlconn, "@i_tel_celular_old", 0, SQLVARCHAR, VLTelCelularold)
            PMPasoValores(sqlconn, "@i_canal", 0, SQLVARCHAR, txtCanal.Text)
            PMPasoValores(sqlconn, "@i_tarj_debito", 0, SQLVARCHAR, txtTarjetaDebito.Text)
            PMPasoValores(sqlconn, "@i_confir_tarj_debito", 0, SQLVARCHAR, TxtNuevaTarjeta.Text)
            PMPasoValores(sqlconn, "@i_motivo", 0, SQLVARCHAR, txtMotivo.Text)
            PMPasoValores(sqlconn, "@i_estado", 0, SQLVARCHAR, lblRelEstado(3).Text)
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, VLSubtipo)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508781)) Then
                PMChequea(sqlconn)
                VTNumeroMensaje = FmMapeaNumMensaje().Trim()
                If VTNumeroMensaje = "" Then
                    COBISMessageBox.Show(FMLoadResString(508704), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                End If
            Else
                PMChequea(sqlconn)
                Exit Sub
            End If
            PLBuscar()
            PLLimpiar_Eliminar()
        Else
            Exit Sub
        End If
    End Sub

    Private Sub txtTarjetaDebito_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTarjetaDebito.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2222))
    End Sub

    Sub BorrarClipboard(ByRef CodTecla As COBISCorp.Framework.UI.Components.COBISTools.KeyCodeConstants, ByRef CtrlAltShift As Integer, ByRef BotonMouse As Integer, ByRef ClickMouse As Boolean)
        If Not ClickMouse Then
            If CodTecla = Keys.Insert And CtrlAltShift = 1 Then
                My.Computer.Clipboard.Clear()
            ElseIf CodTecla = Keys.V And CtrlAltShift = 2 Then
                My.Computer.Clipboard.Clear()
            End If
        Else
            If BotonMouse = 2 Then My.Computer.Clipboard.Clear()
        End If
    End Sub

    Private Sub txtTarjetaDebito_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTarjetaDebito.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Shift As Integer = eventArgs.KeyData \ &H10000
        BorrarClipboard(Keycode, Shift, 0, False)
    End Sub

    Private Sub txtTarjetaDebito_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTarjetaDebito.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtConfirmaTarjDeb_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtConfirmaTarjDeb.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtTarjetaDebito_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTarjetaDebito.Leave
        If txtTarjetaDebito.Text <> "" Then
            If Strings.Len(txtTarjetaDebito.Text) < 16 Or Strings.Len(txtTarjetaDebito.Text) > 19 Then
                COBISMessageBox.Show(FMLoadResString(508628), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtTarjetaDebito.Text = ""
                txtConfirmaTarjDeb.Text = ""
                txtTarjetaDebito.Focus()
            End If
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtTarjetaDebito_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles txtTarjetaDebito.MouseDown
        Dim Button As Integer = CInt(eventArgs.Button)
        BorrarClipboard(0, 0, Button, True)
    End Sub

    Private Sub txtTelCelular_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTelCelular.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2226))
    End Sub

    Private Sub txtTelCelular_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles txtTelCelular.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = 116 Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "747")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_tipo_id", 0, SQLVARCHAR, VGTipoDocValidado)
            PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, VGNumDocValidado)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_relacion_cta_canal", True, FMLoadResString(508784)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtTelCelular.Text = VGACatalogo.Codigo
                lblTelCelular(9).Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(2226), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtTelCelular.Text = ""
            txtTelCelular.Focus()
        End If
    End Sub

    Private Sub txtTelCelular_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtTelCelular.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub cmbProducto_Leave(sender As Object, e As EventArgs) Handles cmbProducto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub cmbProducto_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbProducto.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
    End Sub

    Private Sub cmbProducto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbProducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500658))
    End Sub

    Private Sub txtTelCelular_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtTelCelular.Leave
        If txtTelCelular.Text = "" Then
            lblTelCelular(9).Text = ""
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Enabled = _cmdBoton_1.Enabled
        TSBActualizar.Enabled = _cmdBoton_1.Enabled
        TSBEliminar.Visible = _cmdBoton_5.Visible
        TSBEliminar.Enabled = _cmdBoton_5.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBGenerar.Enabled = cmdResetClave.Enabled
        TSBGenerar.Visible = cmdResetClave.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBGenerar_Click(sender As Object, e As EventArgs) Handles TSBGenerar.Click
        If cmdResetClave.Enabled Then cmdResetClave_Click(cmdResetClave, e)
    End Sub

    Private Sub grdRelacionCanal_ClickEvent(sender As Object, e As EventArgs) Handles grdRelacionCanal.ClickEvent
        PMMarcaFilaCobisGrid(grdRelacionCanal, grdRelacionCanal.Row)
    End Sub
End Class


