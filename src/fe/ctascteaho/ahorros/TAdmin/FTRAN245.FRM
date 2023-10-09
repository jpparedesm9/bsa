VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran245 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Consulta de Bloqueo de Movimientos a la Cuenta de Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   165
   ClientTop       =   1755
   ClientWidth     =   9510
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1055
   LinkTopic       =   "Form5"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9510
   Tag             =   "3113"
   Begin VB.Frame frmCriterio 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   528
      Left            =   1950
      TabIndex        =   17
      Top             =   900
      Width           =   6564
      Begin Threed.SSOption optVigentes 
         Height          =   192
         Index           =   2
         Left            =   72
         TabIndex        =   3
         Top             =   240
         WhatsThisHelpID =   5356
         Width           =   1872
         _Version        =   65536
         _ExtentX        =   3308
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "*Bloqueos vigentes"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Value           =   -1  'True
      End
      Begin Threed.SSOption optVigentes 
         Height          =   192
         Index           =   1
         Left            =   2844
         TabIndex        =   5
         Top             =   240
         WhatsThisHelpID =   5143
         Width           =   1728
         _Version        =   65536
         _ExtentX        =   3048
         _ExtentY        =   339
         _StockProps     =   78
         Caption         =   "*Levantamientos"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
      Begin Threed.SSOption optVigentes 
         Height          =   192
         Index           =   0
         Left            =   2844
         TabIndex        =   4
         Top             =   240
         Visible         =   0   'False
         WhatsThisHelpID =   5029
         Width           =   2136
         _Version        =   65536
         _ExtentX        =   3768
         _ExtentY        =   339
         _StockProps     =   78
         Caption         =   "*Bloqueos cancelados"
         ForeColor       =   8388608
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
      End
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   1
      Left            =   7135
      TabIndex        =   2
      Top             =   615
      Width           =   1365
      _ExtentX        =   2408
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin MSMask.MaskEdBox mskValor 
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   1
      Top             =   615
      Width           =   1360
      _ExtentX        =   2408
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8600
      TabIndex        =   6
      Top             =   2265
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
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
      Enabled         =   0   'False
   End
   Begin MSGrid.Grid grdValores 
      Height          =   3384
      Left            =   36
      TabIndex        =   10
      Top             =   1896
      Width           =   8448
      _Version        =   65536
      _ExtentX        =   14901
      _ExtentY        =   5969
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1950
      TabIndex        =   0
      Top             =   15
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8600
      TabIndex        =   7
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8600
      TabIndex        =   8
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
      Index           =   2
      Left            =   8600
      TabIndex        =   9
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
      _Version        =   65536
      _ExtentX        =   1543
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Tipo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   15
      TabIndex        =   18
      Top             =   1020
      WhatsThisHelpID =   5084
      Width           =   525
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha desde:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   15
      TabIndex        =   16
      Top             =   660
      WhatsThisHelpID =   5172
      Width           =   1245
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha hasta:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   3
      Left            =   5400
      TabIndex        =   15
      Top             =   660
      WhatsThisHelpID =   5173
      Width           =   1275
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de bloqueos de movimientos:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   14
      Top             =   1650
      WhatsThisHelpID =   5299
      Width           =   3015
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8550
      Y1              =   1600
      Y2              =   1600
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   15
      TabIndex        =   13
      Top             =   315
      WhatsThisHelpID =   5265
      Width           =   1920
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "*No. cuenta de ahorros:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   15
      TabIndex        =   12
      Top             =   15
      WhatsThisHelpID =   5254
      Width           =   2055
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8550
      X2              =   8550
      Y1              =   0
      Y2              =   5310
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   1950
      TabIndex        =   11
      Top             =   315
      UseMnemonic     =   0   'False
      Width           =   6550
   End
End
Attribute VB_Name = "FTran245"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRAN245.frm
' NOMBRE LOGICO:    FTran245
' PRODUCTO:         Terminal Administrativa
'*************************************************************
'                       IMPORTANTE
' Esta aplicacion es parte de los paquetes bancarios propiedad
' de MACOSA S.A.
' Su uso no  autorizado queda  expresamente prohibido asi como
' cualquier  alteracion o  agregado  hecho por  alguno  de sus
' usuarios sin el debido consentimiento por escrito de MACOSA.
' Este programa esta protegido por la ley de derechos de autor
' y por las  convenciones  internacionales de  propiedad inte-
' lectual.  Su uso no  autorizado dara  derecho a  MACOSA para
' obtener ordenes  de secuestro o  retencion y para  perseguir
' penalmente a los autores de cualquier infraccion.
'*************************************************************
'                         PROPOSITO
' Consulta de Bloqueo de Movimientos a la Cuenta de Ahorros
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

'Dim VLFormatoFecha As String
'CloVargas Oct/24/01 Manejo de Formato Fecha

Private Sub Form_Load()
    Dim i As Integer
    FTran245.Left = 0   '15
    FTran245.Top = 0   '15
    FTran245.Width = 9450   '9420
    FTran245.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    mskCuenta.Mask = VGMascaraCtaAho$
    'VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    For i = 0 To 1
        mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
        mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
    Next i
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
    Dim VTFDesde As String
    Dim VTFHasta As String
    Select Case Index%
    Case 0

        'Transmitir
        If mskCuenta.ClipText = "" Then
            MsgBox "El número de Cuenta de Ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "245"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
        'VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
         VTFDesde = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fdesde", 0, SQLDATETIME, VTFDesde
        'VTFHasta$ = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
         VTFHasta = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fhasta", 0, SQLDATETIME, VTFHasta
         If optVigentes(0).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "C"
         ElseIf optVigentes(1).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "L"
         ElseIf optVigentes(2).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "V"
         End If
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_consulta_mov_ah", True, " Ok... Consulta de bloqueo de movimientos") Then
            PMMapeaGrid sqlconn&, grdValores, False
            PMChequea sqlconn&
            grdValores.ColAlignment(3) = 2
            mskValor(0).Enabled = False
            mskValor(1).Enabled = False
            If grdValores.Tag = VGMaxRows% Then
                cmdBoton(4).Enabled = True
            Else
                cmdBoton(4).Enabled = False
            End If
        End If

    Case 1
        Dim i As Integer
        'Limpiar
        'mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
        'lblDescripcion(0).Caption = ""
        PMLimpiaGrid grdValores
        mskValor(0).Enabled = True
        mskValor(1).Enabled = True
        For i = 0 To 1
            mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
            mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
        Next i
        optVigentes(2).Value = True
        'mskCuenta.SetFocus
    Case 2
        'Salir
        Unload FTran245
    Case 4
        'Siguientes
        If mskCuenta.ClipText = "" Then
            MsgBox "El código de la cuenta de ahorros es mandatorio", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "245"
         PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT2, VGMoneda$
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
        'VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
         VTFDesde$ = FMConvFecha((mskValor(0).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fdesde", 0, SQLDATETIME, VTFDesde$
        'VTFHasta$ = FMConvFecha((mskValor(1).FormattedText), VLFormatoFecha$, "mm/dd/yyyy")
         VTFHasta$ = FMConvFecha((mskValor(1).FormattedText), VGFormatoFecha$, CGFormatoBase$)
         PMPasoValores sqlconn&, "@i_fhasta", 0, SQLDATETIME, VTFHasta$
         If optVigentes(0).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "C"
         ElseIf optVigentes(1).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "L"
         ElseIf optVigentes(2).Value = True Then
             PMPasoValores sqlconn&, "@i_est", 0, SQLCHAR, "V"
         End If
         grdValores.Col = 6
         grdValores.Row = grdValores.Rows - 1
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, (grdValores.Text)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4&, (VGFecha_SP$)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_consulta_mov_ah", True, " Ok... Consulta de bloqueo de movimientos") Then
            PMMapeaGrid sqlconn&, grdValores, True
            PMChequea sqlconn&
            If grdValores.Tag = VGMaxRows% Then
                cmdBoton(4).Enabled = True
            Else
                cmdBoton(4).Enabled = False
            End If
         End If
    End Select
End Sub

Private Sub grdValores_Click()
    grdValores.Col = 0
    grdValores.SelStartCol = 1
    grdValores.SelEndCol = grdValores.Cols - 1
    If grdValores.Row = 0 Then
        grdValores.SelStartRow = 1
        grdValores.SelEndRow = 1
    Else
        grdValores.SelStartRow = grdValores.Row
        grdValores.SelEndRow = grdValores.Row
    End If
End Sub

Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta de ahorros"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
        If FMChequeaCtaAho((mskCuenta.ClipText)) Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
             PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
             PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
             PMPasoValores sqlconn&, "@i_cerrada", 0, SQLCHAR, "C"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Consulta la cuenta " & "[" & mskCuenta.Text & "]") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(0)
                 PMChequea sqlconn&
                cmdBoton(3).Enabled = True
            Else
                cmdBoton_Click (1)
                Exit Sub
            End If
        Else
            MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
            cmdBoton_Click (1)
            Exit Sub
        End If
    End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Fecha inicial de la consulta[" & VGFormatoFecha & "]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Fecha final de la consulta[" & VGFormatoFecha & "]"
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
    Dim VTValido As Integer
    Dim i As Integer
    Dim VTDias As Long
    On Error Resume Next
    Select Case Index%
    Case 0, 1
        If mskValor(Index%).ClipText <> "" Then
            VTValido = FMVerFormato((mskValor(Index).FormattedText), VGFormatoFecha$)
            If Not VTValido Then
                MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
                mskValor(Index%).SetFocus
                Exit Sub
            End If
        Else
            For i = 0 To 1
                mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
                mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
            Next i
        End If
        If mskValor(0).ClipText <> "" And mskValor(1).ClipText <> "" Then
            VTDias = FMDateDiff("d", (mskValor(0).FormattedText), (mskValor(1).FormattedText), VGFormatoFecha$)
            If VTDias < 0 Then
                MsgBox "Fecha desde mayor a fecha hasta", 48, "Mensaje de Error"
                For i = 0 To 1
                    mskValor(i).Mask = FMMascaraFecha(VGFormatoFecha$)
                    mskValor(i).Text = Format$(VGFecha$, VGFormatoFecha$)
                Next i
                mskValor(0).SetFocus
                Exit Sub
            End If
        End If
    End Select

End Sub


