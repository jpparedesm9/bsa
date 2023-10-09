Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.REC.SharedLibrary
Partial Public Class FCONSTRANClass                     
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLcompara As Integer = 0
    Dim VLVista As String = "1"
    Dim VLTabla As String = ""
    Dim VLBandera As Boolean = False
    Dim VTModo As Integer = 0


    Private Sub PLInicializar()
        mskFecha.DateType = PLFormatoFecha()
        mskfechahasta.DateType = PLFormatoFecha()
        mskFecha.Text = VGFechaProceso
        mskfechahasta.Text = VGFechaProceso
        TSBTransmitir.Enabled = False
        picVisto(0).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31001")
        picVisto(1).Image = COBISCorp.eCOBIS.Commons.Resources.ResourceHandlerManager.GetImage(VGResourceManager, "bmp31002")
        mskFecha.Focus()
    End Sub

    Private Sub FCONSTRAN_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub

    Private Sub FCONSTRAN_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_1.Click, _cmdBoton_0.Click, _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Dim VLPosGrid As Integer = 0
        Dim VTContador As Integer = 0
        Dim VTFecha As Integer
        TSBotones.Focus()
        Select Case Index
            Case 0
                If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(501195), FMLoadResString(500092))
                    mskFecha.Focus()
                    Exit Sub
                End If
                'If IsDate(FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase)) Then
                VTFecha = DateTime.Compare(mskFecha.Text, VGFechaProceso)
                If VTFecha > 0 Then
                    COBISMessageBox.Show(FMLoadResString(20027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Text = VGFechaProceso
                    mskFecha.Focus()
                    Exit Sub
                End If
                For i As Integer = 1 To grdRegistros.Rows - 1
                    grdRegistros.Row = i
                    grdRegistros.Col = 0
                    If grdRegistros.Picture.Equals(picVisto(0).Image) Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "36002")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
                        grdRegistros.Col = 10
                        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, (grdRegistros.CtlText))
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta_super", "sp_cons_trns", True, FMLoadResString(20029)) Then
                            VTContador = VTContador + 1
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                        End If
                    End If
                Next
                If VTContador > 0 Then
                    COBISMessageBox.Show(FMLoadResString(9999), FMLoadResString(500092))
                    cmdBoton_Click(_cmdBoton_1, eventArgs)

                    Exit Sub
                End If
                'Else
                'COBISMessageBox.Show(FMLoadResString(20026), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                'mskFecha.Focus()
                'End If

            Case 1
                If mskFecha.ClipText = "" Then
                    COBISMessageBox.Show(FMLoadResString(501195), FMLoadResString(500092))
                    mskFecha.Focus()
                    Exit Sub
                End If
                If IsDate(mskFecha.Text) Then
                    VTFecha = DateTime.Compare(mskFecha.Text, VGFechaProceso)
                    If VTFecha > 0 Then
                        COBISMessageBox.Show(FMLoadResString(20027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        mskFecha.Text = VGFechaProceso
                        mskFecha.Focus()
                        Exit Sub
                    End If
                    Dim VTFilas As Short
                    Dim VTMaximo As Integer = 0
                    Dim VLTope As Integer
                    VLBandera = True
                    VTModo = 0
                    While VTMaximo = VTFilas
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "36002")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "B")
                        PMPasoValores(sqlconn, "@i_fecha_desde", 0, SQLDATETIME, FMConvFecha(mskFecha.Text, VGFormatoFecha, CGFormatoBase))
                        If mskfechahasta.Visible = True Then
                            PMPasoValores(sqlconn, "@i_fecha_hasta", 0, SQLDATETIME, FMConvFecha(mskfechahasta.Text, VGFormatoFecha, CGFormatoBase))
                        End If
                        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                        PMPasoValores(sqlconn, "@i_causal", 0, SQLCHAR, txtCampo(1).Text)
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, VTModo)
                        If VTModo = "1" Then
                            grdRegistros.Col = 10
                            grdRegistros.Row = grdRegistros.Rows - 1
                            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, (grdRegistros.CtlText))
                        End If
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_conta_super", "sp_cons_trns", True, FMLoadResString(20001)) Then
                            If grdRegistros.Cols >= 10 Then
                                grdRegistros.ColIsVisible(9) = True
                                grdRegistros.ColIsVisible(10) = True
                                grdRegistros.ColIsVisible(13) = True
                            End If
                            PMMapeaGrid(sqlconn, grdRegistros, IIf(VTModo = "0", False, True))
                            PMMapeaTextoGrid(grdRegistros)
                            PMAnchoColumnasGrid(grdRegistros)
                            If grdRegistros.Cols >= 10 Then
                                grdRegistros.ColIsVisible(9) = False
                                grdRegistros.ColIsVisible(10) = False
                                grdRegistros.ColIsVisible(13) = False
                            End If

                            PMChequea(sqlconn)
                            VTFilas = 0
                            VTModo = "1"
                            If VLTope = grdRegistros.Rows - 1 Then
                                Exit While
                            End If
                            VLTope = grdRegistros.Rows - 1
                        Else
                            VTFilas = 1
                            PMChequea(sqlconn)
                        End If

                    End While
                    grdRegistros.Col = 0
                    For i As Integer = 1 To grdRegistros.Rows - 1
                        grdRegistros.Row = i
                        grdRegistros.Picture = picVisto(1).Image
                    Next i
                    VGContadorMaximo = grdRegistros.Rows - 1
                    VGContadorMinimo = grdRegistros.Rows - 1
                    TSBTransmitir.Enabled = False
                Else
                    COBISMessageBox.Show(FMLoadResString(20026), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskFecha.Focus()
                End If
            Case 2
                PLLimpiar()
            Case 3
                Me.Close()
        End Select
    End Sub



    Private Sub mskfechahasta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskfechahasta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2319) & VGFormatoFecha & "]")
        mskfechahasta.SelectionStart = 0
        mskfechahasta.SelectionLength = Strings.Len(mskfechahasta.Text)
    End Sub

    Private Sub mskfechahasta_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskfechahasta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskFecha_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskFecha.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2318) & VGFormatoFecha & "]")
        mskFecha.SelectionStart = 0
        mskFecha.SelectionLength = Strings.Len(mskFecha.Text)

    End Sub

    Private Sub mskFecha_KeyPress(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles mskFecha.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLLimpiar()
        mskFecha.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)
        mskfechahasta.Text = StringsHelper.Format(VGFecha, VGFormatoFecha)    
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""    
        txtCampo(1).Text = ""
        txtCampo(2).Text = ""        
        If cmdBoton(1).Enabled Then
            cmdBoton(1).Enabled = True
        End If
        TSBTransmitir.Enabled = False
        If grdRegistros.Cols >= 10 Then
            grdRegistros.ColIsVisible(9) = True
            grdRegistros.ColIsVisible(10) = True
            grdRegistros.ColIsVisible(13) = False
        End If
        PMLimpiaGrid(grdRegistros)
        mskFecha.Focus()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub TSBBuscar_Click(sender As Object, e As EventArgs) Handles TSBBuscar.Click
        If TSBBuscar.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If TSBTransmitir.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If TSBLimpiar.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If TSBSalir.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBImprimir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBImprimir.Click
        If TSBImprimir.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub
    Private Sub grdRegistros_Enter(sender As Object, e As EventArgs)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500688))
    End Sub

    Private Sub grdRegistros_Leave(sender As Object, e As EventArgs)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub mskfechahasta_LostFocus(sender As Object, e As EventArgs) Handles mskfechahasta.LostFocus
        Dim VT As Integer
        Dim VTFecha1 As String
        Dim VTFecha2 As String
        If mskfechahasta.ClipText <> "" Then
            VT = FMVerFormato((mskfechahasta.Text), VGFormatoFecha)
            If Not VT Then
                COBISMessageBox.Show(FMLoadResString(500063), 48, FMLoadResString(500064))
                mskfechahasta.Focus()
                Exit Sub
            Else
                'Verficar que fecha de consulta sea menor que la fecha del sistema
                VTFecha1 = mskfechahasta.Text
                VTFecha2 = mskFecha.Text
                If FMDateDiff("d", VTFecha1, VTFecha2, VGFormatoFecha) > 0 Then
                    mskfechahasta.Text = mskFecha.Text
                End If
                If FMDateDiff("d", VTFecha1, VGFechaProceso, VGFormatoFecha) <= 0 Then
                    mskfechahasta.Text = VGFechaProceso
                End If
            End If
        End If
    End Sub

    Private Sub txtCampo_Enter(sender As Object, e As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501145))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501146))
        End Select
        VLPaso = True
    End Sub

    Private Sub txtCampo_KeyDown(sender As Object, e As KeyEventArgs) Handles _txtCampo_1.KeyDown, _txtCampo_2.KeyDown
        Dim Keycode As Integer = e.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Dim VTCliente As String = ""
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 1
                    PMCatalogo("A", "sb_causa_reportado", _txtCampo_1, _lblDescripcion_1)
                    If _lblDescripcion_1.Text = "" Then
                        _txtCampo_1.Text = ""
                    End If

                    VLPaso = True

                Case 2
                    PMCatalogo("A", "cl_estados_reportado", _txtCampo_2, _lblDescripcion_2)
                    If _lblDescripcion_2.Text = "" Then
                        _txtCampo_2.Text = ""
                    End If
                    VLPaso = True
            End Select
        End If
    End Sub

    Private Sub txtCampo_TextChanged(sender As Object, e As EventArgs) Handles _txtCampo_1.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Select Case Index
            Case 0, 1, 2, 3, 4, 5
                VLPaso = False
        End Select

    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2
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

    Private Sub _txtCampo_Leave(sender As Object, e As EventArgs) Handles _txtCampo_1.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, sender)
        Select Case Index
            Case 1
                If Not VLPaso Then
                    If txtCampo(1).Text <> "" Then
                        PMCatalogo("V", "sb_causa_reportado", _txtCampo_1, _lblDescripcion_1)
                        If _txtCampo_1.Text = "" Then
                            _lblDescripcion_1.Text = ""
                        End If
                    Else
                        lblDescripcion(1).Text = ""
                    End If
                End If
            Case 2
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        PMCatalogo("V", "cl_estados_reportado", _txtCampo_2, _lblDescripcion_2)
                        If _txtCampo_2.Text = "" Then
                            lblDescripcion(2).Text = ""
                        End If
                    Else
                        lblDescripcion(2).Text = ""
                    End If
                End If
        End Select

    End Sub

    Private Sub grdRegistros_DblClick(sender As Object, e As EventArgs) Handles grdRegistros.DblClick
        PMMarcaFilaCobisGrid(grdRegistros, grdRegistros.Row)
        If grdRegistros.Rows <= 2 Then
            grdRegistros.Row = 1
            grdRegistros.Col = 2
            If grdRegistros.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(502037), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
        End If
        PMMarcarRegistro()
    End Sub
    Private Sub PMMarcarRegistro()
        Dim VTContador As Integer = 0
        grdRegistros.Col = 9
        If grdRegistros.CtlText = "R" Then
            COBISMessageBox.Show(FMLoadResString(50014), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        grdRegistros.Col = 13
        If grdRegistros.CtlText = "OPRE" Or grdRegistros.CtlText = "OPRF" Or grdRegistros.CtlText = "TRIN" Or grdRegistros.CtlText = "APER" Then
            COBISMessageBox.Show(FMLoadResString(50013), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Exit Sub
        End If
        grdRegistros.Col = 0
        If Not grdRegistros.Picture.Equals(picVisto(0).Image) Then
            grdRegistros.Picture = picVisto(0).Image
            VGContadorMaximo = VGContadorMaximo + 1
        Else
            grdRegistros.Picture = picVisto(1).Image
            VGContadorMaximo = VGContadorMaximo - 1
        End If
        If VGContadorMaximo <> VGContadorMinimo Then
            TSBTransmitir.Enabled = True
        Else
            TSBTransmitir.Enabled = False
        End If
    End Sub

    Private Sub grdRegistros_Enter1(sender As Object, e As EventArgs) Handles grdRegistros.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20028))
    End Sub

End Class


