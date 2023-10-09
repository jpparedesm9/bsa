Imports COBISCorp.tCOBIS.CTA.SharedLibrary
Imports COBISCorp.eCOBIS.Commons.MessageBox
Imports COBISCorp.tCOBIS.COBISExplorer.CompositeUI

Public Class FTRAN76Class
    Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
    'Variables
    Dim VLSSN As Integer
    'Constantes
    Const CLMaxLength As Short = 18
    Const CLFormatoValor As String = "#,##0.00"
    Const CLMaxValor As Double = 999999999999.99
    Private Sub FTRAN76_Load(sender As Object, e As EventArgs) Handles MyBase.Load
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
    End Sub
    Private Sub TSBotones_ItemClicked(sender As Object, e As Windows.Forms.ToolStripItemClickedEventArgs) Handles TSBotones.ItemClicked

        Select Case e.ClickedItem.Name
            Case "TSBTransmitir"
                If Me.FLTransmitir Then
                    COBISMessageBox.Show(FMLoadResString(509510) & " " & VLSSN, FMLoadResString(501878), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
                    Me.PLIniciarForm()
                End If
            Case "TSBLimpiar"
                Me.PLIniciarForm()
            Case "TSBSalir"
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
    Private Sub mskValor_Change(sender As Object, e As EventArgs) Handles mskValor.Change
        '
    End Sub
    Private Sub mskValor_GotFocus(sender As Object, e As EventArgs) Handles mskValor.GotFocus
        mskValor.SelectAll()
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500198)) 'Valor del Retiro en Efectivo
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
#End Region

#Region "Functions"
    Private Function FLTransmitir() As Boolean

        If Not FLValidarCampos() Then Return False

        Try
            Dim VTValor As Double = CDbl(mskValor.Text)

            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "263")
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText.Trim)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
            PMPasoValores(sqlconn, "@i_val", 0, SQLMONEY, VTValor)
            PMPasoValores(sqlconn, "@i_ActTot", 0, SQLCHAR, "N")
            PMPasoValores(sqlconn, "@i_canal", 0, SQLINT1, 0)
            PMPasoValores(sqlconn, "@o_ssn", 1, SQLINT4, "0000000000")

            If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_ah_retirosl", True, FMLoadResString(509510)) Then
                PMChequea(sqlconn)
                VLSSN = FMRetParam(sqlconn, 1)
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

        If Not IsNumeric(mskValor.Text.Trim) Then 'Ingrese valor de retiro
            COBISMessageBox.Show(FMLoadResString(509511), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            mskValor.Focus()
            Return False
        Else
            If CDbl(mskValor.Text.Trim) <= 0 Then 'El valor del retiro debe ser mayor a cero
                COBISMessageBox.Show(FMLoadResString(509512), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                mskValor.Focus()
                Return False
            Else
                If CDbl(mskValor.Text) > CLMaxValor Then
                    COBISMessageBox.Show(FMLoadResString(501098) & " " & CLMaxValor.ToString(CLFormatoValor), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    'mskValor.Text = "0.00"
                    mskValor.Focus()
                    Return False
                End If
            End If
        End If

        Return True

    End Function
#End Region

#Region "Procedures"
    Public Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        mskCuenta.Mask = VGMascaraCtaAho
        txtMonCodigo.Text = VGMoneda
        txtMonDescripcion.Text = FLBuscarMoneda(VGMoneda)
        mskValor.MaxReal = CLMaxValor
    End Sub
#End Region

#Region "Inicializar"
    Private Sub PLLimpiar()
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho)
        txtNombre.Text = ""
        mskValor.Text = "0.00"
    End Sub
    Private Sub PLIniciarForm()
        Me.PLIniciarVar()
        Me.PLLimpiar()
        mskCuenta.Focus()
        mskCuenta.SelectAll()
    End Sub
    Private Sub PLIniciarVar()
        VLSSN = 0
    End Sub
#End Region

End Class
