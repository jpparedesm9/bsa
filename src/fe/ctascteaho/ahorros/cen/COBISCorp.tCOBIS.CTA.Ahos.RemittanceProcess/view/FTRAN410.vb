Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran410Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Boolean = False
    Dim VLFormatoCorresponsal As String = "____-____-____"

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VTFDesde As String = String.Empty
        Dim VTFHasta As String = String.Empty
        Dim VTUltimo As String = String.Empty
        Dim VTDias As Integer = 0

        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskValor(0).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500353), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(0).Focus()
                    Exit Sub
                End If
                If mskValor(1).ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500354), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskValor(1).Focus()
                    Exit Sub
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", StringsHelper.Format(VGFecha, VGFormatoFecha), mskValor(1).Text, VGFormatoFecha)
                    If VTDias > 0 Then
                        COBISMessageBox.Show(FMLoadResString(500355), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(1).Mask = ""
                        mskValor(1).Text = ""
                        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
                        mskValor(1).Focus()
                        Exit Sub
                    End If
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
                    If VTDias < 0 Then
                        COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(0).Mask = ""
                        mskValor(0).Text = ""
                        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
                        mskValor(0).Focus()
                        Exit Sub
                    End If
                End If
                If mskCampo.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(508538), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCampo.Focus()
                    Exit Sub
                End If
                If Strings.Len(mskCampo.ClipText) <> 12 Then
                    COBISMessageBox.Show(FMLoadResString(508496), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCampo.Focus()
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "410")
                PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, mskCampo.ClipText)
                PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, "0")
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase) ''"mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecini", 0, SQLDATETIME, VTFDesde)
                VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase) ''"mm/dd/yyyy")
                PMPasoValores(sqlconn, "@i_fecfin", 0, SQLDATETIME, VTFHasta)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_cltaxcorr", True, FMLoadResString(508829)) Then
                    PMMapeaGrid(sqlconn, grdRegistros, False)
                    PMAnchoColumnasGrid(grdRegistros)
                    PMChequea(sqlconn)
                    If CDbl(Convert.ToString(grdRegistros.Tag)) <> 0 Then
                        cmdBoton(0).Enabled = True
                        mskCampo.Enabled = False
                    End If
                    cmdBoton(3).Enabled = (grdRegistros.Rows - 1) >= 20
                    grdRegistros.ColAlignment(2) = 2
                Else
                    PMChequea(sqlconn)
                End If
            Case 1
                mskCampo.Enabled = True
                mskCampo.Text = VLFormatoCorresponsal
                lblDescripcion.Text = ""
                PMLimpiaGrid(grdRegistros)
                mskCampo.Focus()
                cmdBoton(3).Enabled = False
                'cmdBoton(0).Enabled = False
                mskValor(0).Mask = ""
                mskValor(0).Text = ""
                mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
                mskValor(1).Mask = ""
                mskValor(1).Text = ""
                mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
                'FMLoadResString(500018)
                For i As Integer = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                    mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                Next i

            Case 2
                Me.Close()
            Case 3
                If mskCampo.ClipText <> "" Then
                    If Strings.Len(mskCampo.ClipText) = 12 Then
                        grdRegistros.Col = 1
                        grdRegistros.Row = grdRegistros.Rows - 1
                        VTUltimo = grdRegistros.CtlText.Trim()
                        VTUltimo = Strings.Mid(VTUltimo, 6, VTUltimo.Length - 5)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "410")
                        PMPasoValores(sqlconn, "@i_corres", 0, SQLVARCHAR, mskCampo.ClipText)
                        PMPasoValores(sqlconn, "@i_ultimo", 0, SQLINT4, VTUltimo)
                        VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                        PMPasoValores(sqlconn, "@i_fecini", 0, SQLDATETIME, VTFDesde)
                        VTFHasta = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                        PMPasoValores(sqlconn, "@i_fecfin", 0, SQLDATETIME, VTFHasta)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_cltaxcorr", True, "Ok... Consulta de cartas por corresponsal") Then
                            PMMapeaGrid(sqlconn, grdRegistros, True)
                            PMAnchoColumnasGrid(grdRegistros)
                            PMChequea(sqlconn)
                            cmdBoton(3).Enabled = (grdRegistros.Rows - 1) >= 20
                        Else
                            PMChequea(sqlconn)
                        End If
                    Else
                        COBISMessageBox.Show(FMLoadResString(508496), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskCampo.Focus()
                    End If
                Else
                    COBISMessageBox.Show(FMLoadResString(508538), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCampo.Focus()
                End If
        End Select
        PLTSEstado()
    End Sub


    Private Sub FTran410_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLTSEstado()
        TSBSiguiente.Enabled = _cmdBoton_3.Enabled
        TSBSiguiente.Visible = _cmdBoton_3.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Public Sub PLInicializar()

        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(0).DateType = PLFormatoFecha()
        mskValor(0).Connection = VGMap

        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(1).DateType = PLFormatoFecha()
        mskValor(1).Connection = VGMap


        For i As Integer = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        Next i
    End Sub

    Private Sub FTran410_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdRegistros_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Click
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

    Private Sub grdRegistros_ClickEvent(sender As Object, e As EventArgs) Handles grdRegistros.ClickEvent
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
    End Sub

    Private Sub grdRegistros_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdRegistros.DblClick
        If grdRegistros.CtlText <> "" Then
            ReDim VGADatosI(3)
            grdRegistros.Col = 1
            VGADatosI(1) = (Strings.Mid(grdRegistros.CtlText.Trim(), 6, Strings.Len(grdRegistros.CtlText) - 5))
            grdRegistros.Col = 2
            VGADatosI(2) = grdRegistros.CtlText
            grdRegistros.Col = 4
            VGADatosI(3) = grdRegistros.CtlText
            FTran432.ShowPopup(Me)
        End If
    End Sub

    Private Sub grdRegistros_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500341))
    End Sub

    Private Sub mskCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCampo.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2324))
        'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" Código del corresponsal [F5 Ayuda] ")
        mskCampo.SelectionStart = 0
        mskCampo.SelectionLength = Strings.Len(mskCampo.Text)
    End Sub

    Private Sub mskCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyEventArgs) Handles mskCampo.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = VGTeclaAyuda Then
            VGOperacion = "sp_rem_ayuda"
            VLPaso = True
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VGHelpRem)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508822)) Then
                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                PMAnchoColumnasGrid(FRegistros.grdRegistros)
                PMChequea(sqlconn)
                FRegistros.ShowPopup(Me)
                FRegistros.cmdSiguientes.Enabled = Conversion.Val(Convert.ToString(FRegistros.grdRegistros.Tag)) = VGMaxRows
                If VGACatalogo.Codigo <> "" Then
                    mskCampo.Text = VGACatalogo.Codigo
                    lblDescripcion.Text = VGACatalogo.Descripcion
                    VLPaso = True
                    cmdBoton(0).Enabled = True
                    mskValor(0).Focus()
                Else
                    Exit Sub
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskCampo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCampo.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        If Not VLPaso Then
            If Strings.Len(mskCampo.ClipText) = 12 And mskCampo.ClipText <> "" Then
                VGOperacion = "sp_rem_ayuda"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "447")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, VGHelpRem)
                PMPasoValores(sqlconn, "@i_tipoc", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_banco_c", 0, SQLVARCHAR, mskCampo.ClipText)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_ayuda", True, FMLoadResString(508822)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion)
                    PMChequea(sqlconn)
                    cmdBoton(0).Enabled = True
                Else
                    PMChequea(sqlconn)
                    VLPaso = True
                    mskCampo.Text = VLFormatoCorresponsal
                    lblDescripcion.Text = ""
                    cmdBoton(3).Enabled = False
                    PMLimpiaGrid(grdRegistros)
                    mskCampo.Focus()
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(508496), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskCampo.Text = VLFormatoCorresponsal
                lblDescripcion.Text = ""
                mskCampo.Focus()
                Exit Sub
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_1.KeyPress, _mskValor_0.KeyPress
        eventArgs.KeyChar = ChrW(FMVAlidaTipoDato("N", Asc(eventArgs.KeyChar)))
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Leave, _mskValor_0.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Dim VTDias As Integer = 0
        Dim VTValido As Boolean = False
        Select Case Index
            Case 0, 1
                If mskValor(Index).ClipText <> "" Then
                    VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
                    If Not VTValido Then
                        COBISMessageBox.Show(FMLoadResString(500063), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        mskValor(Index).Mask = ""
                        mskValor(Index).Text = ""
                        mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha)
                        mskValor(Index).Focus()
                        Exit Sub
                    End If
                End If
                If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
                    VTDias = FMDateDiff("d", mskValor(0).Text, mskValor(1).Text, VGFormatoFecha)
                    If VTDias < 0 Then
                        COBISMessageBox.Show(FMLoadResString(500356), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                        For i As Integer = 0 To 1
                            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha)
                            mskValor(i).Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
                        Next i
                        mskValor(0).Focus()
                        Exit Sub
                    End If
                End If
        End Select
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_1.Enter, _mskValor_0.Enter
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2326))
                'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" Fecha de inicial de la consulta [dd/mm/yyyy]")
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2325))
                'COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" Fecha final de la consulta [dd/mm/yyyy]")
        End Select
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        VGHelpRem = "C"
    End Sub

    Private Sub mskCampo_TextChanged(sender As Object, e As EventArgs) Handles mskCampo.TextChanged
        VLPaso = False
    End Sub
End Class


