Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTran2696Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Dim VLTabla As String = ""
    Dim VLTablaCC As String = ""
    Dim SS_ACTIVE_CELL As COBISCorp.Framework.UI.Components.ActionConstants

    Private Sub cmbTipo_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.SelectedIndexChanged
        PLBuscar()
    End Sub

    Private Sub cmbTipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmbTipo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(503339) & " ")
    End Sub

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_4.Click, _cmdBoton_3.Click, _cmdBoton_1.Click, _cmdBoton_2.Click, _cmdBoton_0.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 1
                PLCrear()
            Case 2
                PLAsignar()
            Case 3
                Me.Close()
            Case 4
                txt_codigo.Text = ""
                txt_Descripcion.Text = ""
                PLHabilitar()
                txt_codigo.Focus()
            Case 5
                PLEscoger()
        End Select
    End Sub

    Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click
        PLBuscar()
    End Sub

    Private Sub cmdBuscar_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509085) & " ")
    End Sub

    Private Sub FTran2696_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Private Sub PLInicializar()
        MyAppGlobals.AppActiveForm = ""
        cmbTipo.Items.Insert(0, FMLoadResString(502554))
        cmbTipo.Items.Insert(1, FMLoadResString(502555))
        cmbTipo.SelectedIndex = 1 'JSA 0
        grdCausas.Row = 0
        grdCausas.Col = 1
        grdCausas.Text = FMLoadResString(9919)
        grdCausas.Col = 2
        grdCausas.Text = FMLoadResString(9942)
        grdCausas.ColWidth(1) = 1000
        grdCausas.ColWidth(2) = 3000
        grdCausas.Lock = True
        grdCausas.Row = -1
        grdCausas.Col = 0
        grdCausas.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton
        grdCausas.TypeCheckCenter = True
        grdCaja.Row = 0
        grdCaja.Col = 1
        grdCaja.Text = FMLoadResString(9919)
        grdCaja.Col = 2
        FMLoadResString(508754)
        grdCaja.Text = FMLoadResString(9942)
        grdCaja.ColWidth(1) = 1000
        grdCaja.ColWidth(2) = 3000
        grdCaja.Row = -1
        grdCaja.Col = 0
        grdCaja.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton
        grdCaja.TypeCheckCenter = True
        optOper(2).Checked = True
        optOper_ClickHelper(2, 1)
    End Sub

    Private Sub grdCausas_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As COBISCorp.Framework.UI.Components._DSpreadEvents_DblClickEvent) Handles grdCausas.DblClick
        grdCausas.Col = 1
        grdCausas.Col2 = 3
        grdCausas.Row = grdCausas.ActiveRow
        If grdCausas.Row = 0 Then
            grdCausas.Row = 1
            grdCausas.Row2 = 1
        Else
            grdCausas.Row = grdCausas.ActiveRow
            grdCausas.Row2 = grdCausas.ActiveRow
        End If
        grdCausas.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionSelectBlock
        grdCausas.Col = 0
        Dim grdcell As COBISCorp.Framework.UI.Components.CellTypeConstants = grdCausas.CellType
        If grdcell = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeCheckBox Then
            PMCeldaEstatica(grdCausas.ActiveRow, grdCausas.Col, "", 2)            
        Else
            If grdcell = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton Or grdcell <> COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeCheckBox Then
                PMCeldaPicture(grdCausas.ActiveRow, grdCausas.Col, picVisto(0))
            End If
        End If
        PMBloqueaGrid(grdCausas)
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub optOper_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOper_1.CheckedChanged, _optOper_0.CheckedChanged, _optOper_2.CheckedChanged, _optOper_3.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            Dim Index As Integer = Array.IndexOf(optOper, eventSender)
            Dim Value As Integer = optOper(Index).Checked
            optOper_ClickHelper(Index, Value)
        End If
    End Sub

    Private Sub optOper_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _optOper_1.Enter, _optOper_0.Enter, _optOper_2.Enter, _optOper_3.Enter
        Dim Index As Integer = Array.IndexOf(optOper, eventSender)
        If Index = 2 Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509083) & " ")
        Else
            If Index = 3 Then
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509084) & " ")
            End If
        End If
    End Sub

    Private Sub optOper_ClickHelper(ByRef Index As Integer, ByRef Value As Integer)
        If Index = 2 Or Index = 3 Then
            cmbTipo.Enabled = False
            GroupBox1.Text = FMLoadResString(503340)
            GroupBox2.Text = FMLoadResString(503341)
        Else
            Opttipo(1).Enabled = True
            cmbTipo.Enabled = True
            GroupBox1.Text = FMLoadResString(503342)
            GroupBox2.Text = FMLoadResString(503343)
        End If
        PLOperacion()
        PLBuscar()
    End Sub

    Private Sub PMCeldaPicture(ByRef fila As Integer, ByRef columna As Integer, ByRef figura As PictureBox)
        grdCausas.Row = grdCausas.ActiveRow
        grdCausas.Col = 0
        grdCausas.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeCheckBox
        grdCausas.TypeCheckCenter = True
    End Sub

    Private Sub PLBuscar()
        PLOperacion()
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503344)) Then
            PMMapeaGrid(sqlconn, grdCausas, False)
            PMMapeaTextoSGrid(grdCausas)
            PMBloqueaGrid(grdCausas)
            PMChequea(sqlconn)
            grdCausas.Col = 1
            grdCausas.Action = SS_ACTIVE_CELL

            grdCausas.Row = -1
            grdCausas.Col = 0
            grdCausas.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton
            grdCausas.TypeCheckCenter = True

            grdCausas.Row = 0
            grdCausas.Col = 1
            grdCausas.Text = FMLoadResString(9919)
            grdCausas.Col = 2
            grdCausas.Text = FMLoadResString(9942)
            grdCausas.ColWidth(1) = 1000
            grdCausas.ColWidth(2) = 3000
        Else
            PMChequea(sqlconn)
        End If
        PLBuscarcaja()
        PMAnchoColumnasGrid(grdCausas)
        PMAnchoColumnasGrid(grdCaja)
    End Sub

    Private Sub PLBuscarcaja()
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTablaCC)
        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
            PMMapeaGrid(sqlconn, grdCaja, False)
            PMBloqueaGrid(grdCaja)
            PMChequea(sqlconn)
            grdCaja.Col = 1
            grdCaja.Action = SS_ACTIVE_CELL
            grdCaja.Row = 0
            grdCaja.Col = 1
            grdCaja.Text = FMLoadResString(9919)
            grdCaja.Col = 2
            grdCaja.Text = FMLoadResString(9942)
            grdCaja.ColWidth(1) = 1000
            grdCaja.ColWidth(2) = 3000
        Else
            PMBloqueaGrid(grdCaja)
            PMChequea(sqlconn)
            grdCaja.Col = 1
            grdCaja.Action = SS_ACTIVE_CELL
            grdCaja.Row = 0
            grdCaja.Col = 1
            FMLoadResString(508754)
            grdCaja.Text = FMLoadResString(9919)
            grdCaja.Col = 2
            FMLoadResString(508754)
            grdCaja.Text = FMLoadResString(9942)
            grdCaja.ColWidth(1) = 1000
            grdCaja.ColWidth(2) = 3000
            grdCaja.MaxRows = 0
        End If
    End Sub

    Private Sub PMCeldaEstatica(ByRef fila As Integer, ByRef columna As Integer, ByRef Texto As String, ByRef alineacion As Integer)
        grdCausas.Row = grdCausas.ActiveRow
        grdCausas.Col = columna
        grdCausas.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton
        grdCausas.TypeCheckCenter = False
    End Sub

    Private Sub PLEscoger()
        Dim fila As Integer = grdCausas.ActiveRow
        grdCausas.Row = fila
        grdCausas.Col = 1
        txt_codigo.Text = grdCausas.Text
        grdCausas.Col = 2
        txt_Descripcion.Text = grdCausas.Text
    End Sub

    Private Sub PLCrear()
        PLOperacion()
        If txt_codigo.Text <> "" And txt_Descripcion.Text <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "584")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txt_codigo.Text)
            PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txt_Descripcion.Text)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo", True, " " & FMLoadResString(503345) & " ") Then
                PMChequea(sqlconn)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "584")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTablaCC)
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, txt_codigo.Text)
                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, txt_Descripcion.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo", True, " " & FMLoadResString(503345) & " ") Then
                    PMChequea(sqlconn)
                    PLBuscar()
                    PLDeshabilitar()
                Else
                    PMChequea(sqlconn)
                End If
                COBISMessageBox.Show(FMLoadResString(503346), FMLoadResString(503347), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(503348), FMLoadResString(503349), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            txt_codigo.Focus()
        End If
    End Sub

    Private Sub PLAsignar()
        PLOperacion()
        Dim VLBan As Integer = 0

        If grdCausas.MaxRows > 1 Then

            For i As Integer = 1 To grdCausas.MaxRows
                grdCausas.Col = 0
                grdCausas.Row = i

                If grdCausas.CellType = 10 Then
                    VLBan = 1
                End If
                If grdCausas.CellType = 10 And Not grdCausas.BackColor.Equals(Color.LightGreen) Then
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "584")
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLVARCHAR, "I")
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTablaCC)
                    grdCausas.Col = 1
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, grdCausas.Text)
                    grdCausas.Col = 2
                    PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, grdCausas.Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo", True, FMLoadResString(503350)) Then
                        PMChequea(sqlconn)
                        grdCausas.Row = i
                        grdCausas.Col = -1
                        grdCausas.BackColor = Color.LightGreen
                    Else
                        PMChequea(sqlconn)
                        grdCausas.Row = i
                        grdCausas.Col = -1
                        grdCausas.BackColor = Color.LightYellow
                    End If
                End If
            Next i
            If VLBan = 0 Then
                COBISMessageBox.Show(FMLoadResString(503351), FMLoadResString(503352), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Else
                COBISMessageBox.Show(FMLoadResString(503353), FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                PLBuscarcaja()
                PMAnchoColumnasGrid(grdCaja)
            End If
        End If
    End Sub

    Private Sub Opttipo_CheckedChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Opttipo_1.CheckedChanged, _Opttipo_0.CheckedChanged
        If eventSender.Checked Then
            If isInitializingComponent Then
                Exit Sub
            End If
            PLOperacion()
            PLBuscar()
        End If
    End Sub

    Private Sub Opttipo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _Opttipo_1.Enter, _Opttipo_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(503354) & " ")
    End Sub

    Private Sub txt_codigo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txt_codigo.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(501834) & " ")
    End Sub

    Private Sub txt_codigo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txt_codigo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txt_Descripcion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles txt_Descripcion.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(503355) & " ")
    End Sub

    Private Sub txt_Descripcion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles txt_Descripcion.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii < 97 Or KeyAscii > 122) Then
            KeyAscii = 0
        Else
            KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub PLOperacion()
        Dim VLProd As String = String.Empty
        If cmbTipo.Text = FMLoadResString(502554) Then
            VLProd = "CTE"
        Else
            VLProd = "AHO"
        End If
        If optOper(0).Checked Then
            If VLProd = "CTE" Then
                VLTabla = "cc_causa_nc"
                If Opttipo(0).Checked Then
                    VLTablaCC = "cc_causa_nc_caja"
                Else
                    VLTablaCC = "cc_causa_nc_data"
                End If
            Else
                VLTabla = "ah_causa_nc"
                If Opttipo(0).Checked Then
                    VLTablaCC = "ah_causa_nc_caja"
                Else
                    VLTablaCC = "ah_causa_nc_data"
                End If
            End If
        ElseIf optOper(1).Checked Then
            If VLProd = "CTE" Then
                VLTabla = "cc_causa_nd"
                If Opttipo(0).Checked Then
                    VLTablaCC = "cc_causa_nd_caja"
                Else
                    VLTablaCC = "cc_causa_nd_data"
                End If
            Else
                VLTabla = "ah_causa_nd"
                If Opttipo(0).Checked Then
                    VLTablaCC = "ah_causa_nd_caja"
                Else
                    VLTablaCC = "ah_causa_nd_data"
                End If
            End If
        ElseIf optOper(2).Checked Then
            VLProd = "CTE"
            VLTabla = "cc_causa_oioe"
            If Opttipo(0).Checked Then
                VLTablaCC = "cc_causa_oioe_caja"
            End If
        ElseIf optOper(3).Checked Then
            VLProd = "CTE"
            VLTabla = "cc_causa_oe"
            If Opttipo(0).Checked Then
                VLTablaCC = "cc_causa_oe_caja"
            End If
        End If
    End Sub

    Public Sub PLDeshabilitar()
        txt_codigo.Enabled = False
        txt_Descripcion.Enabled = False
    End Sub

    Public Sub PLHabilitar()
        txt_codigo.Enabled = True
        txt_Descripcion.Enabled = True

        grdCausas.Row = -1
        grdCausas.Col = 0
        grdCausas.CellType = COBISCorp.Framework.UI.Components.CellTypeConstants.CellTypeButton
        grdCausas.TypeCheckCenter = True
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBCrear.Enabled = _cmdBoton_1.Enabled
        TSBCrear.Visible = _cmdBoton_1.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_3.Enabled
        TSBSalir.Visible = _cmdBoton_3.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBuscar_Click(cmdBuscar, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub grdCaja_DoubleClick(sender As Object, e As EventArgs) Handles grdCaja.DblClick
        PMBloqueaGrid(grdCaja)
    End Sub

    Private Sub grdCausas_Enter(sender As Object, e As EventArgs) Handles grdCausas.Enter
        If GroupBox1.Text = FMLoadResString(503340) Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509079) & " ")
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509081) & " ")
        End If
    End Sub

    Private Sub grdCausas_Leave(sender As Object, e As EventArgs) Handles grdCausas.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub

    Private Sub grdCaja_Enter(sender As Object, e As EventArgs) Handles grdCaja.Enter
        If GroupBox1.Text = FMLoadResString(503340) Then
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509080) & " ")
        Else
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(" " & FMLoadResString(509082) & " ")
        End If
    End Sub

    Private Sub grdCaja_Leave(sender As Object, e As EventArgs) Handles grdCaja.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
    End Sub
End Class


