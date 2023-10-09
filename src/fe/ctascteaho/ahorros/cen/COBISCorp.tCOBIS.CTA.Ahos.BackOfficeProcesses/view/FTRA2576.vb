Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.tCOBIS.CTA.Ahos.Query

Partial Public Class FTran2576Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLFechahasta As String = ""
    Dim VLMonto As Double = 0
    Dim VLMonto_crtmp As Double = 0
    Dim VT As Integer = 0
    Dim VTFecha1 As String = ""
    Dim VTFecha2 As String = ""
    Dim VTFecha As String = ""
    Dim VTModificable As String = ""
    Dim i As Integer = 0
    Dim j As Integer = 0
    Dim VLFormatoFecha As String = ""


    Private Sub FTran2576_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMBotonSeguridad(Me, 11)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        cmbprodb.Items.Insert(0, FMLoadResString(509495))
        cmbprodb.Items.Insert(1, FMLoadResString(509303))
        cmbprodb.SelectedIndex = 1
        cmbaplicacomision.Items.Insert(0, FMLoadResString(9028))
        cmbaplicacomision.Items.Insert(1, FMLoadResString(509496))
        cmbaplicacomision.SelectedIndex = 0
        Mskcuentadb.Mask = VGMascaraCtaAho
        Mskcuentacr.Mask = VGMascaraCtaAho
        chkmodificable.Checked = 1
        txtCampo(2).Text = "0"
        txtCampo(3).Text = "0"
        mskvalordb.Text = "0.00"
        mskvalorcomision.Text = "0.00"
        mskvalorcr.Text = "0.00"
        cmbTipo.Items.Insert(0, FMLoadResString(509495))
        cmbTipo.Items.Insert(1, FMLoadResString(509303))
        cmbTipo.SelectedIndex = 1
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        'mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        mskfechahasta.Mask = FMMascaraFecha(VLFormatoFecha)
        mskfechahasta.DateType = PLFormatoFecha()
        mskfechahasta.Connection = VGMap
        'mskfechahasta.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        PLBuscarLaborable()
        VLFechahasta = mskfechahasta.Text
        VLMonto = CDbl(mskvalordb.Text)
        cmdBoton(9).Enabled = False
        cmdBoton(4).Enabled = False
        lblDescripcion(1).Text = "0.00"
        VLPaso = True
        txtCampo(4).Focus()
        PLTSEstado()
    End Sub

    Private Sub cmbprodb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500016))
    End Sub

    Private Sub cmbaplicacomision_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbaplicacomision.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500050))
    End Sub

    Private Sub cmbaplicacomision_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbaplicacomision.Leave
        If mskvalorcomision.Text = "" Then
            mskvalorcomision.Text = "0.00"
        End If
    End Sub

    Private Sub cmbprodb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbprodb.Leave
        If cmbprodb.SelectedIndex = 0 Then
            Mskcuentadb.Mask = VGMascaraCtaCte
        Else
            Mskcuentadb.Mask = VGMascaraCtaAho
        End If
        Mskcuentadb_Leave(Mskcuentadb, New EventArgs())
    End Sub

    Private Sub Mskcuentadb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508675))
        Mskcuentadb.SelectionStart = 0
        Mskcuentadb.SelectionLength = Strings.Len(Mskcuentadb.Text)
    End Sub

    Private Sub Mskcuentadb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentadb.Leave
        Try
            If Mskcuentadb.ClipText <> "" Then
                If cmbprodb.SelectedIndex = 0 Then
                    If FMChequeaCtaCte(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(3).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(3).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(3).Text = ""
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(3).Text = ""
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Private Sub mskvalorcomision_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskvalorcomision.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500051))
        mskvalorcomision.SelectionStart = 0
        mskvalorcomision.SelectionLength = Strings.Len(mskvalorcomision.Text)
    End Sub

    Private Sub mskvalorcomision_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskvalorcomision.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
        If KeyAscii = 46 Then
            If mskvalorcomision.Text.IndexOf("."c) + 1 Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskvalorcomision_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskvalorcomision.Leave
        If mskvalorcomision.Text = "" Then
            mskvalorcomision.Text = "0.00"
        End If
        If cmbaplicacomision.SelectedIndex = 1 Then
            If Conversion.Val(mskvalorcomision.Text) > 100 Or Conversion.Val(mskvalorcomision.Text) <= 0 Then
                COBISMessageBox.Show(FMLoadResString(500052), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskvalorcomision.Text = "0.00"
                If mskvalorcomision.Enabled And mskvalorcomision.Visible Then mskvalorcomision.Focus()
            End If
        End If
    End Sub

    Private Sub mskvalordb_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskvalordb.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500053))
        mskvalordb.SelectionStart = 0
        mskvalordb.SelectionLength = Strings.Len(mskvalordb.Text)
    End Sub

    Private Sub mskvalordb_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskvalordb.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
        If KeyAscii = 46 Then
            If mskvalordb.Text.IndexOf("."c) + 1 Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskvalordb_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskvalordb.Leave
        If mskvalordb.Text = "" Then
            mskvalordb.Text = "0.00"
        End If
    End Sub

    Private Sub sscobracomision_CheckStateChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles sscobracomision.CheckStateChanged
        Dim Value As CheckState = sscobracomision.Checked
        sscobracomision_ClickHelper(Value)
    End Sub

    Private Sub sscobracomision_ClickHelper(ByRef Value As CheckState)
        cmbaplicacomision.Enabled = sscobracomision.Checked
        mskvalorcomision.Enabled = sscobracomision.Checked
        If cmbaplicacomision.Enabled Then
            If cmbaplicacomision.Enabled And cmbaplicacomision.Visible Then cmbaplicacomision.Focus()
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.TextChanged, _txtCampo_0.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 4
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500054))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500055))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500056))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500057))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500058))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(508567))
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_4.KeyDown, _txtCampo_0.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown, _txtCampo_3.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            txtCampo(Index).Text = ""
            Select Case Index
                Case 0
                    PMCatalogo("A", "re_tipo_transfer", txtCampo(0), lblDescripcion(2))
                    VLPaso = True
                Case 1
                    PMCatalogo("A", "cc_period_transfer", txtCampo(1), lblDescripcion(4))
                Case 4
                    ReDim VGADatosO(1)
                    FCtranAut.ShowPopup(Me)
                    Me.Cursor = System.Windows.Forms.Cursors.Arrow
                    txtCampo(4).Text = VGADatosO(0)
                    If txtCampo(4).Text <> "" Then
                        PLBuscar()
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_4.KeyPress, _txtCampo_0.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2, 3, 4
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 1
                If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub
    Private Sub Mskcuentacr_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentacr.Leave
        Try
            If Mskcuentacr.ClipText <> "" Then
                If cmbTipo.SelectedIndex = 0 Then
                    If FMChequeaCtaCte(Mskcuentacr.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentacr.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & Mskcuentacr.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentacr.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(0).Text = ""
                            If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentacr.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(0).Text = ""
                        If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(Mskcuentacr.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentacr.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & Mskcuentacr.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                            'mskvalorcr.Focus()
                        Else
                            PMChequea(sqlconn)
                            Mskcuentacr.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(0).Text = ""
                            If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentacr.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(0).Text = ""
                        If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub
    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_4.Leave, _txtCampo_0.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave, _txtCampo_3.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                If Not VLPaso Then
                    If txtCampo(0).Text <> "" Then
                        PMCatalogo("V", "re_tipo_transfer", txtCampo(0), lblDescripcion(2))
                    Else
                        lblDescripcion(2).Text = ""
                    End If
                End If
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "cc_period_transfer", txtCampo(1), lblDescripcion(4))
                    Else
                        lblDescripcion(4).Text = ""
                    End If
                    If txtCampo(1).Text = "Q" Then
                        txtCampo(2).Enabled = True
                        txtCampo(3).Enabled = True
                        If txtCampo(2).Text = "" Then
                            txtCampo(2).Text = "0"
                        End If
                        If txtCampo(3).Text = "" Then
                            txtCampo(3).Text = "0"
                        End If
                        If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Else
                        If txtCampo(1).Text = "M" Then
                            txtCampo(2).Enabled = True
                            txtCampo(3).Text = ""
                            If txtCampo(3).Text = "" Then
                                txtCampo(3).Text = "0"
                            End If
                            txtCampo(3).Enabled = False
                            txtCampo(2).Focus()
                        Else
                            txtCampo(2).Enabled = False
                            txtCampo(3).Enabled = False
                        End If
                    End If
                End If
            Case 2
                If Conversion.Val(Convert.ToString(txtCampo(2).Text)) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Text = ""
                    txtCampo(2).Focus()
                    Exit Sub
                End If
            Case 3
                If Conversion.Val(Convert.ToString(txtCampo(3).Text)) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500077), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(3).Text = ""
                    txtCampo(3).Focus()
                    Exit Sub
                End If
                If Conversion.Val(Convert.ToString(txtCampo(2).Text)) > Conversion.Val(Convert.ToString(txtCampo(3).Text)) Then
                    COBISMessageBox.Show(FMLoadResString(500079), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Text = ""
                    txtCampo(2).Focus()
                    Exit Sub
                End If
            Case 4
                If txtCampo(4).Text <> "" Then
                    cmdBoton(6).Enabled = True
                End If
        End Select
        PLTSEstado()
    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508732))
    End Sub

    Private Sub cmbTipo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Leave
        If cmbTipo.SelectedIndex = 0 Then
            Mskcuentacr.Mask = VGMascaraCtaCte
        Else
            Mskcuentacr.Mask = VGMascaraCtaAho
        End If
        Mskcuentacr_Leave(Mskcuentacr, New EventArgs())
    End Sub

    Private Sub Mskcuentacr_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles Mskcuentacr.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500060))
        Mskcuentacr.SelectionStart = 0
        Mskcuentacr.SelectionLength = Strings.Len(Mskcuentacr.Text)
    End Sub

    Private Sub mskvalorcr_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskvalorcr.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500061))
        mskvalorcr.SelectionStart = 0
        mskvalorcr.SelectionLength = Strings.Len(mskvalorcr.Text)
    End Sub

    Private Sub mskvalorcr_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskvalorcr.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
            KeyAscii = 0
        End If
        If KeyAscii = 46 Then
            If mskvalorcr.Text.IndexOf("."c) + 1 Then
                KeyAscii = 0
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500062) & VGFormatoFecha & "]")
        mskFecha.SelectionStart = 0
        mskFecha.SelectionLength = Strings.Len(mskFecha.Text)
    End Sub

    Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Leave
        If mskFecha.ClipText <> "" Then
            VT = FMVerFormato(mskFecha.Text, VGFormatoFecha)
            If Not VT Then
                COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskFecha.Mask = ""
                mskFecha.Text = ""
                mskFecha.Mask = FMMascaraFecha(VGFormatoFecha)
                'mskFecha.DateType = PLFormatoFecha()
                mskFecha.Connection = VGMap
                mskFecha.Focus()
                Exit Sub
            End If
        End If
    End Sub

    Private Sub mskfechahasta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500062) & VGFormatoFecha & "]")
        mskfechahasta.SelectionStart = 0
        mskfechahasta.SelectionLength = Strings.Len(mskfechahasta.Text)
    End Sub

    Private Sub mskfechahasta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskfechahasta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskfechahasta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Leave
        If mskfechahasta.ClipText <> "" Then
            VT = FMVerFormato(mskfechahasta.Text, VGFormatoFecha)
            If Not VT Then
                COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskfechahasta.Mask = ""
                mskfechahasta.Text = ""
                mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha)
                mskfechahasta.DateType = PLFormatoFecha()
                mskfechahasta.Connection = VGMap
                mskfechahasta.Focus()
                Exit Sub
            Else
                VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
                VTFecha2 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
                If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
                    COBISMessageBox.Show(FMLoadResString(500066), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskfechahasta.Mask = ""
                    mskfechahasta.Text = ""
                    mskfechahasta.Mask = FMMascaraFecha(VGFormatoFecha)
                    mskfechahasta.DateType = PLFormatoFecha()
                    mskfechahasta.Connection = VGMap
                    mskfechahasta.Focus()
                    mskfechahasta.Text = FMDateAdd(VGFechaProceso, "d", 1, VGFormatoFecha)
                    If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Private Sub FTran2576_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_8.Click, _cmdBoton_9.Click, _cmdBoton_10.Click, _cmdBoton_0.Click, _cmdBoton_6.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_1.Click, _cmdBoton_7.Click, _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_11.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBBotones.Focus()
        Select Case Index
            Case 0
                If FLTransferenciaCuadrada() Then
                    Me.Close()
                Else
                    COBISMessageBox.Show(FMLoadResString(500067), FMLoadResString(500068), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    Exit Sub
                End If
            Case 1
                If Not FLTransferenciaCuadrada() Then
                    If COBISMessageBox.Show(FMLoadResString(500069), FMLoadResString(500068), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then
                        Exit Sub
                    End If
                End If
                PLLimpiar()
                VLMonto_crtmp = 0
                Me.Cursor = System.Windows.Forms.Cursors.Arrow
                txtCampo(4).Focus()
            Case 2
                PLEliminar()
            Case 3
                PLCrear()
            Case 4
                PLActualizar()
            Case 5
            Case 6
                PLBuscar()
            Case 7
                PLImprimir()
                Me.Cursor = System.Windows.Forms.Cursors.Arrow
            Case 8
                PLCrearDetalle()
            Case 9
                PLEliminarDetalle()
            Case 10
                PLLimpiarDetalle()
                VLMonto_crtmp = 0
            Case 11
                PLAutorizar()
        End Select
    End Sub

    Private Sub PLBuscarLaborable()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "711")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508800)) Then
            PMMapeaVariable(sqlconn, VTFecha)
            PMChequea(sqlconn)
            If VTFecha.Trim().Length = 0 Then
                COBISMessageBox.Show(FMLoadResString(500070), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            mskFecha.Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
            mskfechahasta.Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
        Else
            mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLBuscar()
        If txtCampo(4).Text = "" Then
            If Mskcuentadb.ClipText = "" Then
                COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                Exit Sub
            End If
            If txtCampo(0).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "711")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508800)) Then
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            txtCampo(0).Text = VTArreglo(1)
            lblDescripcion(2).Text = VTArreglo(2)
            If VTArreglo(3) = "S" Then
                sscobracomision.Checked = True
            Else
                sscobracomision.Checked = False
            End If
            If VTArreglo(4) = "M" Then
                cmbaplicacomision.SelectedIndex = 0
                mskvalorcomision.Text = VTArreglo(6)
            Else
                cmbaplicacomision.SelectedIndex = 1
                mskvalorcomision.Text = VTArreglo(5)
            End If
            mskvalordb.Text = VTArreglo(7)
            txtCampo(1).Text = VTArreglo(8)
            lblDescripcion(4).Text = VTArreglo(9)
            If VTArreglo(8) = "Q" Then
                txtCampo(2).Enabled = True
                txtCampo(3).Enabled = True
            Else
                txtCampo(2).Enabled = False
                txtCampo(3).Enabled = False
            End If
            txtCampo(2).Text = VTArreglo(10)
            txtCampo(3).Text = VTArreglo(11)
            mskFecha.Text = VTArreglo(12)
            mskfechahasta.Text = VTArreglo(13)
            VLFechahasta = mskfechahasta.Text
            VLMonto = CDbl(mskvalordb.Text)
            txtCampo(4).Text = VTArreglo(14)
            txtCampo(4).Enabled = False
            If VTArreglo(16) = "CTE" Then
                cmbprodb.SelectedIndex = 0
            Else
                cmbprodb.SelectedIndex = 1
            End If
            If VTArreglo(17) = "S" Then
                Me.chkmodificable.Checked = 1
            Else
                Me.chkmodificable.Checked = 0
            End If
            Mskcuentadb.Enabled = True
            If VTArreglo(15) <> "" And VTArreglo(16) = "AHO" Then
                Mskcuentadb.Mask = VGMascaraCtaAho
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                Mskcuentadb.Text = FMMascara(VTArreglo(15), VGMascaraCtaAho)
            End If
            If VTArreglo(15) <> "" And VTArreglo(16) = "CTE" Then
                Mskcuentadb.Mask = VGMascaraCtaCte
                Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                Mskcuentadb.Text = FMMascara(VTArreglo(15), VGMascaraCtaCte)
            End If
            If VTArreglo(15) <> "" And VTArreglo(16) <> "" Then
                PLBuscar_Cuenta()
            End If
            cmbprodb.Enabled = False
            Mskcuentadb.Enabled = False
            txtCampo(0).Enabled = False
            cmdBoton(3).Enabled = False
            cmdBoton(4).Enabled = True
            cmdBoton(2).Enabled = True
            cmdBoton(6).Enabled = False
            mskvalordb.Enabled = True
            cmbaplicacomision.Enabled = False
            sscobracomision.Enabled = False
            txtCampo(2).Enabled = False
            txtCampo(3).Enabled = False
            mskFecha.Enabled = False
            mskfechahasta.Enabled = True
            mskvalorcomision.Enabled = False
            grdRegistros.Enabled = True
            Frame1.Enabled = True
            cmbTipo.Enabled = True
            Mskcuentacr.Enabled = True
            lblDescripcion(0).Enabled = True
            mskvalorcr.Enabled = True
            lblDescripcion(1).Enabled = True
            cmdBoton(8).Enabled = True
            cmdBoton(9).Enabled = True
            cmdBoton(10).Enabled = True
            PLBuscarDetalle()
            If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.Focus()
            lblDescripcion(1).Text = StringsHelper.Format(FLSumarValoresGrid(), "###,###,##0.00")
            If (CDbl(lblDescripcion(1).Text)) = CDec(mskvalordb.Text) Then
                lblDescripcion(5).Text = FMLoadResString(502468)
            Else
                lblDescripcion(5).Text = FMLoadResString(502469)
            End If
        Else
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = False
            cmdBoton(2).Enabled = False
            cmdBoton(3).Enabled = True
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        cmbprodb.SelectedIndex = 1
        cmbaplicacomision.SelectedIndex = 0
        cmbTipo.SelectedIndex = 0
        Me.chkmodificable.Checked = 1
        Mskcuentadb.Mask = FMMascara("", VGMascaraCtaAho)
        Mskcuentacr.Mask = FMMascara("", VGMascaraCtaAho)
        txtCampo(2).Text = "0"
        txtCampo(3).Text = "0"
        txtCampo(2).Enabled = False
        txtCampo(3).Enabled = False
        txtCampo(4).Text = ""
        txtCampo(4).Enabled = True
        mskvalordb.Text = "0.00"
        mskvalorcomision.Text = "0.00"
        mskvalorcr.Text = "0.00"
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFecha.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFecha.DateType = PLFormatoFecha()
        mskFecha.Connection = VGMap
        'mskFecha.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        mskfechahasta.Mask = FMMascaraFecha(VLFormatoFecha)
        mskfechahasta.DateType = PLFormatoFecha()
        mskfechahasta.Connection = VGMap
        sscobracomision.Checked = False
        PLBuscarLaborable()
        mskFecha.Enabled = True
        mskfechahasta.Enabled = True
        lblDescripcion(2).Text = ""
        lblDescripcion(4).Text = ""
        lblDescripcion(0).Text = ""
        lblDescripcion(3).Text = ""
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        cmdBoton(3).Enabled = True
        cmdBoton(2).Enabled = False
        cmdBoton(4).Enabled = False
        cmdBoton(6).Enabled = True
        cmdBoton(7).Enabled = False
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = False
        cmdBoton(10).Enabled = True
        If Not cmbprodb.Enabled Then
            cmbprodb.Enabled = True
        End If
        Mskcuentadb.Enabled = True
        txtCampo(0).Enabled = True
        mskvalorcr.Enabled = True
        mskvalordb.Enabled = True
        Mskcuentacr.Enabled = True
        cmbTipo.Enabled = True
        cmbaplicacomision.Enabled = False
        sscobracomision.Enabled = True
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(3).Enabled = True
        mskFecha.Enabled = True
        mskfechahasta.Enabled = True
        mskvalorcomision.Enabled = False
        lblDescripcion(1).Text = "0.00"
        PMLimpiaGrid(grdRegistros)
        cmdBoton(9).Enabled = False
        grdRegistros.Enabled = False
        Frame1.Enabled = False
        cmbTipo.Enabled = False
        Mskcuentacr.Enabled = False
        lblDescripcion(0).Enabled = False
        mskvalorcr.Enabled = False
        lblDescripcion(1).Enabled = False
        cmdBoton(8).Enabled = False
        cmdBoton(9).Enabled = False
        cmdBoton(10).Enabled = False
        If txtCampo(4).Enabled Then txtCampo(4).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLLimpiarDetalle()
        mskvalorcr.Enabled = True
        Mskcuentacr.Enabled = True
        cmbTipo.Enabled = True
        cmbprodb.SelectedIndex = 1
        Mskcuentacr.Mask = FMMascara("", VGMascaraCtaAho)
        lblDescripcion(0).Text = ""
        mskvalorcr.Text = "0.00"
        PMLimpiaGrid(grdRegistros)
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = False
        cmdBoton(10).Enabled = True
        cmdBoton(8).Text = "Crear"
        If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.Focus()
        PLBuscarDetalle()
        PLTSEstado()
    End Sub

    Private Sub PLCrear()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
            Exit Sub
        End If
        If mskvalordb.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500073), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
            Exit Sub
        Else
            If CDec(mskvalordb.Text) <= 0 Then
                COBISMessageBox.Show(FMLoadResString(500074), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
                Exit Sub
            End If
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500075), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
            Exit Sub
        Else
            If txtCampo(1).Text = "Q" Then
                If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(3).Text) <= 0 Or Conversion.Val(txtCampo(3).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500077), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(2).Text) = Conversion.Val(txtCampo(3).Text) Then
                    COBISMessageBox.Show(FMLoadResString(500078), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(2).Text) > Conversion.Val(txtCampo(3).Text) Then
                    COBISMessageBox.Show(FMLoadResString(500079), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
            End If
            If txtCampo(1).Text = "M" Then
                If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "714")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Text)
        If sscobracomision.Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
            If cmbaplicacomision.SelectedIndex = 0 Then
                PMPasoValores(sqlconn, "@i_base_comision", 0, SQLCHAR, "M")
                PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, "0.0")
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskvalorcomision.Text)
            Else
                PMPasoValores(sqlconn, "@i_base_comision", 0, SQLCHAR, "P")
                PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, mskvalorcomision.Text)
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, "0.00")
            End If
        Else
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, "0.0")
            PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, "0.00")
        End If
        PMPasoValores(sqlconn, "@i_monto_total", 0, SQLMONEY, mskvalordb.Text)
        PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text)
        Select Case txtCampo(1).Text
            Case "Q"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text)
            Case "M"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
            Case "D"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
        End Select
        If mskFecha.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500080), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.Focus()
            Exit Sub
        End If
        If mskfechahasta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500081), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500083), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
        If chkmodificable.Checked = CheckState.Checked Then
            VTModificable = "S"
        Else
            VTModificable = "N"
        End If
        PMPasoValores(sqlconn, "@i_modificable", 0, SQLCHAR, VTModificable)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508799)) Then
            PMMapeaVariable(sqlconn, VTFecha)
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(500084), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txtCampo(4).Text = VTFecha
            Mskcuentadb.Enabled = False
            txtCampo(0).Enabled = False
            cmbprodb.Enabled = False
            cmdBoton(4).Enabled = False
            cmdBoton(2).Enabled = True
            cmdBoton(3).Enabled = False
            cmdBoton(6).Enabled = False
            cmbaplicacomision.Enabled = False
            sscobracomision.Enabled = False
            txtCampo(1).Enabled = False
            txtCampo(2).Enabled = False
            txtCampo(3).Enabled = False
            txtCampo(4).Enabled = False
            mskFecha.Enabled = False
            mskfechahasta.Enabled = False
            mskvalorcomision.Enabled = False
            mskvalordb.Enabled = False
            grdRegistros.Enabled = True
            Frame1.Enabled = True
            cmbTipo.Enabled = True
            Mskcuentacr.Enabled = True
            lblDescripcion(0).Enabled = True
            mskvalorcr.Enabled = True
            lblDescripcion(1).Enabled = True
            cmdBoton(8).Enabled = True
            cmdBoton(9).Enabled = True
            cmdBoton(10).Enabled = True
            VLFechahasta = mskfechahasta.Text
            VLMonto = CDbl(mskvalordb.Text)
            If cmbTipo.Enabled And cmbTipo.Visible Then cmbTipo.Focus()
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub PLActualizar()
        Dim VTEstado As String = "N"
        Dim VTValorSumadoGrid As Double = 0
        VTValorSumadoGrid = FLSumarValoresGrid()
        If VTValorSumadoGrid = CDec(mskvalordb.Text) Then
            VTEstado = "I"
        End If
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, VTEstado)
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
            Exit Sub
        End If
        If mskvalordb.Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500073), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
            Exit Sub
        Else
            If CDec(mskvalordb.Text) <= 0 Then
                COBISMessageBox.Show(FMLoadResString(500074), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
                Exit Sub
            End If
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500075), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
            Exit Sub
        Else
            If txtCampo(1).Text = "Q" Then
                If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(3).Text) <= 0 Or Conversion.Val(txtCampo(3).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500077), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(2).Text) = Conversion.Val(txtCampo(3).Text) Then
                    COBISMessageBox.Show(FMLoadResString(500078), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
                If Conversion.Val(txtCampo(2).Text) > Conversion.Val(txtCampo(3).Text) Then
                    COBISMessageBox.Show(FMLoadResString(500079), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
            End If
            If txtCampo(1).Text = "M" Then
                If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                    COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                    Exit Sub
                End If
            End If
        End If
        VTValorSumadoGrid = 0
        VTValorSumadoGrid = FLSumarValoresGrid()
        VLMonto_crtmp = CDbl(mskvalorcr.Text)
        If VTValorSumadoGrid > CDec(mskvalordb.Text) Then
            COBISMessageBox.Show(FMLoadResString(500087), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskvalordb.Enabled And mskvalordb.Visible Then mskvalordb.Focus()
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500088), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.Focus()
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(VLFechahasta, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500089), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskfechahasta.Text = VLFechahasta
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "715")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Text)
        If sscobracomision.Checked Then
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "S")
            If cmbaplicacomision.SelectedIndex = 0 Then
                PMPasoValores(sqlconn, "@i_base_comision", 0, SQLCHAR, "M")
                PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, "0.0")
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskvalorcomision.Text)
            Else
                PMPasoValores(sqlconn, "@i_base_comision", 0, SQLCHAR, "P")
                PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, mskvalorcomision.Text)
                PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, "0.00")
            End If
        Else
            PMPasoValores(sqlconn, "@i_comision", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_tasa", 0, SQLFLT8, "0.0")
            PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, "0.00")
        End If
        PMPasoValores(sqlconn, "@i_monto_total", 0, SQLMONEY, mskvalordb.Text)
        PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text)
        Select Case txtCampo(1).Text
            Case "Q"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text)
            Case "M"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
            Case "D"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
        End Select
        If mskFecha.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500080), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.Focus()
            Exit Sub
        End If
        If mskfechahasta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500081), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
            Exit Sub
        End If
        VTFecha2 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If chkmodificable.Checked = CheckState.Checked Then
            VTModificable = "S"
        Else
            VTModificable = "N"
        End If
        PMPasoValores(sqlconn, "@i_modificable", 0, SQLCHAR, VTModificable)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508798)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(500090), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Mskcuentadb.Enabled = False
            txtCampo(0).Enabled = False
            cmbprodb.Enabled = False
            VLFechahasta = mskfechahasta.Text
            VLMonto = CDbl(mskvalordb.Text)
        Else
            PMChequea(sqlconn)
            PLLimpiar()
        End If
    End Sub

    Private Sub PLEliminar()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500091), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "716")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508797)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(500093), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLCrearDetalle()
        If cmdBoton(8).Text = FMLoadResString(500037) Then
            VLMonto_crtmp = 0
        End If
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentadb.Enabled Then
                If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
            End If
            Exit Sub
        End If
        If Mskcuentacr.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500094), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
            Exit Sub
        End If
        If Mskcuentadb.ClipText = Mskcuentacr.ClipText Then
            COBISMessageBox.Show(FMLoadResString(500095), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If mskFecha.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500080), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskFecha.Enabled And mskFecha.Visible Then mskFecha.Focus()
            Exit Sub
        End If
        If mskfechahasta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500081), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
            Exit Sub
        End If
        If Conversion.Val(mskvalorcr.Text) <= 0 Then
            COBISMessageBox.Show(FMLoadResString(500096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskvalorcr.Enabled And mskvalorcr.Visible Then mskvalorcr.Focus()
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskfechahasta.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        If FMDateDiff("d", VTFecha2, VTFecha1, VGFormatoFecha) < 0 Then
            COBISMessageBox.Show(FMLoadResString(500082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        VTFecha1 = StringsHelper.Format(mskFecha.Text, VGFormatoFecha)
        VTFecha2 = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Dim VTValorSumadoGrid As Double = 0
        VTValorSumadoGrid = FLSumarValoresGrid()
        If (VTValorSumadoGrid - VLMonto_crtmp + CDbl(mskvalorcr.Text)) > CDec(mskvalordb.Text) Then
            COBISMessageBox.Show(FMLoadResString(500097), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskvalorcr.Enabled And mskvalorcr.Visible Then mskvalorcr.Focus()
            Exit Sub
        End If
        If (VTValorSumadoGrid + CDbl(mskvalorcr.Text)) = CDec(mskvalordb.Text) Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "I")
        End If
        If mskfechahasta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500081), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If mskfechahasta.Enabled And mskfechahasta.Visible Then mskfechahasta.Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled And txtCampo(1).Visible Then txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text = "Q" Then
            If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                Exit Sub
            End If
            If Conversion.Val(txtCampo(3).Text) <= 0 Or Conversion.Val(txtCampo(3).Text) > 31 Then
                COBISMessageBox.Show(FMLoadResString(500077), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(3).Enabled And txtCampo(3).Visible Then txtCampo(3).Focus()
                Exit Sub
            End If
            If Conversion.Val(txtCampo(2).Text) = Conversion.Val(txtCampo(3).Text) Then
                COBISMessageBox.Show(FMLoadResString(500078), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                Exit Sub
            End If
            If Conversion.Val(txtCampo(2).Text) > Conversion.Val(txtCampo(3).Text) Then
                COBISMessageBox.Show(FMLoadResString(500079), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                Exit Sub
            End If
        End If
        If txtCampo(1).Text = "M" Then
            If Conversion.Val(txtCampo(2).Text) <= 0 Or Conversion.Val(txtCampo(2).Text) > 31 Then
                COBISMessageBox.Show(FMLoadResString(500076), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                Exit Sub
            End If
        End If
        If mskfechahasta.Text <> VLFechahasta Then
            COBISMessageBox.Show(FMLoadResString(500099), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        If CDbl(mskvalordb.Text) <> VLMonto Then
            COBISMessageBox.Show(FMLoadResString(500099), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "717")
        If cmdBoton(8).Text = "Crear" Then
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
        Else
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        End If
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        If cmbTipo.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_org", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_org", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(3).Text)
        PMPasoValores(sqlconn, "@i_cta_banco_org", 0, SQLVARCHAR, Mskcuentacr.ClipText)
        PMPasoValores(sqlconn, "@i_nombre_org", 0, SQLVARCHAR, lblDescripcion(0).Text)
        PMPasoValores(sqlconn, "@i_periodicidad", 0, SQLCHAR, txtCampo(1).Text)
        Select Case txtCampo(1).Text
            Case "Q"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, txtCampo(3).Text)
            Case "M"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
            Case "D"
                PMPasoValores(sqlconn, "@i_dia_1", 0, SQLINT1, "0")
                PMPasoValores(sqlconn, "@i_dia_2", 0, SQLINT1, "0")
        End Select
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
        PMPasoValores(sqlconn, "@i_monto", 0, SQLMONEY, mskvalorcr.Text)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_transfer", True, FMLoadResString(508801)) Then
            PMChequea(sqlconn)
            PLLimpiarDetalle()
            PLBuscarDetalle()
            lblDescripcion(1).Text = StringsHelper.Format(FLSumarValoresGrid(), "###,###,##0.00")
            If (CDbl(lblDescripcion(1).Text)) = CDec(mskvalordb.Text) Then
                lblDescripcion(5).Text = FMLoadResString(502468)
            Else
                lblDescripcion(5).Text = FMLoadResString(502469)
            End If
        Else
            PMChequea(sqlconn)
            Mskcuentacr.Text = FMMascara("", VGMascaraCtaCte)
            lblDescripcion(0).Text = ""
            mskvalorcr.Text = "0.00"
            PLBuscar()
        End If
        PLTSEstado()
    End Sub

    Private Sub PLEliminarDetalle()
        If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If Mskcuentadb.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500071), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
            Exit Sub
        End If
        If Mskcuentacr.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500094), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Mskcuentacr.Enabled And Mskcuentacr.Visible Then Mskcuentacr.Focus()
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "718")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
        PMPasoValores(sqlconn, "@i_cta_banco_org", 0, SQLVARCHAR, Mskcuentacr.ClipText)
        PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_transfer", True, FMLoadResString(508797)) Then
            PMChequea(sqlconn)
            PLLimpiarDetalle()
            PLBuscarDetalle()
            lblDescripcion(1).Text = StringsHelper.Format(FLSumarValoresGrid(), "###,###,##0.00")
            If (CDbl(lblDescripcion(1).Text)) = CDec(mskvalordb.Text) Then
                lblDescripcion(5).Text = FMLoadResString(502468)
            Else
                lblDescripcion(5).Text = FMLoadResString(502469)
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLBuscarDetalle()
        Dim VTRegistros As Integer = 20
        Dim VTFlag As Integer = False
        Dim VTCuentaCredito As String = ""
        Dim VTModo As Integer = 0
        While VTRegistros = 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "713")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_tipo_transfer", 0, SQLVARCHAR, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_cta_banco_dst", 0, SQLVARCHAR, Mskcuentadb.ClipText)
            If VTCuentaCredito <> "" Then
                PMPasoValores(sqlconn, "@i_cta_banco_org", 0, SQLVARCHAR, VTCuentaCredito)
            End If
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, CStr(VTModo))
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mant_transfer", True, FMLoadResString(508800)) Then
                PMMapeaGrid(sqlconn, grdRegistros, VTFlag)
                PMMapeaTextoGrid(grdRegistros)
                PMChequea(sqlconn)
                VTFlag = True
                VTModo = 1
                VTRegistros = Conversion.Val(Convert.ToString(grdRegistros.Tag))
                grdRegistros.Row = grdRegistros.Rows - 1
                grdRegistros.Col = 2
                VTCuentaCredito = grdRegistros.CtlText
                cmdBoton(7).Enabled = True
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
        End While
        grdRegistros.ColAlignment(5) = 1
        grdRegistros.ColAlignment(6) = 1
        PLTSEstado()
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.ClickEvent
        grdRegistros.Col = 0
        grdRegistros.SelStartCol = 1
        grdRegistros.SelEndCol = grdRegistros.Cols - 1
        If grdRegistros.Row = 0 Then
            grdRegistros.SelStartRow = 1
            grdRegistros.SelEndRow = 1
        Else
            grdRegistros.SelStartRow = grdRegistros.Row
            grdRegistros.SelEndRow = grdRegistros.Row
        End If
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 1
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500113), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        cmbTipo.Enabled = False
        grdRegistros.Col = 1
        If grdRegistros.CtlText = "CTE" Then
            cmbTipo.SelectedIndex = 0
            grdRegistros.Col = 2
            Mskcuentacr.Text = FMMascara(grdRegistros.CtlText, VGMascaraCtaCte)
        Else
            cmbTipo.SelectedIndex = 1
            grdRegistros.Col = 2
            Mskcuentacr.Text = FMMascara(grdRegistros.CtlText, VGMascaraCtaAho)
        End If
        Mskcuentacr.Enabled = False
        grdRegistros.Col = 3
        lblDescripcion(0).Text = grdRegistros.CtlText
        grdRegistros.Col = 4
        mskvalorcr.Text = grdRegistros.CtlText
        mskvalorcr.Enabled = True
        VLMonto_crtmp = 0
        VLMonto_crtmp = CDbl(mskvalorcr.Text)
        If cmdBoton(8).Text = FMLoadResString(500037) Then
            cmdBoton(8).Text = FMLoadResString(500046)
        End If
        cmdBoton(8).Enabled = True
        cmdBoton(9).Enabled = True
        cmdBoton(10).Enabled = True
        PLTSEstado()
    End Sub

    Private Function FLSumarValoresGrid() As Double
        Dim result As Double = 0
        grdRegistros.Col = 1
        If grdRegistros.CtlText.Trim() <> "" Then
            For i As Integer = 1 To grdRegistros.Rows - 1
                grdRegistros.Col = 4
                grdRegistros.Row = i
                result += CDbl(grdRegistros.CtlText)
            Next i
        End If
        Return result
    End Function

    Private Sub PLImprimir()
        Dim Linea As String = String.Empty
        Dim cmbtipodst As String = "" 'JSA
        grdRegistros.Col = 1
        If grdRegistros.CtlText.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500100), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500101), FMLoadResString(500092), COBISMessageBox.COBISButtons.OK Or COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Yes Then
            Me.Cursor = System.Windows.Forms.Cursors.WaitCursor
            FMCabeceraReporte(VGBanco, DateTimeHelper.ToString(DateTime.Today), FMLoadResString(5094979), DateTimeHelper.ToString(DateTimeHelper.Time), Me.Text, VGFecha, CStr(1))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 10
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 98))
            Linea = FMLoadResString(509498) & txtCampo(4).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Linea = FMLoadResString(509499) & txtCampo(0).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Linea = FMLoadResString(509500) & lblDescripcion(2).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Linea = FMLoadResString(509501) & cmbtipodst & "    " & Mskcuentadb.Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Linea = FMLoadResString(509502) & lblDescripcion(3).Text
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Linea = FMLoadResString(509503) & StringsHelper.Format(mskvalordb.Text, "0.00")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 98))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            Linea = FMLoadResString(509504)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(New String("-", 98))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            For i As Integer = 1 To grdRegistros.Rows - 1
                Linea = ""
                grdRegistros.Row = i
                For j As Integer = 1 To grdRegistros.Cols - 1
                    grdRegistros.Col = j
                    Select Case j
                        Case 1, 5, 6
                            Linea = Linea & grdRegistros.CtlText & New String(" "c, 2)
                        Case 2
                            Linea = Linea & grdRegistros.CtlText & New String(" "c, 1)
                        Case 3
                            Linea = Linea & Strings.Mid(grdRegistros.CtlText, 1, 20) & New String(" "c, 25 - Strings.Mid(grdRegistros.CtlText, 1, 20).Length)
                        Case 4
                            Linea = Linea & New String(" "c, 15 - Strings.Len(grdRegistros.CtlText)) & grdRegistros.CtlText & New String(" "c, 4)
                    End Select
                Next j
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(Linea)
            Next i
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(4), VGLogin)
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509295))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509296))
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
            If VGCodPais <> "CO" Then
                COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FMLoadResString(509299))
            End If
            COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.EndDoc()
            Me.Cursor = System.Windows.Forms.Cursors.Default
        End If
    End Sub

    Private Function FLTransferenciaCuadrada() As Boolean
        Dim result As Boolean = False
        Try
            Dim VTMontoCreditos As Double = 0
            Dim VTMontoDebitos As Double = 0
            VTMontoCreditos = 0
            VTMontoDebitos = 0
            VTMontoDebitos = CDbl(mskvalordb.Text)
            If (grdRegistros.Rows - 1) > 0 Then
                For i As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = i
                    grdRegistros.Col = 1
                    If grdRegistros.CtlText.Trim() = "" And VTMontoDebitos = 0 Then
                        result = True
                    End If
                    grdRegistros.Col = 4
                    VTMontoCreditos += CDbl(grdRegistros.CtlText)
                Next i
            End If
            Return VTMontoDebitos = VTMontoCreditos
        Catch
        End Try
        Return result
    End Function

    Sub PLBuscar_Cuenta()
        Try
            If Mskcuentadb.ClipText <> "" Then
                If cmbprodb.SelectedIndex = 0 Then
                    If FMChequeaCtaCte(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                            lblDescripcion(3).Text = ""
                            PLLimpiar()
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaCte)
                        lblDescripcion(3).Text = ""
                        PLLimpiar()
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                Else
                    If FMChequeaCtaAho(Mskcuentadb.ClipText) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "206")
                        PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, Mskcuentadb.ClipText)
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2274) & Mskcuentadb.Text & "]") Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(3))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                            lblDescripcion(3).Text = ""
                            PLLimpiar()
                            If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                            Exit Sub
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        Mskcuentadb.Text = FMMascara("", VGMascaraCtaAho)
                        lblDescripcion(3).Text = ""
                        PLLimpiar()
                        If Mskcuentadb.Enabled And Mskcuentadb.Visible Then Mskcuentadb.Focus()
                        Exit Sub
                    End If
                End If
            End If
        Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
        End Try
    End Sub

    Sub PLAutorizar()
        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500072), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
            Exit Sub
        End If
        If COBISMessageBox.Show(FMLoadResString(500102), FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question, COBISMessageBox.COBISDefaultButton.Button2) = System.Windows.Forms.DialogResult.No Then
            Exit Sub
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "712")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
        If cmbprodb.SelectedIndex = 0 Then
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "CTE")
        Else
            PMPasoValores(sqlconn, "@i_producto_dst", 0, SQLVARCHAR, "AHO")
        End If
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_mantenca_transfer", True, FMLoadResString(508797)) Then
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(500103), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub
    Private Sub PLTSEstado()
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBBuscar.Visible = _cmdBoton_6.Visible
        TSBBuscar.Enabled = _cmdBoton_6.Enabled
        TSBImprimir.Visible = _cmdBoton_7.Visible
        TSBImprimir.Enabled = _cmdBoton_7.Enabled
        TSBTransmitir.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBAutorizar.Visible = _cmdBoton_11.Visible
        TSBAutorizar.Enabled = _cmdBoton_11.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_0.Visible
        TSBSalir.Enabled = _cmdBoton_0.Enabled
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_6.Enabled Then cmdBoton_Click(_cmdBoton_6, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If _cmdBoton_7.Enabled Then cmdBoton_Click(_cmdBoton_7, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBAutorizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBAutorizar.Click
        If _cmdBoton_11.Enabled Then cmdBoton_Click(_cmdBoton_11, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

End Class


