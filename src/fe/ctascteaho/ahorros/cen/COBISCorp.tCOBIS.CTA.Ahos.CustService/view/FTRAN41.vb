Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI

Public Class FTRAN41Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView

    'Variables
    Dim VLEfectivo As Double
    Dim VLChequesL As Double
    Dim VLChequesP As Double
    Dim VLChequesR As Double
    Dim VLTotal As Double
    Dim VLSSN As Integer
    Dim VLSSNB As Integer
    Dim VLOrigenEfec As String
    'Constantes
    Const CLMaxLength As Short = 18
    Const CLFormatoValor As String = "#,##0.00"
    Const CLMaxValor As Double = 999999999999.99
    Private Sub FTRAN41Class_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        ReDim VGArreglo(100, 30)
        VLTotalL = 0
    End Sub
    Private Sub TSBotones_ItemClicked(sender As Object, e As Windows.Forms.ToolStripItemClickedEventArgs) Handles TSBotones.ItemClicked

        Select Case e.ClickedItem.Name
            Case "TSBTransmitir"
                If Me.FLTransmitir Then
                    COBISMessageBox.Show(FMLoadResString(509507) & " " & VLSSN, FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Me.PLIniciarForm()
                End If
            Case "TSBLimpiar"
                Me.PLIniciarForm()
            Case "TSBSalir"
                ReDim VGArreglo(100, 30)
                VLTotalL = 0
                Me.Close()
                Me.Dispose()
        End Select

    End Sub

#Region "Controls"
    Private Sub mskCuenta_MaskInputRejected(sender As Object, e As Windows.Forms.MaskInputRejectedEventArgs) Handles mskCuenta.MaskInputRejected
        '
    End Sub
    Private Sub mskCuenta_GotFocus(sender As Object, e As EventArgs) Handles mskCuenta.GotFocus
        mskCuenta.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500659))
    End Sub
    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave

        txtNombre.Text = ""

        If Not String.IsNullOrEmpty(mskCuenta.ClipText.Trim) Then
            If Not Me.FLConsultarCuenta() Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                mskCuenta.Focus()
            End If
        End If

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub txtNombre_TextChanged(sender As Object, e As EventArgs) Handles txtNombre.TextChanged
        '
    End Sub
    Private Sub txtNombre_GotFocus(sender As Object, e As EventArgs) Handles txtNombre.GotFocus
        txtNombre.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub txtMonCodigo_TextChanged(sender As Object, e As EventArgs) Handles txtMonCodigo.TextChanged
        '
    End Sub
    Private Sub txtMonCodigo_GotFocus(sender As Object, e As EventArgs) Handles txtMonCodigo.GotFocus
        txtMonCodigo.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub txtMonDescripcion_TextChanged(sender As Object, e As EventArgs) Handles txtMonDescripcion.TextChanged
        '
    End Sub
    Private Sub txtMonDescripcion_GotFocus(sender As Object, e As EventArgs) Handles txtMonDescripcion.GotFocus
        txtMonDescripcion.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
    Private Sub mskEfectivo_Change(sender As Object, e As EventArgs) Handles mskEfectivo.Change
        '
    End Sub
    Private Sub mskEfectivo_GotFocus(sender As Object, e As EventArgs) Handles mskEfectivo.GotFocus
        mskEfectivo.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500197)) 'Valor del Depósito en Efectivo
    End Sub
    Private Sub mskEfectivo_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskEfectivo.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskEfectivo.Text.IndexOf(".")
                If VTPos > -1 Then mskEfectivo.SelectionStart = VTPos + 1
        End Select
    End Sub
    Private Sub mskEfectivo_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskEfectivo.KeyPress
        If mskEfectivo.SelectionLength <> mskEfectivo.TextLength Then
            If mskEfectivo.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskEfectivo.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskEfectivo.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskEfectivo_Leave(sender As Object, e As EventArgs) Handles mskEfectivo.Leave
        Me.PLSumar()
        If chkOrigenRemesa.Checked Then
            If VLChequesL + VLChequesP + VLChequesR > 0 Then
                COBISMessageBox.Show(FMLoadResString(509552), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                chkOrigenRemesa.Checked = False
                Exit Sub
            End If
        End If
    End Sub

    Private Sub mskCheLocales_GotFocus(sender As Object, e As EventArgs) Handles mskCheLocales.GotFocus
        'mskCheLocales.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501307)) 'Valor del Depósito en cheques locales 
    End Sub
    Private Sub mskCheLocales_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskCheLocales.KeyDown
        Dim Keycode As Integer = e.KeyCode
        If Keycode = VGTeclaAyuda Then
            FTRANDetalleCheque.VLTipo = "1"
            FTRANDetalleCheque.ShowPopup(Me)
            mskCheLocales.Text = VLTotalL
            VLPaso = True
            FTRANDetalleCheque.Dispose()
        Else
            mskCheLocales.Text = VLTotalL
            'COBISMessageBox.Show(FMLoadResString(501307), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
        End If
    End Sub
    Private Sub mskCheLocales_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles mskCheLocales.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If Char.IsDigit(EventArgs.KeyChar) AndAlso Not Char.IsControl(EventArgs.KeyChar) Then
            KeyAscii = 0 'EventArgs.Handled = True
        End If
        If (KeyAscii = 8) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
        COBISMessageBox.Show(FMLoadResString(501307), FMLoadResString(500085), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
    End Sub
    Private Sub mskCheLocales_Leave(sender As Object, e As EventArgs) Handles mskCheLocales.Leave
        Me.PLSumar()
        If chkOrigenRemesa.Checked Then
            If VLChequesL + VLChequesP + VLChequesR > 0 Then
                COBISMessageBox.Show(FMLoadResString(509552), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                chkOrigenRemesa.Checked = False
                Exit Sub
            End If
        End If
    End Sub
    Private Sub mskChePropios_Change(sender As Object, e As EventArgs) Handles mskChePropios.Change
        '
    End Sub
    Private Sub mskChePropios_GotFocus(sender As Object, e As EventArgs) Handles mskChePropios.GotFocus
        mskChePropios.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501352)) 'Valor del Cheques propios
    End Sub
    Private Sub mskChePropios_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskChePropios.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskChePropios.Text.IndexOf(".")
                If VTPos > -1 Then mskChePropios.SelectionStart = VTPos + 1
            Case 116
                FTRANDetalleCheque.VLTipo = "3"
                FTRANDetalleCheque.ShowPopup(Me)
        End Select
    End Sub
    Private Sub mskChePropios_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskChePropios.KeyPress
        If mskChePropios.SelectionLength <> mskChePropios.TextLength Then
            If mskChePropios.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskChePropios.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskChePropios.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskChePropios_Leave(sender As Object, e As EventArgs) Handles mskChePropios.Leave
        Me.PLSumar()
    End Sub
    Private Sub mskCheRemesas_Change(sender As Object, e As EventArgs) Handles mskCheRemesas.Change
        '
    End Sub
    Private Sub mskCheRemesas_GotFocus(sender As Object, e As EventArgs) Handles mskCheRemesas.GotFocus
        mskCheRemesas.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501308)) 'Valor del Depósito en cheques de remesas
    End Sub
    Private Sub mskCheRemesas_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskCheRemesas.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskCheRemesas.Text.IndexOf(".")
                If VTPos > -1 Then mskCheRemesas.SelectionStart = VTPos + 1
            Case 116
                FTRANDetalleCheque.VLTipo = "2"
                FTRANDetalleCheque.ShowPopup(Me)
        End Select
    End Sub
    Private Sub mskCheRemesas_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskCheRemesas.KeyPress
        If mskCheRemesas.SelectionLength <> mskCheRemesas.TextLength Then
            If mskCheRemesas.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskCheRemesas.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskCheRemesas.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskCheRemesas_Leave(sender As Object, e As EventArgs) Handles mskCheRemesas.Leave
        Me.PLSumar()
    End Sub
    Private Sub txtTotal_TextChanged(sender As Object, e As EventArgs) Handles txtTotal.TextChanged
        '
    End Sub
    Private Sub txtTotal_GotFocus(sender As Object, e As EventArgs) Handles txtTotal.GotFocus
        txtTotal.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub
#End Region

#Region "Functions"
    Private Function FLTransmitir() As Boolean

        VLOrigenEfec = ""
        If chkOrigenRemesa.Checked Then
            If _optOrigen_0.Checked Then VLOrigenEfec = "L" 'Origen de la remesa Local
            If _optOrigen_1.Checked Then VLOrigenEfec = "E" 'Origen de la remesa Exterior
        End If

        If Not FLValidarCampos() Then Return False

        Me.PLSumar()

        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "252")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VLEfectivo)
            PMPasoValores(sqlconn, "@i_loc", 0, SQLMONEY, VLChequesL)
            PMPasoValores(sqlconn, "@i_prop", 0, SQLMONEY, VLChequesP)
            PMPasoValores(sqlconn, "@i_plaz", 0, SQLMONEY, VLChequesR)
            PMPasoValores(sqlconn, "@i_total", 0, SQLMONEY, VLTotal)
            PMPasoValores(sqlconn, "@i_ActTot", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_canal", 0, SQLINT1, 0)
            PMPasoValores(sqlconn, "@i_remesas", 0, SQLCHAR, VLOrigenEfec)
            PMPasoValores(sqlconn, "@o_ssn", 1, SQLINT4, "0000000000")
            PMPasoValores(sqlconn, "@o_ssn_branch", 1, SQLINT4, "0000000000")

            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_depositosl", True, FMLoadResString(509507)) Then
                PMChequea(sqlconn)
                VLSSN = FMRetParam(sqlconn, 1)
                VLSSNB = FMRetParam(sqlconn, 2)
                For j As Integer = 1 To UBound(VGArreglo)
                    If VGArreglo(j, 1) <> Nothing Then
                        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT4, "639")
                        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "O")
                        PMPasoValores(sqlconn, "@i_ssn_dep", 0, SQLCHAR, VLSSN)
                        PMPasoValores(sqlconn, "@i_ssn_branch_dep", 0, SQLCHAR, VLSSNB)
                        PMPasoValores(sqlconn, "@i_filial", 0, SQLINT4, VGFilial)
                        PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
                        PMPasoValores(sqlconn, "@i_producto", 0, SQLINT4, "4")
                        PMPasoValores(sqlconn, "@i_sec", 0, SQLINT2, VGArreglo(j, 10))
                        PMPasoValores(sqlconn, "@i_tipo", 0, SQLVARCHAR, VGArreglo(j, 9))
                        PMPasoValores(sqlconn, "@i_co_banco", 0, SQLINT2, VGArreglo(j, 1))
                        PMPasoValores(sqlconn, "@i_no_banco", 0, SQLVARCHAR, VGArreglo(j, 2))
                        PMPasoValores(sqlconn, "@i_cta_cheque", 0, SQLVARCHAR, VGArreglo(j, 3))
                        PMPasoValores(sqlconn, "@i_num_cheque", 0, SQLINT4, VGArreglo(j, 4))
                        PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, VGArreglo(j, 5))
                        PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGArreglo(j, 7))
                        PMPasoValores(sqlconn, "@i_fechaemision", 0, SQLDATETIME, FMConvFecha(VGArreglo(j, 6), VGFormatoFecha, "mm/dd/yyyy"))
                        PMPasoValores(sqlconn, "@i_estado", 0, SQLVARCHAR, "I")
                        If VGHabilita = "S" Then
                            PMPasoValores(sqlconn, "@i_tipo_chq", 0, SQLVARCHAR, VGArreglo(j, 3))
                            PMPasoValores(sqlconn, "@i_cotizacion", 0, SQLFLT8, VGArreglo(j, 14))
                            PMPasoValores(sqlconn, "@i_valor_convertido", 0, SQLMONEY, VGArreglo(j, 13))
                        End If

                        If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_detallecheque", True, FMLoadResString(509507)) Then
                            PMChequea(sqlconn)
                        Else
                            PMChequea(sqlconn)
                            Exit For
                        End If
                    Else
                        Exit For
                    End If
                Next j
                ReDim VGArreglo(100, 30)
                VLTotalL = 0
                Return True
            Else
                PMChequea(sqlconn)
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    ''' <summary>
    ''' Consulta el nombre de la cuenta
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarCuenta() As Boolean

        Try
            If FMChequeaCtaAho(mskCuenta.ClipText.Trim) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, FMLoadResString(2330) & mskCuenta.Text & "]") Then
                    Dim VTArreglo(10) As String
                    Dim VTR1 As Integer = FMMapeaArreglo(sqlconn, VTArreglo)
                    txtNombre.Text = VTArreglo(1)
                    PMChequea(sqlconn)
                    Return True
                Else
                    PMChequea(sqlconn)
                End If
            Else
                COBISMessageBox.Show(FMLoadResString(500021), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return False

    End Function
    ''' <summary>
    ''' Consulta el valor de un parámetro
    ''' </summary>
    ''' <param name="pProducto">Producto del parámetro</param>
    ''' <param name="pNemonico">Nemónico del parámetro</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarParametro(ByVal pProducto As String, ByVal pNemonico As String) As String

        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
            PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, pNemonico)
            PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, pProducto)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2554)) Then
                Dim VLParametro(15, 2) As String
                Dim VTR1 As Integer = FMMapeaMatriz(sqlconn, VLParametro)
                PMChequea(sqlconn)
                Return VLParametro(3, 1)
            Else
                PMChequea(sqlconn)
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return ""

    End Function
    ''' <summary>
    ''' Valida el ingreso de los campos requeridos
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLValidarCampos() As Boolean

        If String.IsNullOrEmpty(mskCuenta.ClipText.Trim) Then 'INGRESE NUMERO DE CUENTA
            COBISMessageBox.Show(FMLoadResString(508603), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskCuenta.Focus()
            Return False
        Else
            If Not Me.FLConsultarCuenta() Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                txtNombre.Text = ""
                mskCuenta.Focus()
                Return False
            End If
        End If

        If IsNumeric(mskEfectivo.Text) AndAlso CDbl(mskEfectivo.Text) > CLMaxValor Then
            COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            'mskEfectivo.Text = "0.00"
            mskEfectivo.Focus()
            Return False
        End If

        If IsNumeric(mskCheLocales.Text) AndAlso CDbl(mskCheLocales.Text) > CLMaxValor Then
            COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            'mskCheLocales.Text = "0.00"
            mskCheLocales.Focus()
            Return False
        End If

        If IsNumeric(mskChePropios.Text) AndAlso CDbl(mskChePropios.Text) > CLMaxValor Then
            COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            'mskChePropios.Text = "0.00"
            mskChePropios.Focus()
            Return False
        End If

        If IsNumeric(mskCheRemesas.Text) AndAlso CDbl(mskCheRemesas.Text) > CLMaxValor Then
            COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            'mskCheRemesas.Text = "0.00"
            mskCheRemesas.Focus()
            Return False
        End If

        Me.PLSumar()

        If VLTotal <= 0 Then 'El valor total del depósito debe ser mayor a cero
            COBISMessageBox.Show(FMLoadResString(509508), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskEfectivo.Focus()
            Return False
        End If

        'El origen de la remesa solo es valido para depositos en efectivo
        If VLChequesL + VLChequesP + VLChequesR > 0 And (VLOrigenEfec <> "" Or chkOrigenRemesa.Checked) Then
            COBISMessageBox.Show(FMLoadResString(509552), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        If chkOrigenRemesa.Checked And VLOrigenEfec = "" Then
            COBISMessageBox.Show(FMLoadResString(509554), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return False
        End If

        Return True

    End Function
    ''' <summary>
    ''' Devuelve la descripción de la moneda
    ''' </summary>
    ''' <param name="pCodigo">Código de moneda</param>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLBuscarMoneda(ByVal pCodigo As String) As String

        Try
            Dim VTMoneda As String = ""

            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "cl_moneda")
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, pCodigo)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(508804)) Then
                PMMapeaVariable(sqlconn, VTMoneda)
                PMChequea(sqlconn)
                Return VTMoneda
            Else
                PMChequea(sqlconn)
            End If

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return ""

    End Function
#End Region

#Region "Procedures"
    Public Sub PLInicializar()
        Dim VTFlag As Short

        Me.Left = 0
        Me.Top = 0

        'If Me.GetPageArgumentsByName("DepositoInicial") = "S" Then
        '    VLDepInicial = True        
        'Else
        '    VLDepInicial = False
        'End If

        mskCuenta.Mask = VGMascaraCtaAho

        txtMonCodigo.Text = VGMoneda
        txtMonDescripcion.Text = FLBuscarMoneda(VGMoneda)

        mskEfectivo.MaxReal = CLMaxValor
        mskCheLocales.MaxReal = CLMaxValor
        mskChePropios.MaxReal = CLMaxValor
        mskCheRemesas.MaxReal = CLMaxValor

        If FLConsultarParametro("AHO", "VCHPRO") = "S" Then
            VTFlag += 1
            lblChePropios.Visible = True
            mskChePropios.Visible = True
        End If

        If FLConsultarParametro("AHO", "VCHREM") = "S" Then
            VTFlag += 1
            lblCheRemesas.Visible = True
            mskCheRemesas.Visible = True
        End If

        Select Case VTFlag
            Case 0
                Me.Height = 215
                lblTotal.Top = lblChePropios.Top
                txtTotal.Top = mskChePropios.Top
            Case 1
                Me.Height = 240
                lblTotal.Top = lblCheRemesas.Top
                txtTotal.Top = mskCheRemesas.Top
                lblCheRemesas.Top = lblChePropios.Top
                mskCheRemesas.Top = mskChePropios.Top
        End Select
    End Sub
    
    Private Sub PLSumar()
        VLEfectivo = 0
        VLChequesL = 0
        VLChequesP = 0
        VLChequesR = 0
        VLTotal = 0

        If IsNumeric(mskEfectivo.Text.Trim) Then VLEfectivo = CDbl(mskEfectivo.Text.Trim)
        If IsNumeric(mskCheLocales.Text.Trim) Then VLChequesL = CDbl(mskCheLocales.Text.Trim)
        If IsNumeric(mskChePropios.Text.Trim) Then VLChequesP = CDbl(mskChePropios.Text.Trim)
        If IsNumeric(mskCheRemesas.Text.Trim) Then VLChequesR = CDbl(mskCheRemesas.Text.Trim)

        VLTotal = VLEfectivo + VLChequesL + VLChequesP + VLChequesR
        txtTotal.Text = VLTotal.ToString(CLFormatoValor)
    End Sub
#End Region

#Region "Inicializar"
    Private Sub PLLimpiar()
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        txtNombre.Text = ""
        mskEfectivo.Text = "0.00"
        mskCheLocales.Text = "0.00"
        mskChePropios.Text = "0.00"
        mskCheRemesas.Text = "0.00"
        txtTotal.Text = "0.00"
        chkOrigenRemesa.Checked = False
    End Sub
    Private Sub PLIniciarForm()
        Me.PLIniciarVar()
        Me.PLLimpiar()
        ReDim VGArreglo(100, 30)
        VLTotalL = 0
        mskCuenta.Focus()
        mskCuenta.SelectAll()
    End Sub
    Private Sub PLIniciarVar()
        VLEfectivo = 0
        VLChequesL = 0
        VLChequesP = 0
        VLChequesR = 0
        VLTotal = 0
        VLSSN = 0
    End Sub
#End Region

    Private Sub _optOrigen_0_GotFocus(sender As Object, e As EventArgs) Handles _optOrigen_0.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509553))
    End Sub

    Private Sub _optOrigen_1_GotFocus(sender As Object, e As EventArgs) Handles _optOrigen_1.GotFocus
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509553))
    End Sub

    Private Sub chkOrigenRemesa_CheckedChanged(sender As Object, e As EventArgs) Handles chkOrigenRemesa.CheckedChanged
        If chkOrigenRemesa.Checked Then
            Me.PLSumar()
            If VLChequesL + VLChequesP + VLChequesR > 0 Then
                COBISMessageBox.Show(FMLoadResString(509552), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                chkOrigenRemesa.Checked = False
                Exit Sub
            End If
            frmOrigenEfectivo.Enabled = True
        Else
            _optOrigen_0.Checked = False
            _optOrigen_1.Checked = False
            frmOrigenEfectivo.Enabled = False
        End If
    End Sub

    Private Sub chkOrigenRemesa_Enter(sender As Object, e As EventArgs) Handles chkOrigenRemesa.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509553))
    End Sub
End Class