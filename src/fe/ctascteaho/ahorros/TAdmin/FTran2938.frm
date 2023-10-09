VERSION 5.00
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran2938 
   Caption         =   "Consulta de Clientes con Volúmen de Efectivo"
   ClientHeight    =   2400
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   7635
   LinkTopic       =   "Form1"
   LockControls    =   -1  'True
   MDIChild        =   -1  'True
   ScaleHeight     =   2400
   ScaleWidth      =   7635
   Begin VB.Frame Frame1 
      Height          =   2265
      Left            =   30
      TabIndex        =   8
      Top             =   60
      Width           =   6615
      Begin Crystal.CrystalReport rptReporte 
         Left            =   5940
         Top             =   180
         _ExtentX        =   741
         _ExtentY        =   741
         _Version        =   348160
         PrintFileLinesPerPage=   60
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   2205
         MaxLength       =   4
         TabIndex        =   2
         Top             =   855
         Width           =   555
      End
      Begin VB.ComboBox cmbTipo 
         Appearance      =   0  'Flat
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   315
         Left            =   2205
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   1170
         Width           =   2500
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   0
         Left            =   2205
         TabIndex        =   0
         Top             =   180
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskValor 
         Height          =   285
         Index           =   1
         Left            =   2205
         TabIndex        =   1
         Top             =   510
         Width           =   1425
         _ExtentX        =   2514
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   2205
         TabIndex        =   4
         Top             =   1500
         Width           =   2205
         _ExtentX        =   3889
         _ExtentY        =   503
         _Version        =   393216
         PromptChar      =   "_"
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   375
         Index           =   1
         Left            =   2220
         TabIndex        =   15
         Top             =   1830
         Width           =   4320
      End
      Begin VB.Label il_mascara 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "*Código de la agencia:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   270
         Index           =   2
         Left            =   120
         TabIndex        =   14
         Top             =   900
         WhatsThisHelpID =   5032
         Width           =   2025
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   0
         Left            =   2775
         TabIndex        =   13
         Top             =   855
         Width           =   3750
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*Producto:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   120
         TabIndex        =   12
         Top             =   1230
         WhatsThisHelpID =   5048
         Width           =   915
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "*No. de cuenta corriente:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   375
         Index           =   0
         Left            =   120
         TabIndex        =   11
         Top             =   1530
         WhatsThisHelpID =   5016
         Width           =   2130
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha desde:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   5
         Left            =   120
         TabIndex        =   10
         Top             =   240
         Width           =   2040
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Fecha hasta:"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   285
         Index           =   3
         Left            =   120
         TabIndex        =   9
         Top             =   570
         Width           =   2130
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   6720
      TabIndex        =   7
      Top             =   1560
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   6720
      TabIndex        =   6
      Top             =   795
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   6720
      TabIndex        =   5
      Top             =   30
      WhatsThisHelpID =   2007
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Transmitir"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
End
Attribute VB_Name = "FTran2938"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
 '*********************************************************
'   Archivo:        FTran2938.FRM
'   Producto:       Cuentas Corrientes/Ahorros
'   Diseñado por:   Clotilde Vargas de Coello
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de GLOBAL BANK
' Su uso no autorizado queda expresamente prohibido así
' como cualquier alteración o  agregado hecho por alguno
' de sus usuarios sin el debido  consentimiento por
' escrito de la Presidencia Ejecutiva Global Bank
'*********************************************************
' Forma:        FTran2938
' Descripción:  Esta forma permite obtener una consulta
'               de los clientes que manejan volumemes de
'               efectivo, esto lo solicito el área de
'               cumplimiento
 '*********************************************************
Dim VLPaso As Integer

Private Sub Form_Load()
    Dim i As Integer
    FTran2938.Width = 7755
    FTran2938.Height = 2910
    PMLoadResStrings Me
    PMLoadResIcons Me
    For i% = 0 To 1
        mskValor(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
        mskValor(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
    Next i%
    mskCuenta.Mask = VGMascaraCtaCte$
    PLCargarTipo
End Sub

Private Sub PLCargarTipo()
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
End Sub

Private Sub cmdBoton_Click(Index As Integer)
Select Case Index
Case 0
    PLImprimir
Case 1
    PLLimpiar
Case 2
    Unload Me
End Select
End Sub

Private Sub PLImprimir()
    On Error GoTo ErrorImp
    Dim VTFDesde As String
    Dim VTFHasta As String
    Dim VTR1 As Integer
    Dim archivo As String
    Dim VTMsg As String
    Dim VTR As Integer
    Dim reportes As String
    Const IDYES = 6

        ' Fecha de inicio de la consulta
        If Trim$(mskValor(0).ClipText) = "" Then
            MsgBox "La fecha de inicio es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            Exit Sub
        End If

        ' Fecha de fin de la consulta
        If Trim$(mskValor(1).ClipText) = "" Then
            MsgBox "La fecha de fin es mandatorio", 0 + 16, "Mensaje de Error"
            mskValor(1).SetFocus
            Exit Sub
        End If

        ' Validacion de Mandatoriedades
        ' Numero de cuenta
        If Trim$(mskCuenta.ClipText) = "" Then
            MsgBox "El número de Cuenta es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If
        
        ' No se confirmo la transaccion
        If MsgBox("Esta transacción podría tomar algún tiempo" & Chr$(13) & "Está seguro de realizar esta operación?", 1 + 32 + 0, "Mensaje del Sistema") <> 1 Then
            Exit Sub
        End If
        
        Screen.MousePointer = 11
        ReDim VTArreglo(5) As String
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "2938"
        VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_ini", 0, SQLDATETIME, VTFDesde$
        VTFHasta$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
        PMPasoValores sqlconn&, "@i_fecha_fin", 0, SQLDATETIME, VTFHasta$
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If Trim$(txtCampo(1).Text) <> "" Then
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT4, txtCampo(1).Text
        End If
        PMPasoValores sqlconn&, "@i_cta_banco", 0, SQLVARCHAR, (mskCuenta.ClipText)
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "CM"
        End If
        If cmbTipo.Text = "CUENTA AHORRO" Then
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "AM"
        End If
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_mov_volefectivo", True, "Ok... Impresión de Monitoreo Clientes con Volumen de Efectivo") Then
            VTR1% = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            If UBound(VTArreglo()) > 0 Then
                Dim BaseDatos As Database
                Dim Tabla1 As Recordset
                archivo$ = VGPath$ + "\contefec.mdb"
                Set BaseDatos = DBEngine.OpenDatabase(archivo$)
                Set Tabla1 = BaseDatos.OpenRecordset("volumen_efectivo")
                BaseDatos.Execute "delete from volumen_efectivo"
                Tabla1.AddNew
                Tabla1("ve_fecha_inicio") = mskValor(0).Text
                Tabla1("ve_fecha_fin") = mskValor(1).Text
                Tabla1("ve_oficina") = txtCampo(1).Text
                Tabla1("ve_descoficina") = lblDescripcion(0).Caption
                Tabla1("ve_tipocta") = cmbTipo.Text
                Tabla1("ve_cta_banco") = mskCuenta.Text
                Tabla1("ve_desctitular") = lblDescripcion(1).Caption
                Tabla1("ve_nro_transacciones") = IIf(VTArreglo(1) <> "", VTArreglo(1), 0)
                Tabla1("ve_efec_recib") = IIf(VTArreglo(2) <> "", VTArreglo(2), 0)
                Tabla1("ve_efec_pag") = IIf(VTArreglo(3) <> "", VTArreglo(3), 0)
                Tabla1("filial") = Val(VGLOGO$)
                Tabla1.Update
                Tabla1.Close
    
                VTMsg$ = "Asegúrese de que la Impresora se encuentre lista. Desea continuar con la impresión?."
                VTR% = MsgBox(VTMsg$, 36, "Control de impresión de Datos.")
                If VTR% = IDYES Then
                        reportes$ = VGPath$ + "\volumenefec.rpt"
                        rptReporte.ReportFileName = reportes$
                        rptReporte.DataFiles(0) = archivo$
                        rptReporte.Destination = 0
                        rptReporte.Action = 0
                End If
                BaseDatos.Close
            Else
                MsgBox "No existen datos para mostrar", vbInformation, "Control de Información"
                Screen.MousePointer = 0
            End If
        Else
            PMChequea sqlconn&
        End If
                
        Screen.MousePointer = 0
Exit Sub

ErrorImp:
    MsgBox "Error en la Impresión del Reporte " + Err.Description, 0 + 16, "Mensaje de Error"
    Screen.MousePointer = 0
    Exit Sub
End Sub

Private Sub PLLimpiar()
    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
    mskValor(0).Text = Format$(VGFecha$, VGFormatoFecha$)
    mskValor(1).Text = Format$(VGFecha$, VGFormatoFecha$)
    txtCampo(1).Text = ""
    lblDescripcion(0).Caption = ""
    lblDescripcion(1).Caption = ""
End Sub

Private Sub txtCampo_Change(Index As Integer)
    
    If Index% = 1 Then
        VLPaso% = False
    End If
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 1
        VLPaso% = True
        FPrincipal!pnlHelpLine.Caption = " Código de la agencia [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda% Then
        If Index% = 1 Then
            VGOperacion$ = "sp_oficina"
             PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(1).Text & "]") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                 FCatalogo.Show 1
                 txtCampo(1).Text = VGACatalogo.Codigo$
                 lblDescripcion(0).Caption = VGACatalogo.Descripcion$
            Else
                 PMChequea sqlconn&
            End If
            VLPaso% = True
        End If
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        KeyAscii% = Asc(LCase$(Chr$(KeyAscii%)))
    Case 1, 2
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    If Index% = 1 Then
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                 PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cl_oficina"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, (txtCampo(1).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la agencia " & "[" & txtCampo(1).Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                Else
                    VLPaso% = True
                    txtCampo(1).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(1).SetFocus
                    PLLimpiar
                End If
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If
    End If
End Sub


Private Sub cmbTipo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Tipo de Cuenta"
End Sub
Private Sub cmbTipo_LostFocus()
    If cmbTipo.ListIndex = 0 Then  '' Corrientes
        mskCuenta.Mask = VGMascaraCtaCte$
    ElseIf cmbTipo.ListIndex = 1 Then
        mskCuenta.Mask = VGMascaraCtaAho$
    End If
    Call mskCuenta_LostFocus
End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la Cuenta"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If cmbTipo.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(1)
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                    lblDescripcion(1).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaCte$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                
                Exit Sub
            End If
        ElseIf cmbTipo.ListIndex = 1 Then   '  Ahorros
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(1)
                    PMChequea sqlconn&
                Else
                    mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                    lblDescripcion(1).Caption = ""
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                lblDescripcion(1).Caption = ""
                mskCuenta.SetFocus
                Exit Sub
            End If
        Else
                MsgBox "Si se desea consultar una cuenta especifica se debe escoger el producto de la cuenta", 0 + 16, "Mensaje de Error"
                mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
                If cmbTipo.Enabled = True Then cmbTipo.SetFocus
                Exit Sub
        End If
    End If
End Sub


Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Fecha de inicial de la consulta [" & VGFormatoFecha & "]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta [" & VGFormatoFecha & "]"
    End Select
    mskValor(Index%).SelStart = 0
    mskValor(Index%).SelLength = Len(mskValor(Index%).Text)
End Sub

Private Sub mskValor_KeyPress(Index As Integer, KeyAscii As Integer)
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
        KeyAscii% = 0
    End If
End Sub
Private Sub mskValor_LostFocus(Index As Integer)
'*********************************************************
'PROPOSITO: Verifica la validez de la fecha ingresada
'           de acuerdo con el formato de la fecha
'           ingresada
'INPUT    : Index   Identificador de campo
'OUTPUT   : ninguna
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'Abr-12-07  Clotilde Vargas           Emisión Inicial
'*********************************************************
    On Error Resume Next
    
    Dim VTValido As Integer
    Dim i As Integer
    Dim VTDias As Long
    
    Select Case Index%
    Case 0, 1
        If mskValor(Index%).ClipText <> "" Then
            VTValido% = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido% Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i% = 0 To 1
                mskValor(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
            Next i%
        End If
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias& = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha$)
            If VTDias& < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i% = 0 To 1
                    mskValor(i%).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskValor(i%).Text = Format$(VGFecha$, VGFormatoFecha$)
                Next i%
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        End If
    End Select
End Sub


