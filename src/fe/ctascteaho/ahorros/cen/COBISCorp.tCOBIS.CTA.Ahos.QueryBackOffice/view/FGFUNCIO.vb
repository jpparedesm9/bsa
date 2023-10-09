Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FGFuncionariosClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLRespuesta As Integer = 0
        Dim VTCols As Integer = 0
        Select Case Index
            Case 0
                If optOpcion(0).Checked Then
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "1")
                Else
                    If optOpcion(1).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "2")
                    Else
                        If optOpcion(2).Checked Then
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "3")
                        Else
                            If optOpcion(3).Checked Then
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "4")
                            End If
                        End If
                    End If
                End If
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtCampo.Text)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15001")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcbusq", True, System.String.Empty) Then
                    PMMapeaGrid(sqlconn, grdFuncionarios, False)
                    PMChequea(sqlconn)
                    cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdFuncionarios.Tag)) = VGMaxRows
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                If Conversion.Val(Convert.ToString(grdFuncionarios.Tag)) > 0 Then
                    grdFuncionarios.Row = grdFuncionarios.Rows - 1
                    If optOpcion(0).Checked Then
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "1")
                        grdFuncionarios.Col = 1
                        PMPasoValores(sqlconn, "@i_funcionario", 0, SQLINT2, grdFuncionarios.CtlText)
                    Else
                        If optOpcion(1).Checked Then
                            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "2")
                            grdFuncionarios.Col = 2
                            PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, grdFuncionarios.CtlText)
                        Else
                            If optOpcion(2).Checked Then
                                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "3")
                                grdFuncionarios.Col = 3
                                PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, grdFuncionarios.CtlText)
                            Else
                                If optOpcion(3).Checked Then
                                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "4")
                                    grdFuncionarios.Col = 5
                                    PMPasoValores(sqlconn, "@i_cargo", 0, SQLVARCHAR, grdFuncionarios.CtlText)
                                    grdFuncionarios.Col = 1
                                    PMPasoValores(sqlconn, "@i_funcionario", 0, SQLINT2, grdFuncionarios.CtlText)
                                End If
                            End If
                        End If
                    End If
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                    PMPasoValores(sqlconn, "@i_valor", 0, SQLVARCHAR, txtCampo.Text)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15001")
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcbusq", True, System.String.Empty) Then
                        PMMapeaGrid(sqlconn, grdFuncionarios, True)
                        PMChequea(sqlconn)
                        cmdBoton(1).Enabled = Conversion.Val(Convert.ToString(grdFuncionarios.Tag)) = VGMaxRows
                    Else
                        PMChequea(sqlconn)
                    End If
                End If
            Case 2
                If Conversion.Val(Convert.ToString(grdFuncionarios.Tag)) > 0 Then
                    VTCols = grdFuncionarios.Cols - 1
                    ReDim VGBusqueda(VTCols)
                    For i As Integer = 1 To grdFuncionarios.Cols - 1
                        grdFuncionarios.Col = i
                        VGBusqueda(i) = grdFuncionarios.CtlText
                    Next i
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                    Me.Close()
                End If
            Case 3
                grdFuncionarios.Col = 2
                VLRespuesta = COBISMessageBox.Show(FMLoadResString(500236) & grdFuncionarios.CtlText & " ?", FMLoadResString(500237), COBISMessageBox.COBISButtons.OKCancel, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2)
                If VLRespuesta = 2 Then
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                grdFuncionarios.Col = 1
                PMPasoValores(sqlconn, "@i_funcionario", 0, SQLINT2, grdFuncionarios.CtlText)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1510")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_funcionario", True, FMLoadResString(508812)) Then
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                cmdBoton_Click(cmdBoton(0), New EventArgs())
            Case 4
                ReDim VGBusqueda(1)
                Me.Close()
        End Select
        PLTSEstado()
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Enter, _cmdBoton_1.Enter, _cmdBoton_4.Enter, _cmdBoton_2.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500238))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500239))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500240))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500241))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500242))
        End Select
    End Sub

    Private Sub FGFuncionarios_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = System.String.Empty
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLTSEstado()
        lblTitulo(3).Text = "[" & optOpcion(3).Text & "]"
    End Sub

    Private Sub FGFuncionarios_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
    End Sub

    Private Sub grdFuncionarios_ClickEvent(sender As Object, e As EventArgs) Handles grdFuncionarios.ClickEvent
        PMMarcaFilaCobisGrid(grdFuncionarios, grdFuncionarios.Row)
    End Sub

    Private Sub grdFuncionarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdFuncionarios.DblClick
        Dim Actualizar As Integer = 0
        Dim Eliminar As Integer = 0
        Dim operacion As Integer = 0
        If operacion = Actualizar Then
            cmdBoton_Click(cmdBoton(2), New EventArgs())
        Else
            If operacion = Eliminar Then
                cmdBoton_Click(cmdBoton(3), New EventArgs())
            End If
        End If
    End Sub

    Private Sub grdFuncionarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdFuncionarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500235))
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optOpcion_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOpcion_3.CheckedChanged, _optOpcion_2.CheckedChanged, _optOpcion_1.CheckedChanged, _optOpcion_0.CheckedChanged

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

    Private Sub optOpcion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOpcion_3.Enter, _optOpcion_2.Enter, _optOpcion_1.Enter, _optOpcion_0.Enter
        Dim Index As Integer = Array.IndexOf(optOpcion, eventSender)
        Select Case Index
            Case 0
                'Búsqueda por el Código del Funcionario
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500244))
            Case 1
                'Búsqueda por el Nombre del Funcionario
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500245))
            Case 2
                'Búsqueda por el Login del Funcionario
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500246))
            Case 3
                'Búsqueda por el Cargo del Funcionario
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500247))
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Enter
        txtCampo.SelectionStart = 0
        txtCampo.SelectionLength = Strings.Len(txtCampo.Text) - 1
        If optOpcion(0).Checked Then
            'Código del Funcionario
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500248))
        Else
            If optOpcion(1).Checked Then
                'Nombre del Funcionario
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500249))
            Else
                If optOpcion(2).Checked Then
                    'Login del Funcionario
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500250))
                Else
                    If optOpcion(3).Checked Then
                        'Cargo del Funcionario
                        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500251))
                    End If
                End If
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
            If optOpcion(1).Checked Or optOpcion(3).Checked Then
                If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) And (KeyAscii <> 37) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Else
                If optOpcion(2).Checked Then
                    If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 97 Or KeyAscii > 122) And (KeyAscii <> 37) Then
                        KeyAscii = 0
                    Else
                        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToLower())
                    End If
                End If
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCampo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
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
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub _optOpcion_0_Leave(sender As Object, e As EventArgs) Handles _optOpcion_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub GBFuncionarios_Enter(sender As Object, e As EventArgs) Handles GBFuncionarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500235))
    End Sub

    Private Sub GBFuncionarios_Leave(sender As Object, e As EventArgs) Handles GBFuncionarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub grdFuncionarios_Leave(sender As Object, e As EventArgs) Handles grdFuncionarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


