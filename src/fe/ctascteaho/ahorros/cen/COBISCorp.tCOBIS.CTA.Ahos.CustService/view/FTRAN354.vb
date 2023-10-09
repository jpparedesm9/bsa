Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FTRAN354Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLTitular As Integer = 0
    Dim VLPaso As Boolean = False
    Dim VLEstadoInicial As String = ""
    Dim VLFormatoFecha As String = ""
    Dim VLCed As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_2.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 2
                PLActualizar()
            Case 3
                PLLimpiar()
            Case 4
                PLSalir()
        End Select
    End Sub

    Private Sub FTRAN354_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub
    Private Sub PLTSEstado()
        TSBTransmitir.Enabled = _cmdBoton_2.Enabled
        TSBTransmitir.Visible = _cmdBoton_2.Visible
        TSBLimpiar.Enabled = _cmdBoton_3.Enabled
        TSBLimpiar.Visible = _cmdBoton_3.Visible
        TSBSalir.Enabled = _cmdBoton_4.Enabled
        TSBSalir.Visible = _cmdBoton_4.Visible
    End Sub
    Private Sub TSBTransmitir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Public Sub PLInicializar()
        grdPropietarios.set_ColIsVisible(0, False)
        grdPropietarios.ColWidth(1) = 960
        grdPropietarios.ColWidth(2) = 1440
        grdPropietarios.ColWidth(3) = 300
        grdPropietarios.ColWidth(4) = 3915
        grdPropietarios.ColWidth(5) = 375
        grdPropietarios.ColWidth(6) = 1230
        grdPropietarios.Row = 0
        grdPropietarios.Col = 1
        grdPropietarios.CtlText = FMLoadResString(9919)
        grdPropietarios.Col = 2
        grdPropietarios.CtlText = FMLoadResString(9938)
        grdPropietarios.Col = 3
        grdPropietarios.CtlText = FMLoadResString(508988)
        grdPropietarios.Col = 4
        grdPropietarios.CtlText = FMLoadResString(9940)
        grdPropietarios.Col = 5
        grdPropietarios.CtlText = FMLoadResString(508989)
        grdPropietarios.Col = 6
        grdPropietarios.CtlText = FMLoadResString(9095)
        cmdBoton(2).Enabled = False
        cmdBoton(3).Enabled = False
        txtCampo(7).Enabled = False
        txtCampo(4).Enabled = False
        VLTitular = 0
        VLEstadoInicial = New String(" "c, 0)
    End Sub

    Private Sub FTRAN354_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
    End Sub

    Private Sub grdPropietarios_ClickEvent(sender As Object, e As EventArgs) Handles grdPropietarios.ClickEvent
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_DblClick(sender As Object, e As EventArgs) Handles grdPropietarios.DblClick
        PMMarcaFilaCobisGrid(grdPropietarios, grdPropietarios.Row)
    End Sub

    Private Sub grdPropietarios_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles grdPropietarios.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500934))
    End Sub

    Private Sub PLActualizar()
        Dim VTArreglo(20) As String, VTArreglo1(20) As String
        If Not FLVerificarMenor() Then
            Exit Sub
        End If
        If txtCampo(6).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501083), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(501084), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(501085), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).Focus()
            Exit Sub
        Else
            If VLEstadoInicial = txtCampo(5).Text Then
                COBISMessageBox.Show(FMLoadResString(2460), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                Exit Sub
            End If
            If txtCampo(5).Text <> "AP" And txtCampo(5).Text <> "NE" Then
                COBISMessageBox.Show(FMLoadResString(501086), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(5).Text = ""
                lblDescripcion(9).Text = ""
                If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).Focus()
                Exit Sub
            End If
            If txtCampo(5).Text = "NE" And txtCampo(0).Text = "" Then
                COBISMessageBox.Show(FMLoadResString(501087), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCampo(0).Enabled = True
                txtCampo(0).Focus()
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "354")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
        PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_estado", 0, SQLCHAR, txtCampo(5).Text)
        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, txtCampo(2).Text)
        PMPasoValores(sqlconn, "@i_depart", 0, SQLCHAR, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_desc", 0, SQLVARCHAR, txtCampo(0).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2463)) Then

            If txtCampo(2).Text.Trim() = "···&&2" Then
                FMMapeaArreglo(sqlconn, VTArreglo1)
            End If
            FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            cmdBoton(2).Enabled = False
            txtCampo(0).Enabled = False
        Else
            PMChequea(sqlconn)
            lblDescripcion(1).Text = ""
        End If
        PLTSEstado()
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 2 To 7
            If i <> 4 Then
                txtCampo(i).Text = ""
            End If
        Next i
        txtCampo(3).Tag = ""
        lblDescripcion(1).Text = ""
        For i As Integer = 6 To 10
            If i <> 8 Then
                lblDescripcion(i).Text = ""
            End If
        Next i
        lblmalaref.Text = ""
        lblmalaref.Visible = False
        grdPropietarios.Rows = 2
        grdPropietarios.Row = 1
        For i As Integer = 0 To 6
            grdPropietarios.Col = i
            grdPropietarios.CtlText = ""
        Next i
        grdPropietarios.Tag = ""
        VLTitular = 0
        VLEstadoInicial = New String(" "c, 0)
        txtCampo(0).Text = ""
        txtCampo(0).Enabled = False
        If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
        txtCampo(5).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(2).Enabled = False
    End Sub

    Private Sub PLSalir()
        Me.Close()
    End Sub


    Private Sub PLTransmitir()
        Dim VTR As Integer = 0
        If txtCampo(6).Text = "" Then
            Exit Sub
        End If
        For i As Integer = 2 To 6
            If i <> 6 Then
                txtCampo(i).Text = ""
            End If
        Next i
        txtCampo(3).Tag = ""
        lblDescripcion(1).Text = ""
        For i As Integer = 6 To 9
            lblDescripcion(i).Text = ""
        Next i
        grdPropietarios.Rows = 2
        grdPropietarios.Row = 1
        For i As Integer = 0 To 6
            grdPropietarios.Col = i
            grdPropietarios.CtlText = ""
        Next i
        grdPropietarios.Tag = ""
        VLTitular = 0
        VLEstadoInicial = New String(" "c, 0)
        txtCampo(5).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(2).Enabled = False
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "355")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "SI")
        PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2464)) Then
            Dim VTArreglo(20) As String
            FMMapeaArreglo(sqlconn, VTArreglo)

            PMChequea(sqlconn)

            ' VGMoneda = "0"
            If CInt(VTArreglo(3)) = CInt(VGMoneda) Then
                cmdBoton(2).Enabled = True
                cmdBoton(3).Enabled = True
                txtCampo(3).Text = VGMoneda
                PMCatalogo("V", "cl_moneda", txtCampo(3), lblDescripcion(7))
                txtCampo(3).Enabled = False
                VLPaso = True
                txtCampo(4).Text = VTArreglo(4)
                If txtCampo(4).Text.Trim() <> "" Then
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8")
                    PMPasoValores(sqlconn, "@i_dep", 0, SQLINT2, txtCampo(4).Text)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_departamento", True, FMLoadResString(2465)) Then
                        PMMapeaObjeto(sqlconn, lblDescripcion(8))
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        txtCampo(4).Text = ""
                        lblDescripcion(8).Text = ""
                        If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).Focus()
                    End If
                End If
                txtCampo(5).Text = VTArreglo(9)
                VLEstadoInicial = VTArreglo(9)
                PMCatalogo("V", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9))
                VLPaso = True
                txtCampo(7).Text = VTArreglo(10)
                PMCatalogo("V", "pe_categoria", txtCampo(7), lblDescripcion(10))
                VLPaso = True
                If VTArreglo(11) = "S" Then
                    lblmalaref.Text = FMLoadResString(502411)
                    lblmalaref.Visible = True
                Else
                    lblmalaref.Text = ""
                    lblmalaref.Visible = False
                End If
                VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
                lblDescripcion(1).Text = StringsHelper.Format(VTArreglo(6), VLFormatoFecha)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "356")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S1")
                PMPasoValores(sqlconn, "@i_numsol", 0, SQLINT4, txtCampo(6).Text)
                PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, FMLoadResString(2464)) Then
                    Dim Valores(8, 40) As String
                    VTR = FMMapeaMatriz(sqlconn, Valores)
                    VLTitular = 0
                    For i As Integer = 1 To VTR
                        If Valores(1, i) <> "" Then
                            VLCed = Valores(1, i)
                        Else
                            VLCed = Valores(2, i)
                        End If
                        grdPropietarios.AddItem(ChrW(9) & Valores(0, i) & ChrW(9) & VLCed & ChrW(9) & Valores(3, i) & ChrW(9) & Valores(4, i) & ChrW(9) & Valores(5, i) & ChrW(9) & Valores(6, i))
                        If Valores(5, i).Trim() = "T" Then
                            VLTitular = i
                        End If
                    Next i
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                End If
                If grdPropietarios.Rows > 2 Then
                    grdPropietarios.RemoveItem(1)
                End If

                grdPropietarios.ColWidth(0) = 0
                grdPropietarios.ColWidth(1) = 960
                grdPropietarios.ColWidth(2) = 1440
                grdPropietarios.ColWidth(3) = 300
                grdPropietarios.ColWidth(4) = 3915
                grdPropietarios.ColWidth(5) = 375
                grdPropietarios.ColWidth(6) = 2710
                grdPropietarios.Row = 0
                grdPropietarios.Col = 1
                grdPropietarios.CtlText = FMLoadResString(9919)
                grdPropietarios.Col = 2
                grdPropietarios.CtlText = FMLoadResString(9938)
                grdPropietarios.Col = 3
                grdPropietarios.CtlText = FMLoadResString(508988)
                grdPropietarios.Col = 4
                grdPropietarios.CtlText = FMLoadResString(9940)
                grdPropietarios.Col = 5
                grdPropietarios.CtlText = FMLoadResString(508989)
                grdPropietarios.Col = 6
                grdPropietarios.CtlText = FMLoadResString(9095)
                txtCampo(2).Text = VTArreglo(5)
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(2).Text)
                PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                grdPropietarios.Row = VLTitular
                grdPropietarios.Col = 3
                PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(2).Text = ""
                    lblDescripcion(6).Text = ""
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                End If
                If VTArreglo(9) = "PR" Then
                    COBISMessageBox.Show(FMLoadResString(501088), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    cmdBoton(2).Enabled = False
                    txtCampo(2).Enabled = False
                    txtCampo(4).Enabled = False
                    txtCampo(5).Enabled = False
                    txtCampo(7).Enabled = False
                    If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
                    Exit Sub
                End If
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
            Else
                COBISMessageBox.Show(FMLoadResString(501089), My.Application.Info.ProductName)
                If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
            End If

        Else
            PMChequea(sqlconn)
            PLLimpiar()
            If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
        End If

        PLTSEstado()
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.TextChanged, _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2, 3, 4, 5, 6, 7
                VLPaso = False
        End Select
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_6.Enter, _txtCampo_2.Enter, _txtCampo_7.Enter, _txtCampo_3.Enter, _txtCampo_5.Enter, _txtCampo_0.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(2227)) 'observaciones
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501226)) 'producto bancario
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501422)) ' Moneda de la Chequera [F5 Ayuda]
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501093)) 'Estado de la cuenta [F5 Ayuda]
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501095)) 'codigo de categoria
            Case 6

                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501094)) 'numero solicitud
        End Select
        VLPaso = True
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_0.KeyDown, _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode = VGTeclaAyuda Then
            VLPaso = True
            Select Case Index
                Case 2  'Prod Bancario
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2467)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        VLPaso = True
                        FCatalogo.ShowPopup(Me)
                        txtCampo(2).Text = VGACatalogo.Codigo
                        lblDescripcion(6).Text = VGACatalogo.Descripcion
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        If txtCampo(2).Text <> "" And txtCampo(7).Enabled Then
                            If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 3 'MONEDA
                    PMCatalogo("A", "cl_moneda", txtCampo(3), lblDescripcion(7))
                    VLPaso = True
                Case 4
                    VLPaso = True
                    PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8")
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_departamento", True, FMLoadResString(2465)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(4).Text = VGACatalogo.Codigo
                        lblDescripcion(8).Text = VGACatalogo.Descripcion
                        If txtCampo(4).Text <> "" Then
                            If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).Focus()
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
                Case 5 'ESTADO
                    PMCatalogo("A", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9))
                    VLPaso = True
                    If txtCampo(5).Text = "NE" Then
                        txtCampo(0).Enabled = True
                        txtCampo(0).Focus()
                    Else
                        txtCampo(0).Text = ""
                        txtCampo(0).Enabled = False
                        If txtCampo(5).Text <> "" And cmdBoton(2).Enabled Then
                            If cmdBoton(2).Enabled And cmdBoton(2).Visible Then cmdBoton(2).Focus()
                        End If
                    End If
                Case 7 'CATEGORIA
                    If txtCampo(6).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(501082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
                        Exit Sub
                    End If
                    If txtCampo(2).Text.Trim() = "" Then
                        COBISMessageBox.Show(FMLoadResString(500647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                        Exit Sub
                    End If
                    If VLTitular <= 0 Then
                        COBISMessageBox.Show(FMLoadResString(501097), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                        Exit Sub
                    Else
                        grdPropietarios.Row = VLTitular
                        grdPropietarios.Col = 3
                    End If
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                    PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "H")
                    PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                    PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text)
                    PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2468)) Then
                        PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                        PMChequea(sqlconn)
                        FCatalogo.ShowPopup(Me)
                        txtCampo(7).Text = VGACatalogo.Codigo
                        lblDescripcion(10).Text = VGACatalogo.Descripcion
                        If txtCampo(7).Text.Trim() <> "" Then
                            VLPaso = True
                            If txtCampo(4).Enabled Then
                                If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).Focus()
                            End If
                        End If
                    Else
                        PMChequea(sqlconn)
                    End If
            End Select
        End If
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_0.KeyPress, _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
            Case 2, 3, 4, 6
                If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
                    KeyAscii = 0
                End If
            Case 5
                If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
                    KeyAscii = 0
                Else
                    KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
                End If
            Case 7
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Public Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_0.Leave, _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 2 'PROD BANCARIO
                If Not VLPaso Then
                    If txtCampo(2).Text <> "" Then
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501096), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "424")
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_prodfin", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_prodban", 0, SQLINT2, "4")
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_cons_productoban", True, FMLoadResString(2466)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(6))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(2).Text = ""
                            lblDescripcion(6).Text = ""
                            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                        End If
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                    Else
                        lblDescripcion(6).Text = ""
                        txtCampo(7).Text = ""
                        lblDescripcion(10).Text = ""
                    End If
                End If
            Case 3 'MONEDA
                If Not VLPaso Then
                    If txtCampo(3).Text <> "" Then
                        PMCatalogo("V", "cl_moneda", txtCampo(3), lblDescripcion(7))
                    Else
                        lblDescripcion(7).Text = ""
                    End If
                End If
            Case 4
                If Not VLPaso Then
                    If txtCampo(4).Text <> "" Then
                        If CInt(txtCampo(4).Text) > 255 Then
                            COBISMessageBox.Show(FMLoadResString(501098), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(4).Text = ""
                            If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).Focus()
                        End If
                        PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "V")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_ofi", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "8")
                        PMPasoValores(sqlconn, "@i_dep", 0, SQLINT2, txtCampo(4).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_departamento", True, FMLoadResString(2465)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(8))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(4).Text = ""
                            lblDescripcion(8).Text = ""
                            If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).Focus()
                        End If
                    Else
                        lblDescripcion(8).Text = ""
                    End If
                End If
            Case 5 'ESTADO
                If Not VLPaso Then
                    If txtCampo(5).Text <> "" Then
                        PMCatalogo("V", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9))
                        If lblDescripcion(9).Text <> "" Then
                            If txtCampo(5).Text = "NE" Then
                                txtCampo(0).Enabled = True
                                txtCampo(0).Focus()
                            Else
                                txtCampo(0).Text = ""
                                txtCampo(0).Enabled = False
                            End If
                        End If
                    Else
                        lblDescripcion(9).Text = ""
                    End If
                End If
            Case 6 'SOLICITUD
                If Not VLPaso Then
                    PLTransmitir()
                    VLPaso = True
                End If
            Case 7 'CATEGORIA
                If Not VLPaso Then
                    If txtCampo(7).Text <> "" Then
                        If txtCampo(6).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(501082), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).Focus()
                            Exit Sub
                        End If
                        If txtCampo(2).Text.Trim() = "" Then
                            COBISMessageBox.Show(FMLoadResString(500647), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
                            Exit Sub
                        End If
                        If VLTitular <= 0 Then
                            COBISMessageBox.Show(FMLoadResString(501097), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            Exit Sub
                        Else
                            grdPropietarios.Row = VLTitular
                            grdPropietarios.Col = 3
                        End If
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "4101")
                        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "Q")
                        PMPasoValores(sqlconn, "@i_cons_profinal", 0, SQLCHAR, "S")
                        PMPasoValores(sqlconn, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text)
                        PMPasoValores(sqlconn, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.CtlText)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, "4")
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                        PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
                        PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                        PMPasoValores(sqlconn, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text)
                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_categoria_profinal", True, FMLoadResString(2468)) Then
                            PMMapeaObjeto(sqlconn, lblDescripcion(10))
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            txtCampo(7).Text = ""
                            lblDescripcion(10).Text = ""
                            If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).Focus()
                        End If
                    Else
                        lblDescripcion(10).Text = ""
                    End If
                End If
        End Select
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Function FLVerificarMenor() As Boolean
        Dim result As Boolean = False
        Dim VTCadena As String = ""
        Dim vti As Integer = 0
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "350")
        'II JSA CUENTAS MENOR DE EDAD
        If txtCampo(2).Text <> "" Then 'JSA
            PMPasoValores(sqlconn, "@i_prod_banc", 0, SQLCHAR, txtCampo(2).Text)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
        End If
        'FI JSA CUENTAS MENOR DE EDAD
        For j As Integer = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            grdPropietarios.Col = 5
            VTCadena = ""
            vti += 1
            grdPropietarios.Col = 1
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 5
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            grdPropietarios.Col = 4
            VTCadena = VTCadena & (grdPropietarios.CtlText) & "@"
            PMPasoValores(sqlconn, "@i_param" & vti, 0, SQLCHAR, VTCadena)
        Next j
        If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_valida_menor", True, FMLoadResString(2469)) Then
            'II JSA CUENTAS MENOR DE EDAD
            PMMapeaVariable(sqlconn, VTCadena)
            If VTCadena <> "" Then
                COBISMessageBox.Show(VTCadena, FMLoadResString(500092), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            End If
            'FI JSA CUENTAS MENOR DE EDAD
            PMChequea(sqlconn)
            vti = FMRetStatus(sqlconn)
            If vti <> 0 Then
                result = False
            Else
                result = True
            End If
        Else
            PMChequea(sqlconn)
            result = False
        End If
        Return result
    End Function

    Private Sub grdPropietarios_Leave(sender As Object, e As EventArgs) Handles grdPropietarios.Leave
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

End Class


