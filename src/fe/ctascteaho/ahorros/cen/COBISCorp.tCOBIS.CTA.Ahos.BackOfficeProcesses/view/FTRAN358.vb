Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FTran358Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLProducto As String = ""

    Private Sub cbotipocta_Enter(sender As Object, e As EventArgs) Handles cbotipocta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509128)) ' Selección de Tipo de Cuenta
    End Sub

    Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500653)) 'Número de la Cuenta Corriente o de Ahorros
        mskCuenta.SelectionStart = 0
        mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
    End Sub

    Private Sub _optsigno_0_Enter(sender As Object, e As EventArgs) Handles _optsigno_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509129)) 'Signo de la Transacción [Débito]
    End Sub

    Private Sub _optsigno_1_Enter(sender As Object, e As EventArgs) Handles _optsigno_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509130)) 'Signo de la Transacción [Crédito]
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500655)) 'Causa de Nota  [F5 Ayuda]
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub MskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _MskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(MskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500654)) 'Valor de la Nota Crédito
                MskValor(0).Text = MskValor(0).Text.ToString()
                MskValor(0).SelectionStart = 0
                MskValor(0).SelectionLength = Strings.Len(MskValor(0).Text)
        End Select
    End Sub


    Private Sub txtObservacion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtObservacion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500656)) 'Descripción de la Nota Crédito
    End Sub

    Private Sub txtsecuencial_Enter(sender As Object, e As EventArgs) Handles txtsecuencial.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509131)) ' Num. Secuencial
    End Sub

    Private Sub grdPropietarios_Enter(sender As Object, e As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509132)) 'Notas de Débito / Crédito
    End Sub

    Private Sub cbotipocta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cbotipocta.Leave
        If VLProducto <> cbotipocta.Text Then
            lblDescripcion(0).Text = ""
            If cbotipocta.SelectedIndex = 0 Then
                mskCuenta.Mask = VGMascaraCtaCte
            ElseIf cbotipocta.SelectedIndex = 1 Then
                mskCuenta.Mask = VGMascaraCtaAho
            End If
            VLProducto = cbotipocta.Text
        End If
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_4.Click, _cmdBoton_6.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTBase As String = ""
        Dim VTProcedure As String = ""
        Dim VTTransaccion As String = ""
        If cbotipocta.SelectedIndex = 0 Then
            VTBase = "cob_cuentas"
            VTProcedure = "sp_autndc_cte"
            If optsigno(0).Checked Then
                VTTransaccion = CStr(705)
            ElseIf optsigno(1).Checked Then
                VTTransaccion = CStr(706)
            End If
        ElseIf cbotipocta.SelectedIndex = 1 Then
            VTBase = "cob_ahorros"
            VTProcedure = "sp_autndc_aho"
            If optsigno(0).Checked Then
                VTTransaccion = CStr(264)
            ElseIf optsigno(1).Checked Then
                VTTransaccion = CStr(253)
            End If
        End If
        Select Case Index
            Case 0
                PLTransmitir(VTBase, VTProcedure, VTTransaccion)
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3 'Buscar
                PLBuscar(0, VTBase, VTProcedure, VTTransaccion)
            Case 6 ' SIGUIENTE
                PLBuscar(1, VTBase, VTProcedure, VTTransaccion)
            Case 5 ' REVERSAR
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTransaccion)
                PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, VTTransaccion)
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, txtcuenta.Text)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
                PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_fac", 0, SQLCHAR, "N")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                If cbotipocta.SelectedIndex = 0 Then
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
                ElseIf cbotipocta.SelectedIndex = 1 Then
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                End If
                PMPasoValores(sqlconn, "@i_sec_rev", 0, SQLINT4, txtsecuencial.Text)
                PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, MskValor(0).Text)
                PMPasoValores(sqlconn, "@i_nombre_ocx", 0, SQLVARCHAR, "TADMIN.EXE")
                PMPasoValores(sqlconn, "@i_concep", 0, SQLVARCHAR, txtObservacion.Text)
                If FMTransmitirRPC(sqlconn, ServerName, VTBase, VTProcedure, True, FMLoadResString(508814)) Then 'Ok... Bloqueo de Movimientos a Cuenta de Ahorros
                    PMChequea(sqlconn)
                    'cmdBoton(6).Enabled = Conversion.Val(CStr(grdPropietarios.Rows - 1)) >= 20
                    PLAjustaGrid(grdPropietarios, Me)
                    PLLimpiar()
                    PLBuscar(0, VTBase, VTProcedure, VTTransaccion)
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdPropietarios)
                End If
        End Select
        PLTSEstado()
    End Sub

    Sub PLLimpiar()
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        For i As Integer = 0 To 1
            lblDescripcion(i).Text = ""
        Next i
        For i As Integer = 0 To 0
            txtCampo(i).Text = ""
        Next i
        MskValor(0).Text = VGDecimales
        MskValor(0).Text = StringsHelper.Format(0, VGDecimales)
        txtcuenta.Text = ""
        txtObservacion.Text = ""
        PMLimpiaGrid(grdPropietarios)
        cmdBoton(3).Enabled = True
        cmdBoton(0).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        txtcuenta.Visible = False
        lblObservacion(0).Visible = False
        VLProducto = cbotipocta.Text
        mskCuenta.Focus()

        txtcuenta.Enabled = True
        txtCampo(0).Enabled = True
        MskValor(0).Enabled = True
        txtObservacion.Enabled = True
        txtcuenta.Visible = False
    End Sub

    Sub PLTransmitir(VTBase As String, VTProcedure As String, VTTransaccion As String)
        If cbotipocta.SelectedIndex = -1 Then
            COBISMessageBox.Show(FMLoadResString(500647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) '"El tipo de cuenta es mandatorio"
            If cbotipocta.Enabled Then cbotipocta.Focus()
            Exit Sub
        End If
        If Not optsigno(0).Checked And Not optsigno(1).Checked Then
            COBISMessageBox.Show(FMLoadResString(500648), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El signo de la Nota debe ser debito o credito
            If optsigno(0).Enabled Then optsigno(0).Focus()
            Exit Sub
        End If
        If mskCuenta.ClipText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500649), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El código de la cuenta corriente o ahorros es mandatorio
            If mskCuenta.Enabled Then mskCuenta.Focus()
            Exit Sub
        End If
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500650), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'La causa de la nota de debito/crédito es mandatoria
            If txtCampo(0).Enabled Then
                txtCampo(0).Focus()
            End If
            Exit Sub
        End If
        If Conversion.Val(MskValor(0).Text) <= 0 Then
            COBISMessageBox.Show(FMLoadResString(500651), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'El valor de la nota debe ser mayor que cero
            If MskValor(0).Enabled Then
                MskValor(0).Focus()
            End If
            Exit Sub
        End If
        If txtObservacion.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500652), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'La Descripción es mandatoria
            If txtObservacion.Enabled Then
                txtObservacion.Focus()
            End If
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTransaccion)
        PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, VTTransaccion)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_fac", 0, SQLCHAR, "N")
        If cbotipocta.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        ElseIf cbotipocta.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        End If
        PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, MskValor(0).Text)
        PMPasoValores(sqlconn, "@i_nombre_ocx", 0, SQLVARCHAR, "TADMIN.EXE")
        PMPasoValores(sqlconn, "@i_concep", 0, SQLVARCHAR, txtObservacion.Text)
        If FMTransmitirRPC(sqlconn, ServerName, VTBase, VTProcedure, True, FMLoadResString(508814)) Then 'Ok... Bloqueo de Movimientos a Cuenta de Ahorros
            PMChequea(sqlconn)
            cmdBoton_Click(cmdBoton(1), New EventArgs())
            cmdBoton_Click(cmdBoton(3), New EventArgs())
            cmdBoton(0).Enabled = False
            cmdBoton(4).Enabled = True
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PLBuscar(tipo As Integer, VTBase As String, VTProcedure As String, VTTransaccion As String)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTransaccion)
        PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, VTTransaccion)
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
        PMPasoValores(sqlconn, "@i_cau", 0, SQLCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_fac", 0, SQLCHAR, "N")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If cbotipocta.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
        ElseIf cbotipocta.SelectedIndex = 1 Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
        End If
        PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, MskValor(0).Text)
        PMPasoValores(sqlconn, "@i_nombre_ocx", 0, SQLVARCHAR, "TADMIN.EXE")
        PMPasoValores(sqlconn, "@i_concep", 0, SQLVARCHAR, txtObservacion.Text)

        If tipo = 0 Then 'BUSCAR
            PMPasoValores(sqlconn, "@i_siguiente", 0, SQLINT4, "0")
        End If
        If tipo = 1 Then 'SIGUIENTE
            grdPropietarios.Row = grdPropietarios.Rows - 1
            grdPropietarios.Col = 8
            PMPasoValores(sqlconn, "@i_siguiente", 0, SQLINT4, grdPropietarios.CtlText)
        End If

        If FMTransmitirRPC(sqlconn, ServerName, VTBase, VTProcedure, True, FMLoadResString(508814)) Then 'Ok... Bloqueo de Movimientos a Cuenta de Ahorros
            PMMapeaGrid(sqlconn, grdPropietarios, False)
            PMMapeaTextoGrid(grdPropietarios)
            PMAnchoColumnasGrid(grdPropietarios)
            PMChequea(sqlconn)
            '-------------------------------------------------------------------------------------
            If tipo = 0 Then 'BUSCAR
                If Conversion.Val(CStr(grdPropietarios.Rows - 1)) >= 20 Then
                    cmdBoton(6).Enabled = True
                    cmdBoton(3).Enabled = False
                    txtCampo(0).Text = ""
                    MskValor(0).Text = VGDecimales
                    MskValor(0).Text = StringsHelper.Format(0, VGDecimales)
                    If cbotipocta.SelectedIndex = 0 Then
                        mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    ElseIf cbotipocta.SelectedIndex = 1 Then
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                    End If
                    txtObservacion.Text = ""
                    txtcuenta.Text = ""
                    txtsecuencial.Text = ""
                    lblDescripcion(0).Text = ""
                    lblDescripcion(1).Text = ""
                Else
                    cmdBoton(6).Enabled = False
                End If
            End If
            '-------------------------------------------------------------------------------------
            If tipo = 1 Then 'SIGUIENTE
                If Conversion.Val(Convert.ToString(grdPropietarios.Tag)) >= 20 Then
                    cmdBoton(6).Enabled = True
                Else
                    cmdBoton(6).Enabled = False
                    cmdBoton(3).Enabled = True
                    mskCuenta.Focus()
                End If
                If grdPropietarios.Rows <= 2 Then
                    grdPropietarios.Col = 1
                    grdPropietarios.Row = 1
                    If grdPropietarios.CtlText = "" Then
                        Exit Sub
                    End If
                End If
            End If
            '-------------------------------------------------------------------------------------
            grdPropietarios.ColIsVisible(5) = False
            grdPropietarios.ColIsVisible(6) = False
        Else
            PMChequea(sqlconn)
            PMLimpiaGrid(grdPropietarios)
        End If
    End Sub

    Sub PLAjustaGrid(ByRef Celdas As COBISCorp.Framework.UI.Components.COBISGrid, ByRef Ventana As FTran358Class)
        Dim ancho As Integer = 0
        Dim VTWidth As Integer = 0
        For i As Integer = 1 To Celdas.Cols - 1
            ancho = 0
            For j As Integer = 0 To Celdas.Rows - 1
                Celdas.Row = j : Celdas.Col = i
                If VTWidth > ancho Then ancho = VTWidth
            Next j
            Celdas.ColWidth(CShort(i)) = IIf(ancho <= 0, 100, CInt(ancho - 0.15 * ancho))
        Next i
    End Sub

    Private Sub FTran358_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        cbotipocta.Items.Add(FMLoadResString(502554)) 'Cuenta Corriente
        cbotipocta.Items.Add(FMLoadResString(502555)) 'Cuenta de Ahorros
        cbotipocta.SelectedIndex = 1
        cbotipocta.Enabled = False
        VLProducto = cbotipocta.Text
        optsigno(0).Checked = True
        mskCuenta.Mask = VGMascaraCtaAho
        MskValor(0).Text = VGDecimales
        MskValor(0).Text = StringsHelper.Format(0, VGDecimales)
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        cmdBoton(3).Enabled = True
        cmdBoton(0).Enabled = False
        mskCuenta.Focus()
    End Sub

    Private Sub FTran358_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPropietarios.DblClick
        grdPropietarios.Col = 1
        If grdPropietarios.CtlText = "3" Then
            cbotipocta.SelectedIndex = 0
            grdPropietarios.Col = 9
            If grdPropietarios.CtlText = "50" Then
                optsigno(0).Checked = True
            Else
                optsigno(1).Checked = True
            End If
        Else
            cbotipocta.SelectedIndex = 1
            grdPropietarios.Col = 9
            If grdPropietarios.CtlText = "264" Then
                optsigno(0).Checked = True
            Else
                optsigno(1).Checked = True
            End If
        End If
        grdPropietarios.Col = 2
        txtcuenta.Text = grdPropietarios.CtlText
        txtcuenta.Enabled = False
        grdPropietarios.Col = 3
        txtCampo(0).Text = grdPropietarios.CtlText
        txtCampo_Leave(txtCampo(0), New EventArgs())
        txtCampo(0).Enabled = False
        grdPropietarios.Col = 4
        MskValor(0).Text = grdPropietarios.CtlText
        MskValor(0).Enabled = False
        grdPropietarios.Col = 7
        txtObservacion.Text = grdPropietarios.CtlText
        txtObservacion.Enabled = False
        grdPropietarios.Col = 8
        txtsecuencial.Text = grdPropietarios.CtlText
        If txtCampo(0).Text <> "" Then
            cmdBoton(5).Enabled = True
        Else
            cmdBoton(5).Enabled = False
        End If
        lblObservacion(0).Visible = True
        txtcuenta.Visible = True
        PLTSEstado()
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTBase As String = ""
        Dim VTProcedure As String = ""
        Dim VTTransaccion As String = ""
        Dim VTMensaje As String = String.Empty
        Try
            If cbotipocta.SelectedIndex = 0 Then
                VTBase = "cob_cuentas"
                VTProcedure = "sp_tr_query_nom_ctacte"
                VTTransaccion = "16"
                If Not FMChequeaCtaCte(mskCuenta.ClipText) And mskCuenta.ClipText <> "" Then
                    VTMensaje = FMLoadResString(501391) 'El dígito verificador de la cuenta corriente está incorrecto
                    GoTo Salir_Pantalla
                End If
            ElseIf cbotipocta.SelectedIndex = 1 Then
                VTBase = "cob_ahorros"
                VTProcedure = "sp_tr_query_nom_ctahorro"
                VTTransaccion = "206"
                If Not FMChequeaCtaAho(mskCuenta.ClipText) And mskCuenta.ClipText <> "" Then
                    VTMensaje = FMLoadResString(508917) 'El dígito verificador de la cuenta de ahorros está incorrecto
                    GoTo Salir_Pantalla
                End If
            End If
            If mskCuenta.ClipText <> "" Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VTTransaccion)
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, VTBase, VTProcedure, True, FMLoadResString(2544) & "[" & mskCuenta.Text & "]") Then 'Ok... Consulta la cuenta
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    txtCampo(0).Enabled = True
                    MskValor(0).Enabled = True
                    txtObservacion.Enabled = True
                    'txtCampo(0).Focus()
                    txtCampo(0).Text = ""
                    lblDescripcion(1).Text = ""
                    MskValor(0).Text = VGDecimales
                    MskValor(0).Text = StringsHelper.Format(0, VGDecimales)
                    txtObservacion.Text = ""
                    lblObservacion(0).Visible = False
                    txtcuenta.Visible = False
                Else
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(1), New EventArgs())
                    Exit Sub
                End If
            Else
                lblDescripcion(0).Text = ""
            End If

            Compruebacampos()
            Exit Sub
Salir_Pantalla:
            COBISMessageBox.Show(VTMensaje, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            cmdBoton_Click(cmdBoton(1), New EventArgs())
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement("Resume in On-Error-Resume-Next Block")
        End Try
        Compruebacampos()
    End Sub

    Private Sub MskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _MskValor_0.KeyPress
        Dim Index As Integer = Array.IndexOf(MskValor, eventSender)
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Select Case Index
            Case 0
                If Val(MskValor(0).Text) > 100000000 Then
                    'Valor excede el máximo permitido
                    If KeyAscii <> 8 Then
                        COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        KeyAscii = 0
                    End If
                End If
                If VGDecimales = "#,##0" Then
                    If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                        KeyAscii = 0
                    End If
                Else
                    If (KeyAscii <> 8) And (KeyAscii <> 46) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                        KeyAscii = 0
                    End If
                End If
                eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        End Select
        Compruebacampos()
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _MskValor_0.Leave
        Dim Index As Integer = Array.IndexOf(MskValor, eventSender)
        Select Case Index
            Case 0
                MskValor(0).Text = StringsHelper.Format(CDec(MskValor(0).Text), VGDecimales)
        End Select
        Compruebacampos()
    End Sub

    Sub Compruebacampos()
        cmdBoton(0).Enabled = False
        If Val(MskValor(0).Text) > 0 And txtCampo(0).Text <> "" And lblDescripcion(0).Text <> "" Then 'And txtObservacion.Text <> ""
            cmdBoton(0).Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
        Compruebacampos()
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown
        Dim KeyCode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTabla As String = ""
        Select Case Index
            Case 0
                If cbotipocta.SelectedIndex = 0 Then
                    If optsigno(0).Checked Then
                        VTTabla = "cc_causa_nd"
                    ElseIf optsigno(1).Checked Then
                        VTTabla = "cc_causa_nc"
                    End If
                ElseIf cbotipocta.SelectedIndex = 1 Then
                    If optsigno(0).Checked Then
                        VTTabla = "ah_causa_nd"
                    ElseIf optsigno(1).Checked Then
                        VTTabla = "ah_causa_nc"
                    End If
                End If
                If KeyCode = VGTeclaAyuda Then
                    VLPaso = True
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VTTabla)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2549)) Then 'Ok... Consulta de tipos de bloqueos
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                        If txtCampo(0).Text <> "" Then
                            MskValor(0).Focus()
                        End If
                        FCatalogo.Dispose()
                    Else
                        PMChequea(sqlconn)
                        txtCampo(0).Text = ""
                        lblDescripcion(1).Text = ""
                        txtCampo(0).Focus()
                    End If
                End If
        End Select
        Compruebacampos()
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 2
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        Compruebacampos()
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTabla As String = ""
        If Not VLPaso Then
            Select Case Index
                Case 0
                    If cbotipocta.SelectedIndex = 0 Then
                        If optsigno(0).Checked Then
                            VTTabla = "cc_causa_nd"
                        ElseIf optsigno(1).Checked Then
                            VTTabla = "cc_causa_nc"
                        End If
                    ElseIf cbotipocta.SelectedIndex = 1 Then
                        If optsigno(0).Checked Then
                            VTTabla = "ah_causa_nd"
                        ElseIf optsigno(1).Checked Then
                            VTTabla = "ah_causa_nc"
                        End If
                    End If
                    If txtCampo(0).Text <> "" Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VTTabla)
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(0).Text)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(2551) & "[" & txtCampo(0).Text & "]") Then ' Ok... Consulta del parámetro
                            PMMapeaObjeto(sqlconn, lblDescripcion(1))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            VLPaso = True
                            txtCampo(0).Text = ""
                            lblDescripcion(1).Text = ""
                            If txtCampo(0).Enabled Then
                                txtCampo(0).Focus()
                            End If
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
            End Select
        End If
        Compruebacampos()
    End Sub

    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBReversar.Enabled = _cmdBoton_5.Enabled
        TSBReversar.Visible = _cmdBoton_5.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBSiguiente.Enabled = _cmdBoton_6.Enabled
        TSBSiguiente.Visible = _cmdBoton_6.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBImprimir.Enabled = _cmdBoton_4.Enabled
        TSBImprimir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBReversar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBReversar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub txtObservacion_KeyPress(sender As Object, e As KeyPressEventArgs) Handles txtObservacion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If (KeyAscii > 47 And KeyAscii < 58) Or (KeyAscii > 64 And KeyAscii < 91) Or (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        Else
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            e.Handled = True
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

End Class


