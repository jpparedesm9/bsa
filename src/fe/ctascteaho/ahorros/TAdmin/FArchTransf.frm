VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FArchTransf 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Consulta Archivo Transferencias Masivas"
   ClientHeight    =   6240
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   9270
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   ScaleHeight     =   6240
   ScaleWidth      =   9270
   Begin MSMask.MaskEdBox MskFecha 
      Height          =   255
      Left            =   7080
      TabIndex        =   2
      Top             =   120
      Width           =   1095
      _ExtentX        =   1931
      _ExtentY        =   450
      _Version        =   393216
      MaxLength       =   10
      Mask            =   "##/##/####"
      PromptChar      =   "_"
   End
   Begin VB.TextBox txtCampo 
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
      Height          =   285
      Index           =   1
      Left            =   1590
      Locked          =   -1  'True
      TabIndex        =   3
      Top             =   930
      Width           =   6480
   End
   Begin VB.TextBox txtCliente 
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
      Height          =   285
      Left            =   840
      MaxLength       =   7
      TabIndex        =   1
      Top             =   120
      Width           =   960
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8355
      TabIndex        =   8
      Top             =   5445
      WhatsThisHelpID =   2008
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
      Left            =   8355
      TabIndex        =   6
      Top             =   4005
      WhatsThisHelpID =   2068
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Excel"
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
      Left            =   8350
      TabIndex        =   4
      Top             =   120
      WhatsThisHelpID =   2000
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
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
      Index           =   2
      Left            =   8355
      TabIndex        =   7
      Top             =   4725
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
   Begin MSGrid.Grid grdDetalle 
      Height          =   2115
      Left            =   60
      TabIndex        =   5
      Top             =   4065
      Width           =   8175
      _Version        =   65536
      _ExtentX        =   14420
      _ExtentY        =   3731
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
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   1905
      TabIndex        =   32
      Tag             =   "2"
      Top             =   2700
      Width           =   6150
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Mensaje:"
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
      Index           =   12
      Left            =   120
      TabIndex        =   31
      Top             =   2745
      Width           =   780
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
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
      Height          =   195
      Index           =   11
      Left            =   120
      TabIndex        =   30
      Top             =   2115
      Width           =   885
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   1905
      TabIndex        =   29
      Tag             =   "2"
      Top             =   2385
      Width           =   2055
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Cuenta Principal:"
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
      Index           =   8
      Left            =   120
      TabIndex        =   28
      Top             =   2430
      Width           =   1470
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   1905
      TabIndex        =   27
      Tag             =   "2"
      Top             =   2070
      Width           =   6150
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Registros Errores:"
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
      Index           =   6
      Left            =   120
      TabIndex        =   26
      Top             =   3780
      Width           =   1530
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto:"
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
      Index           =   10
      Left            =   4800
      TabIndex        =   25
      Top             =   3780
      Width           =   600
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   2280
      TabIndex        =   24
      Tag             =   "2"
      Top             =   3735
      Width           =   2475
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   5520
      TabIndex        =   23
      Tag             =   "2"
      Top             =   3735
      Width           =   2475
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Detalle:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000080&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   22
      Top             =   3210
      Width           =   675
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   3
      X1              =   0
      X2              =   8280
      Y1              =   3090
      Y2              =   3090
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8280
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   0
      X2              =   8280
      Y1              =   840
      Y2              =   840
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1800
      TabIndex        =   21
      Top             =   120
      UseMnemonic     =   0   'False
      Width           =   360
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   8280
      X2              =   8280
      Y1              =   0
      Y2              =   6240
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2160
      TabIndex        =   20
      Top             =   120
      UseMnemonic     =   0   'False
      Width           =   1875
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   60
      TabIndex        =   19
      Top             =   480
      UseMnemonic     =   0   'False
      Width           =   8115
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   5520
      TabIndex        =   18
      Tag             =   "2"
      Top             =   3420
      Width           =   2475
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2280
      TabIndex        =   17
      Tag             =   "2"
      Top             =   3420
      Width           =   2475
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   1905
      TabIndex        =   16
      Tag             =   "2"
      Top             =   1755
      Width           =   2055
   End
   Begin VB.Label lblValor 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   1905
      TabIndex        =   15
      Tag             =   "2"
      Top             =   1440
      Width           =   2055
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto:"
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
      Index           =   9
      Left            =   4800
      TabIndex        =   14
      Top             =   3465
      Width           =   600
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Registros Procesados:"
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
      Index           =   7
      Left            =   120
      TabIndex        =   13
      Top             =   3465
      Width           =   1920
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Total Registros:"
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
      Index           =   5
      Left            =   120
      TabIndex        =   12
      Top             =   1800
      Width           =   1365
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto Inicial Transf:"
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
      Index           =   3
      Left            =   120
      TabIndex        =   11
      Top             =   1485
      Width           =   1770
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre Archivo:"
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
      Index           =   2
      Left            =   120
      TabIndex        =   10
      Top             =   960
      Width           =   1425
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Cliente:"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000080&
      Height          =   195
      Index           =   0
      Left            =   120
      TabIndex        =   9
      Top             =   120
      Width           =   660
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha:"
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
      Left            =   6360
      TabIndex        =   0
      Top             =   120
      Width           =   600
   End
End
Attribute VB_Name = "FArchTransf"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
Dim VLCodArch As Integer
Dim VLPaso As Integer
Dim VLExisteCliente As Boolean
Dim VLTipoId As String
Dim VLIdentificacion As String
Dim VLFormatoFecha As String
Dim VTR1 As Integer
Dim VLSecuencial As String


Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
        Case 0 'Buscar
            Screen.MousePointer = 11
            PLBuscar
            Screen.MousePointer = 0
        Case 1 'Excel
            Screen.MousePointer = 11
            PLExcel
            Screen.MousePointer = 0
        Case 2
            PLLimpiar
        Case 3 'Salir
            Unload Me
    End Select
End Sub

Private Sub PLExcel()
    grdDetalle.Row = 1
    grdDetalle.col = 1
    If grdDetalle.Text <> "" Then
        GeneraDatos_Excel txtCampo(1).Text
    Else
        MsgBox "No hay datos en la Grilla", vbCritical, "ERROR"
        'mtxtProducto.SetFocus
    End If
End Sub


Private Sub Form_Load()

    MskFecha.Text = Format$(VGFecha$, VLFormatoFecha$)
    Me.Height = 6765
    Me.Width = 9390
    PMLoadResStrings Me
    PMLoadResIcons Me
    PLLimpiar
    VLExisteCliente = False
End Sub

Private Sub txtCliente_Change()
    VLPaso% = False
End Sub

Private Sub txtCliente_GotFocus()
   'If txtCliente.Locked = False Then
    If VGCliente <> 0 Then txtCliente.Text = VGCliente
    FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    txtCliente.SelStart = 0
    txtCliente.SelLength = Len(txtCliente.Text)
   'End If
End Sub

Private Sub txtCliente_KeyDown(Keycode As Integer, Shift As Integer)
Dim F5 As Integer
Dim VTRes As String


    If Keycode <> F5 And Keycode% <> 116 Then
        Exit Sub
    End If
        
     ' F5 para ayuda de cliente
            ' Forma de busqueda de clientes
            txtCliente.Text = ""
            'VLBloqueado = "N"
            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            'Abrir forma de búsqueda de clientes
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName$, ServerNameLocal$, VLFormatoFecha$, VGRol$)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCliente.Text = VGFBusCliente.DatosCliente(1)
            
                    If VGFBusCliente.DatosCliente(0) = "P" Then
                       lblDescripcion(1).Caption = VGFBusCliente.DatosCliente(6) 'Tipo id
                       lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(5) 'CEDULA
                       lblDescripcion(3).Caption = VGFBusCliente.DatosCliente(2) + " " + VGFBusCliente.DatosCliente(3) + " " + VGFBusCliente.DatosCliente(4)
                    Else
                       lblDescripcion(1).Caption = VGFBusCliente.DatosCliente(4) 'Tipo id
                       lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(3) 'nit
                       lblDescripcion(3).Caption = VGFBusCliente.DatosCliente(2) 'NOmBRE
                       If VGFBusCliente.DatosCliente(4) = "N" Then lblDescripcion(1).Caption = "NI"
                     End If
                End If
                VLPaso% = True
                txtCliente.SetFocus
             End If

    PMChequea sqlconn&
 

  'Dim VTIde$
  '  If KeyCode = VGTeclaAyuda% And txtCliente.Locked = False Then
  '      txtCliente.Text = ""
  '      VGCliente = 0
  '      VLPaso% = True
  '      VLExisteCliente = False
  '      FBuscarCliente.Show 1
  '
  '      If VGBusqueda(1) <> "" Then
  '          VLExisteCliente = True
  '          txtCliente.Text = CDbl(VGBusqueda(1))
  '          If VGBusqueda(0) = "P" Then
  '              lblDescripcion(2).Caption = VGBusqueda(5)
  '              lblDescripcion(3).Caption = VGBusqueda(2) + " " + VGBusqueda(3) + " " + VGBusqueda(4)
  '              lblDescripcion(1).Caption = Trim$(VGBusqueda(6))
  '
  '            If lblDescripcion(1).Caption = "N" Then lblDescripcion(1).Caption = "NI"
  '          Else
  '            lblDescripcion(2).Caption = VGBusqueda(3)
  '            lblDescripcion(3).Caption = VGBusqueda(2)
  '          End If
  '
  '          VLPaso% = True
  '      End If
  '  End If
End Sub
Private Sub txtCliente_KeyPress(KeyAscii As Integer)
   If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
      KeyAscii% = 0
   End If
End Sub
Private Sub txtCliente_LostFocus()
Dim txtDir As String
Dim VTFecha As String
Dim VTR1 As Integer

    If VLPaso% = False Then
       txtDir = ""
       VGCliente = 0
       If txtCliente.Text <> "" Then
          VTFecha = FMConvFecha((MskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
    
          PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$

          PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "E"
          PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCliente.Text)
          PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
          If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
             ReDim VTValores(3) As String
             VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
             PMChequea sqlconn&
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
             lblDescripcion(1).Caption = Trim$(VTValores(2))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
             lblDescripcion(2).Caption = Trim$(VTValores(1))
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
             lblDescripcion(3).Caption = Trim$(VTValores(3))
             VLExisteCliente = True
          Else
            VLExisteCliente = False
            txtCliente.Text = ""
            lblDescripcion(1).Caption = "" 'Tipo id
            lblDescripcion(2).Caption = "" 'TIPO ID
            lblDescripcion(3).Caption = "" 'NOmBRE
            PLLimpiar
          End If
          VLPaso% = True
      Else
        If Not VGFBusCliente Is Nothing Then
            lblDescripcion(1).Caption = VGFBusCliente.DatosCliente(0) 'Tipo id
            lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(3) 'TIPO ID
            lblDescripcion(3).Caption = VGFBusCliente.DatosCliente(2) 'NOmBRE
            PLLimpiar
        End If
      End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    VLPaso% = False
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Archivo de Alianzas [F5 Ayuda]"
    End Select

    VLPaso% = True
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
      
        If Keycode = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
        Case 1
            VLPaso% = True
            ReDim VGADatosO(3) As String
           'KME FBusArchAlianza!txtCliente.Text = lblDescripcion(2).Caption
            'KME FBusArchAlianza!txtTipoId.Text = lblDescripcion(1).Caption
           'KME  FBusArchAlianza!lblFecha.Caption = MskFecha.Text
           'KME  FBusArchAlianza.VLExisteCliente = VLExisteCliente
           'KME  FBusArchAlianza.Show 1
            If Trim$(VGADatosO(0)) <> "" Then
               VLCodArch = VGADatosO(0)
               txtCampo(1).Text = VGADatosO(1)
               VLTipoId = VGADatosO(2)
               VLIdentificacion = VGADatosO(3)
            End If
            VLPaso% = True

    End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)

'Validacion de teclas numericas
    If ((KeyAscii < 48) Or (KeyAscii > 57)) And KeyAscii <> 8 Then
        KeyAscii = 0
    End If

End Sub

Private Sub PLBuscar()
Dim VTFecha As String

'    If Trim$(txtCliente.Text) = "" Then
'        MsgBox "Debe Seleccionar el Cliente a Consultar", vbInformation, "Consulta Archivo de Alianzas"
'        txtCliente.SetFocus
'        Exit Sub
'    End If
    
'FIXIT: Replace 'Trim' function with 'Trim$' function                                      FixIT90210ae-R9757-R1B8ZE
    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "Debe Seleccionar el Archivo a Consultar", vbInformation, "Consulta Archivo de Alianzas"
        txtCampo(1).SetFocus
        Exit Sub
    End If
    
    VTFecha = FMConvFecha((MskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "C"
    'PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCliente.Text)
    PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
    PMPasoValores sqlconn&, "@i_codigo_arch", 0, SQLINT4, VLCodArch
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
    PMPasoValores sqlconn&, "@i_identificacion", 0, SQLCHAR, VLIdentificacion
    PMPasoValores sqlconn&, "@i_tipo_ident", 0, SQLCHAR, VLTipoId
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
        ReDim VTValores(15) As String
        VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
       'PMMapeaGrid sqlconn&, grdArchivos, False
        PMChequea sqlconn&
        lblValor(0).Caption = VTValores(1)
        lblValor(1).Caption = VTValores(2)
        lblValor(3).Caption = VTValores(3)
        lblValor(2).Caption = VTValores(4)
        lblValor(5).Caption = VTValores(5)
        lblValor(4).Caption = VTValores(6)
        lblValor(7).Caption = VTValores(7)
        lblValor(8).Caption = VTValores(8)
        lblValor(6).Caption = VTValores(9)
    Else
       MsgBox "Error en la consulta del archivo de alizanza", vbCritical, "Error Consulta"
    End If
    
    PLCargarDetalle
    
End Sub

Private Sub PLCargarDetalle()
Dim VTFecha As String

    VTFecha = FMConvFecha((MskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCliente.Text)
    PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
    PMPasoValores sqlconn&, "@i_codigo_arch", 0, SQLINT4, VLCodArch
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
        PMMapeaGrid sqlconn&, grdDetalle, False
        PMChequea sqlconn&
        grdDetalle.ColWidth(1) = 855
        grdDetalle.ColWidth(2) = 885
        grdDetalle.ColWidth(3) = 1080
        grdDetalle.ColWidth(4) = 1000
        grdDetalle.ColWidth(5) = 1200
        grdDetalle.ColWidth(6) = 3000

        cmdBoton(1).Enabled = True
        If grdDetalle.Tag = 20 Then
            PLSiguientes
        End If
    Else
       MsgBox "Error en la consulta del archivo de alizanza", vbCritical, "Error Consulta"
    End If

End Sub

Private Sub PLSiguientes()
 Dim VTFecha As String
 
   grdDetalle.Row = grdDetalle.Rows - 1
   grdDetalle.col = 1
   VLSecuencial = grdDetalle.Text
   
   VTFecha = FMConvFecha((MskFecha.FormattedText), VGFormatoFecha$, CGFormatoBase$)
   
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
    PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCliente.Text)
    PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
    PMPasoValores sqlconn&, "@i_codigo_arch", 0, SQLINT4, VLCodArch
    PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VLSecuencial$
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
        PMMapeaGrid sqlconn&, grdDetalle, True
        PMChequea sqlconn&
        If grdDetalle.Tag = 20 Then
            PLSiguientes
        End If
        grdDetalle.ColWidth(1) = 855
        grdDetalle.ColWidth(2) = 885
        grdDetalle.ColWidth(3) = 1080
        grdDetalle.ColWidth(4) = 1000
        grdDetalle.ColWidth(5) = 1200
        grdDetalle.ColWidth(6) = 3000
    Else
       MsgBox "Error en la consulta del archivo de alizanza", vbCritical, "Error Consulta"
    End If
End Sub

Private Sub PLLimpiar()
    txtCliente.Text = ""
    lblDescripcion(1).Caption = ""
    lblDescripcion(2).Caption = ""
    lblDescripcion(3).Caption = ""
    txtCampo(1).Text = ""
    
    lblValor(0).Caption = ""
    lblValor(1).Caption = ""
    lblValor(3).Caption = ""
    lblValor(2).Caption = ""
    lblValor(5).Caption = ""
    lblValor(4).Caption = ""
    lblValor(7).Caption = ""
    lblValor(6).Caption = ""
    lblValor(8).Caption = ""
    
    PMLimpiaGrid grdDetalle
    grdDetalle.ColWidth(1) = 650
    cmdBoton(1).Enabled = False
    
End Sub

Sub GeneraDatos_Excel(svArchivo As String)
On Local Error GoTo ErrGeneraDatos_Excel
Dim XlsApl As Excel.Application
Dim xlsLibro As Excel.Workbook
Dim xlhoja As Excel.Worksheet
Dim valor As String

'Dim Fil As Integer, Col As Integer
Dim nlTimer As Long

nlTimer = Timer

Set XlsApl = New Excel.Application
'XlsApl.Visible = True
'XlsApl.Windows (svTitulo & CStr(nlTimer))
XlsApl.Caption = "PROCESAMIENTO ARCHIVO ALIANZAS " & svArchivo '& CStr(nlTimer)
XlsApl.WindowState = xlMinimized


With XlsApl
    .Workbooks.Add
    Set xlsLibro = .ActiveWorkbook
    Set xlhoja = xlsLibro.Worksheets.Add
    xlhoja.Name = svArchivo
    
    With xlsLibro.Worksheets(svArchivo)
    
        .Columns("D:D").Select
        XlsApl.Selection.NumberFormat = "####00-000-00000-0"

        .Activate
        XlsApl.Columns("A:A").Select
        XlsApl.Selection.NumberFormat = "@"
        
        FPrincipal.pnlHelpLine.Caption = " Exportando Archivo [" + svArchivo + "] ..."
        fil = 1
        col = 1
        .Cells(fil, col) = "NOMBRE REPORTE:"
        col = 2
        .Cells(fil, col) = "CONSULTA ARCHIVO TRANSFERENCIA"
        
        fil = 2
        col = 1
        .Cells(fil, col) = "NOMBRE ARCHIVO:"
        col = 2
        .Cells(fil, col) = svArchivo
        
        fil = 3
        col = 1
        .Cells(fil, col) = "FECHA:"
        col = 2
        .Cells(fil, col) = MskFecha.Text
        
        fil = 4
        col = 1
        .Cells(fil, col) = "VALOR INICIAL TRANSFERENCIA:"
        col = 2
        .Cells(fil, col) = lblValor(0).Caption
        
        
        fil = 5
        col = 1
        .Cells(fil, col) = "CONCEPTO:"
        col = 2
        .Cells(fil, col) = lblValor(6).Caption
        
        fil = 7
        col = 1
        .Cells(fil, col) = "TOTAL REGISTROS:"
        col = 2
        .Cells(fil, col) = lblValor(1).Caption
        
        fil = 8
        col = 1
        .Cells(fil, col) = "TOTAL PROCESADOS:"
        col = 2
        .Cells(fil, col) = lblValor(2).Caption
        
        fil = 9
        col = 1
        .Cells(fil, col) = "VALOR PROCESADOS:"
        col = 2
        .Cells(fil, col) = lblValor(3).Caption
        
        fil = 10
        col = 1
        .Cells(fil, col) = "TOTAL NO PROCESADOS:"
        col = 2
        .Cells(fil, col) = lblValor(4).Caption
        
        fil = 11
        col = 1
        .Cells(fil, col) = "VALOR NO PROCESADOS:"
        col = 2
        .Cells(fil, col) = lblValor(5).Caption
               
        col = 1
        For fila = 0 To grdDetalle.Rows - 1
        fil = fil + 1
            FPrincipal.pnlHelpLine.Caption = " Exportando fila [" + CStr(fila) + "] de " + CStr(grdDetalle.Rows - 1) + " ..."
            grdDetalle.Row = fila
            col = 0
            For columna = 1 To grdDetalle.Cols - 1
            col = col + 1
                grdDetalle.col = columna
                valor = grdDetalle.Text
                If FMConvFecha(valor$, VGFecha_Pref$, CGFORMATOFECHA$) <> "" Then
                    .Cells(fil + 1, col) = "'" + grdDetalle.Text
                Else
                    .Cells(fil + 1, col) = grdDetalle.Text
                End If
            Next
'            If fila = 0 Then
'                .Rows("1:1").Select
'                With XlsApl.Selection.Interior
'                    .ColorIndex = 37
'                    .Pattern = xlSolid
'                End With
'                XlsApl.Selection.Font.Bold = True
'                XlsApl.Selection.Borders(xlInsideVertical).LineStyle = xlNone
'                XlsApl.Cells.Select
'                XlsApl.Range("E1").Activate
'                XlsApl.Cells.EntireColumn.AutoFit
'            End If
        Next
   End With
End With
XlsApl.Visible = True
XlsApl.WindowState = xlMaximized
'Set xlsLibro = XlsApl.ActiveWorkbook
XlsApl.Selection.Borders(xlInsideVertical).LineStyle = xlNone
XlsApl.Cells.Select
XlsApl.Range("E1").Activate
XlsApl.Cells.EntireColumn.AutoFit


'xlsLibro.SaveAs App.path & "\" & "Saldos vs Contabilidad_" & CStr(nlTimer) & ".xls", 1
'xlsLibro.Close
'XlsApl.Quit
'MsgBox "Se creo el archivo de Excel " & App.path & "\" & "Saldos vs Contabilidad_" & CStr(nlTimer) & ".xls", vbInformation
'Set XlsApl = Nothing
'Set xlsLibro = Nothing
 
Exit Sub
ErrGeneraDatos_Excel:
    MsgBox Err.Number & " - " & Err.Description, vbInformation
    Exit Sub 'Resume Next
End Sub


