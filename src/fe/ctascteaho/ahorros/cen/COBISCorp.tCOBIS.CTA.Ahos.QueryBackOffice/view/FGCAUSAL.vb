Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Partial Public Class FBusCausalClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
        Dim ErrorSiguientes As Boolean = False
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTNumeroMensaje As String = System.String.Empty
        Dim MaximoRows As Integer = 0
        Try
            Select Case Index
                Case 0
                    If optOpcion(0).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "1")
                    Else
                        If optOpcion(1).Checked Then
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "2")
                        End If
                    End If
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VGCatCausal)
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtCampo.Text)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "741")
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_caubusq", True, System.String.Empty) Then
                        PMMapeaGrid(sqlconn, grdCausales, False)
                        PMChequea(sqlconn)
                        cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdCausales.Tag)) > MaximoRows
                    Else
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdCausales)
                    End If
                Case 1
                    If Conversion.Val(Convert.ToString(grdCausales.Tag)) > 0 Then
                        grdCausales.Row = grdCausales.Rows - 1
                        If optOpcion(0).Checked Then
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "1")
                            grdCausales.Col = 1
                            PMPasoValores(sqlconn, "@i_causal", 0, SQLVARCHAR, grdCausales.CtlText)
                        Else
                            If optOpcion(1).Checked Then
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "2")
                                grdCausales.Col = 2
                                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, grdCausales.CtlText)
                            End If
                        End If
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VGCatCausal)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                        PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtCampo.Text)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "741")
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_caubusq", True, System.String.Empty) Then
                            PMMapeaGrid(sqlconn, grdCausales, True)
                            PMChequea(sqlconn)
                            If CDbl(Convert.ToString(grdCausales.Tag)) > MaximoRows Then
                                PMBotonSeguridad(Me, Index)
                            Else
                                cmdBoton(Index).Enabled = False
                            End If
                            ErrorSiguientes = True
                            grdCausales.TopRow = grdCausales.Rows - 13
                        Else
                            PMChequea(sqlconn)
                            VTNumeroMensaje = FmMapeaNumMensaje().Trim()
                            If VTNumeroMensaje = "151121" Then
                                cmdBoton(Index).Enabled = False
                            End If
                        End If
                    End If
                Case 2
                    If Conversion.Val(Convert.ToString(grdCausales.Tag)) > 0 Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "3")
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "741")
                        grdCausales.Col = 1
                        PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, grdCausales.CtlText)
                        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VGCatCausal)
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                        Dim Valores(10) As String
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_caubusq", True, System.String.Empty) Then
                            FMMapeaArreglo(sqlconn, Valores)
                            PMChequea(sqlconn)
                            VGCausal = Valores(1)
                        Else
                            PMChequea(sqlconn)
                        End If
                        txtCampo.Text = "%"
                        PMLimpiaGrid(grdCausales)
                        Me.Close()
                    End If
                Case 3
                    Me.Close()
                Case 4
                    PMLimpiaGrid(grdCausales)
            End Select
            PLTSEstado()
        Catch excep As System.Exception
            If Not ErrorSiguientes Then
                COBISMessageBox.Show(FMLoadResString(509326), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            End If
            If ErrorSiguientes Then
                grdCausales.TopRow = 1
            End If
        End Try
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Enter, _cmdBoton_1.Enter, _cmdBoton_4.Enter, _cmdBoton_2.Enter, _cmdBoton_3.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508441))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508442))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508559))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500242))
        End Select
    End Sub

    Private Sub PLInicializar()
        PMBotonSeguridad(Me, 0)
        PMBotonSeguridad(Me, 2)
        PMBotonSeguridad(Me, 3)
        PLTSEstado()
    End Sub

    Private Sub FBusCausal_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = System.String.Empty
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub FBusCausal_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
    End Sub

    Private Sub grdCausales_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCausales.Click
        If Conversion.Val(Convert.ToString(grdCausales.Tag)) >= 1 Then
            PMLineaG(grdCausales)
        End If
    End Sub

    Private Sub grdCausales_ClickEvent(sender As Object, e As EventArgs) Handles grdCausales.ClickEvent
        PMMarcaFilaCobisGrid(grdCausales, grdCausales.Row)
    End Sub

    Private Sub grdCausales_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdCausales.DblClick
        cmdBoton_Click(cmdBoton(2), New EventArgs())
    End Sub

    Private Sub grdCausales_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdCausales.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508709))
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optOpcion_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOpcion_1.CheckedChanged, _optOpcion_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optOpcion, eventSender)
            Dim Value As Integer = optOpcion(Index).Checked
            optOpcion_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optOpcion_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        If optOpcion(Index).Checked Then
            lblTitulo(3).Text = "[" & optOpcion(Index).Text & "]"
            txtCampo.Text = "%"
            cmdBoton_Click(cmdBoton(0), New EventArgs())
            txtCampo.Focus()
        End If
    End Sub

    Private Sub optOpcion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOpcion_1.Enter, _optOpcion_0.Enter
        Dim Index As Integer = Array.IndexOf(optOpcion, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508443))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508444))
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Enter
        txtCampo.SelectionStart = 0
        txtCampo.SelectionLength = Strings.Len(txtCampo.Text) - 1
        If optOpcion(0).Checked Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508512))
        Else
            If optOpcion(1).Checked Then
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508656))
            End If
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCampo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If optOpcion(0).Checked Then
            If (KeyAscii <> 8) And (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 37) Then
                KeyAscii = 0
            End If
        Else
            If optOpcion(1).Checked Then
                If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) And (KeyAscii <> 37) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Leave
        If txtCampo.Text = System.String.Empty Then
            txtCampo.Text = "%"
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        txtCampo.Text = txtCampo.Text.Trim()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBSiguiente.Enabled = _cmdBoton_1.Enabled
        TSBSiguiente.Visible = _cmdBoton_1.Visible
        TSBEscoger.Enabled = _cmdBoton_2.Enabled
        TSBEscoger.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEscoger_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEscoger.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
End Class


