Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Gui
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.PER.SharedLibrary
Imports COBISCorp.tCOBIS.PER.Cost

Partial Public Class FRangoEdadClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    Private Sub FRangoEdadClass_Closed(sender As Object, e As EventArgs) Handles Me.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(System.String.Empty)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(System.String.Empty)
    End Sub

    Private Sub FRangoEdadClass_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        TSBActualizar.Enabled = False
        TSBEliminar.Enabled = False
        txtCampo(1).Enabled = False
        PLBuscar()
    End Sub

    Private Sub _optBoton_1_Enter(sender As Object, e As EventArgs) Handles _optBoton_1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20025))
    End Sub

    Private Sub _optBoton_0_Enter(sender As Object, e As EventArgs) Handles _optBoton_0.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(20025))
    End Sub

    Private Sub grdRangoEdades_DblClick(sender As Object, e As EventArgs) Handles grdRangoEdades.DblClick
        PMMarcarRegistro()
    End Sub

    Private Sub grdRangoEdades_Enter(sender As Object, e As EventArgs) Handles grdRangoEdades.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502088))
    End Sub

    Private Sub PLBuscar()
        If txtCampo(3).Text <> "" And txtCampo(2).Text <> "" Then
            If CInt(txtCampo(3).Text) < CInt(txtCampo(2).Text) Then
                COBISMessageBox.Show(FMLoadResString(502107), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(3).Text = ""
                txtCampo(3).Focus()
                Exit Sub
            End If
        End If
        Dim VTFilas As Integer = 0
        Dim VTCODIGO As String = ""
        VTFilas = VTMaxRows
        VTCODIGO = "0"
        While VTFilas = VTMaxRows
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "S")
            If VTCODIGO = "0" Then
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")
            Else
                PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "1")
            End If
            PMPasoValores(sqlconn, "@i_rango_ini", 0, SQLINT2, txtCampo(2).Text)
            PMPasoValores(sqlconn, "@i_rango_fin", 0, SQLINT2, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, VTCODIGO)
            If _optBoton_0.Checked Then PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "V")
            If _optBoton_1.Checked Then PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(20024)) Then
                If VTCODIGO = "0" Then
                    PMMapeaGrid(sqlconn, grdRangoEdades, False)
                Else
                    PMMapeaGrid(sqlconn, grdRangoEdades, True)
                End If
                PMMapeaTextoGrid(grdRangoEdades)
                PMAnchoColumnasGrid(grdRangoEdades)
                PMChequea(sqlconn)
                VTFilas = Conversion.Val(Convert.ToString(grdRangoEdades.Tag))
                grdRangoEdades.Col = 1
                grdRangoEdades.Row = grdRangoEdades.Rows - 1
                VTCODIGO = grdRangoEdades.CtlText
            Else
                PMChequea(sqlconn)

            End If
        End While
        grdRangoEdades.Row = 1
    End Sub
    Private Sub PLCrear()
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502101), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502102), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If

        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502103), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If

        If CInt(txtCampo(3).Text) = CInt(txtCampo(2).Text) Then
            COBISMessageBox.Show(FMLoadResString(20020), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Text = ""
            txtCampo(3).Focus()
            Exit Sub
        End If

        If CInt(txtCampo(3).Text) < CInt(txtCampo(2).Text) Then
            COBISMessageBox.Show(FMLoadResString(502107), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Text = ""
            txtCampo(3).Focus()
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_rango_ini", 0, SQLINT2, _txtCampo_2.Text)
        PMPasoValores(sqlconn, "@i_rango_fin", 0, SQLINT2, _txtCampo_3.Text)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, _txtCampo_4.Text)
        If _optBoton_0.Checked = True Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "V")
        Else
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(20021)) Then
            PMChequea(sqlconn)
            txtCampo(1).Text = ""
            txtCampo(1).Enabled = False
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            TSBActualizar.Enabled = False
            TSBEliminar.Enabled = False
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If

    End Sub

    Private Sub PLActualizar()
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502101), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502102), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If

        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502103), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If

        If CInt(txtCampo(3).Text) = CInt(txtCampo(2).Text) Then
            COBISMessageBox.Show(FMLoadResString(20020), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Text = ""
            txtCampo(3).Focus()
            Exit Sub
        End If

        If CInt(txtCampo(3).Text) < CInt(txtCampo(2).Text) Then
            COBISMessageBox.Show(FMLoadResString(502107), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Text = ""
            txtCampo(3).Focus()
            Exit Sub
        End If

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_rango_ini", 0, SQLINT2, _txtCampo_2.Text)
        PMPasoValores(sqlconn, "@i_rango_fin", 0, SQLINT2, _txtCampo_3.Text)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLCHAR, _txtCampo_4.Text)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, _txtCampo_1.Text)
        If _optBoton_0.Checked = True Then
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "V")
        Else
            PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(20022)) Then
            PMChequea(sqlconn)
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            TSBActualizar.Enabled = False
            TSBEliminar.Enabled = False
            TSBCrear.Enabled = True
            PLBuscar()
        Else
            PMChequea(sqlconn)
            _optBoton_0.Checked = True
            _optBoton_1.Checked = False
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            TSBActualizar.Enabled = False
            TSBEliminar.Enabled = False
            TSBCrear.Enabled = True
            PLBuscar()
        End If
    End Sub

    Private Sub PLEliminar()
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502101), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(2).Focus()
            Exit Sub
        End If

        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502102), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(3).Focus()
            Exit Sub
        End If

        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502103), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(4).Focus()
            Exit Sub
        End If
        Dim Response As String = ""
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "732")
        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "D")
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT2, _txtCampo_1.Text)
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, "N")
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rango_fechas", True, FMLoadResString(20023)) Then
            PMChequea(sqlconn)
            TSBActualizar.Enabled = False
            TSBEliminar.Enabled = False
            TSBCrear.Enabled = True
            txtCampo(1).Text = ""
            txtCampo(2).Text = ""
            txtCampo(3).Text = ""
            txtCampo(4).Text = ""
            PMLimpiaGrid(grdRangoEdades)
            PLBuscar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub TSBCrear_Click(sender As Object, e As EventArgs) Handles TSBCrear.Click
        TSBotones.Focus()
        PLCrear()
    End Sub

    Private Sub PMMarcarRegistro()
        grdRangoEdades.Col = 1
        _txtCampo_1.Text = grdRangoEdades.CtlText
        If _txtCampo_1.Text <> "" Then
            grdRangoEdades.Col = 2
            _txtCampo_4.Text = grdRangoEdades.CtlText
            grdRangoEdades.Col = 3
            _txtCampo_2.Text = grdRangoEdades.CtlText
            grdRangoEdades.Col = 4
            _txtCampo_3.Text = grdRangoEdades.CtlText
            grdRangoEdades.Col = 5
            If grdRangoEdades.CtlText = "V" Then
                _optBoton_0.Checked = True
                TSBEliminar.Enabled = True
                TSBActualizar.Enabled = True
                TSBCrear.Enabled = False
            Else
                TSBEliminar.Enabled = False
                TSBActualizar.Enabled = True
                TSBCrear.Enabled = False
                _optBoton_1.Checked = True
            End If
        Else
            txtCampo(2).Focus()
        End If
    End Sub

    Private Sub TSBEliminar_Click(sender As Object, e As EventArgs) Handles TSBEliminar.Click
        TSBotones.Focus()
        PLEliminar()
    End Sub

    Private Sub limpiar()
        _txtCampo_1.Text = ""
        _txtCampo_2.Text = ""
        _txtCampo_3.Text = ""
        _txtCampo_4.Text = ""
        TSBCrear.Enabled = True
        TSBActualizar.Enabled = False
        TSBEliminar.Enabled = False
        _optBoton_0.Checked = True
        _optBoton_1.Checked = False
    End Sub

    Private Sub TSBLimpiar_Click(sender As Object, e As EventArgs) Handles TSBLimpiar.Click
        limpiar()
    End Sub

    Private Sub TSBSalir_Click(sender As Object, e As EventArgs) Handles TSBSalir.Click
        Me.Close()
    End Sub

    Private Sub TSBBuscar_Click(sender As Object, e As EventArgs) Handles TSBBuscar.Click
        TSBotones.Focus()
        PLBuscar()
    End Sub

    Private Sub TSBActualizar_Click(sender As Object, e As EventArgs) Handles TSBActualizar.Click
        TSBotones.Focus()
        PLActualizar()
        PMLimpiaGrid(grdRangoEdades)
        PLBuscar()
    End Sub


    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_1.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_4.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 4
                If (KeyAscii <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 96) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 1, 2, 3
                KeyAscii = FMValidaTipoDato("N", KeyAscii)
            Case 2, 3
                ValidaRangos()
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)


    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_1.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter, _txtCampo_4.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502090))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502085))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502086))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502087))
        End Select
    End Sub


    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_2.Leave, _txtCampo_3.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 1, 2, 3
                ValidaRangos()
        End Select
    End Sub

    Private Sub ValidaRangos()
        If txtCampo(2).Text <> "" Then
            If CInt(txtCampo(2).Text) > 100 Then
                COBISMessageBox.Show(FMLoadResString(502104), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(2).Text = ""
                txtCampo(2).Focus()
                Exit Sub
            End If
        End If
        If txtCampo(3).Text <> "" Then
            If CInt(txtCampo(3).Text) > 100 Then
                COBISMessageBox.Show(FMLoadResString(502105), FMLoadResString(1472), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(3).Text = ""
                txtCampo(3).Focus()
                Exit Sub
            End If
        End If
    End Sub
End Class

