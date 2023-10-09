Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran099Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLTipo As Integer = 0
    Dim VLDia As Integer = 0
    Dim VLFechaAnt As String = ""
    Dim VLFechaFinAnt As String = ""
    Dim VLSigPuntos As Boolean = False

    Private Sub PLActualizar()
        Dim VTFFin As String = String.Empty
        Dim VTFDesde As String = String.Empty
        If mskValor(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500566), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(0).Focus()
            Exit Sub
        End If
        If mskValor(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500567), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(1).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500568), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" And txtCampo(2).Text.Trim() = "" And txtCampo(3).Text.Trim() = "" And txtCampo(4).Text.Trim() = "" And txtCampo(7).Text.Trim() = "" And txtCampo(6).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500569), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        For i As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = i
            grdOficinas.Col = 0
            If grdOficinas.Picture.Equals(picVisto(0).Image) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "99")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
                grdOficinas.Col = 1
                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, grdOficinas.CtlText)
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                VTFFin = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFDesde)
                PMPasoValores(sqlconn, "@i_linea1", 0, SQLVARCHAR, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_linea2", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_linea3", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_linea4", 0, SQLVARCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_linea5", 0, SQLVARCHAR, txtCampo(6).Text)
                PMPasoValores(sqlconn, "@i_linea6", 0, SQLVARCHAR, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, "0")
                If txtCampo(5).Text <> "T" Then
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(5).Text)
                Else
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
                End If
                PMPasoValores(sqlconn, "@i_fecha_ini_ant", 0, SQLDATETIME, FMConvFecha(VLFechaAnt, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_fecha_fin_ant", 0, SQLDATETIME, FMConvFecha(VLFechaFinAnt, VGFormatoFecha, CGFormatoBase))
                PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFFin)
                If cmbProducto.SelectedIndex = 0 Then
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                Else
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mensaje_estcta", True, FMLoadResString(502516)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdPropietarios)
                End If
            End If
        Next i
        PMMapeaTextoGrid(grdPropietarios)
        PMAnchoColumnasGrid(grdPropietarios)
        grdPropietarios.Focus()
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        For i As Integer = 1 To 7
            If i <> 5 Then
                txtCampo(i).Text = ""
            End If
        Next i
    End Sub

    Private Sub cmbProducto_Enter(sender As Object, e As EventArgs) Handles cmbProducto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502258))
    End Sub

    Private Sub cmbProducto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbProducto.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        'PLLimpiar()
    End Sub

    Private Sub FTran099_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Public Sub PLInicializar()
        VLSigPuntos = False
        Me.Left = 0
        Me.Top = 0

        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
        Dim VTFecha As String = VGFecha
        mskValor(0).Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
        mskValor(1).Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
        cmbProducto.Items.Insert(0, FMLoadResString(502552)) 'CTA. AHORROS
        cmbProducto.Items.Insert(1, FMLoadResString(502553)) 'CTA. CORRIENTE
        cmbProducto.SelectedIndex = 0
        PLConsultarOficinas(0)
        Do While VLSigPuntos
            PLConsultarOficinas(1)
        Loop
        For vti As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = vti
            PMMarcarRegistro()
        Next vti
        picVisto(1).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31002")
        PLTSEstado()
    End Sub

    Private Sub FTran099_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_5.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLTransmitir()
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3
                PLBuscar()
            Case 4
                PLEliminar()
            Case 5
                PLActualizar()
        End Select
    End Sub

    Private Sub grdOficinas_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdOficinas.Click
        grdOficinas.Col = 0
        grdOficinas.SelStartCol = 1
        grdOficinas.SelEndCol = grdOficinas.Cols - 1
        If grdOficinas.Row = 0 Then
            grdOficinas.SelStartRow = 1
            grdOficinas.SelEndRow = 1
        Else
            grdOficinas.SelStartRow = grdOficinas.Row
            grdOficinas.SelEndRow = grdOficinas.Row
        End If
    End Sub

    Private Sub grdOficinas_ClickEvent(sender As Object, e As EventArgs) Handles grdOficinas.ClickEvent
        PMMarcaFilaCobisGrid(grdOficinas, grdOficinas.Row)
    End Sub

    Private Sub grdOficinas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdOficinas.DblClick
        If grdOficinas.Rows <= 2 Then
            grdOficinas.Row = 1
            grdOficinas.Col = 1
            If grdOficinas.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500570), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcaFilaCobisGrid(grdOficinas, grdOficinas.Row)
        PMMarcarRegistro()
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdPropietarios.DblClick
        Dim VTOfiTemp As String = String.Empty
        Dim VTValorcol As String = String.Empty
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)

        PLDesmarcarRegistros()
        grdPropietarios.Col = 1
        If grdPropietarios.CtlText <> "" Then
            grdPropietarios.Col = 1
            VTValorcol = grdPropietarios.CtlText
            For i As Integer = 1 To grdOficinas.Rows - 1
                grdOficinas.Row = i
                grdOficinas.Col = 1
                VTOfiTemp = grdOficinas.CtlText
                If VTValorcol = VTOfiTemp Then
                    grdOficinas.Col = 0
                    grdOficinas.Picture = picVisto(0).Image
                End If
            Next i
            grdPropietarios.Col = 2
            txtCampo(1).Text = grdPropietarios.CtlText
            grdPropietarios.Col = 3
            txtCampo(2).Text = grdPropietarios.CtlText
            grdPropietarios.Col = 4
            txtCampo(3).Text = grdPropietarios.CtlText
            grdPropietarios.Col = 5
            txtCampo(4).Text = grdPropietarios.CtlText
            grdPropietarios.Col = 6
            txtCampo(6).Text = grdPropietarios.CtlText
            grdPropietarios.Col = 7
            txtCampo(7).Text = grdPropietarios.CtlText

            grdPropietarios.Col = 8
            VLFechaAnt = grdPropietarios.CtlText
            grdPropietarios.Col = 9
            VLFechaFinAnt = grdPropietarios.CtlText
            If txtCampo(5).Text = "" Then
                txtCampo(5).Text = "T"
                lblDescripcion(0).Text = FMLoadResString(502616)
            End If
            txtCampo(5).Enabled = False
            cmdBoton(3).Enabled = False
            cmdBoton(5).Enabled = True
            cmdBoton(0).Enabled = False
            PLTSEstado()
        End If
    End Sub

    Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Enter, _mskValor_1.Enter

        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500571) & VGFormatoFecha & "]")
        mskValor(Index).SelectionStart = 0
        mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("FTran099 - V. 7")
    End Sub

    Private Sub mskValor_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Leave, _mskValor_1.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
        Dim VTDias As Integer = 0
        Dim VTValido As Integer = 0
        If mskValor(Index).ClipText <> "" Then
            VTValido = FMVerFormato(mskValor(Index).Text, VGFormatoFecha)
            If Not VTValido Then
                COBISMessageBox.Show(FMLoadResString(500360), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                mskValor(Index).Focus()
                Exit Sub
            End If
        End If
        mskValor(Index).Mask = FMMascaraFecha(VGFormatoFecha)
        If Index = 1 Then
            If mskValor(1).ClipText <> "" And mskValor(0).ClipText <> "" Then
                VTDias = DateAndTime.DateDiff("d", CDate(mskValor(1).Text), CDate(mskValor(0).Text), FirstDayOfWeek.Sunday, FirstWeekOfYear.Jan1)
                If VTDias > 0 Then
                    COBISMessageBox.Show(FMLoadResString(500572), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    mskValor(0).Focus()
                    Exit Sub
                End If
            End If
        End If
    End Sub

    Private Sub PLConsultarOficinas(ByRef parIndex As Integer)
        If parIndex = 0 Then
            PMLimpiaGrid(grdOficinas)
            grdPropietarios.Enabled = False
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "34")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
        Else
            grdOficinas.Col = 1
            grdOficinas.Row = grdOficinas.Rows - 1
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "34")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "O")
            PMPasoValores(sqlconn, "@i_sig", 0, SQLINT2, grdOficinas.CtlText)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_agencia", False, "") Then
            PMMapeaGrid(sqlconn, grdOficinas, parIndex)
            PMChequea(sqlconn)
            VLSigPuntos = Conversion.Val(Convert.ToString(grdOficinas.Tag)) >= 20
        Else
            PMChequea(sqlconn)
        End If
        If grdOficinas.Row > 2 Then
            grdOficinas.Row = 0
            grdOficinas.Col = 0
            grdOficinas.CtlText = FMLoadResString(502944)
            grdOficinas.Col = 1
            grdOficinas.CtlText = FMLoadResString(9919)
            grdOficinas.Col = 2
            grdOficinas.CtlText = FMLoadResString(502597)
            grdOficinas.ColWidth(0) = 1000
            grdOficinas.ColWidth(1) = 1000
            grdOficinas.ColWidth(2) = 6600
        End If
        'PMMapeaTextoGrid(grdOficinas)
        PMAnchoColumnasGrid(grdOficinas)

    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_1.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        VLPaso = True
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502496))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502530))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502533))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502534))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502856))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502881))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509135))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509136))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTProdBanc As String = ""
        Select Case Index
            Case 0
                If Keycode = VGTeclaAyuda Then
                    VGOperacion = "sp_oficina"
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_oficina")
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502501) & "[" & txtCampo(0).Text & "]") Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(0).Text = VGACatalogo.Codigo
                        lblDescripcion(1).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
                End If
            Case 5
                If Keycode = VGTeclaAyuda Then
                    If cmbProducto.SelectedIndex = 0 Then
                        VTProdBanc = CStr(4)
                    Else
                        VTProdBanc = CStr(3)
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, VTProdBanc)
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(502505)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(5).Text = VGACatalogo.Codigo
                        lblDescripcion(0).Text = VGACatalogo.Descripcion
                    Else
                        PMChequea(sqlconn)
                    End If
                    VLPaso = True
                End If
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 5
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 1, 2, 3, 4, 6, 7
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_1.Leave, _txtCampo_2.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Not VLPaso Then
            Select Case Index
                Case 0
                Case 5
                    If txtCampo(5).Text <> "" Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(5).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(502519)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(0))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            lblDescripcion(0).Text = ""
                            txtCampo(5).Text = ""
                        End If
                    Else
                        lblDescripcion(0).Text = ""
                    End If
            End Select
        End If
    End Sub

    Private Sub PMMarcarRegistro()
        If grdOficinas.Row <> 0 Then
            grdOficinas.Col = 0
            If grdOficinas.Picture Is Nothing Then
                grdOficinas.Picture = picVisto(0).Image
            Else
                If (grdOficinas.Picture.Equals(picVisto(0).Image)) Then
                    grdOficinas.Picture = picVisto(1).Image
                Else
                    grdOficinas.Picture = picVisto(0).Image
                End If

            End If
        End If
    End Sub

    Private Sub PLTransmitir()
        Dim VTFFin As String = String.Empty
        Dim VTFDesde As String = String.Empty
        Dim VTBandera As Integer = 0
        If mskValor(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500566), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(0).Focus()
            Exit Sub
        End If
        If mskValor(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500567), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(1).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500568), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(5).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" And txtCampo(2).Text.Trim() = "" And txtCampo(3).Text.Trim() = "" And txtCampo(4).Text.Trim() = "" And txtCampo(6).Text.Trim() = "" And txtCampo(7).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500569), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        VTBandera = 0
        For i As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = i
            grdOficinas.Col = 0
            If grdOficinas.Picture.Equals(picVisto(0).Image) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "99")
                PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
                grdOficinas.Col = 1
                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, grdOficinas.CtlText)
                VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
                VTFFin = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
                PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFDesde)
                PMPasoValores(sqlconn, "@i_linea1", 0, SQLVARCHAR, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_linea2", 0, SQLVARCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_linea3", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_linea4", 0, SQLVARCHAR, txtCampo(4).Text)
                PMPasoValores(sqlconn, "@i_linea5", 0, SQLVARCHAR, txtCampo(6).Text)
                PMPasoValores(sqlconn, "@i_linea6", 0, SQLVARCHAR, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, "0")
                If txtCampo(5).Text <> "" Then
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(5).Text)
                Else
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
                End If
                PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFFin)
                If cmbProducto.SelectedIndex = 0 Then
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                Else
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
                End If
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mensaje_estcta", True, FMLoadResString(502518)) Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    PMChequea(sqlconn)
                    VTBandera = i
                Else
                    PMChequea(sqlconn)
                    PMLimpiaGrid(grdPropietarios)
                End If
            End If
        Next i

        PMMapeaTextoGrid(grdPropietarios)
        PMAnchoColumnasGrid(grdPropietarios)

        grdPropietarios.Focus()

        cmdBoton_Click(cmdBoton(3), New EventArgs())
        If VTBandera <> 0 Then
            For i As Integer = 1 To 7
                If i <> 5 Then
                    txtCampo(i).Text = ""
                End If
            Next i
        End If
    End Sub

    Private Sub PLEliminar()
        Dim VTFFin As String = String.Empty
        Dim VTFDesde As String = String.Empty
        For i As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = i
            grdOficinas.Col = 0
            If grdOficinas.Picture.Equals(picVisto(0).Image) Then
                grdOficinas.Col = 2
                If COBISMessageBox.Show(FMLoadResString(502536) & grdOficinas.CtlText & " ?", FMLoadResString(500092), COBISMessageBox.COBISButtons.YesNo, COBISMessageBox.COBISIcon.Question) = System.Windows.Forms.DialogResult.Yes Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "99")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "E")
                    grdOficinas.Col = 1
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, grdOficinas.CtlText)

                    VTFDesde = FMConvFecha(VLFechaAnt, VGFormatoFecha, CGFormatoBase)
                    VTFFin = FMConvFecha(VLFechaFinAnt, VGFormatoFecha, CGFormatoBase)

                    PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFDesde)
                    PMPasoValores(sqlconn, "@i_linea1", 0, SQLVARCHAR, txtCampo(1).Text)
                    PMPasoValores(sqlconn, "@i_linea2", 0, SQLVARCHAR, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_linea3", 0, SQLVARCHAR, txtCampo(3).Text)
                    PMPasoValores(sqlconn, "@i_linea4", 0, SQLVARCHAR, txtCampo(4).Text)
                    PMPasoValores(sqlconn, "@i_linea5", 0, SQLVARCHAR, txtCampo(6).Text)
                    PMPasoValores(sqlconn, "@i_linea6", 0, SQLVARCHAR, txtCampo(7).Text)
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, "0")
                    If txtCampo(5).Text <> "" Then
                        If txtCampo(5).Text <> "T" Then
                            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(5).Text)
                        Else
                            PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
                        End If
                    Else
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
                    End If
                    If cmbProducto.SelectedIndex = 0 Then
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
                    Else
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
                    End If
                    PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFFin)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mensaje_estcta", True, FMLoadResString(502609)) Then
                        PMMapeaGrid(sqlconn, grdPropietarios, False)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        PMLimpiaGrid(grdPropietarios)
                    End If
                End If
            End If
        Next i
        For i As Integer = 1 To 7
            If i <> 5 Then
                txtCampo(i).Text = ""
            End If
        Next i
        PMAnchoColumnasGrid(grdPropietarios)
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        mskValor(0).Focus()
    End Sub

    Private Sub PLLimpiar()
        mskValor(0).Mask = FMMascaraFecha(VGFormatoFecha)
        mskValor(1).Mask = FMMascaraFecha(VGFormatoFecha)
        Dim VTFecha As String = VGFecha
        
        mskValor(0).Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
        mskValor(1).Text = StringsHelper.Format(VTFecha, VGFormatoFecha)
        lblDescripcion(0).Text = ""
        txtCampo(5).Enabled = True
        For i As Integer = 1 To 7
            txtCampo(i).Text = ""
        Next i
        PMLimpiaGrid(grdPropietarios)
        PLDesmarcarRegistros()
        cmdBoton(3).Enabled = True
        cmdBoton(0).Enabled = True
        mskValor(0).Focus()
        cmdBoton(5).Enabled = False
        cmdBoton(3).Enabled = True
        For vti As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = vti
            PMMarcarRegistro()
        Next vti
        PLTSEstado()
    End Sub

    Private Sub PLBuscar()
        Dim VTFFin As String = String.Empty
        Dim VTFDesde As String = String.Empty
        Dim VTVez As Integer = 0
        Dim VTRows As Integer = 0
        If mskValor(0).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500566), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(0).Focus()
            Exit Sub
        End If
        If mskValor(1).ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500567), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor(1).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(500568), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If Not txtCampo(5).Enabled Then
                txtCampo(5).Enabled = True
            End If
            txtCampo(5).Focus()
            Exit Sub
        End If
        PLDesmarcarRegistros()
        VLTipo = 1
        VTRows = 20
        VTVez = 1
        While VTRows = 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "99")
            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "C")
            If VLTipo = 1 Then
                If VTVez = 1 Then
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, "-1")
                Else
                    grdPropietarios.Row = grdPropietarios.Rows - 1
                    grdPropietarios.Col = 1
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, grdPropietarios.CtlText)
                End If
            Else
                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, txtCampo(0).Text)
            End If
            VTFDesde = FMConvFecha(mskValor(0).Text, VGFormatoFecha, CGFormatoBase)
            VTFFin = FMConvFecha(mskValor(1).Text, VGFormatoFecha, CGFormatoBase)
            PMPasoValores(sqlconn, "@i_fecha", 0, SQLDATETIME, VTFDesde)
            If txtCampo(5).Text <> "" Then
                If txtCampo(5).Text <> "T" Then
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, txtCampo(5).Text)
                Else
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
                End If
            Else
                PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "-1")
            End If
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLINT2, "0")
            PMPasoValores(sqlconn, "@i_linea1", 0, SQLVARCHAR, txtCampo(1).Text)
            PMPasoValores(sqlconn, "@i_linea2", 0, SQLVARCHAR, txtCampo(2).Text)
            PMPasoValores(sqlconn, "@i_linea3", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_linea4", 0, SQLVARCHAR, txtCampo(4).Text)
            PMPasoValores(sqlconn, "@i_linea5", 0, SQLVARCHAR, txtCampo(6).Text)
            PMPasoValores(sqlconn, "@i_linea6", 0, SQLVARCHAR, txtCampo(7).Text)
            PMPasoValores(sqlconn, "@i_fecha_fin", 0, SQLDATETIME, VTFFin)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT2, VGFecha_SP)

            If cmbProducto.SelectedIndex = 0 Then
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "4")
            Else
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT2, "3")
            End If
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_tr_mensaje_estcta", True, FMLoadResString(502518)) Then
                If VTVez = 1 Then
                    PMMapeaGrid(sqlconn, grdPropietarios, False)
                    grdPropietarios.Enabled = Not (grdPropietarios.Row = 0)
                Else
                    PMMapeaGrid(sqlconn, grdPropietarios, True)
                End If
                PMChequea(sqlconn)
                VTRows = Conversion.Val(Convert.ToString(grdPropietarios.Tag))
                VTVez += 1
            Else
                PMChequea(sqlconn)
                PMLimpiaGrid(grdPropietarios)
                VTRows = 0
            End If
        End While
        PMMapeaTextoGrid(grdPropietarios)
        PMAnchoColumnasGrid(grdPropietarios)
    End Sub

    Private Sub PLDesmarcarRegistros()
        For i As Integer = 1 To grdOficinas.Rows - 1
            grdOficinas.Row = i
            If grdOficinas.Row <> 0 Then
                grdOficinas.Col = 0
                If grdOficinas.Picture.Equals(picVisto(0).Image) Then
                    grdOficinas.Picture = picVisto(1).Image
                End If
            End If
        Next i
    End Sub

    Private Sub txtCampo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtCampo_7.MouseDown, _txtCampo_6.MouseDown, _txtCampo_5.MouseDown, _txtCampo_4.MouseDown, _txtCampo_3.MouseDown, _txtCampo_1.MouseDown, _txtCampo_2.MouseDown

    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBEliminar.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_5.Visible
        TSBActualizar.Enabled = _cmdBoton_5.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
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

End Class


