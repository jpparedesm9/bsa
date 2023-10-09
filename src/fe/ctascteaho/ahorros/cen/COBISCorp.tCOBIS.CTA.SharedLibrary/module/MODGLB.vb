Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Globalization
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODGLB
    Public VGDecimales As String = ""
    Public VGPaso As Integer = 0
    Public VGImpOrientacion As Integer = 0
    Public VGOperacion As String = ""
    Public VGADatosI() As String
    Public VGADatosO() As String
    Public VGTeclaAyuda As Integer = 0
    Public VGProducto As String = ""
    Public VGTipoHis As String = ""
    Public VGHelpRem As String = ""
    Public VGFecha As String = ""
    Public VGNombreFilial As String = ""
    Public VGNombreOficina As String = ""
    Public VGAperCifrada As Boolean = False
    Public VGEmpAgencia As Boolean = False
    Public VGPrefijo_cta(,) As String
    Public VGMaxPrefijos As Integer = 0
    Public VGTipoOper As String = ""
    Public VGMTipoDoc(15) As String
    Public VGCodAgencia As String = ""
    Public VGTurno As String = ""
    Public VGTransaccion As String = ""
    Public VGNumTransaccion As String = ""
    Public VGOperador As String = ""
    Public VGNumProducto As String = ""
    Public VGDigito As String = ""
    Public VGCodBanco As String = ""
    Public VGProductoConta As String = ""
    Public VGCorresponsal As Integer = 0
    Public VGCB As Boolean = False
    Public ARCHIVOINI As String = ""
    Public Preferencias(,) As String 'JSA
    Public Seccion() As MODINI.RegistroTOK = Nothing
    Public VGFecha_SP As String
    Public VGFecha_Pref As String = ""
    Public formato_fecha(,) As String
    Public Const CGFormatoBase As String = "mm/dd/yyyy"
    Public VGFormatoFechaStr As String = ""
    Public VGFormatoFechaInt As Integer
    Public VGPathResouces As String = ""
    Public VGCorreo As Integer = 0
    Public VGTIMERMAIL As Integer = 0
    Public VGUsuario As String = ""
    Public VGUsuarioNombre As String = ""
    Public VGFechaProceso As String
    Public VGHabilita As String = "N"
    Public VLTotalL As Double
    Public VGArreglo(100, 30) As String

    Dim FRegistros As FRegistrosClass

    Structure VGLineaImp
        Dim Texto As String
        Dim length As Integer
        Dim col As Integer
        Public Shared Function CreateInstance() As VGLineaImp
            Dim result As New VGLineaImp
            result.Texto = String.Empty
            Return result
        End Function
    End Structure

    Public Structure CatalogoUsuario
        Dim Codigo As String
        Dim Descripcion As String
        Public Shared Function CreateInstance() As CatalogoUsuario
            Dim result As New CatalogoUsuario
            result.Codigo = String.Empty
            result.Descripcion = String.Empty
            Return result
        End Function
    End Structure

    Public VGACatalogo As CatalogoUsuario = CatalogoUsuario.CreateInstance()
    Public VGFilial As String = ""
    Public VGOficina As String = ""
    Public VGOficial As String = ""
    Public VGMoneda As String = ""
    Public VGDescMoneda As String = ""
    Public VGRol As String = ""
    Public VGLongCtaCte As Integer = 0
    Public VGCteAbanks As String = ""
    Public VGLongCtaAho As Integer = 0
    Public VGNumGCtaCte As Integer = 0
    Public VGNumGCtaAho As Integer = 0
    Public VGPesosCtaCte As String = ""
    Public VGPesosCtaAho As String = ""
    Public VGModuloCtaCte As Integer = 0
    Public VGModuloCtaAho As Integer = 0
    Public VGMascaraCtaCte As String = ""
    Public VGMascaraCtaAho As String = ""
    Public VLClienteb As String = ""
    Public VGBanco As String = ""
    Public VGPais As String = ""
    Public VGPath As String = ""
    Public VGBusqueda() As String
    Public VGSaldoLib As String = ""
    Public VGNControl As String = ""
    Public VGNSolicit As String = ""
    Public VGNCausa As String = ""
    Public VGNivelMaximo As String = ""
    Public VGCtaGerencia As String = ""
    Public VGFormatoFecha As String = ""
    Public VGDebug As Integer = 0
    Public VGAyuda() As String
    Public VGCodPais As String = ""
    Public VGManejaNdNc As String = ""
    Public VGLineaPend As String = ""
    Public VGcategoria As String = ""
    Public VGprofinal As String = ""
    Public VGCancelar As String = ""
    Public VGCausal As String = ""
    Public VGCatCausal As String = ""
    Public VGLogTransacciones As String = ""
    Public sqlconn As Integer = 0
    Public ServerName As String = ""
    Public ServerNameLocal As String = ""
    Public VGLogin As String = ""
    Public Password As String = ""
    Public DatabaseName As String = ""
    Public HostName As String = ""
    Public Const VGMaximoRows As Integer = 21
    Public Const VGMaxRows As Integer = 20
    Public VGMascaraTarjeta As String = ""
    Public VGComentario As String = ""
    Public VGMontoVerCheque As Decimal = 0
    'Public VGFBusCliente As BClientes.BuscarClientes  JTA DLL Clientes
    Public VGFBusCliente As COBISCorp.tCOBIS.BClientes.BuscarClientes
    Public VGCuenta As String = ""
    Public VGNombreCuenta As String = ""
    Public VGImpresora As String = ""
    Public VGPerfilCta As String = ""
    Public VGMascaraConta As String = ""
    Public Const VGTablaDigito As String = "716759534743413729231917130703"
    Public VGNombreLargoBanco As String = ""
    Public VGNombreCortoBanco As String = ""
    Public VGDireccionElectro As String = ""
    Public VGDominio As String = ""
    Public VGFonoBanex As String = ""
    Public VGLOGO As String = ""
    Public VGPlazo As String = ""
    Public VGDeposito As String = ""
    Public VGPeriodicidad As String = ""
    Public VGPuntos As String = ""
    Public VGMontoFinal As String = ""
    Public VGContractual As String = ""
    Public VGProgresivo As String = ""
    Public VGEstado As String = ""
    Public VGOrigen As String = ""
    Public VGProdFinal As String = ""
    Public VGOcucol As String = ""
    ' Public FMain As FPrincipalClass

    Public Sub PMBloqueaGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread)
        If parSSControl.MaxRows > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 1
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.BlockMode = True
            parSSControl.Lock = True
            parSSControl.BlockMode = False
            parSSControl.Row = parSSControl.ActiveRow
        End If
    End Sub
    Public Sub CargaFormatoFecha()
        Select Case VGFormatoFechaStr.ToLower
            Case "dd/mm/yyyy"
                VGFecha_SP = "103"
            Case "mm/dd/yyyy"
                VGFecha_SP = "101"
            Case "yyyy/mm/dd"
                VGFecha_SP = "111"
            Case "dd-mm-yyyy"
                VGFecha_SP = "105"
        End Select
    End Sub
    Public Sub PMMarcaFilaCobisGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISGrid, ByRef parRow As Integer) '(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread, ByRef parRow As Integer)
        Dim VTsCtlType As String = parSSControl.GetType().Name
        If VTsCtlType = "COBISGrid" Then
            If parRow > -1 Then
                parSSControl.Col = 0
                parSSControl.SelStartCol = 1
                parSSControl.SelEndCol = parSSControl.Cols - 1
                parSSControl.SelStartRow = parSSControl.Row
                parSSControl.SelEndRow = parSSControl.Row
                'parSSControl.BackColor = SystemColors.Info

            End If
        End If
    End Sub

    Public Sub PMMarcaFilaGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread, ByRef parRow As Integer)
        If parRow > -1 Then
            parSSControl.Col = 1
            parSSControl.Row = 1
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.BlockMode = True
            parSSControl.BackColor = SystemColors.Window
            parSSControl.BlockMode = False
            parSSControl.Col = 1
            parSSControl.Row = parSSControl.ActiveRow
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.Row2 = parSSControl.ActiveRow
            parSSControl.BlockMode = True
            parSSControl.BackColor = SystemColors.Highlight
            parSSControl.BlockMode = False
        End If
    End Sub

    Function FMChequeaCtaAho(ByRef Cuenta As String) As Integer
        If Cuenta.Length < VGLongCtaAho Then
            Return False
        End If
        If Not FMCuenta_Cobis(Cuenta) Then
            Return True
        End If
        Dim VTSum As Integer = 0
        Dim j As Integer = 1
        For i As Integer = (VGLongCtaAho - Cuenta.Length + 1) To VGLongCtaAho - 1
            VTSum += Conversion.Val(Strings.Mid(Cuenta, j, 1)) * Conversion.Val(Strings.Mid(VGPesosCtaAho, i, 1))
            j += 1
        Next i
        Dim VTModulo As Integer = VTSum Mod VGModuloCtaAho
        VTModulo = VGModuloCtaAho - VTModulo
        If VTModulo >= 10 Then
            VTModulo = 0
        End If
        If VTModulo <> Conversion.Val(Strings.Mid(Cuenta, VGLongCtaAho, 1)) Then
            Return False
        Else
            Return True
        End If
    End Function

    Function FMChequeaCtaCte(ByRef Cuenta As String) As Boolean
        Dim VTSum As Integer = 0
        Dim j As Integer = 0
        Dim VTModulo As Integer = 0
        If Cuenta.Length < VGLongCtaCte Then
            Return False
        End If
        If Not FMCuenta_Cobis(Cuenta) Then
            Return True
        End If
        If Conversion.Val(Strings.Mid(Cuenta, 6, 5)) < Conversion.Val(VGCteAbanks) Then
            VTSum = 0
            j = 1
            For i As Integer = (VGLongCtaCte - Cuenta.Length + 1) To VGLongCtaCte - 1
                VTSum += Conversion.Val(Strings.Mid(Cuenta, j, 1)) * Conversion.Val(Strings.Mid("3298765432", i, 1))
                j += 1
            Next i
            VTModulo = VTSum - (VTSum / 11 - 0.5) * 11
            VTModulo = Conversion.Val(Strings.Mid(Cuenta, VGLongCtaCte, 1))
            Return True
        End If
        VTSum = 0
        j = 1
        For i As Integer = (VGLongCtaCte - Cuenta.Length + 1) To VGLongCtaCte - 1
            VTSum += Conversion.Val(Strings.Mid(Cuenta, j, 1)) * Conversion.Val(Strings.Mid(VGPesosCtaCte, i, 1))
            j += 1
        Next i
        VTModulo = VTSum Mod VGModuloCtaCte
        VTModulo = VGModuloCtaCte - VTModulo
        If VTModulo >= 10 Then
            VTModulo = 0
        End If
        If VTModulo <> Conversion.Val(Strings.Mid(Cuenta, VGLongCtaCte, 1)) Then
            Return False
        Else
            Return True
        End If
    End Function

    Function FMChequeaTarjeta(ByRef tarjeta As String) As Integer
        Dim VTProducto As Integer = 0
        Dim VTSum As Integer = 0
        Dim VTFactores As String = "12121212121212121212"
        Dim VTLngpan As Integer = tarjeta.Length
        Dim VTLngfac As Integer = VTFactores.Length
        VTFactores = Strings.Mid(VTFactores, VTLngfac - VTLngpan + 2, VTLngfac)
        For i As Integer = 1 To VTLngpan - 1
            VTProducto = Conversion.Val(Strings.Mid(tarjeta, i, 1)) * Conversion.Val(Strings.Mid(VTFactores, i, 1))
            If VTProducto < 10 Then
                VTSum += VTProducto
            Else
                VTSum = VTSum + VTProducto \ 10 + VTProducto Mod 10
            End If
        Next i
        Dim VTModulo As Integer = VTSum Mod 10
        If VTModulo <> 0 Then
            VTModulo = 10 - VTModulo
        End If
        If VTModulo <> Conversion.Val(Strings.Mid(tarjeta, VTLngpan, 1)) Then
            Return False
        Else
            Return True
        End If
    End Function

    Function FMMascara(ByRef Variable As String, ByRef Mascara As String) As String
        Dim j As Integer = 0
        Dim VTDigito As String = ""
        Dim VTtxt As New StringBuilder
        If Variable = "" Then
            For i As Integer = 1 To Mascara.Length
                If Strings.Mid(Mascara, i, 1) = "#" Then
                    VTtxt.Append("_")
                ElseIf Strings.Mid(Mascara, i, 1) <> "." Then
                    VTtxt.Append("-")
                Else
                    VTtxt.Append(".")
                End If
            Next i
        Else
            j = 1
            For i As Integer = 1 To Mascara.Length
                If Strings.Mid(Mascara, i, 1) = "#" Then
                    VTDigito = Strings.Mid(Variable, j, 1)
                    If VTDigito <> "" Then
                        VTtxt.Append(VTDigito)
                    Else
                        VTtxt.Append("_")
                    End If
                    j += 1
                ElseIf Strings.Mid(Mascara, i, 1) <> "." Then
                    VTtxt.Append("-")
                Else
                    VTtxt.Append(".")
                End If
            Next i
        End If
        Return VTtxt.ToString()
    End Function

    Function FMVAlidaTipoDato(ByRef TipoDato As String, ByRef valor As Integer) As Integer
        Dim result As Integer = 0
        result = valor
        Select Case TipoDato
            Case "N"
                If (valor <> 8) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "A"
                If (valor <> 8) And ((valor < 65) Or (valor > 90)) And (valor <> 241) And (valor <> 209) And ((valor < 97) Or (valor > 122)) And (valor <> 32) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
            Case "S"
                If valor = 32 Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
            Case "B"
                result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
            Case "M"
                If (valor <> 8) And (valor <> 46) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "U"
                If (valor <> 8) And (valor <> 32) And (valor <> 241) And ((valor < 48) Or (valor > 57)) And ((valor < 96) Or (valor > 122)) And ((valor < 65) Or (valor > 90)) And (valor <> 209) Then
                    result = 0
                Else
                    result = Strings.AscW(Strings.Chr(valor).ToString().ToUpper())
                End If
        End Select
        Return result
    End Function

    Function FMVerificar_WinIni() As Integer
        Dim result As Integer = 0
        Dim VTFechaPref As String = String.Empty
        Dim VTMsg As String = String.Empty
        Dim VTProblema As Integer = False
        result = False
        Select Case VGFormatoFecha
            Case "mm/dd/yyyy"
                VTFechaPref = "MM/dd/yyyy"
            Case "dd/mm/yyyy"
                VTFechaPref = "dd/MM/yyyy"
            Case Else
                VTFechaPref = "yyyy/MM/dd"
        End Select
        Dim VTMillar As String = New String(Strings.Chr(32), 255)
        Dim VTDecimal As String = New String(Strings.Chr(32), 255)
        Dim VTFormatoFecha As String = New String(Strings.Chr(32), 255)
        Dim VTRetval As String = FMGetSeparadorMiles()
        If VTRetval = "" Then
            VTMsg = FMLoadResString(502458)
            COBISMessageBox.Show(VTMsg, FMLoadResString(500272), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        VTMillar = VTRetval
        If VTMillar <> "," Then VTProblema = True
        VTRetval = FMGetSeparadorDecimales()
        If VTRetval = "" Then
            VTMsg = FMLoadResString(502459)
            COBISMessageBox.Show(VTMsg, FMLoadResString(500272), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        VTDecimal = VTRetval
        If VTDecimal <> "." Then VTProblema = True
        VTRetval = FMGetFormatoFecha()
        If VTRetval = "" Then
            VTMsg = FMLoadResString(502460)
            COBISMessageBox.Show(VTMsg, FMLoadResString(500272), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        VTFormatoFecha = VTRetval
        If VTFormatoFecha <> VTFechaPref Then VTProblema = True
        If VTProblema Then
            VTProblema = False
            VTMsg = FMLoadResString(502461)
            VTMsg = VTMsg & FMLoadResString(502462) & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & FMLoadResString(502463)
            VTMsg = VTMsg & FMLoadResString(502464) & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & FMLoadResString(502465)
            VTMsg = VTMsg & Strings.Chr(13).ToString() & FMLoadResString(502466)
            VTMsg = VTMsg & Strings.Chr(13).ToString() & FMLoadResString(502467) & VTFechaPref
            COBISMessageBox.Show(VTMsg, FMLoadResString(500273), COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            VTProblema = True
        End If
        Return Not VTProblema
    End Function

    Function FMCuenta_Cobis(ByRef par_cta As String) As Boolean
        For i As Integer = 1 To VGMaxPrefijos
            If VGPrefijo_cta(2, i) = Strings.Mid(par_cta, 3, VGPrefijo_cta(2, i).Length) Then
                Return True
            End If
        Next i
        Return False
    End Function

    Sub PMCatalogo(ByRef tipo As String, ByRef Tabla As String, ByRef ObjetoA As Object, ByRef ObjetoB As Label)
        FRegistros = New FRegistrosClass
        Select Case tipo
            Case "A"
                VGPaso = True
                'Dim tempLoadForm As FRegistrosClass = FRegistros
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(5288)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    'PMMapeaTextoGrid(FRegistros.grdRegistros)
                    PMAnchoColumnasGrid(FRegistros.grdRegistros)
                    PMChequea(sqlconn)
                    FRegistros.ShowPopup()
                    If VGACatalogo.Codigo <> "" Then ObjetoA.Text = VGACatalogo.Codigo
                    If VGACatalogo.Descripcion <> "" Then ObjetoB.Text = VGACatalogo.Descripcion
                    FRegistros.Dispose() '18/05/2016 migracion
                Else
                    PMChequea(sqlconn)
                End If
            Case "V"
                If ObjetoA.Text <> System.String.Empty Then
                    PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                    PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                    PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, ObjetoA.Text)
                    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                    If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(502692) & "[" & ObjetoA.Text & "]") Then
                        PMMapeaObjeto(sqlconn, ObjetoB)
                        PMChequea(sqlconn)
                    Else
                        PMChequea(sqlconn)
                        VGPaso = True
                        ObjetoA.Text = ""
                        ObjetoB.Text = ""
                        If ObjetoA.Enabled <> False Then 'JSA
                            If ObjetoA.Enabled = True Then ObjetoA.Focus()
                        End If
                    End If
                End If
            Case "D"
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "D")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                    PMMapeaObjetoAB(sqlconn, ObjetoA, ObjetoB)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    ObjetoA.Text = ""
                    ObjetoB.Text = ""
                End If
            Case "CTA"
                PMPasoValores(sqlconn, "@i_ctaint", 0, SQLINT2, "0")
                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "206")
                PMPasoValores(sqlconn, "@i_codcliente", 0, SQLVARCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_cta", 0, SQLVARCHAR, "")
                PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
                PMPasoValores(sqlconn, "@i_relacionada", 0, SQLCHAR, "S")
                PMPasoValores(sqlconn, "@i_consulta", 0, SQLCHAR, "S")
                'PMPasoValores(sqlconn, "@i_trn", 0, SQLINT2, Convert.ToString(Me.Tag))
                If FMTransmitirRPC(sqlconn, ServerName, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, "") Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMMapeaTextoGrid(FRegistros.grdRegistros)
                    PMAnchoColumnasGrid(FRegistros.grdRegistros)
                    PMChequea(sqlconn)
                    FRegistros.ShowPopup()
                    If VGACatalogo.Codigo <> "" Then ObjetoA.Text = VGACatalogo.Codigo
                    If VGACatalogo.Descripcion <> "" Then ObjetoB.Text = VGACatalogo.Descripcion
                    FRegistros.Dispose()
                Else
                    PMChequea(sqlconn)
                End If
        End Select
    End Sub

    Sub PMLimpiaGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISGrid)
        grdGrid.Rows = 2
        grdGrid.Cols = 2
        For i As Integer = 0 To 1
            grdGrid.Col = CShort(i)
            For j As Integer = 0 To 1
                grdGrid.Row = CShort(j)
                grdGrid.CtlText = ""
            Next j
        Next i
        grdGrid.Tag = ""
        'grdGrid.ColWidth(0) = 480
        'grdGrid.ColWidth(1) = 480
    End Sub

    Sub PMLogOff()
        Dim VTTemporal As String = ""
        If sqlconn <> 0 Then
            'FPrincipal.VGHook = Nothing
            PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "1502")
            PMPasoValores(sqlconn, "@i_server", 0, SQLVARCHAR, ServerNameLocal)
            PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, VGLogin)
            If FMTransmitirRPC(sqlconn, ServerName, "master", "sp_endlogin", False, "") Then
                PMMapeaVariable(sqlconn, VTTemporal)
                PMChequea(sqlconn)
                Escribir_Ini(ARCHIVOINI)
                SqlClose(sqlconn)
                sqlconn = 0
                COBISMessageBox.Show(FMLoadResString(509174) & ServerNameLocal, FMLoadResString(501312), COBISMessageBox.COBISButtons.OK)
            Else
                PMChequea(sqlconn)
                SqlClose(sqlconn)
                COBISMessageBox.Show(FMLoadResString(509175), FMLoadResString(501312), COBISMessageBox.COBISButtons.OK)
                Escribir_Ini(ARCHIVOINI)
                sqlconn = 0
            End If
        End If
        If Not (VGFBusCliente Is Nothing) Then
            VGFBusCliente = Nothing
        End If
        ' FPrincipal.Text = My.Application.Info.Title
    End Sub

    Sub PMOrdenaGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISGrid, ByRef TipoDato As String, ByRef columna As Integer, ByRef Orden As String)
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim ValorI As Integer = 0
        Dim ValorJ As Integer = 0
        Dim valor As Integer = 0
        Dim VTFilas As Integer = grdGrid.Rows
        Dim VTColumnas As Integer = grdGrid.Cols
        Dim VTArray(VTFilas, VTColumnas) As String
        Dim VTVector(VTColumnas) As String
        Cursor.Current = System.Windows.Forms.Cursors.WaitCursor
        For i = 1 To VTFilas - 1
            grdGrid.Row = i
            For j = 1 To VTColumnas - 1
                grdGrid.Col = j
                VTArray(i, j) = grdGrid.CtlText
            Next j
        Next i
        i = 1
        j = 2
        While i < VTFilas
            Select Case TipoDato
                Case "N"
                    ValorI = Conversion.Val(VTArray(i, columna))
                Case "A", "D"
                    ValorI = CInt(VTArray(i, columna))
                Case "M"
                    ValorI = CDec(VTArray(i, columna))
            End Select
            While j < VTFilas
                Select Case TipoDato
                    Case "N"
                        ValorJ = Conversion.Val(VTArray(j, columna))
                    Case "A", "D"
                        ValorJ = CInt(VTArray(j, columna))
                    Case "M"
                        ValorJ = CDec(VTArray(j, columna))
                End Select
                If Orden = "D" Then
                    valor = ValorJ
                    ValorJ = ValorI
                    ValorI = valor
                End If
                If ValorI > ValorJ Then
                    For X As Integer = 1 To VTColumnas - 1
                        VTVector(X) = VTArray(j, X)
                    Next X
                    For X As Integer = 1 To VTColumnas - 1
                        VTArray(j, X) = VTArray(i, X)
                    Next X
                    For X As Integer = 1 To VTColumnas - 1
                        VTArray(i, X) = VTVector(X)
                    Next X
                    Select Case TipoDato
                        Case "N"
                            ValorI = Conversion.Val(VTArray(i, columna))
                        Case "A", "D"
                            ValorI = CInt(VTArray(i, columna))
                        Case "M"
                            ValorI = CDec(VTArray(i, columna))
                    End Select
                End If
                j += 1
            End While
            i += 1
            j = i + 1
        End While
        For i = 1 To VTFilas - 1
            grdGrid.Row = i
            For j = 1 To VTColumnas - 1
                grdGrid.Col = j
                grdGrid.CtlText = VTArray(i, j)
            Next j
        Next i
        Cursor.Current = System.Windows.Forms.Cursors.Default
    End Sub

    Sub PLAjustaGrid(ByRef Celdas As COBISCorp.Framework.UI.Components.COBISGrid, ByRef Ventana As Object)
        Dim ancho As Integer = 0
        Dim VTWidth As Integer = 0
        For i As Integer = 1 To Celdas.Cols - 1
            ancho = 0
            For j As Integer = 0 To Celdas.Rows - 1
                Celdas.Row = j : Celdas.Col = i
                VTWidth = Ventana.TextWidth(Celdas.CtlText) ' VTWidth = Compatibility.VB6.PixelsToTwipsX(Ventana.CreateGraphics().MeasureString(Celdas.CtlText, Ventana.Font).Width)
                If VTWidth > ancho Then ancho = VTWidth
            Next j
            Celdas.ColWidth(CShort(i)) = IIf(ancho <= 0, 100, CInt(ancho - 0.15 * ancho))
        Next i
    End Sub

    Sub PMAnchoColGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid, ByRef col As Integer)
        lista1.Col = col
        Dim VTColmax As Integer = 5
        For i As Integer = 0 To lista1.Rows - 1
            lista1.Row = i
            If lista1.CtlText.TrimEnd().Length > VTColmax Then
                VTColmax = Strings.Len(lista1.CtlText)
            End If
        Next i
        VTColmax *= 110
        lista1.ColWidth(CShort(col)) = VTColmax
    End Sub

    Sub PMAjustaColsGrid(ByRef grdGrid As COBISCorp.Framework.UI.Components.COBISSpread)
        Dim VTColmax As Integer = 0
        For i As Integer = 0 To grdGrid.MaxCols - 1
            grdGrid.Col = i
            VTColmax = 4
            For j As Integer = 0 To grdGrid.MaxRows - 1
                grdGrid.Row = j
                If grdGrid.Text.TrimEnd().Length > VTColmax Then
                    VTColmax = Strings.Len(grdGrid.Text)
                End If
            Next j
            grdGrid.ColWidth(i) = VTColmax
        Next i
    End Sub


    Sub PMCargar_FechaSP(ByRef Formato As String)
        For i As Integer = 1 To formato_fecha.GetUpperBound(0)
            If formato_fecha(i, 1) = Formato Then
                VGFecha_SP = formato_fecha(i, 2)
                VGFecha_Pref = Formato
            End If
        Next
    End Sub

    Sub FMCabeceraReporte(ByRef NomBanco As String, ByRef FechaEmision As String, ByRef TituloReporte As String, ByRef HoraEmision As String, ByRef ProgFuente As String, ByRef FechaSistema As String, ByRef NumPagina As String)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier New"
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 10
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        Dim TempDate As Date = DateTime.Now
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), NomBanco, FileSystem.TAB(60), FMLoadResString(502435), IIf(DateTime.TryParse(FechaEmision, TempDate), TempDate.ToString(FMLoadResString(509177)), FechaEmision))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(60), FMLoadResString(502437), HoraEmision)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), TituloReporte)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        Dim TempDate2 As Date = DateTime.Now
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(502438), IIf(DateTime.TryParse(FechaSistema, TempDate2), TempDate2.ToString(FMLoadResString(509177)), FechaSistema), FileSystem.TAB(60))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  " & New String("_", 94))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
    End Sub

    Sub FMCabeceraReporteSob(ByRef NomBanco As String, ByRef FechaEmision As String, ByRef TituloReporte As String, ByRef HoraEmision As String, ByRef ProgFuente As String, ByRef FechaSistema As String, ByRef NumPagina As String)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontName = "Courier New"
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentX = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.CurrentY = 0
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontSize = 7
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = True
        Dim TempDate As Date = DateTime.Now
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), NomBanco, FileSystem.TAB(125), FMLoadResString(502435), IIf(DateTime.TryParse(FechaEmision, TempDate), TempDate.ToString(FMLoadResString(509177)), FechaEmision))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(125), FMLoadResString(502437), HoraEmision)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), TituloReporte)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        Dim TempDate2 As Date = DateTime.Now
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print(FileSystem.TAB(5), FMLoadResString(502438), IIf(DateTime.TryParse(FechaSistema, TempDate2), TempDate2.ToString(FMLoadResString(509177)), FechaSistema), FileSystem.TAB(147), FMLoadResString(509178), NumPagina)
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("  " & New String("_", 150))
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.Print("")
        COBISCorp.Framework.UI.Components.COBISPrinterNet.DefInstance.FontBold = False
    End Sub

    Public Sub PMGetDefault(ByRef parOficina As String, ByRef parTabla As String, ByRef parVal As String, ByRef parDes As String)
        Dim VTVal As String = ""
        Dim VTDes As String = ""
        Try
            VTVal = ""
            VTDes = ""
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "D")
            PMPasoValores(sqlconn, "@i_tabla", 0, SQLVARCHAR, parTabla)
            PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, parOficina)
            Dim VTArreglo(10) As String
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                FMMapeaArreglo(sqlconn, VTArreglo)
                PMChequea(sqlconn)
                VTVal = VTArreglo(1)
                VTDes = VTArreglo(2)
            Else
                PMChequea(sqlconn)
            End If
        Catch
        End Try
        parVal = VTVal
        parDes = VTDes
    End Sub

    Public Sub PMBorrarGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread)
        If parSSControl.MaxRows > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 0
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.BlockMode = True
            parSSControl.Action = COBISCorp.Framework.UI.Components.ActionConstants.ActionClearText
            parSSControl.BlockMode = False
            parSSControl.MaxRows = 0
        End If
    End Sub

    Public Sub PMOrdenarGrid(ByRef Celdas As COBISCorp.Framework.UI.Components.COBISGrid, ByRef columna As Integer)
        Dim i As Integer = 0
        Dim j As Integer = 0
        Dim VLPosGrid As Integer = 0
        Dim VLValorMin As String = ""
        Dim VLPos As Integer = 0
        Dim VLValorInter As String = String.Empty
        Dim VLClip As String = String.Empty
        i = Celdas.Rows - 1
        Celdas.Col = columna
        VLPosGrid = 1
        While i >= 1
            j = i - 1
            Celdas.Row = i
            VLValorMin = Strings.Right(New String("0", 30) & Celdas.CtlText.TrimStart(), 30)
            VLPos = i
            While j >= 1
                Celdas.Row = j
                VLValorInter = Strings.Right(New String("0", 30) & Celdas.CtlText.TrimStart(), 30)
                If VLValorInter < VLValorMin Then
                    VLValorMin = Strings.Right(New String("0", 30) & Celdas.CtlText.TrimStart(), 30)
                    VLPos = j
                End If
                j -= 1
            End While
            Celdas.SelStartCol = 1
            Celdas.SelEndCol = Celdas.Cols - 1
            Celdas.SelStartRow = VLPos
            Celdas.SelEndRow = VLPos
            VLClip = Celdas.Clip
            Celdas.RemoveItem(CShort(VLPos))
            Celdas.AddItem(Conversion.Str(VLPosGrid) & ChrW(9) & VLClip)
            i -= 1
            VLPosGrid += 1
        End While
    End Sub



    Public Function FMSeleccionarPrinter() As Boolean
        Dim result As Boolean = False
        FPrint.ShowPopup()
        If VGImpresora <> "" Then result = True
        Return result
    End Function

    Sub GeneraDatosGrid_Excel(ByRef grilla As COBISCorp.Framework.UI.Components.COBISGrid, ByRef svTitulo As String)
        Try
            Dim XlsApl As Excel.Application
            Dim xlsLibro As Excel.Workbook
            Dim xlhoja As Excel.Worksheet
            Dim valor As String = String.Empty
            Dim CGFORMATOFECHA As String = ""
            XlsApl = New Excel.Application()
            XlsApl.Caption = svTitulo
            XlsApl.WindowState = Excel.XlWindowState.xlMinimized
            XlsApl.Workbooks.Add()
            xlsLibro = XlsApl.ActiveWorkbook
            xlhoja = xlsLibro.Worksheets.Add()
            xlhoja.Name = svTitulo
            xlsLibro.Worksheets(svTitulo).Activate()
            grilla.Row = 0
            XlsApl.Columns("A:A", Type.Missing).Select()
            XlsApl.Selection.NumberFormat = "@"
            For Fil As Integer = 0 To grilla.Rows - 1
                COBISCorp.eCOBIS.COBISExplorer.Container.COBISContainer.ShowHelpLine(FMLoadResString(500274) & Fil & "] de " & CStr(grilla.Rows - 1) & " ...")
                grilla.Row = Fil
                For col As Integer = 1 To grilla.Cols - 1
                    grilla.Col = col
                    valor = grilla.CtlText
                    If FMConvFecha(valor, VGFecha_Pref, CGFORMATOFECHA) <> "" Then
                        xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, col).Value2 = "'" & grilla.CtlText
                    Else
                        xlsLibro.Worksheets(svTitulo).Cells(Fil + 1, col).Value2 = grilla.CtlText
                    End If
                Next
                If Fil = 0 Then
                    xlsLibro.Worksheets(svTitulo).Rows("1:1", Type.Missing).Select()
                    XlsApl.Selection.Interior.ColorIndex = 37
                    XlsApl.Selection.Interior.Pattern = Excel.Constants.xlSolid
                    XlsApl.Selection.Font.Bold = True
                    XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
                    XlsApl.Cells.Select()
                    XlsApl.Range("E1").Activate()
                    XlsApl.Cells.EntireColumn.AutoFit()
                End If
            Next
            XlsApl.Visible = True
            XlsApl.WindowState = Excel.XlWindowState.xlMaximized
            XlsApl.Selection.Borders(Excel.XlBordersIndex.xlInsideVertical).LineStyle = Excel.Constants.xlNone
            XlsApl.Cells.Select()
            XlsApl.Range("E1").Activate()
            XlsApl.Cells.EntireColumn.AutoFit()
        Catch excep As System.Exception
            COBISMessageBox.Show(CStr(Information.Err().Number) & " - " & excep.Message, My.Application.Info.ProductName, COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Information)
            Exit Sub
        End Try
    End Sub

    ''Sub PMCreaNumCta()
    '' Dim VGNumcta As String = ""
    '' Dim VLProducto As Integer = 0
    '    If VGProducto = "CTE" Then
    '        VLProducto = 3
    '    Else
    '        VLProducto = 4
    '    End If
    '    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "417")
    '    PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
    '    PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
    '    PMPasoValores(sqlconn, "@i_producto", 0, SQLINT1, CStr(VLProducto))
    '    PMPasoValores(sqlconn, "@i_secucta", 0, SQLINT4, VGNumcta)
    '    If VLProducto = 3 Then
    '    Else
    '        If VGOnline Then
    '            PMPasoValores(sqlconn, "@i_tipo_cta", 0, SQLINT1, FTran201.txtCampo(8).Text.Trim())
    '        Else
    '        End If
    '    End If
    '    PMPasoValores(sqlconn, "@i_mon", 0, SQLINT1, VGMoneda)
    '    PMPasoValores(sqlconn, "@o_cta_banco", 1, SQLVARCHAR, "0")
    '    If FMTransmitirRPC(sqlconn, ServerNameLocal, "cob_remesas", "sp_crea_num_cta", True, " Ok... Creacion de Numero de Cuenta") Then
    '        PMMapeaVariable(sqlconn, VGCuenta)
    '        PMChequea(sqlconn)
    '    End If
    'End Sub

    Function FMValidaNit(ByRef Nit As String) As Integer
        Dim VTNumero As Integer = 0
        Dim VTN As Integer = 0
        Dim VTConstante As Integer = 0
        Dim VTDigOr As Integer = Conversion.Val(Strings.Right(Nit.TrimEnd(), 1))
        Dim VTNit As String = Strings.Left(Nit.Trim(), Nit.Trim().Length - 1)
        Dim VTSuma As Integer = 0
        For i As Integer = VTNit.Length To 1 Step -1
            VTNumero = Conversion.Val(Strings.Mid(VTNit, i, 1))
            VTN = i + 15 - VTNit.Length
            VTConstante = Conversion.Val(Strings.Mid(VGTablaDigito, 2 * VTN, 1)) + 10 * Conversion.Val(Strings.Mid(VGTablaDigito, 2 * VTN - 1, 1))
            VTSuma += VTNumero * VTConstante
        Next i
        Dim VTDig As Integer = VTSuma Mod 11
        If VTDig > 1 Then
            VTDig = 11 - VTDig
        End If
        Return VTDigOr = VTDig
    End Function

    Public Sub PMValida_TipoDoc(ByRef TipoDoc As String, ByRef SubTipo As String)
        VGMTipoDoc(1) = ""
        TipoDoc = TipoDoc.Trim().ToUpper()
        If TipoDoc <> "" Then
            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "1115")
            PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
            PMPasoValores(sqlconn, "@i_subtipo", 0, SQLVARCHAR, SubTipo)
            PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, TipoDoc)
            If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_tipodoc", True, FMLoadResString(508924)) Then
                FMMapeaArreglo(sqlconn, VGMTipoDoc)
                PMChequea(sqlconn)
            Else
                PMChequea(sqlconn)
            End If
        End If
    End Sub

    Function FMGet_Numero(ByRef Token As String) As String
        Dim Aux As New StringBuilder
        For i As Integer = 1 To Token.Length
            Dim dbNumericTemp As Double = 0
            If Double.TryParse(Strings.Mid(Token, i, 1), NumberStyles.Number, CultureInfo.CurrentCulture.NumberFormat, dbNumericTemp) Then
                Aux.Append(Strings.Mid(Token, i, 1))
            End If
        Next i
        Return Aux.ToString()
    End Function
    Sub PMAnchoColumnasGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISSpread, ByRef col As Integer)

        lista1.Col = col
        Dim VTColmax As Integer = 5
        For i As Integer = 0 To lista1.MaxRows - 1
            lista1.Row = i
            If lista1.Text.TrimEnd().Length > VTColmax Then
                VTColmax = Strings.Len(lista1.Text)
            End If
        Next i
        VTColmax *= 110
        lista1.ColWidth(CShort(col)) = VTColmax
    End Sub
    Sub PMAnchoColumnasGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid)
        For j As Integer = 0 To lista1.Cols - 1
            lista1.Col = j
            Dim VTColmax As Integer = 5
            For i As Integer = 0 To lista1.Rows - 1
                lista1.Row = i
                If lista1.CtlText.TrimEnd().Length > VTColmax Then
                    VTColmax = Strings.Len(lista1.CtlText)
                End If
            Next i

            If (VTColmax <= 10) Then 'Para columnas de length 10, se multiplica por un número mayor
                VTColmax *= 130
            Else
                VTColmax *= 120
            End If

            lista1.ColWidth(CShort(j)) = VTColmax
        Next j
    End Sub
    Sub PMAnchoColumnasGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISSpread)
        For j As Integer = 0 To lista1.MaxCols + 1
            lista1.Col = j
            Dim VTColmax As Integer = 5
            For i As Integer = 0 To lista1.MaxRows
                lista1.Row = i
                If lista1.Text.TrimEnd().Length > VTColmax Then
                    VTColmax = Strings.Len(lista1.Text)
                End If
            Next i

            If (VTColmax <= 10) Then 'Para columnas de length 10, se multiplica por un número mayor
                VTColmax *= 130
            Else
                VTColmax *= 120
            End If

            lista1.ColWidth(CShort(j)) = VTColmax
        Next j
    End Sub
End Module


