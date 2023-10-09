Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Globalization
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Partial Public Class FParamContaClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    Dim VLPaso As Integer = 0
    Dim VLTabla As String = ""
    Dim VLSecuencial As String = ""
    Dim VLMatrizTrans(2, 80) As String
    Dim VLParametro As String = ""
    Dim Msg As String = ""
    Dim i As Integer = 0
    Dim causa_sus As Integer = 0
    Dim VTCausaOrg As String = ""
    Dim VTIndicador As String = ""
    Dim causa As String = ""

    Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_0.Click, _cmdBoton_5.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_3.Click, _cmdBoton_4.Click
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                PLBuscar()
            Case 1
                PLLimpiar()
            Case 2
                Me.Close()
            Case 3
                PLIngresar()
            Case 4
                PLModificar()
            Case 5
                Grid1.Col = 0
                Msg = FMLoadResString(502975) & Grid1.CtlText & " ?" 'Esta Seguro de Eliminar el Registro Nro:
                If COBISMessageBox.Show(Msg, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.Yes Then
                    PLEliminar()
                    PLLimpiar()
                End If
        End Select
    End Sub

    Private Sub FParamConta_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
        CargaFormatoFecha()
    End Sub

    Public Sub PLInicializar()
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_trn_causa_contb")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502976)) Then 'Consulta de las transacciones con causa cont.
            FMMapeaMatriz(sqlconn, VLMatrizTrans)
            PMChequea(sqlconn)
        End If
        VLTabla = "cc_campo_contable"
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(503344)) Then 'Ok... Consulta de parámetros
            PMMapeaGrid(sqlconn, grdConta, False)
            PMChequea(sqlconn)
            For j As Integer = 0 To 2
                grdConta.Col = 2
                For i As Integer = 0 To grdConta.Rows - 2
                    grdConta.Row = i + 1
                    CmbContab(j).Items.Insert(i, grdConta.CtlText)
                Next i
            Next j
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private isInitializingComponent As Boolean = False

    Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged, _txtCampo_2.TextChanged, _txtCampo_3.TextChanged
        If isInitializingComponent Then
            Exit Sub
        End If
        VLPaso = False
    End Sub

    Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter, _txtCampo_2.Enter, _txtCampo_3.Enter
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502628)) 'Código del producto [F5 Ayuda]
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502629)) 'Transacción [F5 Ayuda]
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503369)) 'Causa asociada a la transacción [F5 Ayuda]
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502257)) 'Crédito [C] o Débito [D]
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509068)) 'Concepto Contable [F5 Ayuda]
            Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503371)) 'Indicador de la transacción [F5 Ayuda]
            Case 6
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502631)) 'Tipo Total [F5 Ayuda]
            Case 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502632)) 'Tipo Impuesto [F5 Ayuda]
        End Select
        txtCampo(Index).SelectionStart = 0
        txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
    End Sub

    Private Sub CmbContab_GotFocus(ByVal eventSender As Object, e As EventArgs) Handles _CmbContab_0.GotFocus, _CmbContab_1.GotFocus, _CmbContab_2.GotFocus
        Dim Index As Integer = Array.IndexOf(CmbContab, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509069)) 'Lista Campo a Contabilizar
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509070)) 'Lista Campo Base 1
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509071)) 'Lista Campo Base 2
        End Select
    End Sub

    Sub PMTransaccion(ByRef ICampo As Integer, ByRef IProducto As Integer, ByRef operacion As String, ByRef Transaccion As String)
        If txtCampo(IProducto).Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(502633), My.Application.Info.ProductName) 'CODIGO DE PRODUCTO ES OBLIGATORIO
            If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
                txtCampo(IProducto).Focus()
            End If
            Exit Sub
        End If
        VLPaso = True
        If operacion = "S" Then
            VGOperacion = "sp_pro_transaccion"
            VGProductoConta = txtCampo(IProducto).Text
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "15020")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, operacion)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLCHAR, "9")
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, txtCampo(IProducto).Text)
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "R")
            PMPasoValores(sqlconn, "@i_moneda", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_transaccion", 0, SQLINT4, "0")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_pro_transaccion", True, FMLoadResString(502984)) Then 'OK... Consulta de Transacción
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(ICampo).Text = VGACatalogo.Codigo
                lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
                If txtCampo(ICampo).Text.Trim() = "" Then
                    txtCampo(ICampo).Text = ""
                    lblDescripcion(ICampo).Text = ""
                    If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                        txtCampo(ICampo).Focus()
                    End If
                End If
            Else
                PMChequea(sqlconn)
            End If
        Else
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, Transaccion)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
                PMMapeaObjeto(sqlconn, lblDescripcion(ICampo))
                PMChequea(sqlconn)
                txtCampo(2).Text = ""
                lblDescripcion(2).Text = ""
            Else
                PMChequea(sqlconn)
                txtCampo(ICampo).Text = ""
                lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
            VLTabla = ""
            txtCampo(1).Enabled = False
            For i As Integer = 1 To VLMatrizTrans.GetUpperBound(1)
                If txtCampo(0).Text = VLMatrizTrans(0, i) Then
                    VLTabla = VLMatrizTrans(1, i)
                    txtCampo(1).Enabled = True
                    Exit For
                End If
            Next i
        End If
    End Sub

    Sub PMCatalogo1(ByRef ICampo As Integer, ByRef operacion As String, ByRef Tabla As String)
        VGOperacion = ""
        PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, operacion)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502985) & "[" & txtCampo(ICampo).Text & "]") Then 'Consulta de indicadores
            VLPaso = True
            PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
            PMChequea(sqlconn)
            FCatalogo.ShowPopup(Me)
            txtCampo(ICampo).Text = VGACatalogo.Codigo
            lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
            If ICampo <> 7 Then
                txtCampo(ICampo + 1).Focus()
            Else
                txtCampo(ICampo).Focus()
            End If
            If txtCampo(ICampo).Text.Trim() = "" Then
                lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Sub PMProducto(ByRef ICampo As Integer, ByRef operacion As String, ByRef Producto As String)
        VLPaso = True
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
        PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, operacion)
        If operacion = "V" Then
            PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, Producto)
        End If
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(2277)) Then 'OK... Consulta de Productos COBIS
            If operacion = "A" Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                FCatalogo.ShowPopup(Me)
                txtCampo(ICampo).Text = VGACatalogo.Codigo
                lblDescripcion(ICampo).Text = VGACatalogo.Descripcion
                txtCampo(ICampo + 1).Focus()
            Else
                PMMapeaObjeto(sqlconn, lblDescripcion(ICampo))
                PMChequea(sqlconn)
            End If
            If txtCampo(ICampo).Text.Trim() = "" Then
                lblDescripcion(ICampo).Text = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                    txtCampo(ICampo).Focus()
                End If
            End If
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown, _txtCampo_2.KeyDown, _txtCampo_3.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        If Keycode <> VGTeclaAyuda Then
            Exit Sub
        End If
        Select Case Index
            Case 0
                PMProducto(Index, "A", "0")
            Case 1
                PMTransaccion(Index, 0, "S", "0")
            Case 2
                If txtCampo(1).Text = VLParametro Then
                    VLTabla = "ah_cau_nc_gmf_ba"
                End If
                PMCatalogo1(Index, "A", VLTabla)
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(503369)) 'Causa asociada a la transacción [F5 Ayuda] 
            Case 3
                PMCatalogo1(Index, "A", "re_naturaleza_trn")
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(502257)) 'Crédito [C] o Débito [D]
            Case 4
                PMCatalogo1(Index, "A", "re_concepto_contable")
            Case 5
                PMCatalogo1(Index, "A", "cc_tipo_indicador")
            Case 6
                PMCatalogo1(Index, "A", "re_campo_totaliza")
            Case 7
                PMCatalogo1(Index, "A", "cb_tipo_impuesto")
        End Select
    End Sub

    Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress, _txtCampo_2.KeyPress, _txtCampo_3.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Select Case Index
            Case 0, 1, 5
                KeyAscii = FMVAlidaTipoDato("N", KeyAscii)
            Case 4, 2
                KeyAscii = FMVAlidaTipoDato("AN", KeyAscii)
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
            Case 3, 6, 7
                KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
                KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        End Select
        If KeyAscii = 0 Then
            eventArgs.Handled = True
        End If
        eventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave, _txtCampo_2.Leave, _txtCampo_3.Leave
        Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
        Dim VTTranVal As Integer = 0
        Dim causa As String = String.Empty
        Dim VLVal As String = String.Empty
        Dim VLTransac As Integer = 0
        Select Case Index
            Case 1
                If txtCampo(1).Text.Trim() = "" Then
                    lblDescripcion(1).Text = ""
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de producto mandatorio
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(7).Focus()
                    Exit Sub
                End If
                VTTranVal = Conversion.Val(txtCampo(1).Text)
                Select Case txtCampo(0).Text.Trim()
                    Case "3"
                        If VTTranVal > 2999 Or (VTTranVal < 600 And VTTranVal > 99) Or (VTTranVal < 2500 And VTTranVal > 700) Then
                            If VTTranVal <> 401 And VTTranVal <> 402 And VTTranVal <> 403 And VTTranVal <> 404 And VTTranVal <> 405 And VTTranVal <> 406 And VTTranVal <> 407 And VTTranVal <> 408 And VTTranVal <> 409 And VTTranVal <> 410 And VTTranVal <> 489 Then
                                COBISMessageBox.Show(FMLoadResString(502636), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de transacción no pertenece a producto
                                txtCampo(1).Text = ""
                                lblDescripcion(1).Text = ""
                                txtCampo(1).Focus()
                                Exit Sub
                            End If
                        End If
                    Case "4"
                      
                        If VTTranVal <= 200 Or VTTranVal >= 399 Or VTTranVal = 401 Then
                            If VTTranVal <> 200 And VTTranVal <> 217 And VTTranVal <> 218 And VTTranVal <> 401 And VTTranVal <> 402 And VTTranVal <> 403 And VTTranVal <> 404 And VTTranVal <> 405 And VTTranVal <> 406 And VTTranVal <> 407 And VTTranVal <> 408 And VTTranVal <> 409 And VTTranVal <> 410 And VTTranVal <> 489 Then
                                COBISMessageBox.Show(FMLoadResString(502986), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de transacción no pertenece a producto
                                txtCampo(1).Text = ""
                                lblDescripcion(1).Text = ""
                                If txtCampo(1).Enabled And txtCampo(1).Visible Then
                                    txtCampo(1).Focus()
                                End If
                                Exit Sub
                            End If
                        End If

                    Case "10"
                        If (VTTranVal >= 500 Or VTTranVal < 400) Or VTTranVal = 401 Then
                            If VTTranVal >= 700 Or VTTranVal < 600 Then
                                COBISMessageBox.Show(FMLoadResString(503319), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de transacción no pertenece a producto
                                txtCampo(1).Text = ""
                                lblDescripcion(1).Text = ""
                                txtCampo(1).Focus()
                                Exit Sub
                            End If
                        End If
                End Select
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "494")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "H")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLINT4, txtCampo(1).Text)
                PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(1))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Text = ""
                    txtCampo(1).Focus()
                End If
                PLParametro()
                VLTabla = ""
                If txtCampo(1).Text = VLParametro Then
                    txtCampo(2).Enabled = True
                Else
                    txtCampo(2).Enabled = False
                End If
                For i As Integer = 1 To VLMatrizTrans.GetUpperBound(1)
                    If txtCampo(1).Text = VLMatrizTrans(0, i) Then
                        VLTabla = VLMatrizTrans(1, i)
                        txtCampo(2).Enabled = True
                        ' txtCampo(2).Focus()
                        Exit For
                    End If
                Next i
            Case 2
                If txtCampo(1).Text = VLParametro Then
                    VLTabla = "ah_cau_nc_gmf_ba"
                End If
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(2).Text.Trim() = "" Then
                    lblDescripcion(2).Text = ""
                    Exit Sub
                End If
                causa = txtCampo(2).Text
                If VLTabla = "" Then
                    COBISMessageBox.Show(FMLoadResString(502266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Código de transacción mandatorio
                    Exit Sub
                End If
                VLVal = IIf((VLTabla.IndexOf("cc_causa_o", StringComparison.CurrentCultureIgnoreCase) + 1), "S", "N")
                Dim dbNumericTemp As Double = 0
                If txtCampo(2).Text <> "" And Double.TryParse(txtCampo(2).Text, NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) And VLVal = "N" Then
                    causa_sus = CInt(txtCampo(2).Text)
                    causa = txtCampo(2).Text
                    VLTransac = CInt(txtCampo(1).Text)
                    If causa_sus > 500 And (VLTransac = 50 Or VLTransac = 264) Then
                        causa_sus -= 500
                    End If
                    causa = CStr(causa_sus)
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, VLTabla)
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, causa)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502637) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de la causa
                    PMMapeaObjeto(sqlconn, lblDescripcion(2))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(2).Text = ""
                    lblDescripcion(2).Text = ""
                    txtCampo(2).Focus()
                End If
            Case 3
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(3).Text.Trim() = "" Then
                    lblDescripcion(3).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_naturaleza_trn")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(3).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502638) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Naturaleza
                    PMMapeaObjeto(sqlconn, lblDescripcion(3))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(3).Text = ""
                    lblDescripcion(3).Text = ""
                    txtCampo(3).Focus()
                End If
            Case 4
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(4).Text.Trim() = "" Then
                    lblDescripcion(4).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_concepto_contable")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502988) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Naturaleza
                    PMMapeaObjeto(sqlconn, lblDescripcion(4))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(4).Text = ""
                    lblDescripcion(4).Text = ""
                    txtCampo(4).Focus()
                End If
            Case 5
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(5).Text.Trim() = "" Then
                    lblDescripcion(5).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(5).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502989) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Indicador
                    PMMapeaObjeto(sqlconn, lblDescripcion(5))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(5).Text = ""
                    lblDescripcion(5).Text = ""
                    txtCampo(5).Focus()
                End If
            Case 6
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(6).Text.Trim() = "" Then
                    lblDescripcion(6).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(6).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502990) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Total
                    PMMapeaObjeto(sqlconn, lblDescripcion(6))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(6).Text = ""
                    lblDescripcion(6).Text = ""
                    txtCampo(6).Focus()
                End If
            Case 7
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(7).Text.Trim() = "" Then
                    lblDescripcion(7).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, "cb_tipo_impuesto")
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, txtCampo(7).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502991) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Impuesto
                    PMMapeaObjeto(sqlconn, lblDescripcion(7))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(7).Text = ""
                    lblDescripcion(7).Text = ""
                    txtCampo(7).Focus()
                End If
            Case 0
                If VLPaso Then
                    Exit Sub
                End If
                If txtCampo(0).Text.Trim() = "" Then
                    lblDescripcion(0).Text = ""
                    Exit Sub
                End If
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "475")
                PMPasoValores(sqlconn, "@i_ope", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, txtCampo(0).Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_consulta_prod", True, FMLoadResString(502992) & "[" & txtCampo(Index).Text & "]") Then 'Consulta de Producto
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Text = ""
                    txtCampo(0).Focus()
                End If
                If txtCampo(0).Text = "3" Then
                End If
        End Select
    End Sub

    Private Sub PLIngresar()
        If txtCampo(0).Text.Trim() = "" Then
            'El código de producto es mandatorio
            COBISMessageBox.Show(FMLoadResString(502238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(0).Enabled Then txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Then
            'El campo código de transacción es mandatorio
            COBISMessageBox.Show(FMLoadResString(502644), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(1).Enabled Then txtCampo(1).Focus()
            Exit Sub
        End If
        If txtCampo(3).Text.Trim() = "" Then
            'La Naturaleza de la transacción es mandatoria
            COBISMessageBox.Show(FMLoadResString(502643), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(3).Enabled Then txtCampo(3).Focus()
            Exit Sub
        End If
        If txtCampo(4).Text.Trim() = "" Then
            'El campo concepto es mandatorio
            COBISMessageBox.Show(FMLoadResString(502995), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(4).Enabled Then txtCampo(4).Focus()
            Exit Sub
        End If
        If txtCampo(5).Text.Trim() = "" Then
            'El campo Indicador es mandatorio
            COBISMessageBox.Show(FMLoadResString(509029), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(5).Enabled Then txtCampo(5).Focus()
            Exit Sub
        End If
        If txtCampo(6).Text.Trim() = "" Then
            'El campo Tipo Total es mandatorio
            COBISMessageBox.Show(FMLoadResString(502996), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(6).Enabled Then txtCampo(6).Focus()
            Exit Sub
        End If
        If CmbContab(0).Text = "" Then
            'Campo a Contabilizar es mandatorio
            COBISMessageBox.Show(FMLoadResString(509030), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            CmbContab(0).Focus()
            Exit Sub
        End If
        If txtCampo(7).Text.Trim() <> "" And CmbContab(1).Text = "" Then
            'Debe diligenciarse Campo Base1 si se escogió Tipo Impuesto
            COBISMessageBox.Show(FMLoadResString(502997), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            If txtCampo(7).Enabled Then txtCampo(7).Focus()
            Exit Sub
        End If
        If txtCampo(2).Text.Trim() = "" Then
            VTCausaOrg = "0"
        Else
            VTCausaOrg = txtCampo(2).Text
        End If
        If txtCampo(5).Text.Trim() = "" Then
            VTIndicador = "0"
        Else
            VTIndicador = txtCampo(5).Text
        End If
        If txtCampo(2).Enabled And VTCausaOrg = "0" Then
            Msg = FMLoadResString(502998) 'Transaccion maneja causal, Desea parametrizar concepto generico ?
            If COBISMessageBox.Show(Msg, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.Yes Then
                txtCampo(2).Focus()
                Exit Sub
            End If
        End If
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "708")
        PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "I")
        PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(0).Text)
        PMPasoValores(sqlconn, "@i_credeb", 0, SQLCHAR, txtCampo(3).Text)
        PMPasoValores(sqlconn, "@i_tipo_tran", 0, SQLINT2, txtCampo(1).Text)
        PMPasoValores(sqlconn, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg)
        PMPasoValores(sqlconn, "@i_indicador", 0, SQLINT1, VTIndicador)
        PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, txtCampo(4).Text)
        PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(0).Text)
        PMPasoValores(sqlconn, "@i_base1", 0, SQLVARCHAR, CmbContab(1).Text)
        PMPasoValores(sqlconn, "@i_totaliza", 0, SQLCHAR, txtCampo(6).Text)
        PMPasoValores(sqlconn, "@i_tipo_imp", 0, SQLCHAR, txtCampo(7).Text)
        PMPasoValores(sqlconn, "@i_base2", 0, SQLVARCHAR, CmbContab(2).Text)
        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_parctocble", True, FMLoadResString(502999)) Then 'OK ingreso de Transacción a Contabilizar
            txtCampo(0).Focus()
            PMChequea(sqlconn)
            PLLimpiar()
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLLimpiar()
        For i As Integer = 0 To 7
            lblDescripcion(i).Text = ""
            txtCampo(i).Text = ""
        Next i
        PMLimpiaGrid(Grid1)
        cmdBoton(4).Enabled = False
        cmdBoton(5).Enabled = False
        cmdBoton(3).Enabled = True
        CmbContab(0).SelectedIndex = -1
        CmbContab(1).SelectedIndex = -1
        CmbContab(2).SelectedIndex = -1
        txtCampo(0).Enabled = True
        txtCampo(0).Focus()
        PLTSEstado()
    End Sub

    Private Sub PLModificar()
        If VLSecuencial <> "" Then
            If txtCampo(0).Text.Trim() = "" Then
                'El código de producto es mandatorio
                COBISMessageBox.Show(FMLoadResString(502238), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(0).Enabled Then txtCampo(0).Focus()
                Exit Sub
            End If
            If txtCampo(3).Text.Trim() = "" Then
                'La Naturaleza de la transacción es mandatoria
                COBISMessageBox.Show(FMLoadResString(502643), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(3).Enabled Then txtCampo(3).Focus()
                Exit Sub
            End If
            If txtCampo(1).Text.Trim() = "" Then
                'El campo código de transacción es mandatorio
                COBISMessageBox.Show(FMLoadResString(502994), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(1).Enabled Then txtCampo(1).Focus()
                Exit Sub
            End If
            If txtCampo(4).Text.Trim() = "" Then
                'El campo concepto es mandatorio
                COBISMessageBox.Show(FMLoadResString(502645), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(4).Enabled Then txtCampo(4).Focus()
                Exit Sub
            End If
            If txtCampo(6).Text.Trim() = "" Then
                'El campo Tipo Total es mandatorio
                COBISMessageBox.Show(FMLoadResString(502996), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(6).Enabled Then txtCampo(6).Focus()
                Exit Sub
            End If
            If txtCampo(7).Text.Trim() <> "" And CmbContab(1).Text = "" Then
                'Debe diligenciarse Campo Base1 si se escogió Tipo Impuesto
                COBISMessageBox.Show(FMLoadResString(502997), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                If txtCampo(7).Enabled Then txtCampo(7).Focus()
                Exit Sub
            End If
            If txtCampo(2).Text.Trim() = "" Then
                VTCausaOrg = "0"
            Else
                VTCausaOrg = txtCampo(2).Text
            End If
            If txtCampo(5).Text.Trim() = "" Then
                VTIndicador = "0"
            Else
                VTIndicador = txtCampo(5).Text
            End If
            If txtCampo(2).Enabled And VTCausaOrg = "0" Then
                'Transaccion maneja causal, Desea parametrizar concepto generico ?
                Msg = FMLoadResString(502998)
                If COBISMessageBox.Show(Msg, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.YesNo) = System.Windows.Forms.DialogResult.Yes Then
                    txtCampo(2).Focus()
                    Exit Sub
                End If
            End If
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "710")
            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "U")
            PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_credeb", 0, SQLCHAR, txtCampo(3).Text)
            PMPasoValores(sqlconn, "@i_tipo_tran", 0, SQLINT2, txtCampo(1).Text)
            PMPasoValores(sqlconn, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg)
            PMPasoValores(sqlconn, "@i_indicador", 0, SQLINT1, VTIndicador)
            PMPasoValores(sqlconn, "@i_concepto", 0, SQLVARCHAR, txtCampo(4).Text)
            PMPasoValores(sqlconn, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(0).Text)
            PMPasoValores(sqlconn, "@i_base1", 0, SQLVARCHAR, CmbContab(1).Text)
            PMPasoValores(sqlconn, "@i_totaliza", 0, SQLCHAR, txtCampo(6).Text)
            PMPasoValores(sqlconn, "@i_tipo_imp", 0, SQLCHAR, txtCampo(7).Text)
            PMPasoValores(sqlconn, "@i_base2", 0, SQLVARCHAR, CmbContab(2).Text)
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VLSecuencial)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_parctocble", True, FMLoadResString(503000)) Then 'OK Modif de Transacción a Contabilizar
                PMChequea(sqlconn)
                txtCampo(1).Focus()
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(502248), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Transacción a modificarse no seleccionada
        End If
        PLLimpiar()
    End Sub

    Private Sub PLBuscar()
        Dim VTBusqueda As String = String.Empty
        Dim VLCausa As String = String.Empty
        If txtCampo(0).Text.Trim() = "" Then '
            'Código de producto mandatorio
            COBISMessageBox.Show(FMLoadResString(502237), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(0).Focus()
            Exit Sub
        End If
        If txtCampo(1).Text.Trim() = "" Then
            'Código de transacción mandatorio
            COBISMessageBox.Show(FMLoadResString(502266), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            txtCampo(1).Focus()
            Exit Sub
        End If
        Dim VTRegistros As Integer = 20
        Dim VTSecuencial As String = "0"
        Dim VTFlag As Integer = False
        Dim VTCodigoTrn As String = txtCampo(1).Text.Trim()
        If VTCodigoTrn = "" Then
            VTBusqueda = "P"
            VTCodigoTrn = "0"
        Else
            VTBusqueda = "T"
        End If
        If txtCampo(2).Text = "" Then
            VLCausa = "0"
        Else
            VLCausa = txtCampo(2).Text
            VTBusqueda = "C"
        End If
        While VTRegistros = 20
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "719")
            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, VTBusqueda)
            PMPasoValores(sqlconn, "@i_causa_org", 0, SQLCHAR, VLCausa)
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VTSecuencial)
            PMPasoValores(sqlconn, "@i_prod", 0, SQLINT1, txtCampo(0).Text)
            PMPasoValores(sqlconn, "@i_tipo_tran", 0, SQLINT2, VTCodigoTrn)
            PMPasoValores(sqlconn, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_parctocble", True, FMLoadResString(502651)) Then 'OK consulta de Transacciones a Contabilizar
                PMMapeaGrid(sqlconn, Grid1, VTFlag)
                PMMapeaTextoGrid(Grid1)
                PMAnchoColumnasGrid(Grid1)
                PMChequea(sqlconn)
                VTFlag = True
                VTRegistros = Conversion.Val(Convert.ToString(Grid1.Tag))
                Grid1.Row = Grid1.Rows - 1
                Grid1.Col = 8
                VTSecuencial = Grid1.CtlText
                Grid1.Col = 1
                VTCodigoTrn = Grid1.CtlText
            Else
                PMChequea(sqlconn)
                VTRegistros = 0
            End If
        End While
    End Sub

    Private Sub Grid1_ClickEvent(sender As Object, e As EventArgs) Handles Grid1.ClickEvent
        Grid1.Col = 0
        Grid1.SelStartCol = 1
        Grid1.SelEndCol = Grid1.Cols - 1
        If Grid1.Row = 0 Then
            Grid1.SelStartRow = 1
            Grid1.SelEndRow = 1
        Else
            Grid1.SelStartRow = Grid1.Row
            Grid1.SelEndRow = Grid1.Row
        End If
        PMMarcaFilaCobisGrid(Grid1, Grid1.Row)
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509067)) 'Registros de Parametrización Contable
    End Sub

    Private Sub Grid1_DoubleClick(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles Grid1.DblClick
        Dim VT As String = ""
        Dim Indice As Integer = 0
        txtCampo(0).Enabled = False
        If Grid1.Rows <= 2 Then
            Grid1.Row = 1
            Grid1.Col = 1
            If Grid1.CtlText.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(501027), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'No existen transacciones para procesar
                Exit Sub
            End If
        End If
        PMMarcaFilaCobisGrid(Grid1, Grid1.Row)
        VLTabla = ""
        txtCampo(2).Enabled = False
        For i As Integer = 1 To VLMatrizTrans.GetUpperBound(1)
            If txtCampo(1).Text = VLMatrizTrans(0, i) Then
                VLTabla = VLMatrizTrans(1, i)
                txtCampo(2).Enabled = True
                Exit For
            End If
        Next i
        Grid1.Col = 2
        txtCampo(3).Text = Grid1.CtlText.Trim()
        If txtCampo(3).Text = "C" Then
            lblDescripcion(3).Text = FMLoadResString(500638) 'Crédito
        Else
            lblDescripcion(3).Text = FMLoadResString(500639) 'Débito
        End If
        Grid1.Col = 3
        If Grid1.CtlText.Trim() <> "0" Then
            txtCampo(2).Text = Grid1.CtlText.Trim().Trim()
            If VLTabla <> "" And txtCampo(2).Text <> "" Then
                Dim dbNumericTemp As Double = 0
                If Not Double.TryParse(Grid1.CtlText.Trim(), NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                    txtCampo(2).Text = Grid1.CtlText.Trim()
                    PMCatalogo("V", VLTabla, txtCampo(2), lblDescripcion(2))
                Else
                    If txtCampo(1).Text = "48" Or txtCampo(1).Text = "50" Or txtCampo(1).Text = "264" Or txtCampo(1).Text = "253" Then
                        causa_sus = CInt(txtCampo(2).Text)
                        causa = txtCampo(2).Text
                        If causa_sus > 500 Then
                            causa_sus -= 500
                        End If
                    Else
                        causa = txtCampo(2).Text
                        causa_sus = CInt(txtCampo(2).Text)
                    End If
                    txtCampo(2).Text = CStr(causa_sus)
                    PMCatalogo("V", VLTabla, txtCampo(2), lblDescripcion(2))
                    txtCampo(2).Text = causa
                    If CInt(txtCampo(2).Text) > 500 Then
                        lblDescripcion(2).Text = FMLoadResString(502654) & " " & lblDescripcion(2).Text 'VALOR EN SUSPENSO POR
                    End If
                End If
            Else
                txtCampo(2).Text = ""
                lblDescripcion(2).Text = ""
            End If
        Else
            txtCampo(2).Text = Grid1.CtlText.Trim()
            lblDescripcion(2).Text = ""
        End If
        Grid1.Col = 3
        txtCampo(2).Text = Grid1.CtlText
        If txtCampo(2).Text <> "0" And txtCampo(2).Text.Trim() <> "" Then
            txtCampo_Leave(txtCampo(2), New EventArgs())
        End If
        Grid1.Col = 4
        If Grid1.CtlText.Trim() <> "0" Then
            txtCampo(5).Text = Grid1.CtlText.Trim()
            PMCatalogo("V", "cc_tipo_indicador", txtCampo(5), lblDescripcion(5))
        Else
            txtCampo(5).Text = ""
            lblDescripcion(5).Text = ""
        End If
        CmbContab(0).SelectedIndex = -1
        CmbContab(1).SelectedIndex = -1
        CmbContab(2).SelectedIndex = -1
        Grid1.Col = 5
        If Grid1.CtlText <> "" Then
            VT = "N"
            For i As Integer = 0 To CmbContab(0).Items.Count - 1
                CmbContab(0).SelectedIndex = i
                If Grid1.CtlText.Trim() = CmbContab(0).Text Then
                    Indice = i
                    VT = "S"
                    i = CmbContab(0).Items.Count + 1
                End If
            Next i
            If VT = "S" Then
                CmbContab(0).SelectedIndex = Indice
            Else
                CmbContab(0).SelectedIndex = -1
            End If
        End If
        Grid1.Col = 10
        If Grid1.CtlText <> "" Then
            VT = "N"
            For i As Integer = 0 To CmbContab(1).Items.Count - 1
                CmbContab(1).SelectedIndex = i
                If Grid1.CtlText.Trim() = CmbContab(1).Text Then
                    Indice = i
                    VT = "S"
                    i = CmbContab(1).Items.Count + 1
                End If
            Next i
            If VT = "S" Then
                CmbContab(1).SelectedIndex = Indice
            Else
                CmbContab(1).SelectedIndex = -1
            End If
        End If
        Grid1.Col = 11
        If Grid1.CtlText <> "" Then
            VT = "N"
            For i As Integer = 0 To CmbContab(2).Items.Count - 1
                CmbContab(2).SelectedIndex = i
                If Grid1.CtlText.Trim() = CmbContab(2).Text Then
                    Indice = i
                    VT = "S"
                    i = CmbContab(2).Items.Count + 1
                End If
            Next i
            If VT = "S" Then
                CmbContab(2).SelectedIndex = Indice
            Else
                CmbContab(2).SelectedIndex = -1
            End If
        End If
        Grid1.Col = 8
        VLSecuencial = Grid1.CtlText
        Grid1.Col = 9
        If Grid1.CtlText.Trim() <> "" Then
            txtCampo(6).Text = Grid1.CtlText.Trim()
            PMCatalogo("V", "re_campo_totaliza", txtCampo(6), lblDescripcion(6))
        End If
        Grid1.Col = 12
        If Grid1.CtlText.Trim() <> "" Then
            txtCampo(4).Text = Grid1.CtlText.Trim()
            PMCatalogo("V", "re_concepto_contable", txtCampo(4), lblDescripcion(4))
        End If
        Grid1.Col = 13
        If Grid1.CtlText.Trim() <> "" Then
            txtCampo(7).Text = Grid1.CtlText.Trim()
            PMCatalogo("V", "cb_tipo_impuesto", txtCampo(7), lblDescripcion(7))
        End If
        cmdBoton(4).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(5).Enabled = True
        PLTSEstado()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509067)) 'Registros de Parametrización Contable
    End Sub

    Private Sub PLParametro()
        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "F")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, "TGMFBA")
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2628)) Then 'Ok.. Consulta de Nivel Máximo de Autorización
            PMMapeaVariable(sqlconn, VLParametro)
            PMChequea(sqlconn)
        Else
            PMChequea(sqlconn)
        End If
    End Sub

    Private Sub PLEliminar()
        If VLSecuencial <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "709")
            PMPasoValores(sqlconn, "@i_oper", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_sec", 0, SQLINT4, VLSecuencial)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_rem_parctocble", True, FMLoadResString(502655)) Then 'OK Eliminación de Transacción a Contabilizar
                PMChequea(sqlconn)
                PLBuscar()
                cmdBoton(4).Enabled = False
                cmdBoton(5).Enabled = False
            Else
                PMChequea(sqlconn)
            End If
        Else
            COBISMessageBox.Show(FMLoadResString(502250), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error) 'Transacción a eliminarse no seleccionada
        End If
        PLTSEstado()
    End Sub

    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_0.Enabled
        TSBBuscar.Visible = _cmdBoton_0.Visible
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible
        TSBCrear.Enabled = _cmdBoton_3.Enabled
        TSBCrear.Visible = _cmdBoton_3.Visible
        TSBActualizar.Enabled = _cmdBoton_4.Enabled
        TSBActualizar.Visible = _cmdBoton_4.Visible
        TSBEliminar.Enabled = _cmdBoton_5.Enabled
        TSBEliminar.Visible = _cmdBoton_5.Visible
    End Sub

    Private Sub TSBBuscar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub TSBLimpiar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub TSBSalir_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub TSBCrear_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBCrear.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub

    Private Sub TSBActualizar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBActualizar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub TSBEliminar_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBEliminar.Click
        If _cmdBoton_5.Enabled Then cmdBoton_Click(_cmdBoton_5, e)
    End Sub

    Private Sub Grid1_Enter(sender As Object, e As EventArgs) Handles Grid1.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509067)) 'Registros de Parametrización Contable
    End Sub

End Class


