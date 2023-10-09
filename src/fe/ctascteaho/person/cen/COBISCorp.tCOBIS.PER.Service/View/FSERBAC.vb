Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
 Public  Partial  Class FCreaServClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Dim VTEstado As String = string.Empty
		Dim  VTGuarda As String = string.Empty
		Dim VTFilas As Integer = 0
		Dim VTCodigo As String = ""
		Select Case Index
			Case 0
				If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1224), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(0).Focus()
					Exit Sub
				End If
				If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1424), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					txtCampo(2).Focus()
					Exit Sub
				End If
                If mskCosto.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1246), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto.Focus()
                    Exit Sub
                End If
                If optEstado(0).Checked Then
                    VTEstado = "V"
                ElseIf optEstado(1).Checked Then
                    VTEstado = "N"
                End If
                If optGuarda(0).Checked Then
                    VTGuarda = "S"
                ElseIf optGuarda(1).Checked Then
                    VTGuarda = "N"
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4027")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                PMPasoValores(sqlconn, "@i_descr", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_costin", 0, SQLMONEY, mskCosto.Text)
                PMPasoValores(sqlconn, "@i_estad", 0, SQLCHAR, VTEstado)
                PMPasoValores(sqlconn, "@i_histr", 0, SQLCHAR, VTGuarda)
                PMPasoValores(sqlconn, "@i_nemonico", 0, SQLCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ins_serv_pe", True, FMLoadResString(2525)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(1))
                    PMChequea(sqlconn)
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                    cmdBoton(0).Enabled = False
                Else
                    PMChequea(sqlconn)
                End If
                PLTSEstado()
            Case 1
                txtCampo(0).Enabled = True
                cmdBoton_Click(cmdBoton(3), New EventArgs())
                mskCosto.Text = ""
                txtCampo(2).Text = ""
                txtCampo(0).Text = ""
                lblDescripcion(1).Text = ""
                optEstado(0).Checked = True
                optGuarda(0).Checked = True
                PMObjetoSeguridad(cmdBoton(0))
                If lblDescripcion(0).Visible Then
                    lblDescripcion(0).Text = ""
                    lblDescripcion(0).Visible = False
                    lblEtiqueta(6).Visible = False
                End If
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2512))
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(1558))
                txtCampo(0).Focus()
                cmdBoton(4).Enabled = False
                PLTSEstado()
            Case 2
                Me.Close()
            Case 3
                VTFilas = VGMaxRows
                VTCodigo = "0"
                While VTFilas = VGMaxRows
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4029")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCodigo)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ins_serv_pe", True, FMLoadResString(1558)) Then
                        If VTCodigo = "0" Then
                            PMMapeaGrid(sqlconn, grdServicios, False)
                        Else
                            PMMapeaGrid(sqlconn, grdServicios, True)
                        End If
                        PMMapeaTextoGrid(grdServicios)
                        PMChequea(sqlconn)
                        grdServicios.Col = 1
                        grdServicios.Row = grdServicios.Rows - 1
                        VTCodigo = grdServicios.CtlText
                        If Conversion.Val(Convert.ToString(grdServicios.Tag)) > 0 Then
                            grdServicios.ColAlignment(5) = 1
                            grdServicios.ColAlignment(4) = 2
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                    VTFilas = Conversion.Val(Convert.ToString(grdServicios.Tag))
                End While
                grdServicios.Row = 1
                PMAnchoColumnasGrid(grdServicios)
                txtCampo(0).Focus()
            Case 4
                If txtCampo(0).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1224), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(0).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1424), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCampo(2).Focus()
                    Exit Sub
                End If
                If mskCosto.Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(1246), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCosto.Focus()
                    Exit Sub
                End If
                If optEstado(0).Checked Then
                    VTEstado = "V"
                ElseIf optEstado(1).Checked Then
                    VTEstado = "N"
                End If
                If optGuarda(0).Checked Then
                    VTGuarda = "S"
                Else
                    VTGuarda = "N"
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4028")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, lblDescripcion(1).Text)
                PMPasoValores(sqlconn, "@i_descr", 0, SQLCHAR, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_estad", 0, SQLCHAR, VTEstado)
                PMPasoValores(sqlconn, "@i_histr", 0, SQLCHAR, VTGuarda)
                PMPasoValores(sqlconn, "@i_costin", 0, SQLMONEY, mskCosto.Text)
                PMPasoValores(sqlconn, "@i_nemonico", 0, SQLCHAR, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_ins_serv_pe", True, FMLoadResString(1539)) Then
                    PMChequea(sqlconn)
                    cmdBoton(4).Enabled = False
                    cmdBoton_Click(cmdBoton(3), New EventArgs())
                Else
                    PMChequea(sqlconn)
                End If
                PLTSEstado()
        End Select
    End Sub

    Private Sub FCreaServ_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = "" '17/05/2016 migracion
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PMBotonSeguridad(Me, 4)
        PMObjetoSeguridad(cmdBoton(3))
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(4))
        cmdBoton(4).Enabled = False
        cmdBoton_Click(cmdBoton(3), New EventArgs())
        PLTSEstado()
        txtCampo(0).Focus()
    End Sub

    Private Sub FCreaServ_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdServicios_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.ClickEvent
        grdServicios.Col = 0
        grdServicios.SelStartCol = 1
        grdServicios.SelEndCol = grdServicios.Cols - 1
        If grdServicios.Row = 0 Then
            grdServicios.SelStartRow = 1
            grdServicios.SelEndRow = 1
        Else
            grdServicios.SelStartRow = grdServicios.Row
            grdServicios.SelEndRow = grdServicios.Row
        End If
    End Sub

    Private Sub grdServicios_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdServicios.DblClick
        Dim VTRow As Integer = grdServicios.Row
        grdServicios.Col = 1
        grdServicios.Row = 1
        If grdServicios.CtlText <> "" Then
            grdServicios.Row = VTRow

            grdServicios.SelStartCol = 1
            grdServicios.SelEndCol = grdServicios.Cols - 1

            PMMarcarRegistro()
            PMObjetoSeguridad(cmdBoton(4))
            cmdBoton(0).Enabled = False
            txtCampo(0).Enabled = False
            PLTSEstado()
        End If
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdServicios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdServicios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1391))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdServicios_KeyUp(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles grdServicios.KeyUp
        grdServicios.Col = 0
        grdServicios.SelStartCol = 1
        grdServicios.SelEndCol = grdServicios.Cols - 1
        If grdServicios.Row = 0 Then
            grdServicios.SelStartRow = 1
            grdServicios.SelEndRow = 1
        Else
            grdServicios.SelStartRow = grdServicios.Row
            grdServicios.SelEndRow = grdServicios.Row
        End If
    End Sub

    Private Sub mskCosto_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCosto.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2514))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        mskCosto.SelectionStart = 0
        mskCosto.SelectionLength = Strings.Len(mskCosto.Text)
    End Sub

    Private Sub mskCosto_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCosto.Leave
        If mskCosto.Text <> "" Then

            Dim dbNumericTemp As Double = 0
            If Not Double.TryParse(mskCosto.Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                mskCosto.Text = ""
                mskCosto.Focus()
                Exit Sub
            End If
        End If
    End Sub

    Private Sub optEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optEstado_1.Enter, _optEstado_0.Enter
        Dim Index As Integer = Array.IndexOf(optEstado, eventSender)
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2524))
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub optGuarda_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optGuarda_1.Enter, _optGuarda_0.Enter
        Dim Index As Integer = Array.IndexOf(optGuarda, eventSender)
        Select Case Index
            Case 0, 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(1403))
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PMMarcarRegistro()
        grdServicios.Col = 1
        lblDescripcion(1).Text = grdServicios.CtlText
        grdServicios.Col = 2
        txtCampo(0).Text = grdServicios.CtlText
        txtCampo(0).Enabled = False
        grdServicios.Col = 3
        txtCampo(2).Text = grdServicios.CtlText
        grdServicios.Col = 4
        If grdServicios.CtlText = "V" Then
            optEstado(0).Checked = True
        Else
            optEstado(1).Checked = True
        End If
        grdServicios.Col = 5
        mskCosto.Text = grdServicios.CtlText
        grdServicios.Col = 6
        lblDescripcion(0).Text = grdServicios.CtlText
        lblDescripcion(0).Visible = True
        lblEtiqueta(6).Visible = True
        grdServicios.Col = 7
        If grdServicios.CtlText = "S" Then
            optGuarda(0).Checked = True
        Else
            optGuarda(1).Checked = True
        End If
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Enter, _txtCampo_2.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2512))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2513))
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 2
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
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

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBCrear.Enabled = _cmdBoton_0.Enabled
        TSBCrear.Visible = _cmdBoton_0.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView

    End Sub

End Class


