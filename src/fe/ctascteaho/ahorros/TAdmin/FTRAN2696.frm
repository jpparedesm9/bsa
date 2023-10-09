VERSION 5.00
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FTran2696 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento Otros Ingresos-Egresos Caja"
   ClientHeight    =   5385
   ClientLeft      =   225
   ClientTop       =   1785
   ClientWidth     =   9330
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H00000000&
   HelpContextID   =   1111
   Icon            =   "FTRAN2696.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5385
   ScaleWidth      =   9330
   Begin FPSpreadADO.fpSpread grdCausas 
      Height          =   3360
      Left            =   60
      TabIndex        =   10
      Top             =   1980
      Width           =   3645
      _Version        =   393216
      _ExtentX        =   6429
      _ExtentY        =   5927
      _StockProps     =   64
      AutoClipboard   =   0   'False
      DAutoSizeCols   =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      GridColor       =   4210752
      MaxCols         =   2
      MaxRows         =   20
      NoBeep          =   -1  'True
      RestrictCols    =   -1  'True
      RestrictRows    =   -1  'True
      RowHeaderDisplay=   0
      ShadowColor     =   12648447
      SpreadDesigner  =   "FTRAN2696.frx":030A
      UnitType        =   2
      VisibleCols     =   500
      VisibleRows     =   500
   End
   Begin FPSpreadADO.fpSpread grdCaja 
      Height          =   3375
      Left            =   4635
      TabIndex        =   12
      Top             =   1980
      Width           =   3705
      _Version        =   393216
      _ExtentX        =   6535
      _ExtentY        =   5953
      _StockProps     =   64
      AutoClipboard   =   0   'False
      DAutoSizeCols   =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   2
      MaxRows         =   20
      NoBeep          =   -1  'True
      RestrictCols    =   -1  'True
      RestrictRows    =   -1  'True
      RowHeaderDisplay=   0
      ShadowColor     =   12648447
      SpreadDesigner  =   "FTRAN2696.frx":0599
      UnitType        =   2
      VisibleCols     =   500
      VisibleRows     =   500
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   8640
      Picture         =   "FTRAN2696.frx":081C
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   22
      Top             =   2580
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   8850
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   21
      Top             =   2580
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.Frame fra_ndnc 
      ForeColor       =   &H000000FF&
      Height          =   1740
      Left            =   60
      TabIndex        =   16
      Top             =   -45
      Width           =   8295
      Begin VB.Frame Frame1 
         Caption         =   "Destino  de Causales"
         ForeColor       =   &H00000080&
         Height          =   640
         Left            =   4320
         TabIndex        =   25
         Top             =   720
         Width           =   3700
         Begin VB.OptionButton Opttipo 
            Caption         =   "Data Entry"
            ForeColor       =   &H00800000&
            Height          =   210
            Index           =   1
            Left            =   2040
            TabIndex        =   15
            Top             =   290
            Width           =   1515
         End
         Begin VB.OptionButton Opttipo 
            Caption         =   "Caja"
            ForeColor       =   &H00800000&
            Height          =   210
            Index           =   0
            Left            =   240
            TabIndex        =   4
            Top             =   290
            Value           =   -1  'True
            Width           =   1185
         End
      End
      Begin VB.ComboBox cmbTipo 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   1320
         Style           =   2  'Dropdown List
         TabIndex        =   1
         ToolTipText     =   "Producto "
         Top             =   720
         Width           =   2805
      End
      Begin VB.TextBox txt_codigo 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1320
         MaxLength       =   3
         TabIndex        =   2
         ToolTipText     =   "Codigo de causa"
         Top             =   1095
         Width           =   1005
      End
      Begin VB.TextBox txt_Descripcion 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1320
         MaxLength       =   50
         TabIndex        =   3
         ToolTipText     =   "Descripcion de la causa "
         Top             =   1395
         Width           =   6705
      End
      Begin Threed.SSFrame Frame3D2 
         Height          =   495
         Left            =   120
         TabIndex        =   19
         Top             =   120
         Width           =   7905
         _Version        =   65536
         _ExtentX        =   13944
         _ExtentY        =   873
         _StockProps     =   14
         ForeColor       =   255
         BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
            Name            =   "MS Sans Serif"
            Size            =   8.25
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Alignment       =   2
         Begin Threed.SSOption optOper 
            Height          =   210
            Index           =   1
            Left            =   1845
            TabIndex        =   0
            TabStop         =   0   'False
            Tag             =   "S"
            Top             =   510
            Width           =   1710
            _Version        =   65536
            _ExtentX        =   3016
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Nota de &Débito:"
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
            Alignment       =   1
         End
         Begin Threed.SSOption optOper 
            Height          =   210
            Index           =   0
            Left            =   150
            TabIndex        =   9
            Tag             =   "S"
            Top             =   510
            Width           =   1680
            _Version        =   65536
            _ExtentX        =   2963
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Nota de &Crédito:"
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
            Alignment       =   1
         End
         Begin Threed.SSOption optOper 
            Height          =   210
            Index           =   2
            Left            =   1200
            TabIndex        =   13
            TabStop         =   0   'False
            Tag             =   "S"
            Top             =   180
            Width           =   1710
            _Version        =   65536
            _ExtentX        =   3016
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Otros Ingresos:"
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
            Alignment       =   1
            Value           =   -1  'True
         End
         Begin Threed.SSOption optOper 
            Height          =   210
            Index           =   3
            Left            =   4710
            TabIndex        =   14
            TabStop         =   0   'False
            Tag             =   "S"
            Top             =   165
            Width           =   1710
            _Version        =   65536
            _ExtentX        =   3016
            _ExtentY        =   370
            _StockProps     =   78
            Caption         =   "Otros Egresos:"
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
            Alignment       =   1
         End
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   4
         Left            =   60
         TabIndex        =   20
         Top             =   765
         Width           =   840
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Código :"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   60
         TabIndex        =   18
         Top             =   1095
         Width           =   720
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Descripción :"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   60
         TabIndex        =   17
         Top             =   1455
         Width           =   1140
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8445
      TabIndex        =   7
      Top             =   3840
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Limpiar"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN2696.frx":08F6
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8445
      TabIndex        =   8
      Top             =   4605
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Salir"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN2696.frx":0912
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8445
      TabIndex        =   6
      Tag             =   "2548"
      Top             =   3080
      WhatsThisHelpID =   2030
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Crear"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN2696.frx":092E
   End
   Begin Threed.SSCommand cmdBoton 
      DragIcon        =   "FTRAN2696.frx":094A
      Height          =   855
      Index           =   2
      Left            =   3750
      TabIndex        =   11
      Top             =   3045
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1508
      _StockProps     =   78
      Caption         =   "&Asignar"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN2696.frx":0C54
   End
   Begin Threed.SSCommand cmdBuscar 
      Height          =   750
      Index           =   0
      Left            =   8445
      TabIndex        =   5
      Top             =   15
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Buscar"
      ForeColor       =   8388608
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRAN2696.frx":0F6E
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causales ND/NC  :"
      ForeColor       =   &H00000080&
      Height          =   195
      Index           =   3
      Left            =   4635
      TabIndex        =   24
      Top             =   1755
      Width           =   1635
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causales ND/NC Generales :"
      ForeColor       =   &H00000080&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   23
      Top             =   1770
      Width           =   2490
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1755
      Y2              =   1755
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8415
      X2              =   8415
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FTran2696"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10

Dim VLTabla$
Dim VLTablaCC$
Dim VLInicioRow As Long
Dim VLFinRow As Long
Dim SS_ACTIVE_CELL As Integer
Dim RowHeaderDisplay As Integer
Private Sub cmbTipo_Click()
    PLBuscar
End Sub

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo Producto "
End Sub

Private Sub cmdBoton_Click(Index As Integer)

    Select Case Index%
  '  Case 0 'Buscar
  '      PLBuscar
    Case 1 'Crear
        PLCrear
    Case 2 'Asignar
        PLAsignar
    Case 3 'Salir
        Unload FTran2696
    Case 4 'Limpiar
        'PLLimpiar
        txt_codigo.Text = ""
        txt_Descripcion.Text = ""
        PLHabilitar
        txt_codigo.SetFocus
        
    Case 5 'Escoger
        PLEscoger
    End Select
End Sub

Private Sub cmdBuscar_Click(Index As Integer)
    PLBuscar
End Sub

Private Sub Form_Load()
    Dim VLProd As String
    FTran2696.Left = 15
    FTran2696.Top = 15
    FTran2696.Width = 9420
    FTran2696.Height = 5865
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
    'cmdBoton(2).Enabled = False
    
    grdCausas.Row = 0
    grdCausas.Col = 1
    grdCausas.Text = "CODIGO"
    grdCausas.Col = 2
    grdCausas.Text = "DESCRIPCION"
    grdCausas.ColWidth(1) = 1000 'SEC
    grdCausas.ColWidth(2) = 3000
    
    grdCausas.Lock = True
        
    grdCausas.Row = -1
    grdCausas.Col = 0
    grdCausas.CellType = 7     '10 SS_CELL_TYPE_CHECKBOX
    grdCausas.TypeCheckCenter = True
    
    grdCaja.Row = 0
    grdCaja.Col = 1
    grdCaja.Text = "CODIGO"
    grdCaja.Col = 2
    grdCaja.Text = "DESCRIPCION"
    grdCaja.ColWidth(1) = 1000 'SEC
    grdCaja.ColWidth(2) = 3000
    
    'grdCausas.Lock = True

    grdCaja.Row = -1
    grdCaja.Col = 0
    grdCaja.CellType = 7     '10 SS_CELL_TYPE_CHECKBOX
    grdCaja.TypeCheckCenter = True
    
    
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        VLProd$ = "CTE"
    Else
        VLProd$ = "AHO"
    End If
        
    optOper(2).Value = True
    optOper_Click 2, 1
    PMLoadResStrings Me
    PMLoadResIcons Me

End Sub

Private Sub grdCausas_BlockSelected(ByVal BlockCol As Long, ByVal Blockrow As Long, ByVal BlockCol2 As Long, ByVal BlockRow2 As Long)
    VLInicioRow = Blockrow
    VLFinRow = BlockRow2
End Sub

Private Sub grdCausas_DblClick(ByVal Col As Long, ByVal Row As Long)
    Dim grdcell As Integer
    grdCausas.Col = 1
    grdCausas.Col2 = 3
    grdCausas.Row = grdCausas.ActiveRow
    If grdCausas.Row = 0 Then
        grdCausas.Row = 1
        grdCausas.Row2 = 1
    Else
        grdCausas.Row = Row
        grdCausas.Row2 = Row
    End If
    grdCausas.Action = 2 'SS_ACTION_SELECT_BLOCK
    
    VLInicioRow = grdCausas.Row
    VLFinRow = grdCausas.Row2
    

        grdCausas.Col = 0
        grdcell = grdCausas.CellType
        If grdcell = 10 Then
            PMCeldaEstatica CLng(grdCausas.ActiveRow), CLng(grdCausas.Col), "", 2
        Else
            If grdcell = 7 Or grdcell <> 10 Then
                 PMCeldaPicture CLng(grdCausas.ActiveRow), CLng(grdCausas.Col), picVisto(0)
            End If
       End If
    VLInicioRow& = 0
    VLFinRow& = 0
End Sub

Private Sub optOper_Click(Index As Integer, Value As Integer)

'Si se escoge OI/OE se debe bloquear el destino a caja solamente y como
'unico producto CTE
If Index = 2 Or Index = 3 Then
    cmbTipo.Enabled = False
'    Opttipo(0).SetFocus
'    Opttipo(1).Enabled = False
    cmbTipo.Text = "CUENTA CORRIENTE"
    
    lblEtiqueta(2) = "Causales OI/OE Generales :"
    lblEtiqueta(3) = "Causales OI/OE  :"
    
Else
    Opttipo(1).Enabled = True
    cmbTipo.Enabled = True
    lblEtiqueta(2) = "Causales ND/NC Generales :"
    lblEtiqueta(3) = "Causales ND/NC  :"
    
End If

'If optOper(2).Value = True Then 'Otros Ingresos
'
'        VLTOpera$ = "I"
'        VLProd$ = "CTE"
'        VLTabla$ = "cc_causa_oioe"
'
'        If Opttipo(0) Then
'          VLTablaCC$ = "cc_causa_oioe_caja"
'        End If
'
'ElseIf optOper(3).Value = True Then 'Otros Egresos
'
'        VLTOpera$ = "E"
'        VLProd$ = "CTE"
'        VLTabla$ = "cc_causa_oe"
'
'        If Opttipo(0) Then
'          VLTablaCC$ = "cc_causa_oe_caja"
'        End If
'
'End If

    PLOperacion
    PLBuscar
    'PLBuscarcaja
        
End Sub
Private Sub PMCeldaPicture(fila As Long, columna As Long, figura As PictureBox)
    'Fija las variables para una celda y coloca un Picture en la misma
    grdCausas.Row = grdCausas.ActiveRow
    grdCausas.Col = 0 'columna
    grdCausas.CellType = 10 'SS_CELL_TYPE_PICTURE
    grdCausas.TypeCheckCenter = True
End Sub

Private Sub PLBuscar()
        
    PLOperacion
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdCausas, False
        PMChequea sqlconn&
        grdCausas.Col = 1
        grdCausas.Action = SS_ACTIVE_CELL
        grdCausas.Row = 0
        grdCausas.Col = 1
        grdCausas.Text = "CODIGO"
        grdCausas.Col = 2
        grdCausas.Text = "DESCRIPCION"
        grdCausas.ColWidth(1) = 1000 'SEC
        grdCausas.ColWidth(2) = 3000
        RowHeaderDisplay = 0
    End If
    PLBuscarcaja

End Sub

Private Sub PLBuscarcaja()
    
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
     PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTablaCC$
     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
     PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdCaja, False
        PMChequea sqlconn&
        grdCaja.Col = 1
        grdCaja.Action = SS_ACTIVE_CELL
        grdCaja.Row = 0
        grdCaja.Col = 1
        grdCaja.Text = "CODIGO"
        grdCaja.Col = 2
        grdCaja.Text = "DESCRIPCION"
        grdCaja.ColWidth(1) = 1000 'SEC
        grdCaja.ColWidth(2) = 3000
        RowHeaderDisplay = 0
    Else
        grdCaja.Col = 1
        grdCaja.Action = SS_ACTIVE_CELL
        grdCaja.Row = 0
        grdCaja.Col = 1
        grdCaja.Text = "CODIGO"
        grdCaja.Col = 2
        grdCaja.Text = "DESCRIPCION"
        grdCaja.ColWidth(1) = 1000 'SEC
        grdCaja.ColWidth(2) = 3000
        grdCaja.MaxRows = 0
        RowHeaderDisplay = 0
    End If

End Sub

Private Sub PMCeldaEstatica(fila As Long, columna As Long, Texto$, alineacion%)
    'Fija las variables de una celda para que
    'el texto desplegado no pueda ser alterado
    'por el usuario en la ejecucion del programa
    grdCausas.Row = grdCausas.ActiveRow
    grdCausas.Col = columna
    grdCausas.CellType = 7 ' SS_CELL_TYPE_STATIC_TEXT
    grdCausas.TypeCheckCenter = False
End Sub


Private Sub PLEscoger()
    Dim fila As Integer
    fila = grdCausas.ActiveRow
    grdCausas.Row = fila
    grdCausas.Col = 1
    txt_codigo.Text = grdCausas.Text
    grdCausas.Col = 2
    txt_Descripcion.Text = grdCausas.Text
End Sub

Private Sub PLCrear()

    PLOperacion
    If txt_codigo.Text <> "" And txt_Descripcion.Text <> "" Then
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "584"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
        PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
        PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, txt_codigo.Text
        PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txt_Descripcion.Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo", True, " Ok... Inserccion de Catalogo ") Then
           PMChequea sqlconn&
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "584"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
            PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTablaCC$
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, txt_codigo.Text
            PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, txt_Descripcion.Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo", True, " Ok... Inserccion de Catalogo ") Then
               PMChequea sqlconn&
               PLBuscar
               PLDeshabilitar
            End If
            MsgBox "La causal ha sido ingresada", vbInformation, "Ingresa Causales"
        End If
    Else
       MsgBox "Código y Descripción son obligatorios", vbInformation, "Datos Obligatorios"
       txt_codigo.SetFocus
    End If
        
End Sub
Private Sub PLAsignar()
    Dim VLBan As Integer
    Dim i As Integer
    PLOperacion
    VLBan = 0
    If grdCausas.MaxRows > 1 Then
        For i% = 1 To grdCausas.MaxRows
             grdCausas.Col = 0
             grdCausas.Row = i%
             'GYA Validaciones Mensaje Error
             If grdCausas.CellType = CellTypeCheckBox Then
                 VLBan = 1
             End If
             If grdCausas.CellType = 10 And grdCausas.BackColor <> QBColor(10) Then
                  PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "584"
                  PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
                  PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTablaCC$
                  grdCausas.Col = 1
                  PMPasoValores sqlconn&, "@i_codigo", 0, SQLCHAR, grdCausas.Text
                  grdCausas.Col = 2
                  PMPasoValores sqlconn&, "@i_descripcion", 0, SQLCHAR, grdCausas.Text
                  If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_catalogo", True, " Ok... Catalogo de ND/NC Caja") Then
                     PMChequea sqlconn&
                         grdCausas.Row = i%
                         grdCausas.Col = -1
                         grdCausas.BackColor = QBColor(10)
                         
                  Else
                         grdCausas.Row = i%
                         grdCausas.Col = -1
                         grdCausas.BackColor = QBColor(14)
                 End If
              End If
                
         Next i%
         If VLBan = 0 Then
            MsgBox "Debe seleccionar un registro para asignar", vbCritical, "Mantenimiento Causales"
          ' Exit Sub
         Else
           MsgBox "Se generaron las causales satisfactoriamente en el Central, espere un momento actualizacion de catalogos", 0 + 64, "Mensaje de Información"
           PLBuscarcaja
         End If
    End If
End Sub

Private Sub optTipo_Click(Index As Integer)

    PLOperacion
    PLBuscar
End Sub

Private Sub optTipo_GotFocus(Index As Integer)
   FPrincipal!pnlHelpLine.Caption = " Destino de Causales "
End Sub

Private Sub txt_codigo_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Codigo "
End Sub

Private Sub txt_codigo_KeyPress(KeyAscii As Integer)
  If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
End Sub

Private Sub txt_codigo_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Clipboard.Clear
End Sub

Private Sub txt_Descripcion_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Descripcion de la ND/NC "
End Sub

Private Sub txt_Descripcion_KeyPress(KeyAscii As Integer)

If (KeyAscii% <> 8) And (KeyAscii% <> 32) And _
    (KeyAscii% < 65 Or KeyAscii% > 90) And (KeyAscii% < 48 Or KeyAscii% > 57) And (KeyAscii% < 97 Or KeyAscii% > 122) Then
        KeyAscii% = 0
Else
        KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End If
   
End Sub

Private Sub PLOperacion()
    Dim VLProd As String
    Dim VLTOpera As String
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
            VLProd$ = "CTE"
    Else
            VLProd$ = "AHO"
    End If
    

    If optOper(0).Value = True Then
        VLTOpera$ = "C"
        If VLProd$ = "CTE" Then
            VLTabla$ = "cc_causa_nc"
            If Opttipo(0) Then
              VLTablaCC$ = "cc_causa_nc_caja"
             Else
                VLTablaCC$ = "cc_causa_nc_data"
             End If
        Else
            VLTabla$ = "ah_causa_nc"
            
            If Opttipo(0) Then
              VLTablaCC$ = "ah_causa_nc_caja"
             Else
                VLTablaCC$ = "ah_causa_nc_data"
             End If
        End If
        
    ElseIf optOper(1).Value = True Then
            VLTOpera$ = "D"
            If VLProd$ = "CTE" Then
                VLTabla$ = "cc_causa_nd"
                
                If Opttipo(0) Then
                  VLTablaCC$ = "cc_causa_nd_caja"
                 Else
                    VLTablaCC$ = "cc_causa_nd_data"
                 End If
                            
            Else
                VLTabla$ = "ah_causa_nd"
                
                 If Opttipo(0) Then
                  VLTablaCC$ = "ah_causa_nd_caja"
                 Else
                    VLTablaCC$ = "ah_causa_nd_data"
                 End If
                
            End If
    
''''''''''''''''
    ElseIf optOper(2).Value = True Then 'Otros Ingresos
       
        VLTOpera$ = "I"
        VLProd$ = "CTE"
        VLTabla$ = "cc_causa_oioe"
                
        If Opttipo(0) Then
          VLTablaCC$ = "cc_causa_oioe_caja"
        End If
                            
    ElseIf optOper(3).Value = True Then 'Otros Egresos
        
        VLTOpera$ = "E"
        VLProd$ = "CTE"
        VLTabla$ = "cc_causa_oe"
                
        If Opttipo(0) Then
          VLTablaCC$ = "cc_causa_oe_caja"
        End If
                            
    End If
    
End Sub

Private Sub txt_Descripcion_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
Clipboard.Clear
End Sub
Public Sub PLDeshabilitar()
txt_codigo.Enabled = False
txt_Descripcion.Enabled = False
End Sub

Public Sub PLHabilitar()
txt_codigo.Enabled = True
txt_Descripcion.Enabled = True
End Sub


