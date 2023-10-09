Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FMantenimientoClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLOperacion As String = ""
    Dim VGFila As Integer = 0

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_5.Click, _cmdBoton_4.Click, _cmdBoton_0.Click, _cmdBoton_1.Click, _cmdBoton_2.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        TSBotones.Focus()
        Select Case Index
            Case 0
                PLBuscaValor()
            Case 1
                PLModificar()
            Case 2
                PLEliminar()
            Case 3
                PLTransmitir()
            Case 4
                PLLimpiar()
            Case 5
                Me.Dispose()
                Me.Close()
        End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Enter, _cmdBoton_5.Enter, _cmdBoton_4.Enter, _cmdBoton_0.Enter, _cmdBoton_1.Enter, _cmdBoton_2.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502778))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502779))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502780))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502781))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502782))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502783))
        End Select
    End Sub


    Private Sub FMantenimiento_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

    Public Sub PLInicializar()
        If txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "" Then
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
        End If
        If txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(7).Text = "" And txtCampo(6).Text = "" Then
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
        End If
        txtCampo(0).Connection = VGMap
        txtCampo(0).AsociatedLabel = lblDescripcion(0)
        txtCampo(1).Connection = VGMap
        txtCampo(1).AsociatedLabel = lblDescripcion(1)
        txtCampo(2).Connection = VGMap
        txtCampo(2).AsociatedLabel = lblDescripcion(2)
        VLOperacion = "I"
        PMObjetoSeguridad(cmdBoton(0))
        PMObjetoSeguridad(cmdBoton(1))
        PMObjetoSeguridad(cmdBoton(2))
        PMObjetoSeguridad(cmdBoton(3))
        Dim VGBotones(3) As Object
        VGBotones(1) = cmdBoton(0)
        VGBotones(2) = cmdBoton(2)
        VGBotones(3) = cmdBoton(3)
        Me.Text = FMLoadResString(9956)
    End Sub

    Private Sub FMantenimiento_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdValores_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.Click
        PMLineaG(grdValores)
    End Sub

    Private Sub grdValores_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdValores.DblClick
        PLEditar()
        grdValores.Row = 1
        grdValores.Col = 1
        If grdValores.CtlText <> "" Then
            grdValores.Row = VGFila
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
        End If
        PLTSEstado()
        PMMarcaFilaCobisGrid(grdValores, grdValores.Row)
    End Sub

    Private Sub grdValores_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502784))
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PLBuscaValor()
        PMLimpiaG(grdValores)
        If txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(2).Text = "" And txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502785), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        Dim inicio As Integer = True
        Do While (CDbl(Convert.ToString(grdValores.Tag)) >= VGMaximoRows - 1) Or inicio
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4164")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
            PMPasoValores(sqlconn, "@i_modulo", 0, SQLINT4, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_mod_int", 0, SQLINT4, txtCampo(1).Text)
            PMPasoValores(sqlconn, "@i_val_cfijo", 0, SQLVARCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(2).Text)
            PMPasoValores(sqlconn, "@i_val_interfaz", 0, SQLVARCHAR, txtCampo(4).Text)
            If Not inicio Then
                grdValores.Row = grdValores.Rows - 1
                grdValores.Col = 1
                PMPasoValores(sqlconn, "@i_siguiente", 0, SQLVARCHAR, grdValores.CtlText)
            End If
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, Conversion.Str(inicio + 1))
            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_mant_equiv", False, FMLoadResString(502786)) Then
                PMMapeaGrid(sqlconn, grdValores, Not (inicio))
                PMMapeaTextoGrid(grdValores)
                PMAnchoColumnasGrid(grdValores)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
                grdValores.Tag = CStr(0)
            End If
            inicio = False
        Loop
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(509090))
    End Sub

    Private Sub PLEditar()
        If txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "" Then
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
        End If
        VGFila = grdValores.Row
        grdValores.Row = 1
        grdValores.Col = 1
        If grdValores.CtlText <> "" Then
            grdValores.Row = VGFila
            grdValores.Col = 2
            txtCampo(0).Text = grdValores.CtlText
            grdValores.Col = 3
            lblDescripcion(0).Text = grdValores.CtlText
            grdValores.Col = 4
            txtCampo(1).Text = grdValores.CtlText
            grdValores.Col = 5
            lblDescripcion(1).Text = grdValores.CtlText
            grdValores.Col = 6
            txtCampo(2).Text = grdValores.CtlText
            grdValores.Col = 7
            lblDescripcion(2).Text = grdValores.CtlText
            grdValores.Col = 8
            txtCampo(3).Text = grdValores.CtlText
            grdValores.Col = 9
            txtCampo(6).Text = grdValores.CtlText
            grdValores.Col = 10
            txtCampo(7).Text = grdValores.CtlText
            grdValores.Col = 11
            txtCampo(4).Text = grdValores.CtlText
            grdValores.Col = 12
            txtCampo(5).Text = grdValores.CtlText
            fraBusqueda.Enabled = True
            fraBusqueda.Text = FMLoadResString(502787)
            cmdBoton(3).Enabled = False
            txtCampo(0).Enabled = False
            txtCampo(1).Enabled = False
            txtCampo(2).Enabled = False
            txtCampo(3).Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub PLModificar()
        VLOperacion = "U"
        PLTransmitir()
    End Sub

    Private Sub PLEliminar()
        Dim VLValorCobis As String = String.Empty
        Dim Msg As String = String.Empty
        Dim VTResp As DialogResult
        VGFila = grdValores.Row
        grdValores.Row = VGFila
        grdValores.Col = 1
        Dim VLCodigo As String = grdValores.CtlText
        If grdValores.CtlText <> "" Then
            grdValores.Row = VGFila
            grdValores.Col = 12
            VLValorCobis = grdValores.CtlText
            Msg = FMLoadResString(502441) & ChrW(13)
            grdValores.Col = 1
            Msg = Msg & "Codigo COBIS: " & VLCodigo & " - " & VLValorCobis
            VTResp = COBISMessageBox.Show(Msg, FMLoadResString(500064), COBISMessageBox.COBISButtons.YesNo)
            If VTResp = System.Windows.Forms.DialogResult.Yes Then
                grdValores.Col = 2
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4167")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "D")
                PMPasoValores(sqlconn, "@i_modulo", 0, SQLINT4, txtCampo(0).Text)
                PMPasoValores(sqlconn, "@i_mod_int", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_val_cfijo", 0, SQLVARCHAR, txtCampo(3).Text)
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(2).Text)
                PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtCampo(5).Text)
                PMPasoValores(sqlconn, "@i_val_num_ini", 0, SQLVARCHAR, txtCampo(6).Text)
                PMPasoValores(sqlconn, "@i_val_num_fin", 0, SQLVARCHAR, txtCampo(7).Text)
                PMPasoValores(sqlconn, "@i_val_interfaz", 0, SQLVARCHAR, txtCampo(4).Text)
                grdValores.Col = 1
                PMPasoValores(sqlconn, "@i_siguiente", 0, SQLVARCHAR, grdValores.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_mant_equiv", False, FMLoadResString(502788)) Then
                    PMChequea(sqlconn)
                    COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(502788))
                    If FMRetStatus(sqlconn) = 2 Then
                        COBISMessageBox.Show(FMLoadResString(502789), My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK)
                    Else
                        COBISMessageBox.Show(FMLoadResString(502790), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                    End If
                    PLLimpiar()
                Else
                    PMChequea(sqlconn)
                End If
            Else
                Exit Sub
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 0 To 7
            txtCampo(i).Text = ""
        Next i
        cmdBoton(3).Enabled = True
        fraBusqueda.Text = FMLoadResString(502791)
        VLOperacion = "I"
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        txtCampo(6).Enabled = True
        txtCampo(7).Enabled = True
        fraBusqueda.Enabled = True
        lblDescripcion(0).Text = ""
        lblDescripcion(1).Text = ""
        lblDescripcion(2).Text = ""
        PMLimpiaG(grdValores)
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = True
        txtCampo(0).Enabled = True
        txtCampo(1).Enabled = True
        txtCampo(2).Enabled = True
        txtCampo(3).Enabled = True
        txtCampo(0).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLTransmitir()
        Dim msgingreso As String = "" 'JSA
        Dim msgtrn As String = ""
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502792), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If txtCampo(3).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502793), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502794), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If txtCampo(5).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502795), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If txtCampo(0).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502796), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502797), FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        Select Case VLOperacion
            Case "I"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4165")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                msgingreso = FMLoadResString(502798)
                msgtrn = FMLoadResString(508883)
            Case "U"
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4166")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
                msgingreso = FMLoadResString(502799)
                msgtrn = FMLoadResString(9954)
        End Select
        PMPasoValores(sqlconn, "@i_modulo", 0, SQLINT4, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_mod_int", 0, SQLINT4, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_val_cfijo", 0, SQLVARCHAR, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, lblDescripcion(2).Text)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_val_num_ini", 0, SQLVARCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_val_num_fin", 0, SQLVARCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_val_interfaz", 0, SQLVARCHAR, txtCampo(4).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_mant_equiv", False, msgtrn) Then
            PLLimpiar()
            PMMapeaGrid(sqlconn, grdValores, False)
            PMMapeaTextoGrid(grdValores)
            PMAnchoColumnasGrid(grdValores)
            PMChequea(sqlconn)
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(msgtrn)
            COBISMessageBox.Show(msgingreso, FMLoadResString(500064), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
        Else
            PMChequea(sqlconn)
        End If
        PLTSEstado()
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_0.Enter, _txtCampo_1.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502800))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502801))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502802))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502803))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502804))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502805))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502806))
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502807))
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBModificar.Enabled = _cmdBoton_1.Enabled
        TSBModificar.Visible = _cmdBoton_1.Visible
        TSBEliminar.Enabled = _cmdBoton_2.Enabled
        TSBEliminar.Visible = _cmdBoton_2.Visible
        TSBTransmitir.Enabled = _cmdBoton_3.Enabled
        TSBTransmitir.Visible = _cmdBoton_3.Visible
        TSBLimpiar.Enabled = _cmdBoton_4.Enabled
        TSBLimpiar.Visible = _cmdBoton_4.Visible
        TSBSalir.Enabled = _cmdBoton_5.Enabled
        TSBSalir.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBModificar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub
    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        'If Not (Artinsoft.VB6.Gui.ActivateHelper.myActiveForm Is eventSender) Then
        'Artinsoft.VB6.Gui.ActivateHelper.myActiveForm = eventSender
        txtCampo(0).Focus()
        If txtCampo(0).Text <> "" And txtCampo(1).Text <> "" And txtCampo(7).Text <> "" And txtCampo(6).Text <> "" Then
            cmdBoton(1).Enabled = True
            cmdBoton(2).Enabled = True
        End If
        If txtCampo(0).Text = "" And txtCampo(1).Text = "" And txtCampo(7).Text = "" And txtCampo(6).Text = "" Then
            cmdBoton(1).Enabled = False
            cmdBoton(2).Enabled = False
        End If
        'End If
        PLTSEstado()
    End Sub

    Private Sub grdValores_ClickEvent(sender As Object, e As EventArgs) Handles grdValores.ClickEvent
        PMLineaG(grdValores)
        PMMarcaFilaCobisGrid(grdValores, grdValores.Row)
    End Sub

End Class


