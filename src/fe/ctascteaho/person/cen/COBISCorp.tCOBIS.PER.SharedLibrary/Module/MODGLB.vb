Option Strict Off
Option Explicit On
Imports Microsoft.VisualBasic
Imports System
Imports System.Drawing
Imports System.Text
Imports System.Windows.Forms
Imports COBISCorp.eCOBIS.Commons.MessageBox
Public Module MODGLB
    Public VGDecimales As String = ""
    Public VGPaso As Integer = 0
    Public VGConsulta As Integer = 0
    Public VGOperacion As String = ""
    Public VServicioP As String = ""
    Public VTipoRango As String = ""
    Public VGrupoRango As String = ""
    Public VGProducto As String = ""
    Public VGProductos() As String
    Public VGDetalle() As String
    Public VGTeclaAyuda As Integer = 0
    Public VGPersonaliza As Integer = 0
    Public VGCuenta As String = ""
    Public Const CGFormatoBase As String = "mm/dd/yyyy"
    Public VGValores(10) As String
    Public VGTipo As String = ""
    Public VGProd As String = ""
    Public VGFecha As String = ""
    Public VGFormatoFecha As String = ""
    Public VGForma As String = ""
    Public VGDebug As Integer = 0
    Public Y As Integer = 0
    Public VGPathResouces As String = ""
    Public VGTIMERMAIL As Integer = 0
    Public VGFormatoFechaStr As String = ""
    Public VGUsuario As String = ""
    Public VGFormatoFechaInt As Integer
    Public VGUsuarioNombre As String = ""
    Public VGFechaProceso As String
    Public VGIndice As Integer = 0
    Public VGListindex As Integer = 0
    Public VGRolCuenta As String = ""
    Public VGCteAbanks As String = ""
    Public VGCodPais As String = ""
    Public VGManejaNdNc As String = ""
    Public VGLineaPend As String = ""
    Public VGNumGCtaAho As Integer = 0

    Public Structure Empresa
        Dim Codigo As String
        Dim Nombre As String
        Dim Mascara As String
        Dim Sinonimo As String
        Dim Moneda As String
        Public Shared Function CreateInstance() As Empresa
            Dim result As New Empresa
            result.Codigo = String.Empty
            result.Nombre = String.Empty
            result.Mascara = String.Empty
            result.Sinonimo = String.Empty
            result.Moneda = String.Empty
            Return result
        End Function
    End Structure

    Public VGEmpresa As Empresa = Empresa.CreateInstance()

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
    Public VGMoneda As String = ""
    Public VGRol As String = ""
    Public VGLongCtaCte As Integer = 0
    Public VGLongCtaAho As Integer = 0
    Public VGNumGCtaCte As Integer = 0
    Public VGCtaGerencia As String = ""
    Public VGPesosCtaCte As String = ""
    Public VGPesosCtaAho As String = ""
    Public VGCodBanco As String = ""
    Public VGModuloCtaCte As Integer = 0
    Public VGModuloCtaAho As Integer = 0
    Public VGMascaraCtaCte As String = ""
    Public VGMascaraCtaAho As String = ""
    Public VGNivelMaximo As String = ""
    Public VGCorreo As Integer = 0
    Public VGPath As String = ""
    Public VGBusqueda() As String
    Public VGBanco As String = ""
    Public VGPais As String = ""
    Public VGLogTransacciones As String = ""
    Public sqlconn As Integer = 0
    Public ServerName As String = ""
    Public ServerNameLocal As String = ""
    Public VGLogin As String = ""
    Public Password As String = ""
    Public DatabaseName As String = ""
    Public HostName As String = ""
    Public Const VGMaximoRows As Integer = 16
    Public Const VGMaxRows As Integer = 15
    Public Const VTMaxRows As Integer = 20
    Public formato_fecha(,) As String
    Public VGFecha_SP As String = ""
    Public VGSucursalSig As Integer = 0
    Public PathUnico As String = ""
    Public VGMontoVerCheque As Decimal = 0
    Public VGPrefijo_cta(,) As String
    Public VGMaxPrefijos As Integer = 0
    Public VGComplementoCtaAho As String = ""

    Public Sub PMBorrarGrid(ByRef parSSControl As COBISCorp.Framework.UI.Components.COBISSpread)
        If parSSControl.MaxCols > 0 Then
            parSSControl.Row = 1
            parSSControl.Col = 0
            parSSControl.Row2 = parSSControl.MaxRows
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.BlockMode = True
            parSSControl.Action = 12
            parSSControl.BlockMode = False
            parSSControl.MaxRows = 0
        End If
        parSSControl.Tag = CStr(0)
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
            parSSControl.Row = parRow
            parSSControl.Col2 = parSSControl.MaxCols
            parSSControl.Row2 = parRow
            parSSControl.BlockMode = True
            parSSControl.BackColor = SystemColors.Info
            parSSControl.BlockMode = False
        End If
    End Sub

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

    Function FMValidarNumero(ByRef parValor As String, ByRef parLongitud As Integer, ByRef parcaracter As Integer, ByRef parNemonico As String) As Integer
        Dim CGTeclaMenos As Integer = 0
        Dim VTSeparadorDecimal As String = "."
        Dim VTDecimal As Integer = 2
        If parcaracter = CGTeclaMenos Then
            Return 0
        End If
        If VTDecimal > 0 Then
            If (parValor.IndexOf(VTSeparadorDecimal) + 1) >= (parLongitud + (VTDecimal) + 1) Then
                Return 0
            Else
                Return parcaracter
            End If
        Else
            If parValor.Length >= parLongitud Then
                Return 0
            Else
                Return parcaracter
            End If
        End If
    End Function

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

    Function FMCuenta_Cobis(ByRef par_cta As String) As Boolean
        For i As Integer = 1 To VGMaxPrefijos
            If VGPrefijo_cta(2, i) = Strings.Mid(par_cta, 3, VGPrefijo_cta(2, i).Length) Then
                Return True
            End If
        Next i
        Return False
    End Function

    'Function FMChequeaCtaAho(ByRef Cuenta As String) As Integer
    '    Dim VTProducto As Integer = 0
    '    If Cuenta.Length < VGLongCtaAho Then
    '        Return False
    '    End If
    '    Dim VTSum As Integer = 0
    '    Dim j As Integer = 1
    '    For i As Integer = (VGLongCtaAho - Cuenta.Length + 1) To VGLongCtaAho - 1
    '        VTProducto = Conversion.Val(Strings.Mid(Cuenta, j, 1)) * Conversion.Val(Strings.Mid(VGPesosCtaAho, i, 1))
    '        VTSum += VTProducto
    '        j += 1
    '    Next i
    '    Dim VTModulo As Integer = VTSum Mod VGModuloCtaAho
    '    If VTModulo = 0 Then
    '        VTModulo = 0
    '    Else
    '        If VTModulo = 1 Then
    '            VTModulo = 1
    '        Else
    '            VTModulo = VGModuloCtaAho - VTModulo
    '        End If
    '    End If
    '    If VTModulo <> Conversion.Val(Strings.Mid(Cuenta, VGLongCtaAho, 1)) Then
    '        Return False
    '    Else
    '        Return True
    '    End If
    'End Function

    'Function FMChequeaCtaCte(ByRef Cuenta As String) As Integer
    '    Dim VTProducto As Integer = 0
    '    If Cuenta.Length < VGLongCtaCte Then
    '        Return False
    '    End If
    '    Dim VTSum As Integer = 0
    '    Dim j As Integer = 1
    '    For i As Integer = (VGLongCtaCte - Cuenta.Length + 1) To VGLongCtaCte - 1
    '        VTProducto = Conversion.Val(Strings.Mid(Cuenta, j, 1)) * Conversion.Val(Strings.Mid(VGPesosCtaCte, i, 1))
    '        If VTProducto > 9 Then
    '            VTProducto = (IIf(VTProducto / 10 > 0, Math.Floor(VTProducto / 10), Math.Ceiling(VTProducto / 10))) + (VTProducto Mod 10)
    '        End If
    '        VTSum += VTProducto
    '        j += 1
    '    Next i
    '    Dim VTModulo As Integer = VTSum Mod VGModuloCtaCte
    '    If VTModulo = 0 Then
    '        VTModulo = 0
    '    Else
    '        VTModulo = VGModuloCtaCte - VTModulo
    '    End If
    '    If VTModulo <> Conversion.Val(Strings.Mid(Cuenta, VGLongCtaCte, 1)) Then
    '        Return False
    '    Else
    '        Return True
    '    End If
    'End Function

    Function FMMascara(ByRef Variable As String, ByRef Mascara As String) As String
        Dim j As Integer = 0
        Dim VTDigito As String = ""
        Dim VTtxt As New StringBuilder
        If Variable = "" Then
            For i As Integer = 1 To Mascara.Length
                If Strings.Mid(Mascara, i, 1) = "#" Then
                    VTtxt.Append("_")
                Else
                    VTtxt.Append("-")
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
                Else
                    VTtxt.Append("-")
                End If
            Next i
        End If
        Return VTtxt.ToString()
    End Function

    Function FMValidaTipoDato(ByRef TipoDato As String, ByRef valor As Integer) As Integer
        Dim result As Integer = 0
        result = valor
        Select Case TipoDato
            Case "N"
                If (valor <> 8) And ((valor < 48) Or (valor > 57)) Then
                    result = 0
                End If
            Case "A"
                If (valor <> 8) And ((valor < 65) Or (valor > 90)) And ((valor < 97) Or (valor > 122)) Then
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
        End Select
        Return result
    End Function

    Function FMVerificar_WinIni() As Integer
        Dim result As Integer = 0
        Dim VTFechaPref As String = String.Empty
        Dim VTMsg As String = ""
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
        VTMillar = FMGetSeparadorMiles()
        If VTMillar = "" Then
            VTMsg = "Archivo win.ini o entrada sThousand no encontrados."
            COBISMessageBox.Show(VTMsg, "ERROR - FMVerificar_WinIni", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        If VTMillar <> "," Then VTProblema = True
        VTDecimal = FMGetSeparadorDecimales()
        If VTDecimal = "" Then
            VTMsg = "Archivo win.ini o entrada sDecimal no encontrados."
            COBISMessageBox.Show(VTMsg, "ERROR - FMVerificar_WinIni", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        If VTDecimal <> "." Then VTProblema = True
        VTFormatoFecha = FMGetFormatoFecha()
        If VTFormatoFecha = "" Then
            VTMsg = "Archivo win.ini o entrada sShortDate no encontrados."
            COBISMessageBox.Show(VTMsg, "ERROR - FMVerificar_WinIni", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Error)
            Return result
        End If
        If VTFormatoFecha <> VTFechaPref Then VTProblema = True
        If VTProblema Then
            VTProblema = False
            VTMsg = "La configuración para números y fechas del Panel de Control de Windows es "
            VTMsg = VTMsg & "incompatible con las preferencias de COBIS - Personalización." & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "La configuración internacional del Panel de Control "
            VTMsg = VTMsg & "debe ser modificada." & Strings.Chr(13).ToString()
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Separador de miles : , "
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Separador de decimales : . "
            VTMsg = VTMsg & Strings.Chr(13).ToString() & "Formato de fecha : " & VTFechaPref
            COBISMessageBox.Show(VTMsg, "ERROR - Tesorería", COBISMessageBox.COBISButtons.OK, COBISMessageBox.COBISIcon.Exclamation)
            VTProblema = True
        End If
        Return Not VTProblema
    End Function

    Sub PMCatalogo(ByRef tipo As String, ByRef Tabla As String, ByRef ObjetoA As TextBox, ByRef ObjetoB As Label, ByRef FRegistros As Object)
        Select Case tipo
            Case "A"
                VGPaso = True
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "A")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1573)) Then
                    PMMapeaGrid(sqlconn, FRegistros.grdRegistros, False)
                    PMMapeaTextoGrid(FRegistros.grdRegistros)
                    PMChequea(sqlconn)
                    FRegistros.ShowPopup()
                    ObjetoA.Text = VGACatalogo.Codigo
                    ObjetoB.Text = VGACatalogo.Descripcion
                    FRegistros.Dispose() '18/05/2016 migracion
                Else
                    PMChequea(sqlconn)
                End If
            Case "V"
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "V")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_codigo", 0, SQLVARCHAR, ObjetoA.Text)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", True, FMLoadResString(1573) & "[" & ObjetoA.Text & "]") Then
                    PMMapeaObjeto(sqlconn, ObjetoB)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    VGPaso = True
                    ObjetoA.Text = ""
                    ObjetoB.Text = ""
                    ObjetoA.Focus()
                End If
            Case "D"
                PMPasoValores(sqlconn, "@i_tipo", 0, SQLCHAR, "D")
                PMPasoValores(sqlconn, "@i_tabla", 0, SQLCHAR, Tabla)
                PMPasoValores(sqlconn, "@i_filial", 0, SQLINT1, VGFilial)
                PMPasoValores(sqlconn, "@i_oficina", 0, SQLINT2, VGOficina)
                If FMTransmitirRPC(sqlconn, ServerName, "cobis", "sp_hp_catalogo", False, FMLoadResString(1573)) Then
                    PMMapeaObjetoAB(sqlconn, ObjetoA, ObjetoB)
                    PMChequea(sqlconn)
                Else
                    PMChequea(sqlconn)
                    ObjetoA.Text = ""
                    ObjetoB.Text = ""
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
        Dim LoginVG As String = String.Empty
        Dim VTTemporal As String = String.Empty
        VGCorreo = False
        PMPasoValores(sqlconn, "@t_trn", 0, SQLVARCHAR, "1502")
        PMPasoValores(sqlconn, "@i_server", 0, SQLVARCHAR, ServerNameLocal)
        PMPasoValores(sqlconn, "@i_login", 0, SQLVARCHAR, LoginVG)
        If FMTransmitirRPC(sqlconn, ServerName, "master", "sp_endlogin", False, FMLoadResString(1531)) Then
            PMMapeaVariable(sqlconn, VTTemporal)
            PMChequea(sqlconn)
            Escribir_Ini(ARCHIVOINI)
            COBISMessageBox.Show(FMLoadResString(1531) & ServerName, FMLoadResString(1473), COBISMessageBox.COBISButtons.OK)
            SqlExit()
            SqlWinExit()
            sqlconn = 0
        Else
            PMChequea(sqlconn)
            COBISMessageBox.Show(FMLoadResString(1295), FMLoadResString(1473), COBISMessageBox.COBISButtons.OK)
        End If
    End Sub

    Sub PMAnchoColGrid(ByRef lista1 As COBISCorp.Framework.UI.Components.COBISGrid, ByRef Col As Integer)
        lista1.Col = Col
        Dim VTColmax As Integer = 5
        For i As Integer = 0 To lista1.Rows - 1
            lista1.Row = i
            If lista1.CtlText.TrimEnd().Length > VTColmax Then
                VTColmax = Strings.Len(lista1.CtlText)
            End If
        Next i
        VTColmax *= 115
        lista1.ColWidth(CShort(Col)) = VTColmax
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

    Sub PMCargar_FechaSP(ByRef Formato As String)
        For i As Integer = 1 To formato_fecha.GetUpperBound(0)
            If formato_fecha(i, 1) = Formato Then
                VGFecha_SP = formato_fecha(i, 2)
            End If
        Next
    End Sub

    Public Sub PMDireccionPath()
        Try
            Dim cp As CopiaDir.CopiaDirectorios
            cp = New CopiaDir.CopiaDirectorios()
            PathUnico = cp.CreaDirectorios(My.Application.Info.DirectoryPath, My.Application.Info.AssemblyName, "PERSON.INI")
            If PathUnico = "" Then
                PathUnico = VGPath
            End If
        Catch excep As System.Exception
            COBISMessageBox.Show(FMLoadResString(1324) & " " & excep.Message, FMLoadResString(1020))
            PathUnico = My.Application.Info.DirectoryPath
        End Try
    End Sub
    Public Sub PMAgregarDecimal(ByRef grid As COBISCorp.Framework.UI.Components.COBISGrid, ByRef VTColumn As Integer)
        Dim VLLongitud As Integer
        Dim VLPosDeci As Integer
        For VTi As Integer = 1 To grid.Rows
            grid.Row = VTi
            grid.Col = VTColumn
            VLLongitud = 0
            If grid.CtlText <> "" And IsNumeric(grid.CtlText) Then
                VLLongitud = Len(grid.CtlText)
                VLPosDeci = InStr(grid.CtlText, ".") 'Si el punto(.) es el separador decimal
                If VLPosDeci = VLLongitud - 1 Then
                    grid.CtlText = grid.CtlText + "0" 'Se agrega 0 decimal a la derecha
                    VLPosDeci = 0
                End If
                VLPosDeci = InStr(grid.CtlText, ",") 'Si la coma(,) es el separador decimal
                If VLPosDeci = VLLongitud - 1 Then
                    grid.CtlText = grid.CtlText + "0" 'Se agrega 0 decimal a la derecha
                    VLPosDeci = 0
                End If
            End If
        Next VTi
    End Sub

    'Sub PMEmpresa()
    '    Dim COBISTool As ToolBar.ToolBar = New ToolBar.ToolBar
    '    COBISTool.Add()


    '    Dim ToolCmbEmpresa As COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISComboBoxTool = COBISCorp.eCOBIS.COBISExplorer.CompositeUI.COBISMenu.GetCOBISComboBoxTool("cmbEmpresa", "gprHerramienta")
    '    AddHandler ToolCmbEmpresa.ToolValueChanged, AddressOf cmbEmpresa_SelectedIndexChanged
    '    ToolCmbEmpresa.SetPropertyValue("AutoComplete", True)

    '    Dim VTIndice As Integer = 0
    '    If VGIndice Then
    '        VTIndice = VGListindex
    '    Else
    '        VTIndice = ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedIndex")
    '    End If
    '    'cmbEmpresa.Enabled = False
    '    'cmbEmpresa.Items.Clear()
    '    ToolCmbEmpresa.InvokeMethod("Clear", "ValueList.ValueListItems", New Object() {}, New Type() {})

    '    Dim VTEmpresa(20, 20) As String
    '    PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6037")
    '    PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
    '    PMPasoValores(sqlconn, "@i_modo", 0, SQLINT1, "0")
    '    If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, " Actualizando las variables de ambiente...") Then
    '        Y = FMMapeaMatriz(sqlconn, VTEmpresa)
    '        PMChequea(sqlconn)
    '        If Y <> 0 Then
    '            For i As Integer = 1 To Y
    '                ToolCmbEmpresa.InvokeMethod("Add", "ValueList.ValueListItems", New Object() {VTEmpresa(0, i) & " - " & VTEmpresa(1, i)}, New Type() {GetType(Object)})
    '            Next i
    '            If VTIndice > 0 Then
    '                ToolCmbEmpresa.SetPropertyValue("ValueList.SelectedIndex", VTIndice)
    '            Else
    '                ToolCmbEmpresa.SetPropertyValue("ValueList.SelectedIndex", 0)
    '            End If
    '            PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6030")
    '            PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "N")
    '            PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart())
    '            If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_empresa", True, " Actualizando las variables de ambiente...") Then
    '                VGEmpresa.Codigo = CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart()
    '                PMMapeaVariable(sqlconn, VGEmpresa.Nombre)
    '                Dim VTNiveles(20) As String
    '                Y = FMMapeaArreglo(sqlconn, VTNiveles)
    '                PMMapeaVariable(sqlconn, VGEmpresa.Mascara)
    '                PMMapeaVariable(sqlconn, VGEmpresa.Moneda)
    '                PMChequea(sqlconn)
    '                PMPasoValores(sqlconn, "@t_trn", 0, SQLINT2, "6336")
    '                PMPasoValores(sqlconn, "@i_operacion", 0, SQLCHAR, "A")
    '                PMPasoValores(sqlconn, "@i_empresa", 0, SQLINT1, CStr(Conversion.Val(ToolCmbEmpresa.GetPropertyValue("ValueList.SelectedItem").ToString)).TrimStart())
    '                If FMTransmitirRPC(sqlconn, ServerName, "cob_conta", "sp_mascara", True, " Actualizando las variables de ambiente...") Then
    '                    Dim VTTemporal(2) As String
    '                    Y = FMMapeaArreglo(sqlconn, VTTemporal)
    '                    PMChequea(sqlconn)
    '                    If Y <> 0 Then
    '                        VGEmpresa.Sinonimo = VTTemporal(2)
    '                    Else
    '                        VGEmpresa.Sinonimo = ""
    '                    End If
    '                End If
    '                'cmbEmpresa.Enabled = True
    '            End If
    '        Else
    '            VGEmpresa.Codigo = ""
    '            VGEmpresa.Nombre = ""
    '            VGEmpresa.Mascara = ""
    '            VGEmpresa.Sinonimo = ""
    '        End If
    '    Else
    '        VGEmpresa.Codigo = ""
    '        VGEmpresa.Nombre = ""
    '        VGEmpresa.Mascara = ""
    '        VGEmpresa.Sinonimo = ""
    '    End If
    'End Sub

End Module


