Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FAUTRETOFClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLSecuencial As String = ""
    Dim VLEstado As String = ""

    Private Sub PLTEstado()
        TSBuscar.Enabled = _cmdBoton_0.Enabled
        TSBuscar.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_1.Enabled
        TSBTransmitir.Visible = _cmdBoton_1.Visible
        TSBBloquear.Enabled = _cmdBoton_3.Enabled
        TSBBloquear.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_2.Enabled
        TSBLimpiar.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_2.Click, _cmdBoton_3.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLTransmitir()
            Case 3
                PLActualizar()
            Case 2
                PLLimpiar()
            Case 4
                Me.Close()
        End Select
    End Sub

    Private Sub PLInicializar()
        mskCuenta.Mask = VGMascaraCtaAho
        txtValor.Text = "0.00"
        optPago(0).Checked = True
        optPago(2).Checked = True
        PLBuscar()
    End Sub

    Private Sub FAUTRETOF_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResIcons(Me)
        PMLoadResStrings(Me)
        MyAppGlobals.AppActiveForm = ""
        PLInicializar()
        PLTEstado()
    End Sub

    Private Sub grdAutoriza_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdAutoriza.ClickEvent
        PMLineaG(grdAutoriza)
        PMMarcaFilaCobisGrid(grdAutoriza, grdAutoriza.Row)
    End Sub

    Private Sub grdAutoriza_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdAutoriza.DblClick
        PMMarcaFilaCobisGrid(grdAutoriza, grdAutoriza.Row)
        PLEscoger()
    End Sub

    Private Sub PLBuscar()
        If mskCuenta.ClipText = "" Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4133")
        If txtValor.Text <> "0.00" Then
            PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, txtValor.Text)
        Else
            PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, "0")
        End If
        If optPago(1).Checked Then
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "C")
        Else
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "E")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
            PMMapeaGrid(sqlconn, grdAutoriza, False)
            PMMapeaTextoGrid(grdAutoriza)
            PMAnchoColumnasGrid(grdAutoriza)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLEscoger()
        grdAutoriza.Col = 1
        Dim VTFila As Integer = grdAutoriza.Row
        grdAutoriza.Row = 1
        If grdAutoriza.Rows <= 2 And grdAutoriza.CtlText = "" Then
            Exit Sub
        End If
        grdAutoriza.Row = VTFila
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuenta.Text = FMMascara(grdAutoriza.CtlText, VGMascaraCtaAho)
        grdAutoriza.Col = 2
        lblNombre.Text = grdAutoriza.CtlText
        grdAutoriza.Col = 3
        If grdAutoriza.CtlText = "E" Then
            optPago(0).Checked = True
            optPago(1).Checked = False
        Else
            optPago(1).Checked = True
            optPago(0).Checked = False
        End If
        grdAutoriza.Col = 4
        txtValor.Text = grdAutoriza.CtlText
        grdAutoriza.Col = 5
        VLEstado = grdAutoriza.CtlText
        grdAutoriza.Col = grdAutoriza.Cols - 2
        If grdAutoriza.CtlText = "S" Then
            optPago(2).Checked = True
            optPago(3).Checked = False
        Else
            optPago(2).Checked = False
            optPago(3).Checked = True
        End If
        grdAutoriza.Col = grdAutoriza.Cols - 1
        VLSecuencial = grdAutoriza.CtlText
        cmdBoton(1).Enabled = False
        cmdBoton(3).Enabled = True
        PLTEstado()
    End Sub

    Private Sub PLTransmitir()
        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508678), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If txtValor.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(508747), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4131")
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, txtValor.Text)
        If optPago(1).Checked Then
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "C")
        Else
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "E")
        End If
        If optPago(2).Checked Then
            PMPasoValores(sqlconn, "@i_ofi_radica", 0, SQLCHAR, "S")
        Else
            PMPasoValores(sqlconn, "@i_ofi_radica", 0, SQLCHAR, "N")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
            PMMapeaGrid(sqlconn, grdAutoriza, False)
            PMMapeaTextoGrid(grdAutoriza)
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLActualizar()
        If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(508678), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If txtValor.Text = "" Or txtValor.Text = "0.00" Then
            COBISMessageBox.Show(FMLoadResString(508747), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If VLEstado = "B" Then
            COBISMessageBox.Show(FMLoadResString(508438), FMLoadResString(502537), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4132")
        PMPasoValores(sqlconn, "@i_secuencial", 0, SQLINT4, VLSecuencial)
        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
        PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, txtValor.Text)
        If optPago(1).Checked Then
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "C")
        Else
            PMPasoValores(sqlconn, "@i_forma_pago", 0, SQLCHAR, "E")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_aut_retiro_oficina", True, "") Then
            PMMapeaGrid(sqlconn, grdAutoriza, False)
            PMMapeaTextoGrid(grdAutoriza)
            PMChequea(sqlconn)
            PLLimpiar()
            PLBuscar()
            cmdBoton(1).Enabled = True
            cmdBoton(3).Enabled = False
        Else
            PMChequea(sqlconn)
        End If
        PLTEstado()
    End Sub

    Private Sub PLLimpiar()
        mskCuenta.Mask = VGMascaraCtaAho
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        txtValor.Text = "0.00"
        lblNombre.Text = ""
        optPago(0).Checked = True
        optPago(2).Checked = True
        PMLimpiaG(grdAutoriza)
        cmdBoton(1).Enabled = True
        cmdBoton(3).Enabled = False
        PLBuscar()
        PLTEstado()
    End Sub

    Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
        Dim VTNombre As String = ""
        If mskCuenta.ClipText <> "" Then
            If FMChequeaCtaAho(mskCuenta.ClipText) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4133")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
                PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_aut_retiro_oficina", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                    PMMapeaVariable(sqlconn, VTNombre)
                    PMChequea(sqlconn)
                    lblNombre.Text = VTNombre
                    cmdBoton(1).Enabled = True
                    cmdBoton(3).Enabled = False
                Else
                    PMChequea(sqlconn)
                    PLLimpiar()
                    Exit Sub
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                PLLimpiar()
                Exit Sub
            End If
        End If
        PLTEstado()
    End Sub

    Private Sub txtValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txtValor.Enter
        txtValor.SelectionStart = 0
        txtValor.SelectionLength = Strings.Len(txtValor.Text)
    End Sub

    Private Sub txtValor_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles txtValor.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
            KeyAscii = 0
        End If
        KeyAscii = FMValidarNumero(txtValor.Text, 16, KeyAscii, "105")
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Function FMValidarNumero(ByRef parValor As String, ByRef parLongitud As Integer, ByRef parcaracter As Integer, ByRef parNemonico As String) As Integer
        Dim CGTeclaMenos As String = ""
        Dim VTSeparadorDecimal As String = "."
        Dim VTDecimal As Integer = 2
        If parcaracter = StringsHelper.ToDoubleSafe(CGTeclaMenos) Then
            Return 0
        End If
        If VTDecimal > 0 Then
            If (parValor.IndexOf(VTSeparadorDecimal) + 1) >= (parLongitud + (VTDecimal) + 1) Then
                Return 0
            Else
                Return parcaracter
            End If
        Else
            If parValor.Length >= parLongitud Then
                Return 0
            Else
                Return parcaracter
            End If
        End If
    End Function

    Private Sub TSBBUSCAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBTRANSMITIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBBLOQUEAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBloquear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLIMPIAR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSALIR_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        mskCuenta.Focus()
    End Sub
End Class


