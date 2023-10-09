Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FMantCatalogoClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView


    Const INSERTAR As Integer = 1
    Const Actualizar As Integer = 2
    Const Caracter As Integer = 9
    Dim VLTabla As String = ""
    Dim VLOpCatalogo As Integer = 0
    Dim VLactual As String = ""
    Dim VLCargar As Integer = 0
    Dim VLPaso As Integer = 0
    Dim ubicacion As Integer = 0
    Dim VLRPC As String = ""
    Dim VTR As Integer = 0
    Dim i As Integer = 0

    Private Sub cboTabla_SelectedIndexChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cboTabla.SelectedIndexChanged
        If Not VLCargar Then
            If VLactual <> cboTabla.Text Then
                VLactual = cboTabla.Text
                cmdBuscar_Click(cmdBuscar, New EventArgs())
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub cboTabla_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cboTabla.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502859))
    End Sub

    Private Sub cmdActualizar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdActualizar.Click
        Dim VTRow As Integer = grdValores.Row
        grdValores.Row = 1
        grdValores.Col = 1
        If grdValores.Rows >= 2 And grdValores.CtlText <> "" Then
            grdValores.Row = VTRow
            VLOpCatalogo = Actualizar
            grdValores.Col = 1
            TxtCodigo(0).Text = grdValores.CtlText
            grdValores.Col = 2
            txtDescripcion(0).Text = grdValores.CtlText
            grdValores.Col = 3
            txtEstado(0).Text = grdValores.CtlText
            txtEstado_Leave(txtEstado(0), New EventArgs())
            grdValores.Row = 0
            grdValores.Col = 1
            fraCatalogo.Text = grdValores.CtlText
            fraCatalogo.Visible = True
            TxtCodigo(0).Enabled = False
            txtEstado(0).Enabled = True
            fraBusqueda.Visible = False
            pnlBotones.Visible = True
            cmdLimpiar.Enabled = False
        End If
        PLTSEstado()
    End Sub

    Private Sub cmdBuscar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdBuscar.Click
        Dim VTArreglo(10) As String
        If Not cmdBuscar.Enabled Then
            COBISMessageBox.Show(FMLoadResString(502618), FMLoadResString(502832), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            Exit Sub
        End If
        ubicacion = (cboTabla.Text.IndexOf(Strings.Chr(Caracter).ToString()) + 1)
        VLTabla = Strings.Mid(cboTabla.Text, ubicacion + 1, Strings.Len(cboTabla.Text))
        VLRPC = "sp_catalogo"
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1564")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo", True, FMLoadResString(502889)) Then
            VTR = FMMapeaArreglo(sqlconn, VTArreglo)
            PMMapeaGrid(sqlconn, grdValores, False)
            PMChequea(sqlconn)
            grdValores.Row = 0
            For i As Integer = 1 To VTR
                grdValores.Col = i
                grdValores.CtlText = VTArreglo(i)
            Next i
            cmdSiguiente.Enabled = grdValores.Rows >= VGMaximoRows
            grdValores.Row = 1
            PMMapeaTextoGrid(grdValores)
            PMAnchoColumnasGrid(grdValores)
        Else
            PMChequea(sqlconn)
            PMLimpiaG(grdValores)
        End If
        PLTSEstado()
    End Sub

    Private Sub cmdCancelar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdCancelar.Click
        fraBusqueda.Visible = True
        fraCatalogo.Visible = False
        pnlBotones.Visible = False
        cmdTransmitir.Enabled = True
        cmdLimpiar_Click(cmdLimpiar, New EventArgs())
        cmdBuscar_Click(cmdBuscar, New EventArgs())
        PLTSEstado()
    End Sub

    Private Sub cmdIngresar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdIngresar.Click
        If Not cmdBuscar.Enabled Then Exit Sub
        VLOpCatalogo = INSERTAR
        ubicacion = (cboTabla.Text.IndexOf(Strings.Chr(Caracter).ToString()) + 1)
        If ubicacion > 0 Then
            VLTabla = Strings.Mid(cboTabla.Text, ubicacion + 1, Strings.Len(cboTabla.Text))
            If VLTabla = "cc_causa_nd_data" Or VLTabla = "cc_causa_nc_data" Or VLTabla = "ah_causa_nd_data" Or VLTabla = "ah_causa_nc_data" Or VLTabla = "cc_causa_nc_caja" Or VLTabla = "cc_causa_nd_caja" Or VLTabla = "ah_causa_nc_caja" Or VLTabla = "ah_causa_nd_caja" Then
                COBISMessageBox.Show(FMLoadResString(502551), FMLoadResString(502899), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                Exit Sub
            End If
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cl_estado_ser")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLCHAR, "V")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                PMMapeaObjeto(sqlconn, lbldEstado(0))
                txtEstado(0).Text = "V"
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
            End If
            grdValores.Row = 0
            grdValores.Col = 2
            fraCatalogo.Text = grdValores.CtlText
            fraCatalogo.Visible = True
            TxtCodigo(0).Enabled = True
            txtEstado(0).Enabled = False
            TxtCodigo(0).Focus()
            fraBusqueda.Visible = False
            pnlBotones.Visible = True
            cmdLimpiar.Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private Sub cmdLimpiar_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdLimpiar.Click
        TxtCodigo(0).Text = ""
        txtDescripcion(0).Text = ""
        cmdTransmitir.Enabled = True
        If fraCatalogo.Visible Then
            TxtCodigo(0).Focus()
        End If
        cmdTransmitir.Enabled = True
        VLPaso = True
        PLTSEstado()
    End Sub

    Private Sub cmdSalir1_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSalir1.Click
        Me.Dispose()
        Me.Close()
    End Sub

    Private Sub cmdSiguiente_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdSiguiente.Click
        Dim VTArreglo(10) As String
        Dim VTTope As Integer = grdValores.Rows - 1
        VLRPC = "sp_catalogo"
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
        grdValores.Row = grdValores.Rows - 1
        grdValores.Col = 1
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, grdValores.CtlText)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1564")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo", True, FMLoadResString(502539)) Then
            PMMapeaGrid(sqlconn, grdValores, True)
            VTR = FMMapeaArreglo(sqlconn, VTArreglo)
            grdValores.Row = 0
            PMChequea(sqlconn)
            For i As Integer = 1 To VTR
                grdValores.Col = i
                grdValores.CtlText = VTArreglo(i)
            Next i
            If Conversion.Val(Convert.ToString(grdValores.Tag)) >= VGMaximoRows - 1 Then
                cmdSiguiente.Enabled = True
                If grdValores.Rows > VGMaximoRows Then
                    grdValores.TopRow = VTTope
                End If
            Else
                If CDbl(Convert.ToString(grdValores.Tag)) > 0 Then
                    grdValores.TopRow = grdValores.Rows - CDbl(Convert.ToString(grdValores.Tag)) - (VGMaximoRows - CDbl(Convert.ToString(grdValores.Tag)))
                End If
                cmdSiguiente.Enabled = False
            End If
        Else
            PMChequea(sqlconn)
        End If
        PMMapeaTextoGrid(grdValores)
        PMAnchoColumnasGrid(grdValores)
        PLTSEstado()
    End Sub

    Private Sub cmdTransmitir_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles cmdTransmitir.Click
        Dim VLOpCatalgo As Integer = 0
        VLRPC = "sp_catalogo"
        Dim VLBdd As String = "cobis"
        If TxtCodigo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502912), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            TxtCodigo(0).Focus()
            Exit Sub
        End If
        If txtDescripcion(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(502563), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            txtDescripcion(0).Focus()
            Exit Sub
        End If
        If VLOpCatalgo = Actualizar Then
            If txtEstado(0).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(502564), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                txtEstado(0).Focus()
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, VLTabla)
        PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, TxtCodigo(0).Text)
        PMPasoValores(sqlconn, "@i_descripcion", 0, SQLVARCHAR, txtDescripcion(0).Text)
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtEstado(0).Text)
        Select Case VLOpCatalogo
            Case INSERTAR
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "584")
            Case Actualizar
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "585")
        End Select
        Select Case VLOpCatalogo
            Case INSERTAR
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
                cmdTransmitir.Enabled = False
            Case Actualizar
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        End Select
        If FMTransmitirRPC(sqlconn, ServerName, VLBdd, VLRPC, True, FMLoadResString(502593)) Then
            PMChequea(sqlconn)
            COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine(FMLoadResString(9107))
        Else
            PMChequea(sqlconn)
            cmdTransmitir.Enabled = True
        End If
        PLTSEstado()
    End Sub

    Private Sub FMantCatalogo_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMObjetoSeguridad(cmdBuscar)
        PMObjetoSeguridad(cmdSiguiente)
        PMObjetoSeguridad(cmdIngresar)
        PMObjetoSeguridad(cmdActualizar)
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        VGProducto = Me.GetPageArgumentsByName("OP")
        PLInicializar()
        PLTSEstado()

        If fraBusqueda.Enabled = True Then
            cboTabla.SelectedIndex = 0
            'il_tabla.Focus()
        End If
        If VGProducto = FMLoadResString(9112) Then Me.Text = FMLoadResString(508983) & " " & FMLoadResString(9109)
        If VGProducto = FMLoadResString(9113) Then Me.Text = FMLoadResString(508983) & " " & FMLoadResString(9111)
        If VGProducto = FMLoadResString(9114) Then Me.Text = FMLoadResString(508983) & " " & FMLoadResString(9110)
    End Sub

    Public Sub PLInicializar()
        Dim VTItem As String = ""
        Dim VTCaracteres As String = New String(" ", 50)
        VLCargar = True
        Dim VTMatriz(2, 22) As String
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
        PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
        PMPasoValores(sqlconn, "@i_producto", 0, SQLCHAR, VGProducto)
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1578")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo_pro", True, FMLoadResString(502892)) Then
            VTR = FMMapeaMatriz(sqlconn, VTMatriz)
            PMChequea(sqlconn)
            If VTR > 0 Then
                cboTabla.Items.Clear()
                For j As Integer = 1 To VTR
                    VTItem = VTMatriz(0, j).Trim() & VTCaracteres & Strings.Chr(9).ToString() & VTMatriz(1, j).Trim()
                    cboTabla.Items.Add(VTItem)
                Next j
                Do While VTR > 0
                    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "1")
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLCHAR, VGProducto)
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VTMatriz(1, VTR))
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1578")
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_catalogo_pro", False, "") Then
                        VTR = FMMapeaMatriz(sqlconn, VTMatriz)
                        PMChequea(sqlconn)
                        If VTR > 0 Then
                            For j As Integer = 1 To VTR
                                VTItem = VTMatriz(0, j).Trim() & VTCaracteres & Strings.Chr(9).ToString() & VTMatriz(1, j).Trim()
                                cboTabla.Items.Add(VTItem)
                            Next j
                        End If
                    Else
                        PMChequea(sqlconn)
                        VTR = 0
                        ReDim VTMatriz(0, 0)
                    End If
                Loop
            Else
                cboTabla.Items.Clear()
            End If
        Else
            PMChequea(sqlconn)
            cboTabla.Items.Clear()
        End If
        VLCargar = False
        PLTSEstado()
    End Sub

    Private Sub FMantCatalogo_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdValores_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdValores.Click
        PMLineaG(grdValores)
    End Sub

    Private Sub grdValores_ClickEvent(sender As Object, e As EventArgs) Handles grdValores.ClickEvent
        PMLineaG(grdValores)
        PMMarcaFilaCobisGrid(grdValores, grdValores.Row)
    End Sub

    Private Sub grdValores_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles grdValores.DblClick
        If cmdActualizar.Enabled Then
            cmdActualizar_Click(cmdActualizar, New EventArgs())
        Else
            COBISMessageBox.Show(FMLoadResString(502969), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
        End If
    End Sub

    Private Sub TxtCodigo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _TxtCodigo_0.Enter
        Dim Index As Integer = Array.IndexOf(TxtCodigo, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(9108) & " " & StrConv(fraCatalogo.Text, VbStrConv.ProperCase))
        End Select
        TxtCodigo(Index).SelectionStart = 0
        TxtCodigo(Index).SelectionLength = Strings.Len(TxtCodigo(Index).Text)
    End Sub

    Private Sub TxtCodigo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _TxtCodigo_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(TxtCodigo, eventSender)
        Select Case Index
            Case 0
                If VLTabla = "cl_cargo" Or VLTabla = "cl_actividad" Or VLTabla = "cl_profesion" Then
                    If (KeyAscii <> 8) And (KeyAscii < 48 Or KeyAscii > 57) Then
                        KeyAscii = 0
                    End If
                Else
                    If KeyAscii = 32 Or KeyAscii = 44 Then
                        KeyAscii = 0
                    Else
                        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                    End If
                End If
            Case Else
                If (KeyAscii <> 8) And (KeyAscii < 48 Or KeyAscii > 57) Then
                    KeyAscii = 0
                End If
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
        PLTSEstado()
    End Sub

    Private Sub TxtCodigo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _TxtCodigo_0.Leave
        Dim Index As Integer = Array.IndexOf(TxtCodigo, eventSender)
        If VLTabla = "cl_cargo" Then
            If Conversion.Val(TxtCodigo(Index).Text) > 255 Then
                COBISMessageBox.Show(FMLoadResString(502567), FMLoadResString(502550), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
                TxtCodigo(Index).Focus()
                Exit Sub
            End If
        Else
            TxtCodigo(Index).Text = TxtCodigo(Index).Text.Trim().ToUpper()
        End If
        PLTSEstado()
    End Sub

    Private Sub TxtCodigo_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _TxtCodigo_0.MouseDown

    End Sub

    Private Sub txtDescripcion_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtDescripcion_0.Enter
        Dim Index As Integer = Array.IndexOf(txtDescripcion, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502601))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502950))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502599))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502945))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502948))
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502596))
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501038))
        End Select
        txtDescripcion(Index).SelectionStart = 0
        txtDescripcion(Index).SelectionLength = Strings.Len(txtDescripcion(Index).Text)
    End Sub

    Private Sub txtDescripcion_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtDescripcion_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        If VLTabla <> "cc_trn_causa_contb" Then
            If KeyAscii = 209 Or KeyAscii = 241 Then
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Else
                If (KeyAscii <> 8) And (KeyAscii <> 32) And (KeyAscii < 65 Or KeyAscii > 90) And (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii < 97 Or KeyAscii > 122) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            End If
        End If
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtDescripcion_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtDescripcion_0.Leave
        Dim Index As Integer = Array.IndexOf(txtDescripcion, eventSender)
        If VLTabla <> "cc_trn_causa_contb" Then
            txtDescripcion(Index).Text = txtDescripcion(Index).Text.Trim().ToUpper()
        Else
            txtDescripcion(Index).Text = txtDescripcion(Index).Text.Trim()
        End If
    End Sub

    Private Sub txtDescripcion_MouseDown(ByVal eventSender As Object, ByVal eventArgs As MouseEventArgs) Handles _txtDescripcion_0.MouseDown

    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtEstado_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtEstado_0.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtEstado_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtEstado_0.Enter
        Dim Index As Integer = Array.IndexOf(txtEstado, eventSender)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502579))
        txtEstado(Index).SelectionStart = 0
        txtEstado(Index).SelectionLength = Strings.Len(txtEstado(Index).Text)
    End Sub

    Private Sub txtEstado_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtEstado_0.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtEstado, eventSender)
        Const F5 As Integer = 116
        If Keycode = F5 Then
            VLPaso = True
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_estado_ser")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
            PMHelpG("cobis", "sp_hp_catalogo", 3, 1)
            PMBuscarG(1, "@i_tabla", "cl_estado_ser", SQLVARCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMSigteG(1, "@i_codigo", 1, SQLVARCHAR)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then
                PMMapeaGrid(sqlconn, grid_valores.gr_SQL, False)
                PMMapeaTextoGrid(grid_valores.gr_SQL)
                PMAnchoColumnasGrid(grid_valores.gr_SQL)
                PMChequea(sqlconn)
                PMProcesG()
                grid_valores.ShowPopup(Me)
                If Not (Temporales(1) Is Nothing) Then
                    If Temporales(1) <> "" Then
                        txtEstado(Index).Text = Temporales(1)
                        lbldEstado(Index).Text = Temporales(2)
                        VLPaso = True
                        SendKeys.Send("{TAB}")
                    End If
                Else
                    VLPaso = False
                    txtEstado_Leave(txtEstado(Index), New EventArgs())
                End If
            Else
                PMChequea(sqlconn)
            End If
        End If
        PLTSEstado()
    End Sub

    Private Sub txtEstado_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtEstado_0.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtEstado_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtEstado_0.Leave
        Dim Index As Integer = Array.IndexOf(txtEstado, eventSender)
        If Not VLPaso Then
            txtEstado(Index).Text = txtEstado(Index).Text.Trim().ToUpper()
            If txtEstado(Index).Text <> "" Then
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_estado_ser")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtEstado(Index).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, "") Then
                    PMMapeaObjeto(sqlconn, lbldEstado(Index))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtEstado(Index).Text = ""
                    lbldEstado(Index).Text = ""
                    txtEstado(Index).Focus()
                    VLPaso = True
                End If
            End If
        Else
            txtEstado(Index).Text = txtEstado(Index).Text.Trim()
        End If
        If txtEstado(Index).Text = "" And lbldEstado(Index).Text <> "" Then
            lbldEstado(Index).Text = ""
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBActualizar.Enabled = cmdActualizar.Enabled
        TSBActualizar.Visible = cmdActualizar.Visible
        TSBBuscar.Enabled = cmdBuscar.Enabled
        TSBBuscar.Visible = cmdBuscar.Visible
        TSBIngresar.Enabled = cmdIngresar.Enabled
        TSBIngresar.Visible = cmdIngresar.Visible
        TSBLimpiar.Enabled = cmdLimpiar.Enabled
        TSBLimpiar.Visible = cmdLimpiar.Visible
        TSBSalir.Enabled = cmdSalir1.Enabled
        TSBSalir.Visible = cmdSalir1.Visible
        TSBSiguiente.Enabled = cmdSiguiente.Enabled
        TSBSiguiente.Visible = cmdSiguiente.Visible
        TSBTransmitir.Enabled = cmdTransmitir.Enabled
        TSBTransmitir.Visible = cmdTransmitir.Visible
        TSBCancelar.Enabled = cmdCancelar.Enabled
        TSBCancelar.Visible = cmdCancelar.Visible
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        'TSBotones.Focus()
        If cmdActualizar.Enabled Then cmdActualizar_Click(sender, e)
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        'TSBotones.Focus()
        If cmdBuscar.Enabled Then cmdBuscar_Click(sender, e)
    End Sub

    Private Sub TSBIngresar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBIngresar.Click
        'TSBotones.Focus()
        If cmdIngresar.Enabled Then cmdIngresar_Click(sender, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        'TSBotones.Focus()
        If cmdLimpiar.Enabled Then cmdLimpiar_Click(sender, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If cmdSalir1.Enabled Then cmdSalir1_Click(sender, e)
    End Sub

    Private Sub TSBSiguiente_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSiguiente.Click
        'TSBotones.Focus()
        If cmdSiguiente.Enabled Then cmdSiguiente_Click(sender, e)
    End Sub

    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        'TSBotones.Focus()
        If cmdTransmitir.Enabled Then cmdTransmitir_Click(sender, e)
    End Sub

    Private Sub TSBCancelar_Click(sender As Object, e As EventArgs) Handles TSBCancelar.Click
        If cmdCancelar.Enabled Then cmdCancelar_Click(sender, e)
    End Sub

    Private Sub fraBusqueda_VisibleChanged(sender As Object, e As EventArgs) Handles fraBusqueda.VisibleChanged
        If fraBusqueda.Visible Then

            cboTabla.TabStop = True
            grdValores.TabStop = True
            cboTabla.TabIndex = 0
            grdValores.TabIndex = 1
            cboTabla.Focus()
            TxtCodigo(0).TabStop = False
            txtDescripcion(0).TabStop = False
            txtEstado(0).TabStop = False
        Else
            TxtCodigo(0).TabStop = True
            txtDescripcion(0).TabStop = True
            txtEstado(0).TabStop = True
            TxtCodigo(0).Focus()
            TxtCodigo(0).TabIndex = 0
            txtDescripcion(0).TabIndex = 1
            txtEstado(0).TabIndex = 2
            cboTabla.TabStop = False
            grdValores.TabStop = False
        End If
    End Sub

    Private Sub grdValores_Enter(sender As Object, e As EventArgs) Handles grdValores.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5260))
    End Sub
End Class


