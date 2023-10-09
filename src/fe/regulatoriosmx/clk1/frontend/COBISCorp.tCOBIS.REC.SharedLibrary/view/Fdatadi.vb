Option Strict Off
Option Explicit On
Imports Artinsoft.VB6.Utils
Imports Microsoft.VisualBasic
Imports System
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
 public  Partial  Class FdatadiClass
Inherits COBISCorp.tCOBIS.COBISExplorer.CompositeUI.COBISFuncionalityView
	Dim VTR1 As Integer = 0
	Dim i As Integer = 0
	Dim VLPaso As Integer = 0
	Dim VLBase As String = ""
	Dim VLSP As String = ""
	Dim VLSP1 As String = ""
	Dim VLMascara As String = ""
	Dim VLTitular As String = ""

    Private Sub PLInicializar()
        Me.Left = 0
        Me.Top = 0
        If VGProducto = "CTE" Then
            COBISResourceProvider.SetImageID(lblEtiqueta(0), "508653")
            COBISResourceProvider.SetImageID(lblEtiqueta(6), "5017")
            VLMascara = VGMascaraCtaCte
        Else
            'COBISResourceProvider.SetImageID(lblEtiqueta(0), "0")
            lblEtiqueta(0).Text = FMLoadResString(508651)
            '  COBISResourceProvider.SetImageID(lblEtiqueta(6), "0")
            lblEtiqueta(6).Text = FMLoadResString(500108)
            VLMascara = VGMascaraCtaAho
        End If
        PLLimpiar()
        txtCampo(2).MaxLength = 50
    End Sub

    Private Sub Fdatadi_Load(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Load
        MyAppGlobals.AppActiveForm = ""
        PMLoadResStrings(Me)
        PMLoadResIcons(Me)
        PLInicializar()
        PLTSEstado()
    End Sub

	Private Sub Fdatadi_Closed(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles MyBase.Closed
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
		COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowTransactionLine("")
	End Sub

	Private Sub cmdBoton_Click(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Click, _cmdBoton_2.Click, _cmdBoton_1.Click, _cmdBoton_4.Click, _cmdBoton_0.Click
		Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
		Select Case Index
			Case 0
				PLTransmitir("I")
			Case 1
				PLLimpiar()
			Case 2
				Me.Close()
			Case 4
				PLTransmitir("U")
			Case 3
				PLBuscar()
		End Select
    End Sub

    Private Sub cmdBoton_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _cmdBoton_3.Enter, _cmdBoton_2.Enter, _cmdBoton_1.Enter, _cmdBoton_4.Enter, _cmdBoton_0.Enter
        Dim Index As Integer = Array.IndexOf(cmdBoton, eventSender)
        Select Case Index
            Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500047))
            Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500370))
            Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500371))
            Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500046))
            Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500011))
        End Select
    End Sub

	Private Sub mskCuenta_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Enter
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine("")
        COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500194))
		mskCuenta.SelectionStart = 0
		mskCuenta.SelectionLength = Strings.Len(mskCuenta.Text)
	End Sub

	Private Sub mskCuenta_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles mskCuenta.Leave
		Try 
			If mskCuenta.ClipText <> "" Then
				If VGProducto = "CTE" Then
					VLBase = "cob_cuentas"
					VLSP = "sp_tr_query_nom_ctacte"
					VLSP1 = "sp_datos_adic_cte"
					VLMascara = VGMascaraCtaCte
					PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
				Else
					If VGProducto = "AHO" Then
						VLBase = "cob_ahorros"
						VLSP = "sp_tr_query_nom_ctahorro"
						VLSP1 = "sp_datos_adic_aho"
						VLMascara = VGMascaraCtaAho
						PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
					Else
                        COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
						mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
						lblDescripcion(0).Text = ""
						If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
					End If
				End If
				PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
				PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(502622) & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto(sqlconn, lblDescripcion(0))
                    PMChequea(sqlconn)
                    If cmdBoton(3).Enabled And cmdBoton(3).Visible Then cmdBoton(3).Focus()
                    PLBuscaEnte()
                    PLBuscar()
                Else
                    PMChequea(sqlconn)
                    PLLimpiar()
                    mskCuenta.Text = FMMascara("", VLMascara)
                    lblDescripcion(0).Text = ""
                    If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
                    Exit Sub
                End If
			Else
				lblDescripcion(0).Text = ""
			End If
		Catch exc As System.Exception
            NotUpgradedHelper.NotifyNotUpgradedElement(FMLoadResString(9915))
		End Try
	End Sub

	Private Sub PLBuscaEnte()
		Dim VTSpEnte As String = string.Empty
		Dim  VTTrn As String = string.Empty
		Dim  VTBase As String = string.Empty
		If VGProducto = "AHO" Then
			VTSpEnte = "sp_tr_query_clientes_ah"
			VTTrn = "298"
			VTBase = "cob_ahorros"
		Else
			VTSpEnte = "sp_tr_query_clientes"
			VTTrn = "17"
			VTBase = "cob_cuentas"
		End If
		VLTitular = ""
		PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, VTTrn)
		PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
		Dim VTEntes(6, 100) As String
        If FMTransmitirRPC(sqlconn, ServerName, VTBase, VTSpEnte, True, FMLoadResString(2250)) Then
            VTR1 = FMMapeaMatriz(sqlconn, VTEntes)
            PMChequea(sqlconn)
            For i As Integer = 1 To VTR1
                If VTEntes(4, i) = "T" Then
                    VLTitular = VTEntes(0, i).Trim()
                    Exit For
                End If
            Next i
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub mskValor_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _mskValor_0.Enter, _mskValor_2.Enter, _mskValor_3.Enter, _mskValor_4.Enter, _mskValor_5.Enter, _mskValor_6.Enter, _mskValor_7.Enter, _mskValor_1.Enter
		Dim Index As Integer = Array.IndexOf(mskValor, eventSender)
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500195))
			Case 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500196))
			Case 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500197))
			Case 3
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500198))
			Case 4
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500199))
			Case 5
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500200))
			Case 6, 7
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500201))
		End Select
		mskValor(Index).SelectionStart = 0
		mskValor(Index).SelectionLength = Strings.Len(mskValor(Index).Text)
	End Sub

	Private Sub mskValor_KeyPressEvent(ByVal eventSender As Object, ByVal eventArgs As System.Windows.Forms.KeyPressEventArgs) Handles _mskValor_0.KeyPress, _mskValor_2.KeyPress, _mskValor_3.KeyPress, _mskValor_4.KeyPress, _mskValor_5.KeyPress, _mskValor_6.KeyPress, _mskValor_7.KeyPress, _mskValor_1.KeyPress
		If VGDecimales = "#,##0" Then
			If (Asc(eventArgs.KeyChar) <> 8) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
				eventArgs.KeyChar = Chr(0)
			End If
		Else
			If (Asc(eventArgs.KeyChar) <> 8) And (Asc(eventArgs.KeyChar) <> 46) And ((Asc(eventArgs.KeyChar) < 48) Or (Asc(eventArgs.KeyChar) > 57)) Then
				eventArgs.KeyChar = Chr(0)
			End If
		End If
	End Sub

	Private isInitializingComponent As Boolean = false

	Private Sub txtCampo_TextChanged(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_10.TextChanged, _txtCampo_18.TextChanged, _txtCampo_17.TextChanged, _txtCampo_16.TextChanged, _txtCampo_15.TextChanged, _txtCampo_14.TextChanged, _txtCampo_13.TextChanged, _txtCampo_12.TextChanged, _txtCampo_11.TextChanged, _txtCampo_9.TextChanged, _txtCampo_8.TextChanged, _txtCampo_7.TextChanged, _txtCampo_6.TextChanged, _txtCampo_5.TextChanged, _txtCampo_4.TextChanged, _txtCampo_3.TextChanged, _txtCampo_2.TextChanged, _txtCampo_1.TextChanged, _txtCampo_0.TextChanged
		If isInitializingComponent Then
			Exit Sub
		End If
		VLPaso = False
	End Sub

	Private Sub txtCampo_Enter(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_10.Enter, _txtCampo_18.Enter, _txtCampo_17.Enter, _txtCampo_16.Enter, _txtCampo_15.Enter, _txtCampo_14.Enter, _txtCampo_13.Enter, _txtCampo_12.Enter, _txtCampo_11.Enter, _txtCampo_9.Enter, _txtCampo_8.Enter, _txtCampo_7.Enter, _txtCampo_6.Enter, _txtCampo_5.Enter, _txtCampo_4.Enter, _txtCampo_3.Enter, _txtCampo_2.Enter, _txtCampo_1.Enter, _txtCampo_0.Enter
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		VLPaso = True
		Select Case Index
			Case 0
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500202))
			Case 1, 2
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500202))
			Case 3, 4, 5, 6, 7, 8, 9
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500204))
			Case 10, 11, 12, 13, 14, 15, 16
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500205))
			Case 17
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500206))
			Case 18
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500207))
		End Select
		txtCampo(Index).SelectionStart = 0
		txtCampo(Index).SelectionLength = Strings.Len(txtCampo(Index).Text)
	End Sub

	Private Sub txtCampo_KeyDown(ByVal eventSender As Object, ByVal eventArgs As KeyEventArgs) Handles _txtCampo_10.KeyDown, _txtCampo_18.KeyDown, _txtCampo_17.KeyDown, _txtCampo_16.KeyDown, _txtCampo_15.KeyDown, _txtCampo_14.KeyDown, _txtCampo_13.KeyDown, _txtCampo_12.KeyDown, _txtCampo_11.KeyDown, _txtCampo_9.KeyDown, _txtCampo_8.KeyDown, _txtCampo_7.KeyDown, _txtCampo_6.KeyDown, _txtCampo_5.KeyDown, _txtCampo_4.KeyDown, _txtCampo_3.KeyDown, _txtCampo_2.KeyDown, _txtCampo_1.KeyDown, _txtCampo_0.KeyDown
		Dim Keycode As Integer = eventArgs.KeyCode
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If Keycode = VGTeclaAyuda Then
			VLPaso = True
			Select Case Index
				Case 0
                    PMCatalogo("A", "cl_forma_depini", txtCampo(Index).Text, lblDescripcion(1))
				Case 1, 2
                    PMCatalogo("A", "pf_otros_prod_bancarios", txtCampo(Index).Text, lblDescripcion(Index + 2))
				Case 10, 11, 12, 13, 14, 15, 16
                    PMCatalogo("A", "cl_frecuencia", txtCampo(Index).Text, lblDescripcion(Index - 5))
				Case 17
                    PMCatalogo("A", "cl_pro_cta", txtCampo(Index).Text, lblDescripcion(2))
				Case 18
                    PMCatalogo("A", "cl_orig_fond", txtCampo(Index).Text, lblDescripcion(12))
			End Select
		End If
	End Sub

	Private Sub txtCampo_KeyPress(ByVal eventSender As Object, ByVal eventArgs As KeyPressEventArgs) Handles _txtCampo_10.KeyPress, _txtCampo_18.KeyPress, _txtCampo_17.KeyPress, _txtCampo_16.KeyPress, _txtCampo_15.KeyPress, _txtCampo_14.KeyPress, _txtCampo_13.KeyPress, _txtCampo_12.KeyPress, _txtCampo_11.KeyPress, _txtCampo_9.KeyPress, _txtCampo_8.KeyPress, _txtCampo_7.KeyPress, _txtCampo_6.KeyPress, _txtCampo_5.KeyPress, _txtCampo_4.KeyPress, _txtCampo_3.KeyPress, _txtCampo_2.KeyPress, _txtCampo_1.KeyPress, _txtCampo_0.KeyPress
		Dim KeyAscii As Integer = Strings.Asc(eventArgs.KeyChar)
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		Select Case Index
			Case 1, 2, 3, 4, 5, 6, 7, 8, 9
				If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
					KeyAscii = 0
				End If
			Case 10, 11, 12, 13, 14, 15, 16
				KeyAscii = Strings.AscW(Strings.Chr(KeyAscii).ToString().ToUpper())
		End Select
		If KeyAscii = 0 Then
			eventArgs.Handled = True
		End If
		eventArgs.KeyChar = Convert.ToChar(KeyAscii)
	End Sub

	Private Sub txtCampo_Leave(ByVal eventSender As Object, ByVal eventArgs As EventArgs) Handles _txtCampo_10.Leave, _txtCampo_18.Leave, _txtCampo_17.Leave, _txtCampo_16.Leave, _txtCampo_15.Leave, _txtCampo_14.Leave, _txtCampo_13.Leave, _txtCampo_12.Leave, _txtCampo_11.Leave, _txtCampo_9.Leave, _txtCampo_8.Leave, _txtCampo_7.Leave, _txtCampo_6.Leave, _txtCampo_5.Leave, _txtCampo_4.Leave, _txtCampo_3.Leave, _txtCampo_2.Leave, _txtCampo_1.Leave, _txtCampo_0.Leave
		Dim Index As Integer = Array.IndexOf(txtCampo, eventSender)
		If Not VLPaso Then
			Select Case Index
				Case 0
					If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_forma_depini", txtCampo(Index).Text, lblDescripcion(1))
					Else
						lblDescripcion(1).Text = ""
					End If
				Case 1, 2
					If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "pf_otros_prod_bancarios", txtCampo(Index).Text, lblDescripcion(Index + 2))
					Else
						lblDescripcion(Index + 2).Text = ""
						txtCampo(Index).Text = ""
					End If
				Case 10, 11, 12, 13, 14, 15, 16
					If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_frecuencia", txtCampo(Index).Text, lblDescripcion(Index - 5))
					Else
						lblDescripcion(Index - 5).Text = ""
						txtCampo(Index).Text = ""
					End If
				Case 17
					If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_pro_cta", txtCampo(Index).Text, lblDescripcion(2))
					Else
						lblDescripcion(2).Text = ""
					End If
				Case 18
					If txtCampo(Index).Text <> "" Then
                        PMCatalogo("V", "cl_orig_fond", txtCampo(Index).Text, lblDescripcion(12))
					Else
						lblDescripcion(12).Text = ""
					End If
			End Select
		End If
	End Sub

	Private Sub PLBuscar()
		If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500208), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			mskCuenta.Focus()
			Exit Sub
		End If
		If VGProducto = "CTE" Then
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2840")
		Else
			PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "347")
		End If
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "Q")
		PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
		Dim VTArreglo(30) As String
        If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP1, True, FMLoadResString(509240) & "[" & mskCuenta.Text & "]") Then
            VTR1 = FMMapeaArreglo(sqlconn, VTArreglo)
            PMChequea(sqlconn)
            If VTR1 <= 0 Then
                cmdBoton(4).Enabled = False
                cmdBoton(0).Enabled = True
                If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).Focus()
                For i As Integer = 0 To 7
                    mskValor(i).Text = VGDecimales
                    mskValor(i).Text = StringsHelper.Format(0, VGDecimales)
                Next i
                For i As Integer = 1 To 12
                    lblDescripcion(i).Text = ""
                Next i
                For i As Integer = 0 To 18
                    txtCampo(i).Text = ""
                Next i
                Exit Sub
            End If
            cmdBoton(4).Enabled = True
            cmdBoton(0).Enabled = False
            mskValor(0).Text = VTArreglo(1)
            txtCampo(0).Text = VTArreglo(2)
            txtCampo_Leave(txtCampo(0), New EventArgs())
            txtCampo(17).Text = VTArreglo(3)
            txtCampo_Leave(txtCampo(17), New EventArgs())
            txtCampo(1).Text = VTArreglo(4)
            txtCampo_Leave(txtCampo(1), New EventArgs())
            txtCampo(2).Text = VTArreglo(5)
            txtCampo_Leave(txtCampo(2), New EventArgs())
            mskValor(1).Text = VTArreglo(6)
            txtCampo(3).Text = VTArreglo(7)
            txtCampo(10).Text = VTArreglo(8)
            txtCampo_Leave(txtCampo(10), New EventArgs())
            mskValor(2).Text = VTArreglo(9)
            txtCampo(4).Text = VTArreglo(10)
            txtCampo(11).Text = VTArreglo(11)
            txtCampo_Leave(txtCampo(11), New EventArgs())
            mskValor(3).Text = VTArreglo(12)
            txtCampo(5).Text = VTArreglo(13)
            txtCampo(12).Text = VTArreglo(14)
            txtCampo_Leave(txtCampo(12), New EventArgs())
            mskValor(4).Text = VTArreglo(15)
            txtCampo(6).Text = VTArreglo(16)
            txtCampo(13).Text = VTArreglo(17)
            txtCampo_Leave(txtCampo(13), New EventArgs())
            mskValor(5).Text = VTArreglo(18)
            txtCampo(7).Text = VTArreglo(19)
            txtCampo(14).Text = VTArreglo(20)
            txtCampo_Leave(txtCampo(14), New EventArgs())
            mskValor(6).Text = VTArreglo(21)
            txtCampo(8).Text = VTArreglo(22)
            txtCampo(15).Text = VTArreglo(23)
            txtCampo_Leave(txtCampo(15), New EventArgs())
            mskValor(7).Text = VTArreglo(24)
            txtCampo(9).Text = VTArreglo(25)
            txtCampo(16).Text = VTArreglo(26)
            txtCampo_Leave(txtCampo(16), New EventArgs())
            txtCampo(18).Text = VTArreglo(27)
            txtCampo_Leave(txtCampo(18), New EventArgs())
            If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).Focus()
        Else
            PMChequea(sqlconn)
        End If
	End Sub

	Private Sub PLLimpiar()
		mskCuenta.Mask = VLMascara
		For i As Integer = 0 To 7
			mskValor(i).Text = VGDecimales
			mskValor(i).Text = StringsHelper.Format(0, VGDecimales)
		Next i
		For i As Integer = 0 To 12
			lblDescripcion(i).Text = ""
		Next i
		For i As Integer = 0 To 18
			txtCampo(i).Text = ""
		Next i
		cmdBoton(0).Enabled = True
		cmdBoton(4).Enabled = False
		mskCuenta.Text = FMMascara("", VLMascara)
		If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
	End Sub

	Private Sub PLTransmitir(ByRef tipo As String)
		Dim VTFecha As String = ""
		If mskCuenta.ClipText = "" Then
            COBISMessageBox.Show(FMLoadResString(500208), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			If mskCuenta.Enabled And mskCuenta.Visible Then mskCuenta.Focus()
			Exit Sub
		End If
		If Conversion.Val(mskValor(0).Text) <= 0 Then
            COBISMessageBox.Show(FMLoadResString(500209), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			If mskValor(0).Enabled And mskValor(0).Visible Then mskValor(0).Focus()
			Exit Sub
		End If
		If txtCampo(0).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500210), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			If txtCampo(0).Enabled And txtCampo(0).Visible Then txtCampo(0).Focus()
			Exit Sub
		End If
		If txtCampo(18).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500211), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			If txtCampo(18).Enabled And txtCampo(18).Visible Then txtCampo(18).Focus()
			Exit Sub
		End If
		If txtCampo(17).Text = "" Then
            COBISMessageBox.Show(FMLoadResString(500212), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
			If txtCampo(17).Enabled And txtCampo(17).Visible Then txtCampo(17).Focus()
			Exit Sub
		End If
		If txtCampo(1).Text.Trim() <> "" And txtCampo(2).Text.Trim() <> "" Then
			If txtCampo(1).Text = txtCampo(2).Text Then
                COBISMessageBox.Show(FMLoadResString(500213), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).Focus()
				Exit Sub
			End If
		End If
		For i As Integer = 3 To 9
			If Conversion.Val(txtCampo(i).Text) < 0 Then
                COBISMessageBox.Show(FMLoadResString(500214), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				If txtCampo(i).Enabled And txtCampo(i).Visible Then txtCampo(i).Focus()
				Exit Sub
			End If
			If Conversion.Val(txtCampo(i).Text) >= 10000 Then
                COBISMessageBox.Show(FMLoadResString(500215), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
				If txtCampo(i).Enabled And txtCampo(i).Visible Then txtCampo(i).Focus()
				Exit Sub
			End If
			If txtCampo(i).Text <> "" Then
				If Conversion.Val(mskValor(i - 2).Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(500216), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If mskValor(i - 2).Enabled And mskValor(i - 2).Visible Then mskValor(i - 2).Focus()
					Exit Sub
				End If
				If txtCampo(i + 7).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500217), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If txtCampo(i + 7).Enabled And txtCampo(i + 7).Visible Then txtCampo(i + 7).Focus()
					Exit Sub
				End If
			End If
			If Conversion.Val(mskValor(i - 2).Text) > 0 Then
				If txtCampo(i).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500218), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If txtCampo(i).Enabled And txtCampo(i).Visible Then txtCampo(i).Focus()
					Exit Sub
				End If
				If txtCampo(i + 7).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500217), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If txtCampo(i + 7).Enabled And txtCampo(i + 7).Visible Then txtCampo(i + 7).Focus()
					Exit Sub
				End If
			End If
			If txtCampo(i + 7).Text <> "" Then
				If Conversion.Val(mskValor(i - 2).Text) = 0 Then
                    COBISMessageBox.Show(FMLoadResString(500216), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If mskValor(i - 2).Enabled And mskValor(i - 2).Visible Then mskValor(i - 2).Focus()
					Exit Sub
				End If
				If txtCampo(i).Text = "" Then
                    COBISMessageBox.Show(FMLoadResString(500218), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
					If txtCampo(i).Enabled And txtCampo(i).Visible Then txtCampo(i).Focus()
					Exit Sub
				End If
			End If
		Next i
		If tipo = "I" Then
			If VGProducto = "CTE" Then
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2838")
			Else
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "345")
			End If
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "I")
			VTFecha = FMConvFecha(VGFecha, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_ingreso", 0, SQLDATETIME, VTFecha)
		Else
			If VGProducto = "CTE" Then
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "2839")
			Else
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "346")
			End If
			PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "U")
			VTFecha = FMConvFecha(VGFecha, VGFormatoFecha, CGFormatoBase)
			PMPasoValores(sqlconn, "@i_fecha_modif", 0, SQLDATETIME, VTFecha)
		End If
		PMPasoValores(sqlconn, "@i_cta_banco", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_mon", 0, SQLINT2, VGMoneda)
		PMPasoValores(sqlconn, "@i_origen_fondos", 0, SQLVARCHAR, txtCampo(18).Text)
		PMPasoValores(sqlconn, "@i_dep_inicial", 0, SQLMONEY, mskValor(0).Text)
		PMPasoValores(sqlconn, "@i_forma_dep_inicial", 0, SQLVARCHAR, txtCampo(0).Text)
		PMPasoValores(sqlconn, "@i_proposito_cuenta", 0, SQLVARCHAR, txtCampo(17).Text)
		PMPasoValores(sqlconn, "@i_prod_cobis1", 0, SQLVARCHAR, txtCampo(1).Text)
		PMPasoValores(sqlconn, "@i_prod_cobis2", 0, SQLVARCHAR, txtCampo(2).Text)
		PMPasoValores(sqlconn, "@i_monto_ext", 0, SQLMONEY, mskValor(1).Text)
		PMPasoValores(sqlconn, "@i_trx_ext", 0, SQLINT2, txtCampo(3).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_ext", 0, SQLVARCHAR, txtCampo(10).Text)
		PMPasoValores(sqlconn, "@i_monto_efec", 0, SQLMONEY, mskValor(2).Text)
		PMPasoValores(sqlconn, "@i_trx_efec", 0, SQLINT2, txtCampo(4).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_efec", 0, SQLVARCHAR, txtCampo(11).Text)
		PMPasoValores(sqlconn, "@i_monto_refec", 0, SQLMONEY, mskValor(3).Text)
		PMPasoValores(sqlconn, "@i_trx_refec", 0, SQLINT2, txtCampo(5).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_refec", 0, SQLVARCHAR, txtCampo(12).Text)
		PMPasoValores(sqlconn, "@i_monto_giro", 0, SQLMONEY, mskValor(4).Text)
		PMPasoValores(sqlconn, "@i_trx_giro", 0, SQLINT2, txtCampo(6).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_giro", 0, SQLVARCHAR, txtCampo(13).Text)
		PMPasoValores(sqlconn, "@i_monto_gerencia", 0, SQLMONEY, mskValor(5).Text)
		PMPasoValores(sqlconn, "@i_trx_gerencia", 0, SQLINT2, txtCampo(7).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_gerencia", 0, SQLVARCHAR, txtCampo(14).Text)
		PMPasoValores(sqlconn, "@i_monto_transfer", 0, SQLMONEY, mskValor(6).Text)
		PMPasoValores(sqlconn, "@i_trx_transfer", 0, SQLINT2, txtCampo(8).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_transfer", 0, SQLVARCHAR, txtCampo(15).Text)
		PMPasoValores(sqlconn, "@i_monto_recib", 0, SQLMONEY, mskValor(7).Text)
		PMPasoValores(sqlconn, "@i_trx_recib", 0, SQLINT2, txtCampo(9).Text)
		PMPasoValores(sqlconn, "@i_frecuencia_recib", 0, SQLVARCHAR, txtCampo(16).Text)
        If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP1, True, FMLoadResString(509241) & mskCuenta.Text & "]") Then
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = True
            cmdBoton(0).Enabled = False
            VGPerfilCta = "S"
        Else
            PMChequea(sqlconn)
            Exit Sub
        End If
		PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, tipo)
		Select Case tipo
			Case "I"
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1421")
			Case "U"
				PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1423")
		End Select
		PMPasoValores(sqlconn, "@i_ente", 0, SQLINT4, VLTitular)
		PMPasoValores(sqlconn, "@i_cuenta", 0, SQLVARCHAR, mskCuenta.ClipText)
		PMPasoValores(sqlconn, "@i_producto", 0, SQLVARCHAR, VGProducto)
		PMPasoValores(sqlconn, "@i_descmoneda", 0, SQLVARCHAR, VGDescMoneda)
		PMPasoValores(sqlconn, "@i_origen", 0, SQLVARCHAR, txtCampo(18).Text)
		PMPasoValores(sqlconn, "@i_proposito", 0, SQLVARCHAR, txtCampo(17).Text)
		PMPasoValores(sqlconn, "@i_deposini", 0, SQLVARCHAR, mskValor(0).ClipText)
		PMPasoValores(sqlconn, "@i_ntrandeb", 0, SQLVARCHAR, txtCampo(5).Text)
		PMPasoValores(sqlconn, "@i_ntrancre", 0, SQLVARCHAR, txtCampo(4).Text)
		PMPasoValores(sqlconn, "@i_mpromdeb", 0, SQLVARCHAR, mskValor(3).ClipText)
		PMPasoValores(sqlconn, "@i_mpromcre", 0, SQLVARCHAR, mskValor(2).ClipText)
        If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_inf_cuenta", True, FMLoadResString(509240)) Then
            PMChequea(sqlconn)
            cmdBoton(4).Enabled = True
            cmdBoton(0).Enabled = False
        Else
            PMChequea(sqlconn)
        End If
	End Sub

    Private Sub ToolStripButton3_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBSalir.Click
        If _cmdBoton_2.Enabled Then cmdBoton_Click(_cmdBoton_2, e)
    End Sub

    Private Sub ToolStripButton1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBLimpiar.Click
        If _cmdBoton_1.Enabled Then cmdBoton_Click(_cmdBoton_1, e)
    End Sub

    Private Sub ToolStripButton4_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBModificar.Click
        If _cmdBoton_4.Enabled Then cmdBoton_Click(_cmdBoton_4, e)
    End Sub

    Private Sub ToolStripButton5_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBTransmitir.Click
        If _cmdBoton_0.Enabled Then cmdBoton_Click(_cmdBoton_0, e)
    End Sub

    Private Sub ToolStripButton2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles TSBBuscar.Click
        If _cmdBoton_3.Enabled Then cmdBoton_Click(_cmdBoton_3, e)
    End Sub
    Private Sub PLTSEstado()
        TSBBuscar.Enabled = _cmdBoton_3.Enabled
        TSBBuscar.Visible = _cmdBoton_3.Visible()
        TSBTransmitir.Enabled = _cmdBoton_0.Enabled
        TSBTransmitir.Visible = _cmdBoton_0.Visible()
        TSBModificar.Enabled = _cmdBoton_4.Enabled
        TSBModificar.Visible = _cmdBoton_4.Visible()
        TSBLimpiar.Enabled = _cmdBoton_1.Enabled
        TSBLimpiar.Visible = _cmdBoton_1.Visible()
        TSBSalir.Enabled = _cmdBoton_2.Enabled
        TSBSalir.Visible = _cmdBoton_2.Visible()
    End Sub

    Private Sub _ShowView(ByVal eventSender As Object, ByVal eventArgs As System.EventArgs) Handles MyBase.ShowView
        
        On Error Resume Next
        If mskCuenta.ClipText <> "" Then
            If VGProducto = "CTE" Then
                VLBase = "cob_cuentas"
                VLSP = "sp_tr_query_nom_ctacte"
                VLSP1 = "sp_datos_adic_cte"
                VLMascara = VGMascaraCtaCte
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "16")
            Else
                If VGProducto = "AHO" Then
                    VLBase = "cob_ahorros"
                    VLSP = "sp_tr_query_nom_ctahorro"
                    VLSP1 = "sp_datos_adic_aho"
                    VLMascara = VGMascaraCtaAho
                    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                Else
                    COBISMessageBox.Show(FMLoadResString(500020), FMLoadResString(500018), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte)
                    lblDescripcion(0).Text = ""
                    mskCuenta.Focus()
                End If
            End If
            PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, mskCuenta.ClipText)
            PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
            If FMTransmitirRPC(sqlconn, ServerName, VLBase, VLSP, True, FMLoadResString(502972) & "[" & mskCuenta.Text & "]") Then
                PMMapeaObjeto(sqlconn, lblDescripcion(0))
                PMChequea(sqlconn)
                PLBuscar()
            Else
                PMChequea(sqlconn)
                mskCuenta.Text = FMMascara("", VLMascara)
                lblDescripcion(0).Text = ""
                mskCuenta.Focus()
                Exit Sub
            End If
        End If
        'End If
    End Sub
End Class


