Imports Artinsoft.VB6.Utils
Imports System.Windows.Forms.DataGridView
Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI

Public Class FTRANDetalleChequeClass
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    'Variables
    Public dtDetalle As DataTable
    Dim drDetalle As DataRow()
    Dim VLEfectivo As Double
    Dim VLChequesL As Double
    Dim VLChequesP As Double
    Dim VLChequesR As Double
    Dim VLTotalConv As Double
    Dim VLValor As String
    Dim VLSSN As Integer
    Dim VLNumCheque As Integer
    Dim VLFormatoFecha As String = ""
    Dim VLAccion As String = "I"
    Dim VLCoBanco As String
    Dim VLBanco As String
    Dim VLNumCuenta As String
    Dim VLTipoChq As String
    Dim VLFechaEmision As String
    Dim VLUlt As Short
    Dim VLSec As Short = 0
    Dim VLCodBanco As Short
    Dim VLDiasChq As Short
    Dim VLMaxCh As Short
    Dim VTExiste As Boolean = False
    Dim VLPasoCompraVenta As Boolean = True
    Dim VTValor(100) As Double
    'Constantes
    Const CLMaxLength As Short = 18
    Const CLFormatoValor As String = "#,##0.00"
    Const CLMaxValor As Double = 999999999999.99
    Public VLCot_usd As String
    Public VLFactor As String
    Public VLValConvertido As String
    Public VLCotizacion As String
    Public VLTipo As String



    Private Sub FTRANDetalleChequeClass_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub
    Private Sub TSBotones_ItemClicked(sender As Object, e As Windows.Forms.ToolStripItemClickedEventArgs) Handles TSBotones.ItemClicked
        TSBotones.Focus()
        Select Case e.ClickedItem.Name
            Case "TSBAceptar"
                PLAceptar()
            Case "TSBAgregar"
                PLAgregar()
            Case "TSBEliminar"
                PLEliminar()
        End Select

    End Sub

#Region "Controls"

    Private Sub mskValor_GotFocus(sender As Object, e As EventArgs) Handles mskValor.GotFocus
        mskValor.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5266)) 'Valor del Depósito en cheques locales 
    End Sub
    Private Sub mskValor_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskValor.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskValor.Text.IndexOf(".")
                If VTPos > -1 Then mskValor.SelectionStart = VTPos + 1
        End Select
    End Sub
    Private Sub mskValor_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskValor.KeyPress
        If mskValor.SelectionLength <> mskValor.TextLength Then
            If mskValor.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskValor.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskValor.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskValor_Leave(sender As Object, e As EventArgs) Handles mskValor.Leave
        'Me.PLSumar()
    End Sub

    Private Sub mskValorConvertido_GotFocus(sender As Object, e As EventArgs) Handles mskValorConvertido.GotFocus
        mskValor.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5267)) 'Valor del Depósito en cheques locales 
    End Sub
    Private Sub mskValorConvertido_KeyDown(sender As Object, e As Windows.Forms.KeyEventArgs) Handles mskValorConvertido.KeyDown
        Select Case e.KeyCode
            Case 110, 190
                Dim VTPos As Short = mskValor.Text.IndexOf(".")
                If VTPos > -1 Then mskValor.SelectionStart = VTPos + 1
        End Select
    End Sub
    Private Sub mskValorConvertido_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles mskValorConvertido.KeyPress
        If mskValor.SelectionLength <> mskValor.TextLength Then
            If mskValor.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = mskValor.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (mskValor.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
    End Sub
    Private Sub mskValorConvertido_Leave(sender As Object, e As EventArgs) Handles mskValorConvertido.Leave
        'Me.PLSumar()
    End Sub

#End Region

#Region "Functions"
    ''' <summary>
    ''' Valida el ingreso de los campos requeridos
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLValidarCampos() As Boolean

        'Valida Tipo de cheque (solo en cheques del exterior)
        If VLTipo = "2" Then
            If lblNoTipo.Text.Trim() = "" Then
                COBISMessageBox.Show(FMLoadResString(500281), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                txtCoTipo.Focus()
                Return False
            End If
        End If

        Dim drDetalleTmp As DataRow()
        Dim VTExiste As Boolean = False
        'Valida banco
        Select Case VLTipo
            Case "3" 'CLChePropio
                If lblNoBanco.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502104), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCoBanco.Focus()
                    Return False
                End If
                If mskCuenta.ClipText.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Focus()
                    Return False
                Else
                    If Not Me.FLConsultarCuenta() Then
                        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
                        lblNoCuenta.Text = ""
                        mskCuenta.Focus()
                        Return False
                    End If
                End If
                drDetalleTmp = dtDetalle.Select("CodBanco=" + txtCoBanco.Text.Trim() + " and Cuenta=" + mskCuenta.ClipText.Trim() + " and NumeroCheque=" + txtNumCheque.Text.Trim() + " and Secuencial <> " + VLSec.ToString())
                If (drDetalleTmp.GetLength(0) > 0) Then VTExiste = True
                If (VTExiste) Then
                    COBISMessageBox.Show(FMLoadResString(5271), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNumCheque.Focus()
                    Return False
                End If
            Case "1" 'CLCheLocal
                If lblNoBanco.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502104), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtCoBanco.Focus()
                    Return False
                Else
                    If txtCoBanco.Text = VLCodBanco.ToString() Then
                        COBISMessageBox.Show(FMLoadResString(5289), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCoBanco.Focus()
                        Return False
                    End If
                End If
                If txtNumCuenta.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(500332), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNumCuenta.Focus()
                    Return False
                End If
                If txtNumCheque.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(501543), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNumCheque.Focus()
                    Return False
                Else
                    'Valida que no se haya registrado el número de cheque

                    drDetalleTmp = dtDetalle.Select("Cod.Banco=" + txtCoBanco.Text.Trim() + " and Cuenta=" + txtNumCuenta.Text.Trim() + " and Num.Cheque=" + txtNumCheque.Text.Trim() + " and Secuencial <> " + VLSec.ToString())
                    If (drDetalleTmp.GetLength(0) > 0) Then VTExiste = True
                    If (VTExiste) Then
                        COBISMessageBox.Show(FMLoadResString(5271), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtNumCheque.Text = ""
                        txtNumCheque.Focus()
                        Return False
                    End If
                End If
            Case "2"  'CLCheExterior
                If txtBanco.Text.Trim() = "" Then
                    COBISMessageBox.Show(FMLoadResString(502104), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtBanco.Focus()
                    Return False
                End If
                For i As Integer = 1 To grdDetalle.MaxCols - 1                              
                    '         if (grdDetalle("Banco"       , i).Value.ToString() = txtBanco.Text.Trim()     and
                    '             grdDetalle("Cuenta"      , i).Value.ToString() = txtNumCuenta.Text.Trim() and
                    '             grdDetalle("NumeroCheque", i).Value.ToString() = txtNumCheque.Text.Trim() and
                    '             grdDetalle("Secuencial"  , i).Value.ToString() != VLSec.ToString())

                    '    VTExiste = True
                    'End If
                        Next i
                If (VTExiste) Then
                    COBISMessageBox.Show(FMLoadResString(5271), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    txtNumCheque.Focus()
                    Return False
                End If
        End Select


        'Valor del cheque
        If mskValor.Text ="0.00" Then
            COBISMessageBox.Show(FMLoadResString(501528), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor.Text = ""
            mskValor.Focus()
            Return False
        End If

        If IsNumeric(mskValor.Text) AndAlso CDbl(mskValor.Text) > CLMaxValor Then
            COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor.Text = ""
            mskValor.Focus()
            Return False
        End If

        'Fecha de emisión del cheque
        If Not IsDate(mskFechaEmi.Text) Then
            COBISMessageBox.Show(FMLoadResString(501373), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFechaEmi.Focus()
            Exit Function
        Else

            Dim VTFechaMin As DateTime
            Dim VTFechaMax As DateTime
            Dim VTFechaHoy As String = VGFechaProceso
            Dim VTInter As String = "d"
            Dim VTDiasChq As Integer = -VLDiasChq
            Dim VTMaxChq As Integer = +VLMaxCh

            VTFechaMin = FMDateAdd(VTFechaHoy, VTInter, VTDiasChq, VGFormatoFecha)

            If (mskFechaEmi.Text < VTFechaMin) Then
                COBISMessageBox.Show(FMLoadResString(5272), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFechaEmi.Text = ""
                mskFechaEmi.Focus()
                Return False
            End If

            VTFechaMax = FMDateAdd(VTFechaHoy, VTInter, VTMaxChq, VGFormatoFecha)
            If (mskFechaEmi.Text > VTFechaMax) Then
                COBISMessageBox.Show(FMLoadResString(5287), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskFechaEmi.Text = ""
                mskFechaEmi.Focus()
                Return False
            End If

        End If

        'Moneda del cheque
        If lblNoMoneda.Text.Trim() = "" Then
            COBISMessageBox.Show(FMLoadResString(509541), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskFechaEmi.Focus()
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

    ''' <summary>
    ''' Consulta el nombre de la cuenta
    ''' </summary>
    ''' <returns></returns>
    ''' <remarks></remarks>
    Private Function FLConsultarCuenta() As Boolean

        Try
            If FMChequeaCtaAho(mskCuenta.ClipText.Trim) Then
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_tr_query_nom_ctacte", True, FMLoadResString(2237) & mskCuenta.Text & "]") Then
                    Dim VTArreglo(10) As String
                    Dim VTR1 As Integer = FMMapeaArreglo(sqlconn, VTArreglo)
                    lblNoCuenta.Text = VTArreglo(1)
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

    Private Function FLCompraVentaDivisas()
        Try
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "26445")
            PMPasoValores(sqlconn, "@i_moneda_origen", 0, SQLINT1, txtCoMoneda.Text)
            PMPasoValores(sqlconn, "@i_valor", 0, SQLMONEY, mskValor.Text)
            PMPasoValores(sqlconn, "@i_moneda_destino", 0, SQLINT1, VGMoneda)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT4, VGOficina)
            PMPasoValores(sqlconn, "@i_modulo", 0, SQLVARCHAR, "AHO")
            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "C")
            PMPasoValores(sqlconn, "@i_transaccion", 0, SQLCHAR, "DEP")

            PMPasoValores(sqlconn, "@o_valor_convertido", 1, SQLMONEY, VLValConvertido)
            PMPasoValores(sqlconn, "@o_cot_usd", 1, SQLFLT8, VLCot_usd)
            PMPasoValores(sqlconn, "@o_factor", 1, SQLMONEY, VLFactor)
            PMPasoValores(sqlconn, "@o_cotizacion", 1, SQLFLT8, VLCotizacion)

            If FMTransmitirRPC(sqlconn, ServerName, "cob_remesas", "sp_op_divisas_cascara", True, FMLoadResString(2344)) Then
                VLValConvertido = FMRetParam(sqlconn, 1).ToString()
                VLCot_usd = FMRetParam(sqlconn, 2).ToString()
                VLFactor = FMRetParam(sqlconn, 3).ToString()
                VLCotizacion = FMRetParam(sqlconn, 4).ToString()
                mskValorConvertido.Text = VLValConvertido
                mskCotizacion.Text = VLCotizacion
                PMChequea(sqlconn)
                Return True

            Else

                PMChequea(sqlconn)
                Return False
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try

        Return ""
    End Function

    Private Function FLLeerParametro(ByVal pProducto As String, pNemonico As String, pTipo As String) As String
        Dim VTDato As String = ""
        Dim VTRDatos(14) As String
        Dim VTR As Integer

        PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1579")
        PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
        PMPasoValores(sqlconn, "@i_nemonico", 0, SQLVARCHAR, pNemonico)
        PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, pProducto)

        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_parametro", True, FMLoadResString(2344)) Then
            VTR = FMMapeaArreglo(sqlconn, VTRDatos)
            PMChequea(sqlconn)
            If (VTR > 0) Then
                Select Case pTipo
                    Case "C"
                        VTDato = VTRDatos(4)
                    Case "S"
                        VTDato = VTRDatos(5)
                        VLCodBanco = VTDato
                    Case "I"
                        VTDato = VTRDatos(7)
                        If VTRDatos(1) = "DVCH" Then
                            VLDiasChq = VTDato
                        Else
                            VLMaxCh = VTDato
                        End If
                End Select
            End If
        Else
            PMChequea(sqlconn)
        End If

        Return VTDato
    End Function

    Private Function FLDescripcionBanco(pCodigo As Short) As String
        Try
            Dim VTValor As String = ""
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "18")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_bco", 0, SQLINT2, pCodigo.ToString())

            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_banco", True, FMLoadResString(3722)) Then
                PMMapeaVariable(sqlconn, VTValor)
                PMChequea(sqlconn)
                Return VTValor
            Else
                PMChequea(sqlconn)
            End If
            Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
        Return ""
    End Function

    Private Function FLValorCatalogo(pTabla As String, pValor As String) As String
        Try
            Dim VTValor As String = ""
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, pTabla)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, pValor)

            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(5282)) Then
                PMMapeaVariable(sqlconn, VTValor)
                PMChequea(sqlconn)
                Return VTValor
            Else
                PMChequea(sqlconn)
            End If
        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return ""
        End Try

    End Function

#End Region

#Region "Procedures"
    Public Sub PLInicializar()
        Dim VTTipo As String
        If Not IsNothing(VGArreglo(1, 1)) Then
            PLCrearTablaDetalle()
            FLTransmitir("C")
            grdDetalle.DataSource = dtDetalle
            Me.grdDetalle.ActiveSheet.Columns.Get(4).HorizontalAlignment = FarPoint.Win.Spread.CellHorizontalAlignment.Right
            grdDetalle.ColWidth(1) = 1200
            grdDetalle.ColWidth(4) = 1200
            grdDetalle.ColWidth(7) = 1200
            grdDetalle.ColWidth(10) = 1200
        Else
            PLCrearTablaDetalle()
            grdDetalle.DataSource = dtDetalle
            grdDetalle.ColWidth(1) = 1200
            grdDetalle.ColWidth(4) = 1200
            grdDetalle.ColWidth(7) = 1200
            grdDetalle.ColWidth(10) = 1200
        End If

        txtCoMoneda.Text = VGMoneda
        lblNoMoneda.Text = FLBuscarMoneda(VGMoneda)

        txtBanco.Width = 311
        txtBanco.Top = txtCoBanco.Top
        txtBanco.Left = txtCoBanco.Left

        txtNumCuenta.Width = txtNumCheque.Width
        txtNumCuenta.Top = mskCuenta.Top
        txtNumCuenta.Left = mskCuenta.Left

        mskValor.MaxReal = CLMaxValor
        mskValorConvertido.MaxReal = CLMaxValor
        mskCotizacion.MaxReal = CLMaxValor
        mskValorConvertido.Text = ""
        mskCotizacion.Text = ""

        mskCuenta.Mask = VGMascaraCtaCte

        FLLeerParametro("CTE", "CBCO", "S")
        FLLeerParametro("CTE", "DVCH", "I")
        FLLeerParametro("CTE", "DFMCH", "I")
        Select Case VLTipo
            Case "1" 'Cheque Local
                FLMoverCampos()
                txtCoTipo.Enabled = False
                lblNoTipo.Enabled = False
                txtBanco.Visible = False
                mskCuenta.Visible = False
                lblNoCuenta.Visible = False
                lblCotizacion.Visible = False
                lblvalorCon.Visible = False
                mskCotizacion.Visible = False
                mskValorConvertido.Visible = False
                txtCoTipo.Visible = False
                lblNoTipo.Visible = False
                Label4.Visible = False
                txtCoBanco.Focus()
            Case "2"  'Cheque Extranjro
                txtCoBanco.Visible = False
                lblNoBanco.Visible = False
                mskCuenta.Visible = False
                lblNoCuenta.Visible = False
            Case "3"  'Cheques Propios
                txtCoTipo.Enabled = False
                lblNoTipo.Enabled = False
                txtCoBanco.Text = VLCodBanco.ToString()
                txtCoBanco.Enabled = False
                lblNoBanco.Text = FLDescripcionBanco(VLCodBanco)
                txtBanco.Visible = False
                txtNumCuenta.Visible = False
        End Select
        VTTipo = FLValorCatalogo("cc_tipos_cheque", VLTipo)
        Me.Text += " - " + VTTipo


        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFechaEmi.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaEmi.DateType = PLFormatoFecha()
        mskFechaEmi.Connection = VGMap
        mskFechaEmi.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        TSBEliminar.Enabled = False

        Select Case VLTipo
            Case "1" 'Cheque Local
                txtCoBanco.Focus()
            Case "2"  'Cheque Extrangero
                txtCoTipo.Focus()
            Case "3"  'Cheques Propios
                mskCuenta.Focus()
        End Select

    End Sub

    Private Sub FLMoverCampos()
        Label3.Top = Label1.Top
        Label3.Left = Label1.Left
        mskValor.Top = txtCoMoneda.Top
        mskValor.Left = txtCoMoneda.Left
        _lblEtiqueta_5.Top = Label1.Top
        mskFechaEmi.Top = lblNoMoneda.Top
        Label1.Top = _lblEtiqueta_6.Top
        Label1.Left = _lblEtiqueta_6.Left
        txtCoMoneda.Top = txtNumCheque.Top
        txtCoMoneda.Left = txtNumCheque.Left
        lblNoMoneda.Top = txtNumCheque.Top

        _lblEtiqueta_6.Top = _lblEtiqueta_0.Top
        _lblEtiqueta_6.Left = _lblEtiqueta_0.Left
        txtNumCheque.Top = txtNumCuenta.Top
        txtNumCheque.Left = txtNumCuenta.Left
        
        _lblEtiqueta_0.Top = Label2.Top
        _lblEtiqueta_0.Left = Label2.Left
        txtNumCuenta.Top = txtCoBanco.Top
        txtNumCuenta.Left = txtCoBanco.Left
        Label2.Top = Label4.Top
        Label2.Left = Label4.Left
        txtCoBanco.Top = txtCoTipo.Top
        txtCoBanco.Left = txtCoTipo.Left
        lblNoBanco.Top = lblNoTipo.Top
        lblNoBanco.Left = lblNoTipo.Left

    End Sub
    Private Sub PLCrearTablaDetalle()
        Select Case VLTipo
            Case "1" 'Cheque Local
                dtDetalle = New DataTable()
                dtDetalle.Columns.Add(UCase("Cod.Banco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Banco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Cuenta"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Num.Cheque"), System.Type.GetType("System.UInt32"))
                dtDetalle.Columns.Add(UCase("Valor"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Fecha"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Cod.Moneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Des.Moneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Tipo"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Secuencial"), System.Type.GetType("System.UInt16"))
            Case "2"  'Cheque Extrangero
                VGHabilita = "S"
                dtDetalle = New DataTable()
                dtDetalle.Columns.Add(UCase("Tipo"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Secuencial"), System.Type.GetType("System.UInt16"))
                dtDetalle.Columns.Add(UCase("CodTipoCheque"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("DesTipoCheque"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("CodBanco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Banco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Cuenta"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("NumeroCheque"), System.Type.GetType("System.UInt32"))
                dtDetalle.Columns.Add(UCase("Valor"), System.Type.GetType("System.Double"))
                dtDetalle.Columns.Add(UCase("Fecha"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("CodMoneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("DesMoneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("ValorConvertido"), System.Type.GetType("System.Double"))
                dtDetalle.Columns.Add(UCase("Cotizacion"), System.Type.GetType("System.Decimal"))
            Case "3"  'Cheques Propios
                dtDetalle = New DataTable()
                dtDetalle.Columns.Add(UCase("CodBanco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Banco"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Cuenta"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("NumeroCheque"), System.Type.GetType("System.UInt32"))
                dtDetalle.Columns.Add(UCase("Valor"), System.Type.GetType("System.Double"))
                dtDetalle.Columns.Add(UCase("Fecha"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("CodMoneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("DesMoneda"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Tipo"), System.Type.GetType("System.String"))
                dtDetalle.Columns.Add(UCase("Secuencial"), System.Type.GetType("System.UInt16"))
        End Select

        
    End Sub

    Private Sub PLSumar()
        VLChequesL = 0
        VLChequesP = 0
        VLChequesR = 0
        VLTotalL = 0

        'VLCantidadChq = grdDetalle.Rows

        Select Case VLTipo

            Case "3" 'CLChePropio
                If (dtDetalle.Rows.Count > 0) Then
                    VLTotalL = dtDetalle.Compute("sum(Valor)", "")
                    If (VLPasoCompraVenta = False) Then VLTotalConv = dtDetalle.Compute("sum(ValorConvertido)", "")
                Else
                    VLTotalL = 0
                    If (VLPasoCompraVenta = False) Then VLTotalConv = 0
                End If
            Case "1" 'CLCheLocal
                If dtDetalle.Rows.Count > 0 Then
                    VLTotalL = CDbl(dtDetalle.Compute("sum(Valor)", ""))
                    If (VLPasoCompraVenta = False) Then VLTotalConv = CDbl(dtDetalle.Compute("sum(ValorConvertido)", ""))
                Else
                    VLTotalL = 0
                    If (VLPasoCompraVenta = False) Then VLTotalConv = 0
                End If
            Case "2"  'CLCheExterior
                If dtDetalle.Rows.Count > 0 Then
                    VLTotalL = dtDetalle.Compute("sum(Valor)", "")
                Else
                    VLTotalL = 0
                End If
        End Select

    End Sub
    Private Sub PLLimpiarCampos()

        txtCoTipo.Text = ""
        lblNoTipo.Text = ""

        If (VLTipo <> "3") Then
            txtCoBanco.Text = ""
            lblNoBanco.Text = ""
        End If

        txtBanco.Text = ""
        mskCuenta.Text = ""
        lblNoCuenta.Text = ""
        txtNumCuenta.Text = ""
        txtNumCheque.Text = ""
        mskValor.Text = "0.00"
        Dim VLFecha As String = String.Empty
        VLFecha = FMDateAdd(VGFechaProceso, "d", 0, VGFormatoFecha)
        VLFormatoFecha = VGFormatoFecha
        mskFechaEmi.Mask = FMMascaraFecha(VLFormatoFecha)
        mskFechaEmi.DateType = PLFormatoFecha()
        mskFechaEmi.Connection = VGMap
        mskFechaEmi.Text = FMConvFecha(VLFecha, VLFormatoFecha, VGFormatoFecha)
        TSBEliminar.Enabled = False
        TSBAgregar.Text = FMLoadResString(500124)
        txtCoMoneda.Text = VGMoneda
        lblNoMoneda.Text = FLBuscarMoneda(VGMoneda)
        mskValorConvertido.Text = "0.00"
        mskCotizacion.Text = "0"
    End Sub

    Private Sub PLAgregar()
        If (FLValidarCampos()) Then
            If (VLAccion = "I") Then
                VLUlt = VLUlt + 1
                VLSec = VLUlt
                If grdDetalle.MaxRows > 0 Then
                    grdDetalle.Row = grdDetalle.MaxRows
                    grdDetalle.Col = 10
                    VLSec = grdDetalle.Text
                    VLSec = VLSec + 1
                End If

            End If
            Select Case VLTipo
                Case "1" 'Cheque Local
                    VLCoBanco = txtCoBanco.Text.Trim()
                    VLBanco = lblNoBanco.Text.Trim()
                    VLNumCuenta = txtNumCuenta.Text.Trim()
                Case "2"  'Cheque Extrangero
                    VLTipoChq = txtCoTipo.Text.Trim()
                    VLBanco = txtBanco.Text.Trim()
                    VLNumCuenta = txtNumCuenta.Text.Trim()
                Case "3"  'Cheques Propios
                    VLCoBanco = txtCoBanco.Text.Trim()
                    VLBanco = lblNoBanco.Text.Trim()
                    VLNumCuenta = mskCuenta.ClipText.Trim()
            End Select
            VLNumCheque = txtNumCheque.Text
            VLValor = mskValor.Text

            Dim VTFormatoFecha As String
            VTFormatoFecha = "mm/dd/yyyy"
            VLFechaEmision = mskFechaEmi.Text
            VLFechaEmision = FMConvFecha(VLFechaEmision, VGFormatoFecha, VTFormatoFecha)

            FLTransmitir(VLAccion)
            VLSec = 0
            VLAccion = "I"
            PLLimpiarCampos()
            Select Case VLTipo
                Case "1" 'Cheque Local
                    txtCoBanco.Focus()
                Case "2"  'Cheque Extrangero
                    txtCoTipo.Focus()
                Case "3"  'Cheques Propios
                    mskCuenta.Focus()
            End Select
        End If
        PMAnchoColumnasGrid(grdDetalle)
        Me.grdDetalle.ActiveSheet.Columns.Get(4).HorizontalAlignment = FarPoint.Win.Spread.CellHorizontalAlignment.Right
        grdDetalle.ColWidth(1) = 1200
        grdDetalle.ColWidth(3) = 1500
        grdDetalle.ColWidth(4) = 1200
        grdDetalle.ColWidth(7) = 1200
        grdDetalle.ColWidth(8) = 1200
        grdDetalle.ColWidth(10) = 1200
    End Sub

    Private Sub PLEliminar()
        Dim Response As String = ""
        Const MB_YESNO As Integer = 4
        Const MB_ICONQUESTION As Integer = 32
        Const MB_DEBUTTON1 As Integer = 0
        Const IDYES As Integer = 6
        Dim DgDef As COBISMsgBox.COBISButtons = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
        If grdDetalle.Text <> "" Then
            Response = CStr(COBISMsgBox.MsgBox(FMLoadResString(5280), DgDef, FMLoadResString(502214)))
            If StringsHelper.ToDoubleSafe(Response) = IDYES Then
                grdDetalle.Col = 10
                drDetalle = dtDetalle.Select("Secuencial=" + VLSec.ToString())
                If (drDetalle.GetLength(0) > 0) Then drDetalle(0).Delete()
                VLSec = 0
                TSBAgregar.Text = FMLoadResString(500124)
                VLAccion = "I"
                PLLimpiarCampos()
                Select Case VLTipo
                    Case "1" 'Cheque Local
                        txtCoBanco.Focus()
                    Case "2"  'Cheque Extrangero
                        txtCoTipo.Focus()
                    Case "3"  'Cheques Propios
                        mskCuenta.Focus()
                End Select
            Else
                PLLimpiarCampos()
            End If

        Else
            COBISMessageBox.Show(FMLoadResString(5281), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End If

    End Sub

    Private Sub PLAceptar()
        VLTotalL = 0
        ReDim VTValor(100)
        For i As Integer = 1 To grdDetalle.MaxRows
            grdDetalle.Row = i
            grdDetalle.Col = 5
            VTValor(i) = grdDetalle.Text
            VLTotalL = VLTotalL + VTValor(i)
        Next i

        'PLSumar()
        If grdDetalle.MaxRows <> 0 Then
            ReDim VGArreglo(100, 30)
            For j As Integer = 1 To grdDetalle.MaxRows
                grdDetalle.Row = j
                For i As Integer = 1 To grdDetalle.MaxCols
                    grdDetalle.Col = i
                    VGArreglo(j, i) = grdDetalle.Text
                Next i
            Next j
        Else
            ReDim VGArreglo(100, 30)
            VLTotalL = 0
        End If
        Me.Close()
    End Sub

    Private Function FLTransmitir(pTipo As String) As Boolean
        Try
            Dim drNewDetalle As DataRow
            Select Case pTipo
                Case "I"
                    drNewDetalle = dtDetalle.NewRow()
                    drNewDetalle("Cod.Banco") = VLCoBanco
                    drNewDetalle("Banco") = VLBanco
                    drNewDetalle("Cuenta") = VLNumCuenta
                    drNewDetalle("Num.Cheque") = VLNumCheque
                    drNewDetalle("Valor") = VLValor
                    drNewDetalle("Fecha") = mskFechaEmi.Text
                    drNewDetalle("Cod.Moneda") = txtCoMoneda.Text
                    drNewDetalle("Des.Moneda") = lblNoMoneda.Text.Trim()
                    drNewDetalle("Tipo") = VLTipo
                    drNewDetalle("Secuencial") = VLSec
                    If (VLPasoCompraVenta = False) Then
                        drNewDetalle("Cod.TipoCheque") = VLTipoChq
                        drNewDetalle("Des.TipoCheque") = lblNoTipo.Text.Trim()
                        drNewDetalle("ValorConvertido") = VLValConvertido
                        drNewDetalle("Cotizacion") = VLCotizacion
                    End If
                    dtDetalle.Rows.Add(drNewDetalle)



                Case "U"
                   
                    drDetalle(0)("Cod.Banco") = VLCoBanco
                    drDetalle(0)("Banco") = VLBanco
                    drDetalle(0)("Cuenta") = VLNumCuenta
                    drDetalle(0)("Num.Cheque") = VLNumCheque
                    drDetalle(0)("Valor") = VLValor
                    drDetalle(0)("Fecha") = mskFechaEmi.Text
                    drDetalle(0)("Cod.Moneda") = txtCoMoneda.Text
                    drDetalle(0)("Des.Moneda") = lblNoMoneda.Text.Trim()
                    If (VLPasoCompraVenta = False) Then
                        drDetalle(0)("CodTipoCheque") = VLTipoChq
                        drDetalle(0)("DesTipoCheque") = lblNoTipo.Text.Trim()
                    End If
                Case "C"
                    For j As Integer = 1 To UBound(VGArreglo)
                        If VGArreglo(j, 1) <> Nothing Then
                            drNewDetalle = dtDetalle.NewRow()
                            drNewDetalle("Cod.Banco") = VGArreglo(j, 1)
                            drNewDetalle("Banco") = VGArreglo(j, 2)
                            drNewDetalle("Cuenta") = VGArreglo(j, 3)
                            drNewDetalle("Num.Cheque") = VGArreglo(j, 4)
                            drNewDetalle("Valor") = VGArreglo(j, 5)
                            drNewDetalle("Fecha") = VGArreglo(j, 6)
                            drNewDetalle("Cod.Moneda") = VGArreglo(j, 7)
                            drNewDetalle("Des.Moneda") = VGArreglo(j, 8)
                            drNewDetalle("Tipo") = VGArreglo(j, 9)
                            drNewDetalle("Secuencial") = VGArreglo(j, 10)
                            If (VLPasoCompraVenta = False) Then
                                drNewDetalle("CodTipoCheque") = VGArreglo(j, 3)
                                drNewDetalle("DesTipoCheque") = VGArreglo(j, 4)
                                drNewDetalle("ValorConvertido") = VGArreglo(j, 13)
                                drNewDetalle("Cotizacion") = VGArreglo(j, 14)
                            End If
                            dtDetalle.Rows.Add(drNewDetalle)
                        Else
                            Exit For
                        End If
                    Next j

            End Select
           

        Catch ex As Exception
            COBISMessageBox.Show("Error: " & ex.Message, FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
        End Try
    End Function

#End Region

    Private Sub txtCoTipo_Enter(sender As Object, e As EventArgs) Handles txtCoTipo.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500347))
    End Sub

    Private Sub txtCoTipo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As Windows.Forms.KeyEventArgs) Handles txtCoTipo.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = 116 Then
            txtCoTipo.Text = ""
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, "re_origen_cheque")
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502627)) Then
                PMMapeaListaH(sqlconn, FCatalogo.lstCatalogo, False)
                PMChequea(sqlconn)
                VLPaso = True
                FCatalogo.ShowPopup(Me)
                txtCoTipo.Text = VGACatalogo.Codigo
                lblNoTipo.Text = VGACatalogo.Descripcion
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Private Sub txtCoTipo_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles txtCoTipo.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCoTipo_Leave(sender As Object, e As EventArgs) Handles txtCoTipo.Leave
        If VLPaso Then
            Exit Sub
        End If
        If txtCoTipo.Text <> "" Then
            PMCatalogo("V", "re_origen_cheque", txtCoTipo, lblNoTipo)
        Else
            lblNoTipo.Text = ""
        End If
    End Sub

    Private Sub txtCoBanco_Enter(sender As Object, e As EventArgs) Handles txtCoBanco.Enter
        VLPaso = False
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5270))
    End Sub

    Private Sub txtCoBanco_KeyDown(ByVal eventSender As Object, ByVal eventArgs As Windows.Forms.KeyEventArgs) Handles txtCoBanco.KeyDown
        Dim Keycode As Integer = eventArgs.KeyCode
        If Keycode = 116 Then
            VGOperacion = "sp_banco"
            txtCoBanco.Text = ""
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "18")
            PMPasoValores(sqlconn, "@i_help", 0, SQLCHAR, "A")
            PMPasoValores(sqlconn, "@i_tran", 0, SQLCHAR, "O")
            PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
            PMPasoValores(sqlconn, "@i_modo", 0, SQLINT2, "0")

            PMHelpG("cob_cuentas", "sp_banco", 7, 1)
            PMBuscarG(1, "@i_operacion", "H", SQLCHAR)
            PMBuscarG(2, "@i_tipo", "A", SQLCHAR)
            PMBuscarG(3, "@i_modo", "0", SQLINT1)
            PMBuscarG(4, "@t_trn", "18", SQLINT2)
            PMBuscarG(5, "@i_help", "A", SQLCHAR)
            PMBuscarG(6, "@i_tran", "O", SQLCHAR)
            PMBuscarG(7, "@i_filial", VGFilial, SQLINT1)
            PMSigteG(1, "@i_secuencial", 1, SQLINT4)
            If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_banco", True, FMLoadResString(502627)) Then
                PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                PMChequea(sqlconn)
                PMMapeaTextoGrid(FRegistros.grdRegistros)
                PMAnchoColumnasGrid(FRegistros.grdRegistros)
                VLPaso = True
                FRegistros.ShowPopup()
                If VGACatalogo.Codigo <> "" Then
                    txtCoBanco.Text = VGACatalogo.Codigo
                    lblNoBanco.Text = VGACatalogo.Descripcion
                    VLPaso = True
                Else
                    lblNoBanco.Text = ""
                    VLPaso = False
                End If
                FRegistros.Dispose()
            Else
                PMChequea(sqlconn)
            End If
        Else
            VLPaso = False
        End If
    End Sub

    Private Sub txtCoBanco_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles txtCoBanco.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCoBanco_Leave(sender As Object, e As EventArgs) Handles txtCoBanco.Leave
        If Not VLPaso Then
            If txtCoBanco.Text <> "" Then
                lblNoBanco.Text = ""
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "18")
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_bco", 0, SQLINT2, txtCoBanco.Text)
                If FMTransmitirRPC(sqlconn, ServerName, "cob_cuentas", "sp_banco", True, FMLoadResString(502627)) Then
                    PMMapeaObjeto(sqlconn, lblNoBanco)
                    PMChequea(sqlconn)
                    If lblNoBanco.Text = "" Then
                        COBISMessageBox.Show(FMLoadResString(5289), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                        txtCoBanco.Text = ""
                        txtCoBanco.Focus()
                    End If
                    VLPaso = False
                Else
                    PMChequea(sqlconn)
                    lblNoBanco.Text = ""
                    txtCoBanco.Text = ""
                    txtCoBanco.Focus()
                    VLPaso = True
                End If
            Else
                lblNoBanco.Text = ""
                VLPaso = True
            End If
        End If
    End Sub


    Private Sub mskCuenta_Enter(sender As Object, e As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(508667))
    End Sub

    Private Sub txtNumCheque_Enter(sender As Object, e As EventArgs) Handles txtNumCheque.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(501052))
    End Sub

    Private Sub txtNumCheque_KeyPress(sender As Object, e As Windows.Forms.KeyPressEventArgs) Handles txtNumCheque.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(e.KeyChar)
        If txtNumCheque.SelectionLength <> txtNumCheque.TextLength Then
            If txtNumCheque.Text.Trim.Length > CLMaxLength Then
                Dim VTPos As Short = txtNumCheque.Text.IndexOf(".")
                If (VTPos = -1 And Char.IsDigit(e.KeyChar)) Or (txtNumCheque.SelectionStart < VTPos And Char.IsDigit(e.KeyChar)) Then e.Handled = True
            End If
        End If
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            e.Handled = True
        End If
        e.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtCoMoneda_Enter(sender As Object, e As EventArgs) Handles txtCoMoneda.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(509550))
    End Sub

    Private Sub txtCoMoneda_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles txtCoMoneda.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub mskCuenta_Leave(sender As Object, e As EventArgs) Handles mskCuenta.Leave
        lblNoCuenta.Text = ""

        If Not String.IsNullOrEmpty(mskCuenta.ClipText.Trim) Then
            If Not Me.FLConsultarCuenta() Then
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                mskCuenta.Focus()
            End If
        End If

        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(String.Empty)
    End Sub

    Private Sub txtNumCuenta_Enter(sender As Object, e As EventArgs) Handles txtNumCuenta.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500653))
    End Sub

    Private Sub txtNumCuenta_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles txtNumCuenta.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub txtBanco_Enter(sender As Object, e As EventArgs) Handles txtBanco.Enter
        VLPaso = True
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5270))
    End Sub

    Private Sub txtBanco_KeyPress(sender As Object, EventArgs As Windows.Forms.KeyPressEventArgs) Handles txtBanco.KeyPress
        Dim KeyAscii As Integer = Strings.Asc(EventArgs.KeyChar)
        KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
        If KeyAscii = 0 Then
            EventArgs.Handled = True
        End If
        EventArgs.KeyChar = Convert.ToChar(KeyAscii)
    End Sub

    Private Sub grdDetalle_ClickEvent(sender As Object, e As Framework.UI.Components._DSpreadEvents_ClickEvent) Handles grdDetalle.ClickEvent
        grdDetalle.Row = 1
        PMMarcaFilaGrid(grdDetalle, grdDetalle.Row)
    End Sub
 

    Private Sub grdDetalle_DblClick(sender As Object, e As Framework.UI.Components._DSpreadEvents_DblClickEvent) Handles grdDetalle.DblClick
        grdDetalle.Col = 1
        grdDetalle.Row = 1
        If grdDetalle.Text <> "" Then
            grdDetalle.Row = grdDetalle.ActiveRow
            grdDetalle.Col = 10
            VLSec = grdDetalle.Text
            drDetalle = dtDetalle.Select("Secuencial=" + VLSec.ToString())

            If (drDetalle.GetLength(0) > 0) Then

                VLAccion = "U"
                Select Case (VLTipo)
                    Case "3"
                        txtCoBanco.Text = drDetalle(0)("Cod.Banco").ToString()
                        lblNoBanco.Text = drDetalle(0)("Banco").ToString()
                        mskCuenta.Text = drDetalle(0)("Cuenta").ToString()
                    Case "1"
                        txtCoBanco.Text = drDetalle(0)("Cod.Banco").ToString()
                        lblNoBanco.Text = drDetalle(0)("Banco").ToString()
                        txtNumCuenta.Text = drDetalle(0)("Cuenta").ToString()
                    Case "2"
                        txtCoTipo.Text = drDetalle(0)("CodTipoCheque").ToString()
                        lblNoTipo.Text = drDetalle(0)("DesTipoCheque").ToString()
                        txtBanco.Text = drDetalle(0)("Banco").ToString()
                        txtNumCuenta.Text = drDetalle(0)("Cuenta").ToString()
                        mskCotizacion.Text = drDetalle(0)("Cotizacion").ToString()
                        mskValorConvertido.Text = drDetalle(0)("ValorConvertido").ToString()
                End Select

                Dim VTValorTmp As Double
                VTValorTmp = drDetalle(0)("Valor").ToString()

                txtNumCheque.Text = drDetalle(0)("Num.Cheque").ToString()
                mskValor.Text = VTValorTmp.ToString("#,##0.00")
                mskFechaEmi.Text = drDetalle(0)("Fecha").ToString()
                txtCoMoneda.Text = drDetalle(0)("Cod.Moneda").ToString()
                lblNoMoneda.Text = drDetalle(0)("Des.Moneda").ToString()
                'mskCotizacion.Text = VTCotizacionTmp.ToString("#,##0.00")
                'mskValorConvertido.Text = VTValorConvTmp.ToString("#,##0.00")
                TSBAgregar.Text = FMLoadResString(2031)
                TSBEliminar.Enabled = True
                Select Case (VLTipo)
                    Case "3"
                        mskCuenta.Focus()
                    Case "1"
                        txtCoBanco.Focus()
                    Case "2"
                        txtCoTipo.Focus()
                End Select

            End If
        End If
    End Sub

    Private Sub grdDetalle_Enter(sender As Object, e As EventArgs) Handles grdDetalle.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5264))
    End Sub

    Private Sub mskFechaEmi_Enter(sender As Object, e As EventArgs) Handles mskFechaEmi.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(5283))
    End Sub

End Class
