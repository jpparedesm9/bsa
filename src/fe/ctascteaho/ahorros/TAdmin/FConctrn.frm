VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FConcTrn 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Concepto Contable por Transacción"
   ClientHeight    =   5460
   ClientLeft      =   120
   ClientTop       =   1740
   ClientWidth     =   9360
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
   HelpContextID   =   1039
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5460
   ScaleWidth      =   9360
   Begin MSGrid.Grid grdConta 
      Height          =   495
      Left            =   8580
      TabIndex        =   23
      Top             =   930
      Visible         =   0   'False
      Width           =   615
      _Version        =   65536
      _ExtentX        =   1085
      _ExtentY        =   873
      _StockProps     =   77
      ForeColor       =   4210752
      BackColor       =   16777215
   End
   Begin VB.TextBox txtConcepto 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1845
      MaxLength       =   4
      TabIndex        =   31
      Top             =   1245
      Width           =   690
   End
   Begin VB.Frame Frame1 
      BackColor       =   &H00C0C0C0&
      Caption         =   "Campo del calculo de Base del Impuesto"
      ForeColor       =   &H00000080&
      Height          =   750
      Left            =   375
      TabIndex        =   26
      Top             =   1620
      Width           =   7200
      Begin VB.ComboBox CmbContab 
         Appearance      =   0  'Flat
         Height          =   315
         Index           =   1
         ItemData        =   "FConctrn.frx":0000
         Left            =   4755
         List            =   "FConctrn.frx":0002
         Style           =   2  'Dropdown List
         TabIndex        =   28
         Top             =   330
         Width           =   2040
      End
      Begin VB.ComboBox CmbContab 
         Appearance      =   0  'Flat
         Height          =   315
         Index           =   0
         ItemData        =   "FConctrn.frx":0004
         Left            =   1425
         List            =   "FConctrn.frx":0006
         Style           =   2  'Dropdown List
         TabIndex        =   27
         Top             =   330
         Width           =   2040
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   " Base 2:"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   1
         Left            =   3990
         TabIndex        =   30
         Top             =   405
         Width           =   630
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   " Base 1:"
         BeginProperty Font 
            Name            =   "Small Fonts"
            Size            =   6.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00800000&
         Height          =   165
         Index           =   6
         Left            =   390
         TabIndex        =   29
         Top             =   390
         Width           =   600
      End
   End
   Begin VB.ComboBox CmbContab 
      Appearance      =   0  'Flat
      Height          =   315
      Index           =   2
      ItemData        =   "FConctrn.frx":0008
      Left            =   6075
      List            =   "FConctrn.frx":000A
      Style           =   2  'Dropdown List
      TabIndex        =   25
      Top             =   1245
      Width           =   2190
   End
   Begin VB.TextBox txtCausal 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1845
      MaxLength       =   4
      TabIndex        =   2
      Top             =   645
      Width           =   690
   End
   Begin VB.TextBox txtTImpuesto 
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   1845
      MaxLength       =   1
      TabIndex        =   3
      Top             =   945
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1845
      MaxLength       =   4
      TabIndex        =   1
      Top             =   330
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   7
      Left            =   1845
      MaxLength       =   2
      TabIndex        =   0
      Top             =   30
      Width           =   690
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00808080&
      FillColor       =   &H00808080&
      ForeColor       =   &H00808080&
      Height          =   195
      Index           =   0
      Left            =   7560
      Picture         =   "FConctrn.frx":000C
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   16
      Top             =   1335
      Visible         =   0   'False
      Width           =   195
   End
   Begin VB.PictureBox picVisto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      ForeColor       =   &H80000008&
      Height          =   195
      Index           =   1
      Left            =   7755
      ScaleHeight     =   165
      ScaleWidth      =   165
      TabIndex        =   15
      Top             =   1320
      Visible         =   0   'False
      Width           =   195
   End
   Begin MSGrid.Grid grdTran 
      Height          =   2850
      Left            =   0
      TabIndex        =   11
      Top             =   2535
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   5027
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   15
      Left            =   8445
      TabIndex        =   4
      Top             =   60
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
      Index           =   1
      Left            =   8445
      TabIndex        =   7
      Tag             =   "2536"
      Top             =   3120
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
      Index           =   14
      Left            =   8445
      TabIndex        =   10
      Top             =   4665
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
      Index           =   17
      Left            =   8445
      TabIndex        =   9
      Top             =   3885
      WhatsThisHelpID =   2003
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Index           =   3
      Left            =   8445
      TabIndex        =   6
      Tag             =   "8002"
      Top             =   2355
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   16
      Left            =   8445
      TabIndex        =   5
      Top             =   825
      WhatsThisHelpID =   2020
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Si&guiente"
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
      Index           =   0
      Left            =   8445
      TabIndex        =   8
      Top             =   1590
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
   Begin VB.Label lblconta 
      Height          =   240
      Left            =   7665
      TabIndex        =   32
      Top             =   1875
      Visible         =   0   'False
      Width           =   540
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Campo a Contabilizar:"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00800000&
      Height          =   165
      Index           =   7
      Left            =   4095
      TabIndex        =   24
      Top             =   1320
      Width           =   1725
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2550
      TabIndex        =   22
      Top             =   630
      Width           =   5700
   End
   Begin VB.Label lblTImpuesto 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2550
      TabIndex        =   21
      Top             =   930
      Width           =   5700
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cód. Transacción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   20
      Top             =   345
      Width           =   1575
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2550
      TabIndex        =   19
      Top             =   330
      Width           =   5700
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2550
      TabIndex        =   18
      Top             =   30
      Width           =   5700
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   120
      TabIndex        =   17
      Top             =   60
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Concepto"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   105
      TabIndex        =   14
      Top             =   1245
      Width           =   825
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Impuesto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   105
      TabIndex        =   13
      Top             =   915
      Width           =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Causal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   12
      Top             =   630
      Width           =   645
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -75
      X2              =   8310
      Y1              =   2430
      Y2              =   2430
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8355
      Y1              =   -15
      Y2              =   5580
   End
End
Attribute VB_Name = "FConcTrn"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10

Dim VLParametro As String
Dim VLTabla As String
Dim VLser As String
Dim VLser1 As String
Dim VLcon As String
Dim Index As Integer
Dim causa As String
Dim VLTransac As Integer
Dim causa_sus As String





Private Sub cmdBoton_Click(Index As Integer)
   Select Case Index%
        Case 0 'trasmitir
            PLTrasmitir
        Case 1 'Eliminar
            PLEliminar
        Case 3 'Actualizar
              PLActualizar
        Case 15  ' Buscar los 20 primeros registros
            PLBuscar
        Case 16  'Siguientes
            PLSiguientes
        Case 17 'Limpiar
            PLLimpiar (True)
        Case 14 'Salir
            Unload FConcTrn
      
      End Select
End Sub


Private Sub Form_Load()

    FConcTrn.Left = 15
    FConcTrn.Top = 15
    FConcTrn.Width = 9420
    FConcTrn.Height = 5970
   
    VLTabla = "cc_campo_contable"
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Ok... Consulta de parámetros") Then
        PMMapeaGrid sqlconn&, grdConta, False
        PMChequea sqlconn&
        grdConta.col = 2
        For i% = 0 To grdConta.Rows - 2
            grdConta.Row = i% + 1
            CmbContab(0).AddItem grdConta.Text, i
            CmbContab(1).AddItem grdConta.Text, i
            CmbContab(2).AddItem grdConta.Text, i
            'CmbConta.ListIndex = 0
        Next i
    End If
    PMLoadResStrings Me
    PMLoadResIcons Me
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub PLTrasmitir()
    ' Validacion de Mandatoriedades
    
    If CmbContab(0).Text = "" And CmbContab(1).Text = "" Then
        MsgBox "El campo de Base es Obligatorio", 0 + 16, "Mensaje de Error"
        CmbContab(0).SetFocus
        Exit Sub
    End If
    
    If CmbContab(2).Text = "" Then
        MsgBox "El campo que Contabiliza el Impuesto es obligatorio", 0 + 16, "Mensaje de Error"
        CmbContab(2).SetFocus
        Exit Sub
    End If
    
    If txtCampo(7).Text = "" Then
        MsgBox "El código del Producto es Obligatorio", 0 + 16, "Mensaje de Error"
        txtCampo(7).SetFocus
        Exit Sub
    End If
    
    If txtCampo(0).Text = "" Then
        MsgBox "El código de la transaccion es Obligatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
    If txtTImpuesto.Text = "" Then
        MsgBox "El Tipo de Impuesto es Obligatorio", 0 + 16, "Mensaje de Error"
        txtTImpuesto.SetFocus
        Exit Sub
    End If
    
    If txtConcepto.Text = "" Then
        MsgBox "El Concepto es Obligatorio", 0 + 16, "Mensaje de Error"
        txtConcepto.SetFocus
        Exit Sub
    End If
    
  If CmbContab(0).Text <> "" And CmbContab(1).Text <> "" Then
        VLser$ = Mid$(CmbContab(0).List(CmbContab(0).ListIndex), 1, 3)
        VLser1$ = Mid$(CmbContab(1).List(CmbContab(1).ListIndex), 1, 3)
        If VLser$ <> VLser1$ Then
            MsgBox "Los campos base deben ser del mismo tipo", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
        End If
        
        If CmbContab(0).Text = CmbContab(1).Text Then
            MsgBox "Los campos base deben ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
        End If
  End If
  
   If CmbContab(2).Text <> "" Then
     VLcon$ = Mid$(CmbContab(2).List(CmbContab(2).ListIndex), 1, 3)
     
     If VLser$ <> "" Then
         If VLcon$ <> VLser$ Then
            MsgBox "El tipo de campo a contabilizar  y base 1 no pueden ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
         End If
     End If
     
     If VLser1$ <> "" Then
         If VLcon$ <> VLser1$ Then
            MsgBox "El tipo de campo a contabilizar  y base 2 no pueden ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
         End If
     End If
     
  End If
 
  
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4107
    PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, txtCausal.Text
    PMPasoValores sqlconn&, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text
    PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "I"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7).Text
    PMPasoValores sqlconn&, "@i_base1", 0, SQLVARCHAR, CmbContab(0).Text
    PMPasoValores sqlconn&, "@i_base2", 0, SQLVARCHAR, CmbContab(1).Text
    PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text
            
            
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_concepto_tran", True, "Ok... Ingreso de Transaccion Especifica ") Then
        PMChequea sqlconn&
        PLLimpiar (False)
        PLBuscar
    Else
        MsgBox "Error en la trasmision de la Inserción", 0 + 16, "Mensaje de Error"
    End If
    
End Sub

Private Sub PLActualizar()
    ' Validacion de Mandatoriedades
    
    If txtCampo(7).Text = "" Then
        MsgBox "El código del Producto es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtCampo(0).Text = "" Then
        MsgBox "El código de la transaccion es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtTImpuesto.Text = "" Then
        MsgBox "El Tipo de Impuesto es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtConcepto.Text = "" Then
        MsgBox "El Concepto es Obligatorio", 0 + 16, "Mensaje de Error"
        txtConcepto.SetFocus
        Exit Sub
    End If
    
    
    If CmbContab(2).Text = "" Then
        MsgBox "El campo que Contabiliza el Impuesto es obligatorio", 0 + 16, "Mensaje de Error"
        CmbContab(2).SetFocus
        Exit Sub
    End If
    
    If CmbContab(0).Text = "" And CmbContab(1).Text = "" Then
        MsgBox "El campo de Base es Obligatorio", 0 + 16, "Mensaje de Error"
        CmbContab(0).SetFocus
        Exit Sub
    End If
    
  If CmbContab(0).Text <> "" And CmbContab(1).Text <> "" Then
        VLser$ = Mid$(CmbContab(0).List(CmbContab(0).ListIndex), 1, 3)
        VLser1$ = Mid$(CmbContab(1).List(CmbContab(1).ListIndex), 1, 3)
        If VLser$ <> VLser1$ Then
            MsgBox "Los campos base deben ser del mismo tipo", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
        End If
        
        If CmbContab(0).Text = CmbContab(1).Text Then
            MsgBox "Los campos base deben ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
        End If
    
  End If
    
  If CmbContab(2).Text <> "" Then
     VLcon$ = Mid$(CmbContab(2).List(CmbContab(2).ListIndex), 1, 3)
     
     If VLser$ <> "" Then
         If VLcon$ <> VLser$ Then
            MsgBox "El tipo de campo a contabilizar  y base 1 no pueden ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
         End If
     End If
     If VLser1$ <> "" Then
         If VLcon$ <> VLser1$ Then
            MsgBox "El tipo de campo a contabilizar  y base 2 no pueden ser diferentes", 0 + 16, "Mensaje de Error"
            CmbContab(0).SetFocus
            Exit Sub
         End If
     End If
     
  End If
    
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4107
    PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, txtCausal.Text
    PMPasoValores sqlconn&, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text
    PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "U"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7).Text
    PMPasoValores sqlconn&, "@i_base1", 0, SQLVARCHAR, CmbContab(0).Text
    PMPasoValores sqlconn&, "@i_base2", 0, SQLVARCHAR, CmbContab(1).Text
    PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text
    PMPasoValores sqlconn&, "@i_conta_antes", 0, SQLVARCHAR, lblconta.Caption
            
            
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_concepto_tran", True, "Ok... Ingreso de Transaccion Especifica ") Then
        PMChequea sqlconn&
        PLLimpiar (False)
        PLBuscar
        cmdBoton(3).Enabled = False 'Boton de Actualizar
        cmdBoton(1).Enabled = False  'Boton de Eliminar
        cmdBoton(0).Enabled = True  'Boton de Transmitir

    Else
        MsgBox "Error en la trasmision de la Actualizacion", 0 + 16, "Mensaje de Error"
    End If
End Sub
Private Sub PLEliminar()
    If txtCampo(7).Text = "" Then
        MsgBox "El código del Producto es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtCampo(0).Text = "" Then
        MsgBox "El código de la transaccion es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtTImpuesto.Text = "" Then
        MsgBox "El Tipo de Impuesto es Obligatorio", 0 + 16, "Mensaje de Error"
        cmdBoton(17).SetFocus
        Exit Sub
    End If
    
    If txtConcepto.Text = "" Then
        MsgBox "El Concepto es Obligatorio", 0 + 16, "Mensaje de Error"
        txtConcepto.SetFocus
        Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, 4107
    PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, txtCausal.Text
    PMPasoValores sqlconn&, "@i_timpuesto", 0, SQLVARCHAR, txtTImpuesto.Text
    PMPasoValores sqlconn&, "@i_concepto", 0, SQLVARCHAR, txtConcepto.Text
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "D"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7).Text
    PMPasoValores sqlconn&, "@i_contabiliza", 0, SQLVARCHAR, CmbContab(2).Text
    
            
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_concepto_tran", True, "Ok... Eliminacion de la Transaccion Especifica ") Then
        PMChequea sqlconn&
        PLLimpiar (False)
        PLBuscar
        cmdBoton(3).Enabled = False 'Boton de Actualizar
        cmdBoton(1).Enabled = False  'Boton de Eliminar
        cmdBoton(0).Enabled = True  'Boton de Transmitir

    Else
        MsgBox "Error en la trasmision de la Eliminacion", 0 + 16, "Mensaje de Error"
    End If

End Sub

Private Sub PLBuscar()

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, 4107
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, "0"
       
             
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_concepto_tran", True, "Ok... Consulta de transacciones Definidas ") Then
            PMMapeaGrid sqlconn&, grdTran, False
            PMChequea sqlconn&
            
            If Val(grdTran.Tag) = 20 Then
               cmdBoton(16).Enabled = True
            Else
               cmdBoton(16).Enabled = False
            End If
        Else
             PLLimpiar (True)
        End If
End Sub

Private Sub PLLimpiar(VLBan As Boolean)

    txtCampo(0).Text = ""
    txtCampo(7).Text = ""
    lblDescripcion(3).Caption = ""
    lblDescripcion(0).Caption = ""
    txtTImpuesto.Text = ""
    lblTImpuesto.Caption = ""
    txtConcepto.Text = ""
    txtCausal.Text = ""
    lblDescripcion(1).Caption = ""
    txtCampo(0).Enabled = True
    txtCampo(7).Enabled = True
    txtCausal.Enabled = True
    txtTImpuesto.Enabled = True

    If VLBan = True Then
        PMLimpiaGrid grdTran
    End If
    cmdBoton(3).Enabled = False 'Boton de Actualizar
    cmdBoton(1).Enabled = False 'Boton de Eliminar
    cmdBoton(0).Enabled = True  'Boton de Transmitir
    cmdBoton(16).Enabled = False 'Boton de Siguientes
    CmbContab(0).ListIndex = -1
    CmbContab(1).ListIndex = -1
    CmbContab(2).ListIndex = -1
    txtCampo(7).SetFocus
    
End Sub

Private Sub PLSiguientes()
    
        grdTran.Row = grdTran.Rows - 1
        grdTran.col = 1

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, 4107
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
        grdTran.Row = grdTran.Rows - 1
        grdTran.col = 1
        PMPasoValores sqlconn&, "@i_sec", 0, SQLINT2, grdTran.Text
        grdTran.col = 3
        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, grdTran.Text
        grdTran.col = 4
        PMPasoValores sqlconn&, "@i_tipoimp", 0, SQLVARCHAR, grdTran.Text
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_concepto_tran", True, "Ok... Consulta de transacciones Definidas ") Then
            PMMapeaGrid sqlconn&, grdTran, True
            PMChequea sqlconn&
            grdTran.ColAlignment(3) = 1
            
            If Val(grdTran.Tag) = 20 Then
               cmdBoton(16).Enabled = True
            Else
               cmdBoton(16).Enabled = False
            End If
        Else
             PLLimpiar (False)
        End If
    
End Sub

Private Sub grdtran_Click()
    
    grdTran.col = 0
    grdTran.SelStartCol = 1
    grdTran.SelEndCol = grdTran.Cols - 1
    If grdTran.Row = 0 Then
        grdTran.SelStartRow = 1
        grdTran.SelEndRow = 1
    Else
        grdTran.SelStartRow = grdTran.Row
        grdTran.SelEndRow = grdTran.Row
    End If
End Sub

Private Sub grdtran_DblClick()
    'PLObtenerDatos
    lblDescripcion(1).Caption = ""
    lblconta.Caption = ""
    If grdTran.Text <> "" Then
        CmbContab(0).ListIndex = -1
        CmbContab(1).ListIndex = -1
        CmbContab(2).ListIndex = -1
        
        grdTran.col = 1
        txtCampo(0).Text = grdTran.Text
        grdTran.col = 2
        lblDescripcion(0).Caption = grdTran.Text
        grdTran.col = 4
        txtTImpuesto.Text = grdTran.Text  ' Impuesto
        grdTran.col = 5
        lblTImpuesto.Caption = grdTran.Text
        grdTran.col = 6
        txtConcepto.Text = grdTran.Text ' Concepto
        grdTran.col = 7
        txtCampo(7).Text = grdTran.Text
        grdTran.col = 8
        lblDescripcion(3).Caption = grdTran.Text
        'Req 371 - Se modifica el orden de la causal, para que sea llamada luego de colocar el producto CAV 12/03/2014
        grdTran.col = 3
        txtCausal.Text = grdTran.Text  ' Causal
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
        If txtCausal.Text <> "0" And Trim$(txtCausal.Text) <> "" Then
           txtCausal_LostFocus
        End If
        
        grdTran.col = 9
        If Trim$(grdTran.Text) <> "" Then
            CmbContab(2).Text = Trim$(grdTran.Text)
            lblconta.Caption = CmbContab(2).Text
        End If
        
        grdTran.col = 10
        If Trim$(grdTran.Text) <> "" Then
            CmbContab(0).Text = Trim$(grdTran.Text)
        End If
        
        grdTran.col = 11
        If Trim$(grdTran.Text) <> "" Then
            CmbContab(1).Text = Trim$(grdTran.Text)
        End If
      

        cmdBoton(3).Enabled = True  'Boton de Actualizar
        cmdBoton(1).Enabled = True  'Boton de Eliminar
        cmdBoton(0).Enabled = False 'Boton de Transmitir
        
        txtCampo(0).Enabled = False
        txtCampo(7).Enabled = False
        txtCausal.Enabled = False
        txtTImpuesto.Enabled = False
    End If
    txtConcepto.SetFocus
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
        Case 0, 7
            VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de la transacción por producto"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Producto (3-CTE, 4-AHO, 10-REM)"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode% <> VGTeclaAyuda% Then
        Exit Sub
    End If

    Select Case Index%
    
        Case 7
            ' Producto a Contabilizar
            VLPaso% = True
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
             PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " OK... Consulta de Productos COBIS") Then
                 PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                 PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.Codigo$
                lblDescripcion(3).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(7).Text) = "" Then
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(7).SetFocus
                End If
            End If
        Case 0
                    'Transacciones por producto
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
            If Trim$(txtCampo(7).Text) = "" Then
                MsgBox "CODIGO DE PRODUCTO ES OBLIGATORIO"
                txtCampo(7).SetFocus
                Exit Sub
            End If
            VLPaso% = True
            VGOperacion$ = "sp_pro_transaccion"
            VGProductoConta = txtCampo(7)
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "15020"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "9"
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(7)
            PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "R"
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_transaccion", 0, SQLINT4, "0"
            If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_pro_transaccion", True, " OK... Consulta de Productos COBIS") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(0).Text = VGACatalogo.Codigo$
                lblDescripcion(0).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(0).Text) = "" Then
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                End If
            End If
    
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTTranVal As Integer

    Select Case Index%
    Case 0
        'Transacciones
        
        If Trim$(txtCampo(0).Text) = "" Then
            lblDescripcion(0).Caption = ""
            txtCausal.Text = ""
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            MsgBox "Código de producto mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            If Trim$(txtCausal.Text) <> "" Then
                txtCausal.Text = ""
                lblDescripcion(1).Caption = ""
            End If
            txtCampo(7).SetFocus
            Exit Sub
        End If

        ' Validar los rangos de transacciones de acuerdo al producto
        VTTranVal = Val(txtCampo(0).Text)
        Select Case Trim$(txtCampo(7).Text)
        
        Case "3"

            If VTTranVal% > 2999 Or (VTTranVal% < 2500 And VTTranVal% > 99) And VTTranVal% <> 638 Then
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCausal.Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        Case "4"

            'If VTTranVal% <= 200 Or VTTranVal% >= 302 Then
            If VTTranVal% <= 200 Or VTTranVal% >= 399 Then   'EAA 03/27/2001
                MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        Case "10"
            'If (VTTranVal% <= 400 Or VTTranVal% >= 500)
            If (VTTranVal% >= 500 Or VTTranVal% < 400) Then
                If (VTTranVal% >= 700 Or VTTranVal% < 600) And VTTranVal% <> 638 Then
                    MsgBox "Código de transacción no pertenece a producto", 0 + 16, "Mensaje de Error"
                    txtCampo(0).Text = ""
                    lblDescripcion(0).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                End If
            End If
        End Select
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "494"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (txtCampo(0).Text)
         PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP$
         PMPasoValores sqlconn&, "@i_prod", 0, SQLINT1, txtCampo(7).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_trn_contabilizar", False, "") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             txtCausal.Text = ""
             lblDescripcion(1).Caption = ""
             PMChequea sqlconn&
        Else
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
        End If

       PLParametro
        VLTabla$ = ""
        If txtCampo(0).Text = VLParametro$ Then
           txtCausal.Enabled = True
        End If
    Case 7
        'Productos COBIS
        
        If VLPaso% = True Then
            Exit Sub
        End If
        
        If Trim$(txtCampo(7).Text) = "" Then
            lblDescripcion(3).Caption = ""
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCausal.Text = ""
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "475"
         PMPasoValores sqlconn&, "@i_ope", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT4, (txtCampo(7).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_prod", True, " Consulta de Producto " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(3)
             txtCampo(0).Text = ""
             lblDescripcion(0).Caption = ""
             txtCausal.Text = ""
             lblDescripcion(1).Caption = ""
             PMChequea sqlconn&
        Else
            txtCampo(7).Text = ""
            lblDescripcion(3).Caption = ""
            txtCampo(7).SetFocus
        End If

        If txtCampo(7).Text = "3" Then
        End If

    
    End Select
End Sub



Private Sub txtCausal_Change()
VLPaso% = False
End Sub

Private Sub txtCausal_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado e ini-
'           cializa la variable que chequea los cambios
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA          AUTOR               RAZON
'26/Dic/2000    J.Loyo              Emisión Inicial
'*********************************************************
    FPrincipal!pnlTransaccionLine.Caption = ""
    txtCausal.MaxLength = 4
    FPrincipal!pnlHelpLine.Caption = "Causal Asociada a la transaccion"
    txtCausal.SelStart = 0
    txtCausal.SelLength = Len(txtCausal.Text)
    'If txtCampo(7).Text = "" Then
        'MsgBox "Código de Producto es obligatorio", 0 + 16, "Mensaje de Error"
        'txtCampo(0).Text = ""
        'txtCampo(7).SetFocus
        'Exit Sub
    'End If
    'If txtCampo(0).Text = "" Then
        'MsgBox "Código de transacción es obligatorio", 0 + 16, "Mensaje de Error"
        'txtCampo(0).SetFocus
        'Exit Sub
    'End If
End Sub

Private Sub txtCausal_KeyDown(Keycode As Integer, Shift As Integer)

If Keycode% <> VGTeclaAyuda% Then
    Exit Sub
End If
If txtCausal.Text <> "" Then
   txtCausal.Text = ""
   lblDescripcion(1).Caption = ""
End If
If txtCampo(0).Text = VLParametro$ Then
       VLTabla$ = "ah_cau_nc_gmf_ba"
End If
            
If txtCampo(7) = 3 And txtCampo(0) = 86 Then
  VLTabla$ = "cc_causa_oe"
End If
If txtCampo(7) = 3 And txtCampo(0) = 32 Then
  VLTabla$ = "cc_causa_oioe"
End If
If txtCampo(7) = 3 And txtCampo(0) = 50 Then
  VLTabla$ = "cc_causa_nd"
End If
If txtCampo(7) = 3 And txtCampo(0) = 48 Then
  VLTabla$ = "cc_causa_nc"
End If
If txtCampo(7) = 4 And txtCampo(0) = 264 Then
  VLTabla$ = "ah_causa_nd"
End If
If txtCampo(7) = 4 And txtCampo(0) = 253 Then
  VLTabla$ = "ah_causa_nc"
End If

If VLTabla$ = "" Then
  Exit Sub
End If
    PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
       VLPaso% = True
       PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
       PMChequea sqlconn&
       FCatalogo.Show 1
       txtCausal.Text = VGACatalogo.Codigo$
       lblDescripcion(1).Caption = VGACatalogo.Descripcion$
       If Trim$(txtCausal.Text) = "" Then
          lblDescripcion(1).Caption = ""
          txtCausal.SetFocus
        End If
    End If
End Sub

Private Sub txtCausal_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
   
End Sub


Private Sub txtCausal_LostFocus()
        'Causas

        If VLPaso% = True Then
            Exit Sub
        End If
        'Req 371 - CAV - 12/03/2014 - Validacion que el numero de trn se haya ingresado
        If Trim$(txtCausal.Text) <> "" Then
            If txtCampo(7).Text = "" Then
                MsgBox "Código de Producto es obligatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
                txtCausal.Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(7).SetFocus
                Exit Sub
            End If
            If txtCampo(0).Text = "" Then
                MsgBox "Código de transacción es obligatorio", 0 + 16, "Mensaje de Error"
                txtCausal.Text = ""
                lblDescripcion(1).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        End If
        'If Trim$(txtCampo(0).Text) = "" Then
        '    'MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
        '    txtCausal.Text = ""
        '    lblDescripcion(1).Caption = ""
        '    Exit Sub
        'End If
        
        If Trim$(txtCausal.Text) = "" Then
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        causa = txtCausal.Text
        If txtCampo(0).Text = VLParametro$ Then
          VLTabla$ = "ah_cau_nc_gmf_ba"
        End If
        If txtCampo(7) = 3 And txtCampo(0) = 86 Then
          VLTabla$ = "cc_causa_oe"
        End If
        If txtCampo(7) = 3 And txtCampo(0) = 32 Then
          VLTabla$ = "cc_causa_oioe"
        End If
        If txtCampo(7) = 3 And txtCampo(0) = 50 Then
          VLTabla$ = "cc_causa_nd"
        End If
        If txtCampo(7) = 3 And txtCampo(0) = 48 Then
          VLTabla$ = "cc_causa_nc"
        End If
        If txtCampo(7) = 4 And txtCampo(0) = 264 Then
          VLTabla$ = "ah_causa_nd"
        End If
        If txtCampo(7) = 4 And txtCampo(0) = 253 Then
          VLTabla$ = "ah_causa_nc"
        End If
        
        If VLTabla$ = "" Then
            MsgBox "Código de transacción mandatorio", 0 + 16, "Mensaje de Error"
            Exit Sub
        End If
        
        If txtCampo(0).Text <> "" And IsNumeric(txtCausal.Text) Then
            VLTransac = CInt(txtCampo(0).Text)
        End If
        
        If (VLTransac% = 50 Or VLTransac% = 264) Then
            If txtCausal.Text <> "" And IsNumeric(txtCausal.Text) Then
                causa_sus = CInt(txtCausal.Text)
                causa = txtCausal.Text
                VLTransac% = txtCampo(0).Text
                If causa_sus > 500 And (VLTransac% = 50 Or VLTransac% = 264) Then
                        causa_sus = causa_sus - 500
                        'cmdBoton(2).Enabled = False
                End If
                causa$ = CStr(causa_sus)
            End If
        End If
                
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, VLTabla$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, causa$ ' (Txtcampo(1).Text)
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la causa " & "[" & txtCampo(Index%).Text & "]") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(1)
             PMChequea sqlconn&
        Else
            txtCausal.Text = ""
            lblDescripcion(1).Caption = ""
            txtCausal.Enabled = True
            txtCausal.SetFocus
        End If

End Sub

Private Sub txtConcepto_GotFocus()

    FPrincipal!pnlTransaccionLine.Caption = ""
    txtConcepto.MaxLength = 4
    FPrincipal!pnlHelpLine.Caption = "Concepto Asociado a la transaccion"
    txtConcepto.SelStart = 0
    txtTImpuesto.SelLength = Len(txtTImpuesto.Text)
End Sub

Private Sub txtConcepto_KeyPress(KeyAscii As Integer)
    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
End Sub

Private Sub txtTImpuesto_Change()
'*********************************************************
'Objetivo:  Indica que el contenido del campo ha cambiado
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Mar/2003    J.Loyo              Emisión Inicial
'*********************************************************

    VLPaso% = False
End Sub

Private Sub txtTImpuesto_GotFocus()
'*********************************************************
'Objetivo:  Despliega el mensaje de ayuda apropiado e ini-
'           cializa la variable que chequea los cambios
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA          AUTOR               RAZON
'01/Mar/2003    J.Loyo              Emisión Inicial
'*********************************************************

    FPrincipal!pnlTransaccionLine.Caption = ""
    txtTImpuesto.MaxLength = 1
    FPrincipal!pnlHelpLine.Caption = "Tipo de Impuesto [F5 ayuda]"
    txtTImpuesto.SelStart = 0
    txtTImpuesto.SelLength = Len(txtTImpuesto.Text)
End Sub
Private Sub txtTImpuesto_KeyDown(Keycode As Integer, Shift As Integer)
'*********************************************************
'Objetivo:  Llama a la forma de ayuda grid_valores que
'           muestra los códigos de tipo de Garantia
'Input   :  KeyCode     código de la tecla F5
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Mar/2003    J.Loyo              Emisión Inicial
'*********************************************************
    
    If Keycode = VGTeclaAyuda% Then
        
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR, "cb_tipo_impuesto"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de Tipo de Impuesto ") Then
             PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
             PMChequea sqlconn&
             VLPaso = True
            FCatalogo.Show 1
            txtTImpuesto.Text = VGACatalogo.Codigo$
            lblTImpuesto.Caption = VGACatalogo.Descripcion$
            
        End If
    End If
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

Private Sub txtTImpuesto_KeyPress(KeyAscii As Integer)
    KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

Private Sub txtTImpuesto_LostFocus()
'*********************************************************
'Objetivo:  Cuando el contenido del campo ha cambiado invo-
'           al sp que trae la descripción del código
'Input   :  ninguno
'Output  :  ninguno
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'01/Mar/2003    J.Loyo              Emisión Inicial
'*********************************************************
    If VLPaso% = True Then
        Exit Sub
    End If
    If txtTImpuesto.Text <> "" Then
        PMCatalogo "V", "cb_tipo_impuesto", txtTImpuesto, lblTImpuesto
    Else
        lblTImpuesto.Caption = ""
    End If
End Sub

