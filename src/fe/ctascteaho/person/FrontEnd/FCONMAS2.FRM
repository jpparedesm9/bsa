VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Begin VB.Form FConsulMas2 
   Appearance      =   0  'Flat
   Caption         =   " Consulta de Costos a estar en linea"
   ClientHeight    =   5325
   ClientLeft      =   105
   ClientTop       =   1380
   ClientWidth     =   9300
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   8.25
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FCONMAS2.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.CommandButton cmdBoton 
      Caption         =   "Sig&tes."
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   740
      Index           =   3
      Left            =   8400
      Picture         =   "FCONMAS2.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4084"
      Top             =   780
      Width           =   875
   End
   Begin MSMask.MaskEdBox mskFecha 
      BeginProperty DataFormat 
         Type            =   1
         Format          =   "dd/MM/yyyy"
         HaveTrueFalseNull=   0
         FirstDayOfWeek  =   0
         FirstWeekOfYear =   0
         LCID            =   9226
         SubFormatType   =   3
      EndProperty
      Height          =   285
      Left            =   2160
      TabIndex        =   0
      Top             =   0
      Width           =   930
      _ExtentX        =   1640
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      MaxLength       =   10
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      PromptChar      =   "_"
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   2805
      Left            =   15
      TabIndex        =   30
      Top             =   2505
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14659
      _ExtentY        =   4948
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
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   0
      Left            =   8400
      Picture         =   "FCONMAS2.frx":053C
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "4084"
      Top             =   15
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   1
      Left            =   2160
      MaxLength       =   5
      TabIndex        =   5
      Top             =   1560
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   5
      Left            =   2160
      MaxLength       =   4
      TabIndex        =   6
      Top             =   1815
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   4
      Left            =   2160
      MaxLength       =   3
      TabIndex        =   3
      Top             =   795
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   0
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   1
      Top             =   285
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   3
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   2
      Top             =   540
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Salir"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   740
      Index           =   2
      Left            =   8400
      Picture         =   "FCONMAS2.frx":079E
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   4545
      Width           =   875
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Limpiar"
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   740
      Index           =   1
      Left            =   8400
      Picture         =   "FCONMAS2.frx":0B04
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3800
      Width           =   875
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Index           =   2
      Left            =   2160
      MaxLength       =   2
      TabIndex        =   4
      Top             =   1305
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Aprobar"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   750
      Index           =   4
      Left            =   8400
      Picture         =   "FCONMAS2.frx":0E6A
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "4085"
      Top             =   1560
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha de Vigencia:"
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
      Index           =   2
      Left            =   45
      TabIndex        =   32
      Top             =   30
      Width           =   1440
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8325
      X2              =   -15
      Y1              =   2340
      Y2              =   2340
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Valores del Servicio:"
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
      Left            =   45
      TabIndex        =   31
      Top             =   2355
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   4
      Left            =   3105
      TabIndex        =   18
      Top             =   1560
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
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
      Index           =   16
      Left            =   45
      TabIndex        =   19
      Top             =   1050
      Width           =   675
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   11
      Left            =   3105
      TabIndex        =   20
      Top             =   1050
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   250
      Index           =   9
      Left            =   2160
      TabIndex        =   21
      Top             =   1070
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursal:"
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
      Index           =   11
      Left            =   45
      TabIndex        =   22
      Top             =   1560
      Width           =   720
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Prod. Bancario:"
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
      Index           =   12
      Left            =   45
      TabIndex        =   23
      Top             =   285
      Width           =   1215
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   10
      Left            =   3105
      TabIndex        =   25
      Top             =   285
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   8
      Left            =   3105
      TabIndex        =   29
      Top             =   1815
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio disponible:"
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
      Index           =   10
      Left            =   45
      TabIndex        =   28
      Top             =   1815
      Width           =   1515
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Cobis:"
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
      Index           =   8
      Left            =   45
      TabIndex        =   27
      Top             =   795
      Width           =   1275
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   7
      Left            =   3090
      TabIndex        =   26
      Top             =   795
      Width           =   5250
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   2
      Left            =   2160
      TabIndex        =   16
      Top             =   2070
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro:"
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
      Index           =   9
      Left            =   45
      TabIndex        =   17
      Top             =   2070
      Width           =   525
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   1
      Left            =   3105
      TabIndex        =   24
      Top             =   2070
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   0
      Left            =   3105
      TabIndex        =   15
      Top             =   540
      Width           =   5220
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      BeginProperty Font 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   240
      Index           =   3
      Left            =   3105
      TabIndex        =   14
      Top             =   1305
      Width           =   5220
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Mercado:"
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
      Index           =   5
      Left            =   45
      TabIndex        =   13
      Top             =   540
      Width           =   735
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
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
      Index           =   0
      Left            =   45
      TabIndex        =   12
      Top             =   1305
      Width           =   825
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8350
      X2              =   8350
      Y1              =   15
      Y2              =   5475
   End
End
Attribute VB_Name = "FConsulMas2"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLTrans As Integer
'! removed Dim VLDato As String

Dim VLFormatoFecha As String
'! removed Dim VLMoneda As String


Sub PMLimpiaGrid(grdGrid As Object)
Dim i%, j%
'FIXIT: 'Rows' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Rows' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.Rows = 2
'FIXIT: 'Cols' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Cols' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
    grdGrid.Cols = 2
    For i% = 0 To 1
'FIXIT: 'Col' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Col' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
        grdGrid.Col = i%
        For j% = 0 To 1
'FIXIT: 'Row' is not a property of the generic 'Control' object in Visual Basic .NET. To access 'Row' declare 'grdGrid' using its actual type instead of 'Control'     FixIT90210ae-R1460-RCFE85
            grdGrid.Row = j%
            grdGrid.Text = ""
        Next j%
    Next i%
    grdGrid.Tag = ""
End Sub

Private Sub cmdBoton_Click(Index As Integer)
   Dim VTFilas%
   Dim VTRango$
   Dim VTCategoria$

   Select Case Index%
   Case 0
     'Buscar
     
     
        
        If Trim$(mskFecha.ClipText) = "" Then
            MsgBox "La fecha de Vigencia es mandatorio", 0 + 16, "Mensaje de Error"
            mskFecha.SetFocus
            Exit Sub
        End If

        If txtCampo(0).Text = "" Then
            MsgBox "El producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If txtCampo(3).Text = "" Then
            MsgBox "El código del mercado es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If txtCampo(4).Text = "" Then
            MsgBox "El código de la moneda es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "La categoría es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(1).Text = "" Then
            MsgBox "La Sucursal es Mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

     VTFilas% = VGMaxRows%
     VTRango$ = "0"
     VTCategoria$ = "0"
     While VTFilas% = VGMaxRows%


         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4084"
         'PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_suc", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
        If txtCampo(5).Text <> "" Then
             PMPasoValores sqlconn&, "@i_ser_disp", 0, SQLINT2, txtCampo(5).Text
        End If

        If lblDescripcion(2).Caption <> "" Then
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLVARCHAR, lblDescripcion(2).Caption
        End If
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_con_costot_no_linea", True, "Ok...Consulta de Costos - Servicios") Then
                If VTRango$ = "0" Then
                     PMMapeaGrid sqlconn&, grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, grdRegistros, True
                End If
    
                 PMChequea sqlconn&
                If Val(grdRegistros.Tag) > 0 Then
                    grdRegistros.ColAlignment(3) = 1
                    grdRegistros.ColAlignment(4) = 1
                    grdRegistros.ColAlignment(5) = 1
                    grdRegistros.ColAlignment(6) = 1
                    grdRegistros.ColAlignment(7) = 1
                    grdRegistros.ColAlignment(8) = 2


                End If
    
                'grdRegistros.Col = 2
                'grdRegistros.Row = grdRegistros.Rows - 1
                'VTRango$ = grdRegistros.Text
    
            End If
            VTFilas% = Val(grdRegistros.Tag)
       Wend
       grdRegistros.Col = 1
       If Val(grdRegistros.Tag) = VGMaxRows% Then
          'cmdBoton(3).Enabled = True
          PMObjetoSeguridad cmdBoton(3)
       End If
       

    Case 1 'Limpiar
        
        
        If txtCampo(5).Text <> "" Then
            txtCampo(5).Text = ""
            txtCampo(5).Enabled = True
            lblDescripcion(8).Caption = ""
            lblDescripcion(2).Caption = ""
            lblDescripcion(1).Caption = ""
            txtCampo(5).SetFocus
        Else
            If txtCampo(1).Text <> "" Then
                txtCampo(1).Text = ""
                txtCampo(1).Enabled = True
                lblDescripcion(4).Caption = ""
                txtCampo(1).SetFocus
             Else
                If txtCampo(2).Text <> "" Then
                    txtCampo(2).Text = ""
                    txtCampo(2).Enabled = True
                    lblDescripcion(3).Caption = ""
                    txtCampo(2).SetFocus
                Else
                    If txtCampo(4).Text <> "" Then
                        txtCampo(4).Text = ""
                        lblDescripcion(7).Caption = ""
                        lblDescripcion(9).Caption = ""
                        lblDescripcion(11).Caption = ""
                        txtCampo(4).Enabled = True
                        txtCampo(4).SetFocus
                    Else
                        If txtCampo(3).Text <> "" Then
                            txtCampo(3).Text = ""
                            txtCampo(3).Enabled = True
                            lblDescripcion(0).Caption = ""
                            txtCampo(3).SetFocus
                        Else
                            If txtCampo(0).Text <> "" Then
                                txtCampo(0).Text = ""
                                txtCampo(0).Enabled = True
                                lblDescripcion(10).Caption = ""
                            End If
                        End If
                            
                    End If
                End If
             End If
        End If
        VLPaso% = True
         
        PMLimpiaGrid grdRegistros
        
        'cmdBoton(0).Enabled = True
        
        PMObjetoSeguridad cmdBoton(0)
        PMObjetoSeguridad cmdBoton(3)
        PMObjetoSeguridad cmdBoton(4)
        
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        'cmdBoton_Click (3)

    Case 2 'Salir
        Unload FConsulMas2

    Case 3  'Siguientes

        grdRegistros.Row = grdRegistros.Rows - 1
        grdRegistros.Col = 13
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4084"
         'PMPasoValores SqlConn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text
         PMPasoValores sqlconn&, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_suc", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_sec", 0, SQLINT4, (grdRegistros.Text)
         PMPasoValores sqlconn&, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_con_costot_no_linea", True, "Ok... Consulta de Servicios Personalizables") Then
             PMMapeaGrid sqlconn&, grdRegistros, True
             PMChequea sqlconn&
            ' If Val(grdRegistros.Tag) > 0 Then
            '    grdRegistros.ColWidth(2) = 1
            '    grdRegistros.ColWidth(4) = 1
            '    grdRegistros.ColWidth(6) = 1
            '    grdRegistros.ColWidth(8) = 1
            '    grdRegistros.ColWidth(10) = 1
            '    grdRegistros.ColWidth(9) = 1
            '
            ' End If
            
            'If Val(grdRegistros.Tag) = VGMaxRows% + 5 Then
            '    cmdBoton(3).Enabled = True
            'Else
            '    cmdBoton(3).Enabled = False
            'End If
            grdRegistros.Row = 1
        End If
    Case 4
        PLConfirmar
End Select
End Sub

Private Sub Form_Load()
Dim VLFecha$
Dim i%
    FConsulMas2.Left = 15
    FConsulMas2.Top = 15
    FConsulMas2.Width = 9420
    FConsulMas2.Height = 5835
    'PMBotonSeguridad FConsulMas2, 2
    'PMBotonSeguridad FConsulMas2, 4
    'cmdBoton(0).Enabled = True
    'cmdBoton(2).Enabled = True
    'cmdBoton(3).Enabled = False
    'cmdBoton(4).Enabled = True
    'cmdBoton(1).Enabled = True

    VLFecha$ = FMDateAdd(VGFecha, "d", 1, "mm/dd/yyyy")
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    mskFecha.Mask = FMMascaraFecha(VLFormatoFecha$)
    mskFecha.Text = FMConvFecha(VLFecha$, "mm/dd/yyyy", Get_Preferencia("FORMATO-FECHA"))
    
'    VLFecha$ = DateAdd("d", 1, VGFecha)
'    mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
'    mskFecha.Text = Format$(VLFecha$, VGFormatoFecha$)
    
    'VLFecha$ = DateAdd("d", 1, VGFecha)
    'mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
    'mskFecha.Text = Format$(VLFecha$, "mm/dd/yyyy")
    
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(4)
    
    
    VLTrans% = True
    For i% = 0 To 5
        txtCampo(i%).Height = 240
    Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub mskFecha_GotFocus()
FPrincipal.pnlHelpLine.Caption = " Fecha de Vigencia " + "[" + VGFormatoFecha$ + "]"

'FPrincipal!pnlHelpLine.Caption = " Fecha de Vigencia [mm/dd/yyyy]"
End Sub

Private Sub mskFecha_LostFocus()
Dim VTValido%
Dim VLFecha$
  If mskFecha.ClipText <> "" Then
        VTValido% = FMVerFormato((mskFecha.FormattedText), VGFormatoFecha$)
        If Not VTValido% Then
            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            
            Exit Sub
        End If
    End If
    If mskFecha.Text <> Format$(VLFecha$, VGFormatoFecha$) Then
        If FMDateDiff("d", Format$(VLFecha$, VGFormatoFecha$), (mskFecha.Text), VGFormatoFecha$) < 0 Then
            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
            mskFecha.Mask = ""
            mskFecha.Text = ""
            mskFecha.Mask = FMMascaraFecha(VGFormatoFecha$)
            mskFecha.SetFocus
            Exit Sub
        End If
    End If


'    If mskFecha.ClipText <> "" Then
'        VTValido% = FMVerFormato((mskFecha.FormattedText), "mm/dd/yyyy")
'        If Not VTValido% Then
'            MsgBox "Formato de Fecha Inválido", 48, "Mensaje de Error"
'            mskFecha.Mask = ""
'            mskFecha.Text = ""
'            mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
'            mskFecha.SetFocus
'
'            Exit Sub
'        End If
'    End If
'    If mskFecha.Text <> Format$(VLFecha$, "mm/dd/yyyy") Then
'        If FMDateDiff("d", Format$(VLFecha$, "mm/dd/yyyy"), (mskFecha.Text), "mm/dd/yyyy") < 0 Then
'            MsgBox "Fecha de Vigencia Incorrecta", 16, "Mensaje de Error"
'            mskFecha.Mask = ""
'            mskFecha.Text = ""
'            mskFecha.Mask = FMMascaraFecha("mm/dd/yyyy")
'            mskFecha.SetFocus
'            Exit Sub
'        End If
'   End If

End Sub

Private Sub PMSubserv()
    If VGDetalle(0) = "S" Then
        If txtCampo(5).Text = "" Then

            lblDescripcion(8).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(1).Caption = VGDetalle(2) 'des rubro
            txtCampo(5).Text = VGDetalle(3) 'cod serv dis
            lblDescripcion(2).Caption = VGDetalle(4) 'cod rubro
            
        Else
            
            lblDescripcion(8).Caption = VGDetalle(1) 'des serv dis
            lblDescripcion(1).Caption = VGDetalle(2) 'des rubro
            lblDescripcion(2).Caption = VGDetalle(3) 'cod rubro

        End If
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4, 5
        VLPaso% = False
        lblDescripcion(1).Caption = ""
        lblDescripcion(2).Caption = ""
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Producto Bancario [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Categoria [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Mercado [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Producto Cobis [F5 Ayuda]"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Codigo de Servicio Dis. [F5 Ayuda]"

    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim i%
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
    Case 0
          VGOperacion$ = "sp_prod_bancario"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4002"
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
           PMPasoValores sqlconn&, "@i_modo", 0, SQLINT4, "0"
           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                PMChequea sqlconn&
               FRegistros.Show 1
               txtCampo(0).Text = VGACatalogo.Codigo$
               lblDescripcion(10).Caption = VGACatalogo.Descripcion$
               VLPaso% = True
                    
          Else
               VGOperacion$ = ""
          End If

        Case 1
            VGOperacion$ = "sp_hp_sucursal"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(4).Caption = VGValores(2)
                Else
                    txtCampo(1).Text = ""
                    lblDescripcion(4).Caption = ""
                    VGOperacion$ = ""
                End If
                
                VLPaso% = True
            Else
                txtCampo(1).Text = ""
                lblDescripcion(4).Caption = ""
                VGOperacion$ = ""
            End If
                
        Case 2
            ' Consulta de las categorias
            'If txtCampo(3).Text = "" Then
            '    MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            '    txtCampo(3).SetFocus
            '    Exit Sub
            'End If
            PMCatalogo "A", "pe_categoria", txtCampo(2), lblDescripcion(3)
            VLPaso% = True
        Case 3
            ' Consulta sectores
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "A", "cc_sector", txtCampo(3), lblDescripcion(0)
            PMCatalogo "A", "cc_tipo_banca", txtCampo(3), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
            VLPaso% = True


        Case 4
            
            VGOperacion$ = "sp_promon"
            VGTipo$ = "H"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4075"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then

                    txtCampo(4).Text = VGValores(1)
                    lblDescripcion(9).Caption = VGValores(2)
                    lblDescripcion(7).Caption = VGValores(3)
                    'lblDescripcion(11).Caption = VGValores(4)
                    If lblDescripcion(9).Caption = "0" Then
                        lblDescripcion(11).Caption = "PESOS"
                        Else
                           lblDescripcion(11).Caption = "DOLARES"
                    End If

               '     txtCampo(0).SetFocus
                    For i% = 1 To 10
                        VGValores(i%) = ""
                    Next i%
                End If
            Else
            VGOperacion$ = ""
            VGTipo$ = ""
            End If
         
         VLPaso% = True
        Case 5
            FAyudaSubserv2.Show 1
            'Unload FRubros
            VGForma$ = "FConsulMas2"
            If VGDetalle(1) <> "" Then
                PMSubserv
                VLPaso% = True
            End If

        End Select
        
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 2, 3
        KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    Case 0, 1, 4, 5, 6, 7
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim i%
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4003"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prod_bancario", False, "") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(10)
                     PMChequea sqlconn&
                 Else
                   txtCampo(0).Text = ""
                   lblDescripcion(10).Caption = ""
                   txtCampo(0).SetFocus
                 End If
            Else
                lblDescripcion(10).Caption = ""
            End If
        End If
    Case 1
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
            
               If txtCampo(1).Text > 32000 Then
                    MsgBox "El código de sucursal fuera de rango", 0 + 16, "Mensaje de Error"
                    txtCampo(1).Text = ""
                    txtCampo(1).SetFocus
                    Exit Sub
                 End If
            
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(4)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(4).Caption = ""
                    txtCampo(1).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(4).Caption = ""
            End If
        End If
    Case 2
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).Text = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If
            If txtCampo(2).Text = "" Then
                lblDescripcion(3).Caption = ""
                txtCampo(2).SetFocus
                Exit Sub
             End If
            PMCatalogo "V", "pe_categoria", txtCampo(2), lblDescripcion(3)
        End If


    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text = "" Then
                lblDescripcion(0).Caption = ""
                txtCampo(3).SetFocus
                Exit Sub
            End If
            'IU ERP 02/13/2001 PE00001
            'PMCatalogo "V", "cc_sector", txtCampo(3), lblDescripcion(0)
            PMCatalogo "V", "cc_tipo_banca", txtCampo(3), lblDescripcion(0)
            'FU ERP 02/13/2001 PE00001
        End If

    Case 4
      If VLPaso% = False Then
            
    
        If txtCampo(4).Text <> "" Then
            'Tiene que ser una cuenta de ahorros o una cuenta corriente
            If txtCampo(4).Text <> "3" And txtCampo(4).Text <> "4" Then
                MsgBox "Código Incorrecto", 0 + 16, "Mensaje de Error"
                txtCampo(4).Text = ""
                txtCampo(4).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_promon"
            VGTipo$ = "Q"
            ' GBB26May98008 II:
            ' Se debe haver un load a la forma antes de cargar los valores
            Load FRegistros
            'GBB26May98008 IF:
        
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4076"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, txtCampo(4).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
             'PMPasoValores SqlConn&, "@i_moneda", 0, SQLINT1, "0"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_promon", True, " Consulta del producto ") Then
                 PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                 PMChequea sqlconn&
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    lblDescripcion(9).Caption = VGValores(2) 'moneda
                    lblDescripcion(7).Caption = VGValores(3) ' descripcion
                    'lblDescripcion(1).Caption = VGValores(4)' tipo producto
                    If lblDescripcion(9).Caption = "0" Then
                        lblDescripcion(11).Caption = "PESOS"
                        Else
                          lblDescripcion(11).Caption = "DOLARES"
                    End If
                Else
                    If lblDescripcion(7).Caption = "" Then
                        txtCampo(4).Text = ""
                        txtCampo(4).SetFocus
                    End If
                End If
                For i% = 1 To 5
                    VGValores(i%) = ""
                Next i%
            
            Else
                    VLPaso% = True
                    txtCampo(2).Text = ""
                    lblDescripcion(9).Caption = ""
                    lblDescripcion(7).Caption = ""
                    lblDescripcion(11).Caption = ""
                    txtCampo(4).SetFocus
            End If
         Else
            lblDescripcion(9).Caption = ""
            lblDescripcion(7).Caption = ""
            lblDescripcion(11).Caption = ""
            

         End If
        VGOperacion$ = ""
        VGTipo$ = ""
      End If

    Case 5
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
               'VLPaso% = True
               VGForma$ = "FConsulMas2"
               FAyudaSubserv2.Show 1
               If VGDetalle(1) <> "" Then
                    PMSubserv
               Else
                    If lblDescripcion(8).Caption = "" Then
                        txtCampo(5).Text = ""
                        txtCampo(5).SetFocus
                        VLPaso% = True
                    End If
               End If
            End If
        End If
    End Select
End Sub


Public Sub PLConfirmar()
    Dim msg As String
    Dim aux As String
    Dim Ini_row_grid%
    Dim Fin_row_grid%
    Dim i%
    If txtCampo(0) = "" Then
        MsgBox "Favor diligenciar el Prod.Bancario ", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
        txtCampo(0).SetFocus
        Exit Sub
    End If
    If txtCampo(3) = "" Then
        MsgBox "Favor diligenciar el Mercado.", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
        txtCampo(3).SetFocus
        Exit Sub
    End If
    If txtCampo(4) = "" Then
        MsgBox "Favor diligenciar el Producto Cobis", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
        txtCampo(4).SetFocus
        Exit Sub
    End If
    If lblDescripcion(9) = "" Then
        MsgBox "No existe valor de Moneda para consultar Valores del Servicio", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
        Exit Sub
    End If
    If Trim$(mskFecha.ClipText) = "" Then
        MsgBox "La fecha de Vigencia es mandatorio", 0 + 16, "Mensaje de Error"
        mskFecha.SetFocus
        Exit Sub
    End If

    If txtCampo(2).Text = "" Then
        MsgBox "La categoría es mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(2).SetFocus
        Exit Sub
    End If
    If txtCampo(1).Text = "" Then
        MsgBox "La Sucursal es Mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
    End If
    
    If grdRegistros.Rows <= 2 Or grdRegistros.Cols <= 2 Then
        If grdRegistros.Cols > 2 Then
            grdRegistros.Col = 2
            grdRegistros.Row = 1
            If grdRegistros.Text = "" Then
                MsgBox "No existen datos Consultados en la Lista De Valores Del Servicio. ", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
                Exit Sub
            End If
        Else
            MsgBox "No existen datos Consultados en la Lista De Valores Del Servicio. ", vbCritical, "Personalizacion.ConsuloCostosAEstarEnLinea"
            Exit Sub
        End If
    End If

    
    If grdRegistros.SelStartCol = 1 And grdRegistros.SelEndCol = 13 Then
        msg = "Desea Confirmar  SERVICIO(s)  Resaltado(s) del grid ?"
        aux = MsgBox(msg, vbYesNo, "Personalizacion.ConsuloCostosAEstarEnLinea")
        If aux = vbYes Then
            Ini_row_grid% = grdRegistros.SelStartRow
            Fin_row_grid% = grdRegistros.SelEndRow
        Else
            Exit Sub
        End If
    Else
        msg = "Desea confirmar todos los SERVICIOS visualizados en el grid ?"
        aux = MsgBox(msg, vbYesNo, "Personalizacion.ConsuloCostosAEstarEnLinea")
        If aux = vbYes Then
            Ini_row_grid% = 1
            Fin_row_grid% = grdRegistros.Rows - 1
        Else
            Exit Sub
        End If
    End If
    
    For i% = Ini_row_grid% To Fin_row_grid%
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4085"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
        PMPasoValores sqlconn&, "@i_pro_cobis", 0, SQLINT1, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_pro_banc", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_sector", 0, SQLVARCHAR, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, lblDescripcion(9).Caption
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_categoria", 0, SQLVARCHAR, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_suc", 0, SQLINT2, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_fecha_vig", 0, SQLVARCHAR, FMConvFecha((mskFecha.Text), Get_Preferencia("FORMATO-FECHA"), "mm/dd/yyyy")
        grdRegistros.Row = i%
        grdRegistros.Col = 13
        PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, grdRegistros.Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_con_costot_no_linea", True, "Ok...Aprobacion de Costos - Servicios") Then
                     PMChequea sqlconn&
        Else
            msg = " Error en actualizacion de confirmacion secuencial: " + grdRegistros.Text
            grdRegistros.Row = 1
            msg = msg + " Servicio: " + grdRegistros.Text
        End If
    Next i%
    cmdBoton_Click (0)
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 3, 4, 5
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub



