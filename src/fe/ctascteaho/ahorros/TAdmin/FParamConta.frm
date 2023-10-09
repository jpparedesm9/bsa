VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FParamConta 
   Caption         =   "Parametrización Contable"
   ClientHeight    =   5220
   ClientLeft      =   75
   ClientTop       =   465
   ClientWidth     =   9030
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   ScaleHeight     =   5220
   ScaleWidth      =   9030
   Begin VB.Frame frmDatos 
      Height          =   2736
      Left            =   15
      TabIndex        =   18
      Top             =   0
      Width           =   8052
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   7
         Left            =   5580
         MaxLength       =   1
         TabIndex        =   8
         Top             =   2050
         Width           =   384
      End
      Begin VB.ComboBox CmbContab 
         Height          =   288
         Index           =   2
         ItemData        =   "FParamConta.frx":0000
         Left            =   5580
         List            =   "FParamConta.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   10
         Top             =   2350
         Width           =   2292
      End
      Begin VB.ComboBox CmbContab 
         Height          =   288
         Index           =   1
         ItemData        =   "FParamConta.frx":0004
         Left            =   2172
         List            =   "FParamConta.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   9
         Top             =   2350
         Width           =   2076
      End
      Begin VB.ComboBox CmbContab 
         Height          =   288
         Index           =   0
         ItemData        =   "FParamConta.frx":0008
         Left            =   2172
         List            =   "FParamConta.frx":000A
         Style           =   2  'Dropdown List
         TabIndex        =   7
         Top             =   2050
         Width           =   2076
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   6
         Left            =   5580
         MaxLength       =   1
         TabIndex        =   6
         Top             =   1740
         Width           =   384
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   5
         Left            =   1212
         MaxLength       =   1
         TabIndex        =   5
         Top             =   1740
         Width           =   1170
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   4
         Left            =   1212
         MaxLength       =   10
         TabIndex        =   4
         Top             =   1440
         Width           =   1170
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   1
         Left            =   1212
         MaxLength       =   4
         TabIndex        =   1
         Top             =   540
         Width           =   1170
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   0
         Left            =   1212
         MaxLength       =   2
         TabIndex        =   0
         Top             =   240
         Width           =   1170
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   2
         Left            =   1212
         MaxLength       =   4
         TabIndex        =   2
         Top             =   840
         Width           =   1170
      End
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   3
         Left            =   1212
         MaxLength       =   1
         TabIndex        =   3
         Top             =   1140
         Width           =   1170
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Impuesto:"
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
         Height          =   192
         Index           =   10
         Left            =   4284
         TabIndex        =   37
         Top             =   2076
         Width           =   1248
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   7
         Left            =   5976
         TabIndex        =   36
         Top             =   2050
         Width           =   1880
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Campo Base2:"
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
         Height          =   192
         Index           =   9
         Left            =   4284
         TabIndex        =   35
         Top             =   2380
         Width           =   1224
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Campo Base1:"
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
         Height          =   192
         Index           =   8
         Left            =   72
         TabIndex        =   34
         Top             =   2380
         Width           =   1224
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Campo a Contabilizar:"
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
         Height          =   192
         Index           =   7
         Left            =   60
         TabIndex        =   33
         Top             =   2080
         Width           =   1836
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Tipo Total:"
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
         Height          =   192
         Index           =   6
         Left            =   4608
         TabIndex        =   32
         Top             =   1764
         Width           =   924
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   6
         Left            =   5976
         TabIndex        =   31
         Top             =   1740
         Width           =   1880
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Indicador:"
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
         Height          =   192
         Index           =   5
         Left            =   60
         TabIndex        =   30
         Top             =   1740
         Width           =   840
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   5
         Left            =   2400
         TabIndex        =   29
         Top             =   1740
         Width           =   2100
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Concepto:"
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
         Height          =   192
         Index           =   4
         Left            =   60
         TabIndex        =   28
         Top             =   1440
         Width           =   852
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   285
         Index           =   4
         Left            =   2400
         TabIndex        =   27
         Top             =   1440
         Width           =   5460
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Transacción:"
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
         Height          =   192
         Index           =   0
         Left            =   60
         TabIndex        =   26
         Top             =   570
         Width           =   1092
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   1
         Left            =   2400
         TabIndex        =   25
         Top             =   540
         Width           =   5460
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto:"
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
         Height          =   192
         Index           =   3
         Left            =   60
         TabIndex        =   24
         Top             =   270
         Width           =   804
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   0
         Left            =   2400
         TabIndex        =   23
         Top             =   240
         Width           =   5460
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Causal:"
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
         Height          =   192
         Index           =   1
         Left            =   60
         TabIndex        =   22
         Top             =   870
         Width           =   636
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   2
         Left            =   2400
         TabIndex        =   21
         Top             =   840
         Width           =   5460
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Naturaleza:"
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
         Height          =   192
         Index           =   2
         Left            =   60
         TabIndex        =   20
         Top             =   1140
         Width           =   960
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H00C0C0C0&
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H80000008&
         Height          =   288
         Index           =   3
         Left            =   2400
         TabIndex        =   19
         Top             =   1140
         Width           =   5460
      End
   End
   Begin MSGrid.Grid Grid1 
      Height          =   2355
      Left            =   30
      TabIndex        =   17
      Top             =   2820
      Width           =   7965
      _Version        =   65536
      _ExtentX        =   14049
      _ExtentY        =   4154
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin MSGrid.Grid grdConta 
      Height          =   510
      Left            =   8175
      TabIndex        =   38
      Top             =   780
      Visible         =   0   'False
      Width           =   690
      _Version        =   65536
      _ExtentX        =   1228
      _ExtentY        =   910
      _StockProps     =   77
      BackColor       =   16777215
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8115
      TabIndex        =   11
      Tag             =   "4011"
      Top             =   45
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
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
      Index           =   5
      Left            =   8115
      TabIndex        =   14
      Tag             =   "4010"
      Top             =   2805
      WhatsThisHelpID =   2006
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Eliminar"
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8115
      TabIndex        =   16
      Top             =   4350
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
      Height          =   765
      Index           =   1
      Left            =   8115
      TabIndex        =   15
      Top             =   3570
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1349
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
      Index           =   3
      Left            =   8115
      TabIndex        =   12
      Tag             =   "8001"
      Top             =   1275
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
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
      Index           =   4
      Left            =   8115
      TabIndex        =   13
      Tag             =   "4009"
      Top             =   2040
      WhatsThisHelpID =   2031
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Actualizar"
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
   Begin VB.Line Line1 
      BorderColor     =   &H00400000&
      BorderWidth     =   2
      X1              =   0
      X2              =   8050
      Y1              =   2760
      Y2              =   2760
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00400000&
      BorderWidth     =   2
      X1              =   8070
      X2              =   8070
      Y1              =   0
      Y2              =   5160
   End
End
Attribute VB_Name = "FParamConta"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Option Explicit
Dim VLPaso As Integer
Dim VLTabla As String
Dim VLSecuencial As String
'IU VMA 22-jun-2001
'Dim VLMatrizTrans(2, 30) As String
Dim VLMatrizTrans(2, 80) As String
'FU VMA 22-jun-2001
Dim VLTrnCaus As Integer


Dim VLBuscar As String
Dim VLParametro As String
Dim Msg As String
Dim i As Integer
Dim causa_sus As Integer
Dim VTCausaOrg As String
Dim VTIndicador As String
Dim causa As String


Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index%
    Case 0 'Buscar
        VLBuscar$ = "S"
        PLBuscar
    Case 1 'Limpiar
        PLLimpiar
    Case 2 'Salir
        Unload Me
    Case 3 'Ingresar
        PLIngresar
    Case 4 'Actualizar
        PLModificar
        
    Case 5 'Eliminar
        Grid1.Col = 0
        Msg$ = "Esta Seguro de Eliminar el Registro Nro: " + Grid1.Text + " ?"
        If MsgBox(Msg$, 4) = 6 Then
            VLBuscar$ = "N"
               PLEliminar
               PLLimpiar
        End If
    End Select
End Sub

Private Sub Form_Load()
    Dim j As Integer
    FParamConta.Left = 15
    FParamConta.Top = 15
    FParamConta.Width = 9180
    FParamConta.Height = 5730

    ' Carga los datos de las Transacciones que tienen causa para la contabilidad
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_trn_causa_contb"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de las transacciones con causa cont.") Then
         VLTrnCaus% = FMMapeaMatriz(sqlconn&, VLMatrizTrans())
         PMChequea sqlconn&
    End If
    For i% = 0 To 7
        If i% <> 5 Then txtCampo(i%).Height = 240
    Next
    
    
    VLTabla$ = "cc_campo_contable"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdConta, False
        PMChequea sqlconn&
        For j% = 0 To 2
            grdConta.Col = 2
            For i% = 0 To grdConta.Rows - 2
                grdConta.Row = i% + 1
                CmbContab(j%).AddItem grdConta.Text, i
            Next i
        Next j
    End If
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
        Case 0
            FPrincipal!pnlHelpLine.Caption = " Código del producto [F5 Ayuda]"
        Case 1
            FPrincipal!pnlHelpLine.Caption = " Transacción [F5 Ayuda]"
        Case 2
            FPrincipal!pnlHelpLine.Caption = " Causa asociada a la transacción [F5 Ayuda] "
        Case 3
            FPrincipal!pnlHelpLine.Caption = " Crédito [C] o Débito [D] "
        Case 4
            FPrincipal!pnlHelpLine.Caption = " Concepto Contable "
        Case 5
            FPrincipal!pnlHelpLine.Caption = " Indicador de la transacción [F5 Ayuda]"
        Case 6
            FPrincipal!pnlHelpLine.Caption = " Tipo Total [F5 Ayuda]"
        Case 7
            FPrincipal!pnlHelpLine.Caption = " Tipo Impuesto [F5 Ayuda])"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Sub PMTransaccion(ICampo As Integer, IProducto As Integer, operacion As String, Transaccion As String)
    'Transacciones por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(IProducto).Text) = "" Then
        MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
        If txtCampo(IProducto).Enabled And txtCampo(IProducto).Visible Then
           txtCampo(IProducto).SetFocus
        End If
        Exit Sub
    End If
    VLPaso% = True
    If operacion = "S" Then
        VGOperacion$ = "sp_pro_transaccion"
        VGProductoConta = txtCampo(IProducto)
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, operacion
        PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "9"
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(IProducto)
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
        PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
        PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, "0"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " OK... Consulta de Transacción") Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(ICampo).Text = VGACatalogo.Codigo$
            lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
            If Trim$(txtCampo(ICampo).Text) = "" Then
                txtCampo(ICampo).Text = ""
                lblDescripcion(ICampo).Caption = ""
                If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                   txtCampo(ICampo).SetFocus
                End If
            End If
        End If
    Else
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, Transaccion
        PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
            PMMapeaObjeto sqlconn&, lblDescripcion(ICampo)
            PMChequea sqlconn&
            'Limpia campo causal porque depende de la transaccion
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
        Else
            txtCampo(ICampo).Text = ""
            lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If

        VLTabla$ = ""
        txtCampo(1).Enabled = False
        For i% = 1 To UBound(VLMatrizTrans, 2)
            If txtCampo(0).Text = VLMatrizTrans(0, i%) Then
                VLTabla$ = VLMatrizTrans(1, i%)
                txtCampo(1).Enabled = True
                Exit For
            End If
        Next i%
    End If
End Sub

Sub PMCatalogo1(ICampo As Integer, operacion As String, Tabla As String)
    VGOperacion$ = ""
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, Tabla$
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, operacion
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de indicadores " & "[" & txtCampo(ICampo).Text & "]") Then
        VLPaso% = True
        PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
        PMChequea sqlconn&
        FCatalogo.Show 1
        txtCampo(ICampo).Text = VGACatalogo.Codigo$
        lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
        If ICampo <> 7 Then
            txtCampo(ICampo + 1).SetFocus
        Else
            txtCampo(ICampo).SetFocus
        End If
        
        If Trim$(txtCampo(ICampo).Text) = "" Then
            lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If
    End If
End Sub


Sub PMProducto(ICampo As Integer, operacion As String, Producto As String)
    'Operacion: A - Search (F5), V - Query (LostFocus)
    VLPaso% = True
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
    PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, operacion
    If operacion = "V" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, Producto
    End If
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then
        If operacion = "A" Then
            PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
            PMChequea sqlconn&
            FCatalogo.Show 1
            txtCampo(ICampo).Text = VGACatalogo.Codigo$
            lblDescripcion(ICampo).Caption = VGACatalogo.Descripcion$
            txtCampo(ICampo + 1).SetFocus
        Else
             PMMapeaObjeto sqlconn&, lblDescripcion(ICampo)
             PMChequea sqlconn&
        End If
        If Trim$(txtCampo(ICampo).Text) = "" Then
            lblDescripcion(ICampo).Caption = ""
            If txtCampo(ICampo).Enabled And txtCampo(ICampo).Visible Then
                txtCampo(ICampo).SetFocus
            End If
        End If
    End If
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)

    If Keycode% <> VGTeclaAyuda% Then
        Exit Sub
    End If
    
    Select Case Index%
        Case 0
            Call PMProducto(Index%, "A", "0")
        Case 1
            Call PMTransaccion(Index%, 0, "S", "0")
        Case 2
            If txtCampo(1).Text = VLParametro$ Then
               VLTabla$ = "ah_cau_nc_gmf_ba"
            End If
            Call PMCatalogo1(Index%, "A", VLTabla$)
            FPrincipal!pnlHelpLine.Caption = " Causa asociada a la transacción [F5 Ayuda] "
        Case 3
            Call PMCatalogo1(Index%, "A", "re_naturaleza_trn")
            FPrincipal!pnlHelpLine.Caption = " Crédito [C] o Débito [D] "
        Case 4
            Call PMCatalogo1(Index%, "A", "re_concepto_contable")
        Case 5
            Call PMCatalogo1(Index%, "A", "cc_tipo_indicador")
        Case 6
            Call PMCatalogo1(Index%, "A", "re_campo_totaliza")
        Case 7
            Call PMCatalogo1(Index%, "A", "cb_tipo_impuesto")
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
        Case 0, 1, 5
           KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
        Case 4, 2
            KeyAscii% = FMVAlidaTipoDato("AN", KeyAscii%)
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        Case 3, 6, 7
            KeyAscii% = FMVAlidaTipoDato("A", KeyAscii%)
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTTranVal As Integer
    Dim causa As String
    Dim VLVal As String
    Dim VLTransac As Integer
    Select Case Index%
    Case 1
        'Transacciones
        
        If Trim$(txtCampo(1).Text) = "" Then
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(7).SetFocus
            Exit Sub
        End If

        ' Validar los rangos de transacciones de acuerdo al producto
        VTTranVal% = Val(txtCampo(1).Text)
        Select Case Trim$(txtCampo(0).Text)
        Case "3"

            'If VTTranVal% > 2999 Or (VTTranVal% < 2500 And VTTranVal% > 99) Then
            If VTTranVal% > 2999 Or (VTTranVal% < 600 And VTTranVal% > 99) Or (VTTranVal% < 2500 And VTTranVal% > 700) Then
               ' If VTTranVal% <> 401   Then
               If (VTTranVal% <> 401 And VTTranVal% <> 402 And VTTranVal% <> 403 And VTTranVal% <> 404 And VTTranVal% <> 405 And VTTranVal% <> 406 And VTTranVal% <> 407 And VTTranVal% <> 408 And VTTranVal% <> 409 And VTTranVal% <> 410 And VTTranVal% <> 489) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                    Exit Sub
                End If
            End If
        Case "4"

            'If VTTranVal% <= 200 Or VTTranVal% >= 302 Then
            If VTTranVal% <= 200 Or VTTranVal% >= 399 Or VTTranVal% = 401 Then   'EAA 03/27/2001
               ' If VTTranVal% <> 401 Then
                If (VTTranVal% <> 401 And VTTranVal% <> 402 And VTTranVal% <> 403 And VTTranVal% <> 404 And VTTranVal% <> 405 And VTTranVal% <> 406 And VTTranVal% <> 407 And VTTranVal% <> 408 And VTTranVal% <> 409 And VTTranVal% <> 410 And VTTranVal% <> 489) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    If txtCampo(1).Enabled And txtCampo(1).Visible Then
                          txtCampo(1).SetFocus
                    End If
                    Exit Sub
                End If
            End If
        Case "10"
            'If (VTTranVal% <= 400 Or VTTranVal% >= 500)
            If (VTTranVal% >= 500 Or VTTranVal% < 400) Or VTTranVal% = 401 Then
                If (VTTranVal% >= 700 Or VTTranVal% < 600) Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    lblDescripcion(1).Caption = ""
                    txtCampo(1).SetFocus
                    Exit Sub
                End If
            End If
        End Select
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (txtCampo(1).Text)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
            'txtCampo(2).Text = ""
            'lblDescripcion(2).Caption = ""
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(1).SetFocus
        End If

        PLParametro
        VLTabla$ = ""
        If txtCampo(1).Text = VLParametro$ Then
           txtCampo(2).Enabled = True
        Else
           txtCampo(2).Enabled = False
        End If
        For i% = 1 To UBound(VLMatrizTrans, 2)
            If txtCampo(1).Text = VLMatrizTrans(0, i%) Then
                VLTabla$ = VLMatrizTrans(1, i%)
                txtCampo(2).Enabled = True
                txtCampo(2).SetFocus
                Exit For
            End If
        Next i%

    Case 2

        'Causas
        If txtCampo(1).Text = VLParametro$ Then
              VLTabla$ = "ah_cau_nc_gmf_ba"
        End If
            
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            lblDescripcion(2).Caption = ""
            Exit Sub
        End If
        causa$ = txtCampo(2).Text
        
        If VLTabla$ = "" Then
            MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        
        VLVal = IIf(InStr(1, VLTabla$, "cc_causa_o", vbTextCompare), "S", "N")
        If txtCampo(2).Text <> "" And IsNumeric(txtCampo(2).Text) And VLVal = "N" Then
            causa_sus = CInt(txtCampo(2).Text)
            causa$ = txtCampo(2).Text
            VLTransac% = txtCampo(1).Text
            If causa_sus > 500 And (VLTransac% = 50 Or VLTransac% = 264) Then
                    causa_sus = causa_sus - 500
                    'cmdBoton(2).Enabled = False
            End If
            causa$ = CStr(causa_sus)
        End If
                
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, causa$ ' (Txtcampo(1).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(2)
             PMChequea sqlconn&
             
        Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
            txtCampo(2).SetFocus
        End If

Case 3
        'Naturaleza
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(3).Text) = "" Then
            lblDescripcion(3).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_naturaleza_trn"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(3).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Naturaleza " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(3)
             PMChequea sqlconn&
         Else
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(3).SetFocus
         End If
         
    Case 4
        'Concepto
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(4).Text) = "" Then
            lblDescripcion(4).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_concepto_contable"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(4).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Naturaleza " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(4)
             PMChequea sqlconn&
         Else
            txtCampo(4).Text = ""
            lblDescripcion(4).Caption = ""
            txtCampo(4).SetFocus
         End If
    Case 5
        'Indicadores
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(5).Text) = "" Then
            lblDescripcion(5).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cc_tipo_indicador"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(5).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Indicador " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(5)
             PMChequea sqlconn&
         Else
            txtCampo(5).Text = ""
            lblDescripcion(5).Caption = ""
            txtCampo(5).SetFocus
         End If
        
    Case 6
        'TipoTotal
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(6).Text) = "" Then
            lblDescripcion(6).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "re_campo_totaliza"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(6).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Total " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(6)
             PMChequea sqlconn&
         Else
            txtCampo(6).Text = ""
            lblDescripcion(6).Caption = ""
            txtCampo(6).SetFocus
         End If
         
    Case 7
        'Impuesto
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            lblDescripcion(7).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "cb_tipo_impuesto"
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, (txtCampo(7).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Impuesto " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(7)
             PMChequea sqlconn&
         Else
            txtCampo(7).Text = ""
            lblDescripcion(7).Caption = ""
            txtCampo(7).SetFocus
         End If
    
    Case 0
        'Productos COBIS
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            lblDescripcion(0).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
         PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (txtCampo(0).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " Consulta de Producto " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
        Else
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
        End If

        If txtCampo(0).Text = "3" Then
        End If
            
   

    End Select
End Sub


Private Sub PLIngresar()

    ' Valida mandatoriedades
    
    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(3).Text) = "" Then
        MsgBox "La Naturaleza de la transacción es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(3).Enabled = True Then txtCampo(3).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El campo código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(4).Text) = "" Then
        MsgBox "El campo concepto es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(6).Text) = "" Then
        MsgBox "El campo Tipo Total es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(6).Enabled = True Then txtCampo(6).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(7).Text) <> "" And CmbContab(1).Text = "" Then
        MsgBox "Debe diligenciarse Campo Base1 si se escogió Tipo Impuesto", 0 + 16, "Mensaje de Error"
        If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(2).Text) = "" Then
        VTCausaOrg$ = "0"
    Else
        VTCausaOrg$ = txtCampo(2).Text
    End If

    If Trim$(txtCampo(5).Text) = "" Then
        VTIndicador$ = "0"
    Else
        VTIndicador$ = txtCampo(5).Text
    End If

    If txtCampo(2).Enabled = True And VTCausaOrg$ = "0" Then
        Msg$ = "Transaccion maneja causal, Desea parametrizar concepto generico ?"
        If MsgBox(Msg$, 4) = 6 Then
         txtCampo(2).SetFocus
         Exit Sub
        End If
    End If
    
    
       
        
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "708"
     PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
     PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(0).Text)
     PMPasoValores sqlconn&, "@i_credeb", 0, SQLCHAR, (txtCampo(3).Text)
     PMPasoValores sqlconn&, "@i_tipo_tran", 0, SQLINT2, (txtCampo(1).Text)
     PMPasoValores sqlconn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
     PMPasoValores sqlconn&, "@i_indicador", 0, SQLINT1, VTIndicador$
     
     PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, (CmbContab(0).Text)
     PMPasoValores sqlconn&, "@i_base1", 0, SQLVARCHAR, (CmbContab(1).Text)
     PMPasoValores sqlconn&, "@i_totaliza", 0, SQLCHAR, (txtCampo(6).Text)
     
     PMPasoValores sqlconn&, "@i_tipo_imp", 0, SQLCHAR, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_base2", 0, SQLVARCHAR, (CmbContab(2).Text)
     
     
     
     
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_parctocble", True, "OK ingreso de Transacción a Contabilizar") Then
        txtCampo(0).SetFocus
    End If
     PMChequea sqlconn&
    PLLimpiar
End Sub


Private Sub PLLimpiar()

    For i% = 0 To 7
        lblDescripcion(i%).Caption = ""
        txtCampo(i%).Text = ""
    Next i%
       
    PMLimpiaGrid Grid1
    
    ' Actualizar
    cmdBoton(4).Enabled = False
    ' Eliminar
    cmdBoton(5).Enabled = False
    ' Ingresar
    cmdBoton(3).Enabled = True
        
    CmbContab(0).ListIndex = -1
    CmbContab(1).ListIndex = -1
    CmbContab(2).ListIndex = -1
    
    txtCampo(0).Enabled = True
    
End Sub

Private Sub PLModificar()

    If VLSecuencial$ <> "" Then
    
        ' Valida mandatoriedades
        
   If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El código de producto es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(0).Enabled = True Then txtCampo(0).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(3).Text) = "" Then
        MsgBox "La Naturaleza de la transacción es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(3).Enabled = True Then txtCampo(3).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El campo código de transacción es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(1).Enabled = True Then txtCampo(1).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(4).Text) = "" Then
        MsgBox "El campo concepto es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(4).Enabled = True Then txtCampo(4).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(6).Text) = "" Then
        MsgBox "El campo Tipo Total es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(6).Enabled = True Then txtCampo(6).SetFocus
        Exit Sub
    End If
    
    If Trim$(txtCampo(7).Text) <> "" And CmbContab(1).Text = "" Then
        MsgBox "Debe diligenciarse Campo Base1 si se escogió Tipo Impuesto", 0 + 16, "Mensaje de Error"
        If txtCampo(7).Enabled = True Then txtCampo(7).SetFocus
        Exit Sub
    End If
    
    
    
        If Trim$(txtCampo(2).Text) = "" Then
            VTCausaOrg$ = "0"
        Else
            VTCausaOrg$ = txtCampo(2).Text
        End If
    
       
        If Trim$(txtCampo(5).Text) = "" Then
            VTIndicador$ = "0"
        Else
            VTIndicador$ = txtCampo(5).Text
        End If
    
   If txtCampo(2).Enabled = True And VTCausaOrg$ = "0" Then
        Msg$ = "Transaccion maneja causal, Desea parametrizar concepto generico ?"
        If MsgBox(Msg$, 4) = 6 Then
         txtCampo(2).SetFocus
         Exit Sub
        End If
    End If

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "710"
     PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
     PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(0).Text)
     PMPasoValores sqlconn&, "@i_credeb", 0, SQLCHAR, (txtCampo(3).Text)
     PMPasoValores sqlconn&, "@i_tipo_tran", 0, SQLINT2, (txtCampo(1).Text)
     PMPasoValores sqlconn&, "@i_causa_org", 0, SQLVARCHAR, VTCausaOrg$
     PMPasoValores sqlconn&, "@i_indicador", 0, SQLINT1, VTIndicador$
     
     PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, (CmbContab(0).Text)
     PMPasoValores sqlconn&, "@i_base1", 0, SQLVARCHAR, (CmbContab(1).Text)
     PMPasoValores sqlconn&, "@i_totaliza", 0, SQLCHAR, (txtCampo(6).Text)
     
     PMPasoValores sqlconn&, "@i_tipo_imp", 0, SQLCHAR, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_base2", 0, SQLVARCHAR, (CmbContab(2).Text)
     
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VLSecuencial$
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_parctocble", True, "OK Modif de Transacción a Contabilizar") Then
            PMChequea sqlconn&
            txtCampo(1).SetFocus
        End If
    Else
        MsgBox "Transacción a modificarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If
    PLLimpiar
End Sub


Private Sub PLBuscar()

    Dim VTRegistros As Integer
    Dim VTSecuencial As String
    Dim VTFlag As Integer
    Dim VTCodigoTrn As String
    Dim VTBusqueda As String
    Dim VLCausa As String
    ' La busqueda se realiza por producto

    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If

    ' Traer las definciones de perfiles contables para un
    ' producto determinado

    VTRegistros% = 20
    VTSecuencial$ = "0"
    VTFlag% = False

    VTCodigoTrn$ = Trim$(txtCampo(1).Text)
    If VTCodigoTrn$ = "" Then
        VTBusqueda$ = "P"
        VTCodigoTrn$ = "0"
    Else
        VTBusqueda$ = "T"
    End If

    If txtCampo(2).Text = "" Then
        VLCausa$ = "0"
    Else
        VLCausa$ = txtCampo(2).Text
        VTBusqueda$ = "C"
    End If

    While VTRegistros% = 20
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "719"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, VTBusqueda$
         'PMPasoValores SqlConn&, "@i_causa", 0, SQLINT4, VLCausa$
         PMPasoValores sqlconn&, "@i_causa_org", 0, SQLCHAR, VLCausa$
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VTSecuencial$
         PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_tipo_tran", 0, SQLINT2, VTCodigoTrn$
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_parctocble", True, "OK consulta de Transacciones a Contabilizar") Then
             PMMapeaGrid sqlconn&, Grid1, VTFlag%
             PMChequea sqlconn&
            VTFlag% = True
            VTRegistros% = Val(Grid1.Tag)
            'GYA Activa Boton Imprimir.
          '  If VTRegistros% > 0 Then
          '     cmdBoton(4).Enabled = True
          '  End If
            
            Grid1.Row = Grid1.Rows - 1
            Grid1.Col = 8
            VTSecuencial$ = Grid1.Text
            Grid1.Col = 1
            VTCodigoTrn$ = Grid1.Text
        Else
            VTRegistros% = 0
        End If
    Wend
    Grid1.ColWidth(2) = 1600
    Grid1.ColWidth(4) = 1000
    Grid1.ColWidth(5) = 1000
    Grid1.ColWidth(6) = 900
    Grid1.ColWidth(7) = 1200
    Grid1.ColWidth(8) = 650
    Grid1.ColWidth(9) = 700
  '  Grid1.ColWidth(10) = 800
   ' Grid1.ColWidth(11) = 1
    'Grid1.ColWidth(12) = 700
    'Grid1.ColWidth(13) = 700
    
   
End Sub


Private Sub Grid1_Click()
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
End Sub

Private Sub Grid1_DblClick()
    
    Dim VT As String
    Dim Indice As Integer
    
    txtCampo(0).Enabled = False

    ' Verificar que existan transacciones para procesar
    If Grid1.Rows <= 2 Then
        Grid1.Row = 1
        Grid1.Col = 1
        If Trim$(Grid1.Text) = "" Then
            MsgBox "No existen transacciones para procesar", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
    End If

    'Escoge los datos del registro a procesar

    VLTabla$ = ""
    txtCampo(2).Enabled = False
    For i% = 1 To UBound(VLMatrizTrans, 2)
        If txtCampo(1).Text = VLMatrizTrans(0, i%) Then
            VLTabla$ = VLMatrizTrans(1, i%)
            txtCampo(2).Enabled = True
            Exit For
        End If
    Next i%

    
    ' Signo de Contabilizacion
    Grid1.Col = 2
    txtCampo(3).Text = Trim$(Grid1.Text)
    If txtCampo(3).Text = "C" Then
        lblDescripcion(3).Caption = "CREDITO"
    Else
        lblDescripcion(3).Caption = "DEBITO"
    End If

    ' Causa origen de la transaccion
    Grid1.Col = 3
    If Trim$(Grid1.Text) <> "0" Then
'FIXIT: Replace 'LTrim' function with 'LTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'RTrim' function with 'RTrim$' function                                    FixIT90210ae-R9757-R1B8ZE
        txtCampo(2).Text = LTrim$(RTrim$(Trim$(Grid1.Text)))
        If VLTabla$ <> "" And txtCampo(2).Text <> "" Then
            If Not IsNumeric(Trim$(Grid1.Text)) Then
                txtCampo(2).Text = Trim$(Grid1.Text)
                PMCatalogo "V", VLTabla$, txtCampo(2), lblDescripcion(2)
            Else
                If txtCampo(1).Text = "48" Or txtCampo(1).Text = "50" Or txtCampo(1).Text = "264" Or txtCampo(1).Text = "253" Then
                    causa_sus = CInt(txtCampo(2).Text)
                    causa$ = txtCampo(2).Text
                    If causa_sus > 500 Then
                        causa_sus = causa_sus - 500
                    End If
                Else
                    causa = txtCampo(2).Text
                    causa_sus = txtCampo(2).Text
                End If
                txtCampo(2).Text = CStr(causa_sus)
                PMCatalogo "V", VLTabla$, txtCampo(2), lblDescripcion(2)
                txtCampo(2).Text = causa
                If CInt(txtCampo(2).Text) > 500 Then
                    lblDescripcion(2).Caption = "VALOR EN SUSPENSO POR " + lblDescripcion(2).Caption
                End If
            End If
        Else
            txtCampo(2) = ""
            lblDescripcion(2) = ""
        End If
    Else
        txtCampo(2).Text = Trim$(Grid1.Text)
        lblDescripcion(2).Caption = ""
    End If

    ' Causa
    Grid1.Col = 3
    txtCampo(2).Text = Grid1.Text
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If txtCampo(2).Text <> "0" And Trim$(txtCampo(2).Text) <> "" Then
       txtCampo_LostFocus (2)
    End If
    ' Indicador de la transaccion
    Grid1.Col = 4
    If Trim$(Grid1.Text) <> "0" Then
        txtCampo(5).Text = Trim$(Grid1.Text)
        PMCatalogo "V", "cc_tipo_indicador", txtCampo(5), lblDescripcion(5)
    Else
        txtCampo(5) = ""
        lblDescripcion(5) = ""
    End If
    
    CmbContab(0).ListIndex = -1
    CmbContab(1).ListIndex = -1
    CmbContab(2).ListIndex = -1
    
    ' Campo acontabilizar
    Grid1.Col = 5
    If Grid1.Text <> "" Then
        VT$ = "N"
        For i% = 0 To CmbContab(0).ListCount - 1
            CmbContab(0).ListIndex = i%
            If Trim$(Grid1.Text) = CmbContab(0).Text Then
                Indice% = i%
                VT$ = "S"
                i% = CmbContab(0).ListCount + 1
            End If
            
        Next i%
        If VT$ = "S" Then
            CmbContab(0).ListIndex = Indice%
        Else
            CmbContab(0).ListIndex = -1
        End If
    End If
    
    Grid1.Col = 10
    If Grid1.Text <> "" Then
        VT$ = "N"
        For i% = 0 To CmbContab(1).ListCount - 1
            CmbContab(1).ListIndex = i%
            If Trim$(Grid1.Text) = CmbContab(1).Text Then
                Indice% = i%
                VT$ = "S"
                i% = CmbContab(1).ListCount + 1
            End If
            
        Next i%
        If VT$ = "S" Then
            CmbContab(1).ListIndex = Indice%
        Else
            CmbContab(1).ListIndex = -1
        End If
    End If
    
    Grid1.Col = 11
    If Grid1.Text <> "" Then
        VT$ = "N"
        For i% = 0 To CmbContab(2).ListCount - 1
            CmbContab(2).ListIndex = i%
            If Trim$(Grid1.Text) = CmbContab(2).Text Then
                Indice% = i%
                VT$ = "S"
                i% = CmbContab(2).ListCount + 1
            End If
            
        Next i%
        If VT$ = "S" Then
            CmbContab(2).ListIndex = Indice%
        Else
            CmbContab(2).ListIndex = -1
        End If
    End If

    
    
    ' Guardar el secuenciial para la actualizacion
    Grid1.Col = 8
    VLSecuencial$ = Grid1.Text
    
    
    
    'Totaliza
    Grid1.Col = 9
    If Trim$(Grid1.Text) <> "" Then
        txtCampo(6).Text = Trim$(Grid1.Text)
        PMCatalogo "V", "re_campo_totaliza", txtCampo(6), lblDescripcion(6)
    End If
    
    'Concepto
    Grid1.Col = 12
    If Trim$(Grid1.Text) <> "" Then
        txtCampo(4).Text = Trim$(Grid1.Text)
        PMCatalogo "V", "re_concepto_contable", txtCampo(4), lblDescripcion(4)
    End If
    
    'Tipo Impuesto
    Grid1.Col = 13
    If Trim$(Grid1.Text) <> "" Then
        txtCampo(7).Text = Trim$(Grid1.Text)
        PMCatalogo "V", "cb_tipo_impuesto", txtCampo(7), lblDescripcion(7)
    End If
    
    
           
    
    ' Actualizar
    cmdBoton(4).Enabled = True
    ' Ingresar
    cmdBoton(3).Enabled = False
    ' Eliminar
    cmdBoton(5).Enabled = True

End Sub
Private Sub PLParametro()
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1579"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "F"
     PMPasoValores sqlconn&, "@i_nemonico", 0, SQLVARCHAR, "TGMFBA"
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_parametro", True, "Ok.. Consulta de Nivel Máximo de Autorización") Then
         PMMapeaVariable sqlconn&, VLParametro$
         PMChequea sqlconn&
    End If
End Sub

Private Sub PLEliminar()

    If VLSecuencial$ <> "" Then
   
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "709"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, VLSecuencial$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_rem_parctocble", True, "OK Eliminación de Transacción a Contabilizar") Then
             PMChequea sqlconn&
             PLBuscar
             cmdBoton(4).Enabled = False
             cmdBoton(5).Enabled = False
        End If
        
    Else
        MsgBox "Transacción a eliminarse no seleccionada", 0 + 16, "Mensaje de Error"
    End If
   

End Sub


