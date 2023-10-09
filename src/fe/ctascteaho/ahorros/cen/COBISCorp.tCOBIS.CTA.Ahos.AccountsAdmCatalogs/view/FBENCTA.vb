Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FBenCtaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLTrn As String = ""
    Dim VLBase As String = ""
    Dim VLSP As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim respuesta As DialogResult
        Select Case Index
            Case 0
                If txtCed.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500130), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCed.Focus()
                    Exit Sub
                End If
                If txtNombre.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500131), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNombre.Focus()
                    Exit Sub
                End If
                If txtPctje.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500132), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtPctje.Text) > 100 Then
                    COBISMessageBox.Show(FMLoadResString(500133), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtPctje.Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(500134), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrn)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "I")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(0).Trim())
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, txtCed.Text.Trim())
                PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtNombre.Text.Trim())
                PMPasoValores(sqlconn, "@i_porcentaje", 0, SQLFLT8, txtPctje.Text.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(509256)) Then
                    PMChequea(sqlconn)
                    PLLimpiar()
                Else
                    PMChequea(sqlconn)
                End If
                PLBuscar()
            Case 1
                If txtCed.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500130), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCed.Focus()
                    Exit Sub
                End If
                If txtNombre.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500131), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNombre.Focus()
                    Exit Sub
                End If
                If txtPctje.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500132), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtPctje.Text) > 100 Then
                    COBISMessageBox.Show(FMLoadResString(500133), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtPctje.Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(500134), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtPctje.Focus()
                    Exit Sub
                End If
                grdBeneficiarios.Col = 1
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrn)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "U")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(0).Trim())
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_ced_ruc", 0, SQLVARCHAR, txtCed.Text.Trim())
                PMPasoValores(sqlconn, "@i_nombre", 0, SQLVARCHAR, txtNombre.Text.Trim())
                PMPasoValores(sqlconn, "@i_porcentaje", 0, SQLFLT8, txtPctje.Text.Trim())
                PMPasoValores(sqlconn, "@i_beneficiario", 0, SQLINT4, grdBeneficiarios.CtlText.Trim())
                If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(509257)) Then
                    PMChequea(sqlconn)
                    PLLimpiar()
                Else
                    PMChequea(sqlconn)
                End If
                PLBuscar()
                cmdBoton(0).Enabled = True
                cmdBoton(1).Enabled = False
                cmdBoton(2).Enabled = True
                grdBeneficiarios.Enabled = True
            Case 2
                grdBeneficiarios.Col = 3
                If grdBeneficiarios.CtlText <> "" And grdBeneficiarios.Row <> 0 Then
                    respuesta = COBISMessageBox.Show(FMLoadResString(500135) & grdBeneficiarios.CtlText & " ?", My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo)
                    If respuesta = System.Windows.Forms.DialogResult.No Then
                        Exit Sub
                    End If
                    grdBeneficiarios.Col = 1
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrn)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "D")
                    PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(0).Trim())
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_beneficiario", 0, SQLINT4, grdBeneficiarios.CtlText.Trim())
                    If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(509258) & "[" & grdBeneficiarios.CtlText & "]") Then
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                    End If
                    PLBuscar()
                Else
                    COBISMessageBox.Show(FMLoadResString(500136), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                End If
            Case 3
                PLLimpiar()
            Case 4
                If VGADatosI(3) <> "consulta" And Not FLVerificar() Then Exit Sub
                Me.Close()
        End Select
    End Sub

    Public Sub PLInicializar()
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLLimpiaGrid()
        PLLimpiar()
        SSPCta(0).Text = VGADatosI(0)
        SSPCta(1).Text = VGADatosI(1)
        If VGADatosI(3) = "consulta" Then
            frnBeneficiario.Enabled = False
            frnBeneficiario.Visible = False
        Else
            frnBeneficiario.Enabled = True
            frnBeneficiario.Visible = True
        End If
        If VGADatosI(2) = "3" Then
            VLTrn = "2821"
            VLBase = "cob_cuentas"
            VLSP = "sp_beneficiario_ctacte"
        Else
            VLTrn = "333"
            VLBase = "cob_ahorros"
            VLSP = "sp_beneficiario_ahorros"
        End If
        PLBuscar()
    End Sub
    Private Sub PLTSEstado()
        TSBAgregar.Enabled = _cmdBoton_0.Enabled
        TSBAgregar.Visible = _cmdBoton_0.Visible

        TSBModificar.Enabled = _cmdBoton_1.Enabled
        TSBModificar.Visible = _cmdBoton_1.Visible

        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible

        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub


    Private Sub FBenCta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()

    End Sub

    Private Sub FBenCta_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdBeneficiarios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdBeneficiarios.Click
        grdBeneficiarios.Col = 0
        grdBeneficiarios.SelStartCol = 1
        grdBeneficiarios.SelEndCol = grdBeneficiarios.Cols - 1
        If grdBeneficiarios.Row = 0 Then
            grdBeneficiarios.SelStartRow = 1
            grdBeneficiarios.SelEndRow = 1
        Else
            grdBeneficiarios.SelStartRow = grdBeneficiarios.Row
            grdBeneficiarios.SelEndRow = grdBeneficiarios.Row
        End If
    End Sub

    Private Sub grdBeneficiarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdBeneficiarios.DblClick
        grdBeneficiarios.Col = 0
        grdBeneficiarios.SelStartCol = 1
        grdBeneficiarios.SelEndCol = grdBeneficiarios.Cols - 1
        If grdBeneficiarios.Row = 0 Then
            grdBeneficiarios.SelStartRow = 1
            grdBeneficiarios.SelEndRow = 1
        Else
            grdBeneficiarios.Col = 1
            If grdBeneficiarios.CtlText <> "" And VGADatosI(3) <> "consulta" Then
                grdBeneficiarios.SelStartRow = grdBeneficiarios.Row
                grdBeneficiarios.SelEndRow = grdBeneficiarios.Row
                grdBeneficiarios.Col = 2
                txtCed.Text = grdBeneficiarios.CtlText.Trim()
                grdBeneficiarios.Col = 3
                txtNombre.Text = grdBeneficiarios.CtlText.Trim()
                grdBeneficiarios.Col = 4
                txtPctje.Text = grdBeneficiarios.CtlText.Trim()
                cmdBoton(1).Enabled = True
                cmdBoton(0).Enabled = False
                cmdBoton(2).Enabled = False
                grdBeneficiarios.Enabled = False
                If txtCed.Enabled And txtCed.Visible Then txtCed.Focus()
            Else
                cmdBoton(0).Enabled = True
                cmdBoton(1).Enabled = False
                cmdBoton(2).Enabled = False
                grdBeneficiarios.Enabled = True
            End If
        End If
    End Sub

    Private Sub grdBeneficiarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdBeneficiarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500137))
    End Sub

    Private Sub PLLimpiaGrid()
        PMLimpiaGrid(grdBeneficiarios)
        grdBeneficiarios.Cols = 5
        grdBeneficiarios.ColWidth(0) = 400
        grdBeneficiarios.ColWidth(1) = 1
        grdBeneficiarios.ColWidth(2) = 1500
        grdBeneficiarios.ColWidth(3) = 3300
        grdBeneficiarios.ColWidth(4) = 780
        grdBeneficiarios.Row = 0
        grdBeneficiarios.Col = 0
        grdBeneficiarios.CtlText = "No."
        grdBeneficiarios.Col = 1
        grdBeneficiarios.CtlText = "Secuencial"
        grdBeneficiarios.Col = 2
        grdBeneficiarios.CtlText = "Ced. /NIT /Pas."
        grdBeneficiarios.Col = 3
        grdBeneficiarios.CtlText = "Nombre"
        grdBeneficiarios.Col = 4
        grdBeneficiarios.CtlText = "Porcentaje"
    End Sub

    Private Sub txtCed_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtCed.Enter
        txtCed.SelectionStart = 0
        txtCed.SelectionLength = Strings.Len(txtCed.Text)
    End Sub

    Private Sub txtCed_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtCed.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) And (KeyAscii < 48 Or KeyAscii < 57) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtNombre_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtNombre.Enter
        txtNombre.SelectionStart = 0
        txtNombre.SelectionLength = Strings.Len(txtNombre.Text)
    End Sub

    Private Sub txtPctje_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtPctje.Enter
        txtPctje.SelectionStart = 0
        txtPctje.SelectionLength = Strings.Len(txtPctje.Text)
    End Sub

    Private Sub txtNombre_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtNombre.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If (KeyAscii <> 8 And KeyAscii <> 32 And KeyAscii <> 209) And ((KeyAscii < 48) Or (KeyAscii > 57)) And (KeyAscii < 65 Or KeyAscii > 90) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtPctje_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txtPctje.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) And (KeyAscii <> 46) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLLimpiar()
        txtCed.Text = ""
        txtNombre.Text = ""
        txtPctje.Text = ""
        cmdBoton(0).Enabled = True
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = True
        grdBeneficiarios.Enabled = True
        If txtCed.Enabled And txtCed.Visible Then txtCed.Focus()
    End Sub

    Private Sub PLBuscar()
        Dim VTR As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrn)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "S")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(0).Trim())
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(509256)) Then
            Dim Beneficiarios(8, 40) As String
            VTR = FMMapeaMatriz(sqlconn, Beneficiarios)
            PMLimpiaGrid(grdBeneficiarios)
            PMChequea(sqlconn)
            PLLimpiaGrid()
            For i As Integer = 1 To VTR
                grdBeneficiarios.AddItem(Conversion.Str(i) & ChrW(9) & Beneficiarios(0, i) & ChrW(9) & Beneficiarios(1, i) & ChrW(9) & Beneficiarios(2, i) & ChrW(9) & Beneficiarios(3, i))
            Next i
            If grdBeneficiarios.Rows > 2 Then
                grdBeneficiarios.RemoveItem(1)
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Function FLVerificar() As Boolean
        Dim result As Boolean = False
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, VLTrn)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, "T")
        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, VGADatosI(0).Trim())
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(509256)) Then
            PMChequea(sqlconn)
            result = True
        Else
            PMChequea(sqlconn)
        End If
        Return result
    End Function

    Private Sub TSBAGREGAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAgregar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBMODIFICAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBELIMINAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

End Class


