VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0F1F1508-C40A-101B-AD04-00AA00575482}#7.0#0"; "MhRealInput.ocx"
Begin VB.Form FProCont 
   Appearance      =   0  'Flat
   Caption         =   "Caracteristicas Especiales"
   ClientHeight    =   5340
   ClientLeft      =   885
   ClientTop       =   1350
   ClientWidth     =   9375
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
   LinkTopic       =   "Form2"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5340
   ScaleWidth      =   9375
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   420
      Left            =   6240
      TabIndex        =   14
      Top             =   2200
      Width           =   1815
      Begin VB.OptionButton optContrac 
         Caption         =   "Si"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   195
         TabIndex        =   15
         Top             =   150
         Value           =   -1  'True
         Width           =   660
      End
      Begin VB.OptionButton optContrac 
         Caption         =   "No"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   960
         TabIndex        =   16
         TabStop         =   0   'False
         Top             =   150
         Width           =   780
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1440
      MaxLength       =   3
      TabIndex        =   12
      Text            =   "M"
      Top             =   2565
      Width           =   800
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   1440
      MaxLength       =   4
      TabIndex        =   13
      Text            =   "0"
      Top             =   2865
      Width           =   800
   End
   Begin VB.Frame Frame5 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   780
      Left            =   6240
      TabIndex        =   17
      Top             =   2550
      Width           =   1815
      Begin VB.OptionButton optEstado 
         Caption         =   "Vigente"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   195
         TabIndex        =   18
         Top             =   150
         Value           =   -1  'True
         Width           =   1500
      End
      Begin VB.OptionButton optEstado 
         Caption         =   "No Vigente"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   195
         TabIndex        =   19
         TabStop         =   0   'False
         Top             =   480
         Width           =   1500
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Enabled         =   0   'False
      Height          =   285
      Index           =   7
      Left            =   7440
      MaxLength       =   3
      TabIndex        =   40
      Top             =   4560
      Visible         =   0   'False
      Width           =   800
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      BackColor       =   &H80000000&
      Enabled         =   0   'False
      Height          =   285
      Index           =   6
      Left            =   7440
      MaxLength       =   3
      TabIndex        =   39
      Top             =   4200
      Visible         =   0   'False
      Width           =   800
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1440
      MaxLength       =   3
      TabIndex        =   3
      Top             =   615
      Width           =   800
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1440
      MaxLength       =   4
      TabIndex        =   2
      Top             =   315
      Width           =   800
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1440
      MaxLength       =   5
      TabIndex        =   1
      Top             =   15
      Width           =   800
   End
   Begin MSGrid.Grid grdProdContractual 
      Height          =   1395
      Left            =   30
      TabIndex        =   32
      Top             =   3840
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14631
      _ExtentY        =   2461
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
      Left            =   8430
      Picture         =   "FPROCONT.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   20
      Tag             =   "4123"
      Top             =   45
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Index           =   1
      Left            =   8430
      Picture         =   "FPROCONT.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   21
      Tag             =   "4125"
      Top             =   1515
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Index           =   5
      Left            =   8430
      Picture         =   "FPROCONT.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   22
      Tag             =   "4124"
      Top             =   2280
      Width           =   870
   End
   Begin VB.Frame Frame4 
      Height          =   1095
      Left            =   1470
      TabIndex        =   34
      Top             =   960
      Width           =   6855
      Begin VB.TextBox txtCampo 
         Appearance      =   0  'Flat
         Height          =   285
         Index           =   4
         Left            =   840
         MaxLength       =   3
         TabIndex        =   4
         Top             =   240
         Width           =   800
      End
      Begin VB.Frame Frame2 
         Appearance      =   0  'Flat
         ForeColor       =   &H80000008&
         Height          =   420
         Left            =   4800
         TabIndex        =   6
         Top             =   140
         Width           =   1815
         Begin VB.OptionButton optPlazo 
            Caption         =   "Si"
            ForeColor       =   &H00800000&
            Height          =   200
            Index           =   0
            Left            =   195
            TabIndex        =   7
            Top             =   150
            Value           =   -1  'True
            Width           =   660
         End
         Begin VB.OptionButton optPlazo 
            Caption         =   "No"
            ForeColor       =   &H00800000&
            Height          =   195
            Index           =   1
            Left            =   960
            TabIndex        =   8
            TabStop         =   0   'False
            Top             =   150
            Width           =   780
         End
      End
      Begin VB.Frame Frame3 
         Appearance      =   0  'Flat
         ForeColor       =   &H80000008&
         Height          =   420
         Left            =   4800
         TabIndex        =   9
         Top             =   500
         Width           =   1815
         Begin VB.OptionButton optCuota 
            Caption         =   "Si"
            ForeColor       =   &H00800000&
            Height          =   200
            Index           =   0
            Left            =   195
            TabIndex        =   10
            Top             =   150
            Value           =   -1  'True
            Width           =   660
         End
         Begin VB.OptionButton optCuota 
            Caption         =   "No"
            ForeColor       =   &H00800000&
            Height          =   200
            Index           =   1
            Left            =   960
            TabIndex        =   11
            TabStop         =   0   'False
            Top             =   150
            Width           =   780
         End
      End
      Begin MhinrelLib.MhRealInput mskCosto 
         Height          =   285
         Index           =   0
         Left            =   840
         TabIndex        =   5
         Top             =   555
         Width           =   1905
         _Version        =   458753
         _ExtentX        =   3360
         _ExtentY        =   503
         _StockProps     =   205
         ForeColor       =   -2147483630
         Enabled         =   -1  'True
         FillColor       =   16777215
         MaxReal         =   0
         MinReal         =   0
         SpinChangeReal  =   0
         AutoHScroll     =   -1  'True
         CaretColor      =   -2147483642
         CaretVisible    =   -1  'True
         DecimalPlaces   =   2
         Separator       =   -1  'True
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Negociar Plazo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   13
         Left            =   3360
         TabIndex        =   38
         Top             =   255
         Width           =   1365
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Negociar Cuota:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   14
         Left            =   3360
         TabIndex        =   37
         Top             =   615
         Width           =   1395
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Plazo:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   5
         Left            =   120
         TabIndex        =   36
         Top             =   240
         Width           =   540
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackStyle       =   0  'Transparent
         Caption         =   "Cuota:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   120
         TabIndex        =   35
         Top             =   555
         Width           =   570
      End
   End
   Begin MhinrelLib.MhRealInput mskCosto 
      Height          =   285
      Index           =   1
      Left            =   1440
      TabIndex        =   26
      Top             =   2265
      Width           =   2745
      _Version        =   458753
      _ExtentX        =   4842
      _ExtentY        =   503
      _StockProps     =   205
      ForeColor       =   -2147483630
      Enabled         =   0   'False
      FillColor       =   16777215
      MaxReal         =   3.4E+38
      MinReal         =   0
      SpinChangeReal  =   0
      AutoHScroll     =   -1  'True
      CaretColor      =   -2147483642
      CaretVisible    =   -1  'True
      DecimalPlaces   =   2
      Separator       =   -1  'True
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Index           =   2
      Left            =   8430
      Picture         =   "FPROCONT.frx":0876
      Style           =   1  'Graphical
      TabIndex        =   23
      Tag             =   "4126"
      Top             =   3040
      Visible         =   0   'False
      Width           =   870
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
      Height          =   750
      Index           =   4
      Left            =   8430
      Picture         =   "FPROCONT.frx":0B80
      Style           =   1  'Graphical
      TabIndex        =   25
      Top             =   4560
      Width           =   870
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
      Height          =   750
      Index           =   3
      Left            =   8430
      Picture         =   "FPROCONT.frx":0EE6
      Style           =   1  'Graphical
      TabIndex        =   24
      Top             =   3810
      Width           =   870
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8370
      Y1              =   3480
      Y2              =   3480
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Monto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   120
      TabIndex        =   46
      Top             =   2265
      Width           =   1065
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Imprime Plan:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4800
      TabIndex        =   45
      Top             =   2350
      Width           =   1155
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2255
      TabIndex        =   44
      Top             =   2565
      Width           =   1945
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Periodicidad:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   120
      TabIndex        =   43
      Top             =   2580
      Width           =   1125
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackStyle       =   0  'Transparent
      Caption         =   "Puntos Adicionales"
      ForeColor       =   &H00800000&
      Height          =   435
      Index           =   12
      Left            =   120
      TabIndex        =   42
      Top             =   2895
      Width           =   1155
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   4800
      TabIndex        =   41
      Top             =   2880
      Width           =   1425
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2250
      TabIndex        =   29
      Top             =   615
      Width           =   6075
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   30
      Top             =   645
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   31
      Top             =   345
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2250
      TabIndex        =   33
      Top             =   315
      Width           =   6075
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2250
      TabIndex        =   27
      Top             =   15
      Width           =   6075
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   28
      Top             =   45
      Width           =   810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Productos Contractuales"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   0
      Top             =   3600
      Width           =   2100
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   2160
      Y2              =   2160
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5280
   End
End
Attribute VB_Name = "FProCont"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FPROCONT.FRM
' NOMBRE LOGICO:    FProCont
' PRODUCTO:         Personalización
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
' Realiza el mantenimiento de los productos contractuales
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 30-Mar-11      J. Loyo H.          Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLProducto As String

Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const MB_DEFBUTTON1 = 0
    '! removed Const IDNO = 7
    '! removed Const IDCANCEL = 2
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim VTCuota$
    Dim VTPlazo$
    Dim VTPlan$
    Dim VTEstado$
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
    Select Case Index%
    Case 0
        'Buscar
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
         
         
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4123"
        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_producto_contractual", True, " Ok... Consulta de Producto Contractuales") Then
           PMMapeaGrid sqlconn&, grdProdContractual, False
           PMChequea sqlconn&

           grdProdContractual.ColWidth(1) = 1000
           grdProdContractual.ColWidth(2) = 5750
           grdProdContractual.ColWidth(3) = 1000

           mskCosto(0).Text = "0.00"
           mskCosto(1).Text = "0.00"
           
           PLModoInsertar True
           PLLimpiar "=", 3
           PLLimpiar "=", 4
           PLLimpiar "=", 5
           PLLimpiar "=", 6
           
        End If

    Case 1
        'Crear
        If Trim$(txtCampo(0).Text) = "" Then
           MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(0).SetFocus
           Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
           MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(1).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(2).Text <> "" Then
           MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(2).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(4).Text > "000" Then
           MsgBox "El plazo es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(4).SetFocus
           Exit Sub
        End If
        
        If Int(txtCampo(4).Text) > "250" Then
           MsgBox "El plazo excede el limite maximo", 0 + 16, "Mensaje de Error"
           txtCampo(4).SetFocus
           Exit Sub
        End If
        
        If Not mskCosto(0).Text > "0.00" Then
           MsgBox "El Valor de la cuota es mandatorio", 0 + 16, "Mensaje de Error"
           mskCosto(0).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(3).Text <> "" Then
           MsgBox "La periodicidad es un campo mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(3).SetFocus
           Exit Sub
        End If
        If Not txtCampo(5).Text >= "0" Then
           MsgBox "El campo Puntos Adicionales no puede ser nulo", 0 + 16, "Mensaje de Error"
           txtCampo(5).SetFocus
           Exit Sub
        End If
        
        If optCuota(0).Value Then
           VTCuota$ = "S"
        ElseIf optCuota(1).Value Then
           VTCuota$ = "N"
        End If

        If optPlazo(0).Value Then
           VTPlazo$ = "S"
        ElseIf optPlazo(1).Value Then
           VTPlazo$ = "N"
        End If
        
        If optContrac(0).Value Then
           VTPlan$ = "S"
        ElseIf optContrac(1).Value Then
           VTPlan$ = "N"
        End If
        
        If optEstado(0).Value Then
           VTEstado$ = "V"
        ElseIf optEstado(1).Value Then
           VTEstado$ = "C"
        End If
        
        If VTEstado$ = "C" Then
           Response = MsgBox("Desea Actualizar el registro en Estado No Vigente?", DgDef, "Mensaje de Seguridad")
           If Response = IDYES Then
              MsgBox "Se Actualiza el Registro en Estado No Vigente", 0 + 16, "Mensaje del Servidor"
           Else
              MsgBox "Se debe modificar el Estado del Registro", 0 + 16, "Mensaje del Servidor"
              optEstado(0).Value = True
              Exit Sub
           End If
        End If
        
        mskCosto_LostFocus 0
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4125"
        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
        PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_plazo", 0, SQLINT2, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_cuota", 0, SQLMONEY, mskCosto(0).Text
        PMPasoValores sqlconn&, "@i_monto_final", 0, SQLMONEY, mskCosto(1).Text
        PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_ptos_premio", 0, SQLFLT8&, txtCampo(5).Text
        PMPasoValores sqlconn&, "@i_plazo_neg", 0, SQLCHAR, VTPlazo$
        PMPasoValores sqlconn&, "@i_cuota_neg", 0, SQLCHAR, VTCuota$
        PMPasoValores sqlconn&, "@i_plan_pago", 0, SQLCHAR, VTPlan$
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_producto_contractual", True, " Ok... Creación de Categoría por Producto Final") Then
           PMChequea sqlconn&
           cmdBoton_Click (0)
        End If
    
    Case 2
        'Eliminar
        Response = MsgBox("Desea Eliminar la Característica Especial de la Categoría por Producto Final?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4126"
             PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_producto_contractual", True, " Ok... Eliminando Categoría por Producto Final") Then
                PMChequea sqlconn&
                cmdBoton_Click (0)
            End If
        Else
            Exit Sub
        End If

    Case 3
        'Limpiar
        PLLimpiar ">", 0
        PLModoInsertar True
        txtCampo(5).Text = "0"
        txtCampo(0).SetFocus
         
    Case 4
        'Salir
        Unload FProCont
    
    Case 5
        'Actualizar
       If Trim$(txtCampo(0).Text) = "" Then
           MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(0).SetFocus
           Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
           MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(1).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(2).Text <> "" Then
           MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(2).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(4).Text > "000" Then
           MsgBox "El plazo es mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(4).SetFocus
           Exit Sub
        End If
        
        If Int(txtCampo(4).Text) > "250" Then
           MsgBox "El plazo excede el limite maximo", 0 + 16, "Mensaje de Error"
           txtCampo(4).SetFocus
           Exit Sub
        End If
        
        If Not mskCosto(0).Text > "0.00" Then
           MsgBox "El Valor de la cuota es mandatorio", 0 + 16, "Mensaje de Error"
           mskCosto(0).SetFocus
           Exit Sub
        End If
        
        If Not txtCampo(3).Text <> "" Then
           MsgBox "La periodicidad es un campo mandatorio", 0 + 16, "Mensaje de Error"
           txtCampo(3).SetFocus
           Exit Sub
        End If
        If Not txtCampo(5).Text >= "0" Then
           MsgBox "El campo Puntos Adicionales no puede ser nulo", 0 + 16, "Mensaje de Error"
           txtCampo(5).SetFocus
           Exit Sub
        End If
        
        If optCuota(0).Value Then
           VTCuota$ = "S"
        ElseIf optCuota(1).Value Then
           VTCuota$ = "N"
        End If

        If optPlazo(0).Value Then
           VTPlazo$ = "S"
        ElseIf optPlazo(1).Value Then
           VTPlazo$ = "N"
        End If
        
        If optContrac(0).Value Then
           VTPlan$ = "S"
        ElseIf optContrac(1).Value Then
           VTPlan$ = "N"
        End If
        
        If optEstado(0).Value Then
           VTEstado$ = "V"
        ElseIf optEstado(1).Value Then
           VTEstado$ = "C"
        End If
        
        
        If VTEstado$ = "C" Then
           Response = MsgBox("Desea Actualizar el registro en Estado No Vigente?", DgDef, "Mensaje de Seguridad")
           If Response = IDYES Then
              MsgBox "Se Actualiza el Registro en Estado No Vigente", 0 + 16, "Mensaje del Servidor"
           Else
              MsgBox "Se debe modificar el Estado del Registro", 0 + 16, "Mensaje del Servidor"
              optEstado(0).Value = True
              Exit Sub
           End If
        End If
        
        mskCosto_LostFocus 0
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4124"
        PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
        PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
        PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
        PMPasoValores sqlconn&, "@i_plazo", 0, SQLINT2, txtCampo(4).Text
        PMPasoValores sqlconn&, "@i_cuota", 0, SQLMONEY, mskCosto(0).Text
        PMPasoValores sqlconn&, "@i_monto_final", 0, SQLMONEY, mskCosto(1).Text
        PMPasoValores sqlconn&, "@i_periodicidad", 0, SQLCHAR, txtCampo(3).Text
        PMPasoValores sqlconn&, "@i_ptos_premio", 0, SQLFLT8&, txtCampo(5).Text
        PMPasoValores sqlconn&, "@i_plazo_neg", 0, SQLCHAR, VTPlazo$
        PMPasoValores sqlconn&, "@i_cuota_neg", 0, SQLCHAR, VTCuota$
        PMPasoValores sqlconn&, "@i_plan_pago", 0, SQLCHAR, VTPlan$
        PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VTEstado$
        
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_producto_contractual", True, " Ok... Actualizando la Categoría por Producto Final") Then
           PMChequea sqlconn&
           cmdBoton_Click (0)
        End If


    End Select
End Sub
Private Sub Form_Load()

'*********************************************************
'Objetivo:  Carga la forma que se encargara de Administrar
'           los parametros de los productos contractuales
'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'30/Mar/11  J. Loyo H.          Emisión Inicial
'*********************************************************

' Coordenadas para el despliegue de la forma
    
  FProCont.Left = 0    '15
  FProCont.Top = 0    '15
  FProCont.Width = 9450   '9420
  FProCont.Height = 5900   '5730

  PMLoadResStrings Me
  PMLoadResIcons Me
  PLModoInsertar True
  PMBotonSeguridad FProCont, 5
 
  PMObjetoSeguridad cmdBoton(0)
  PMObjetoSeguridad cmdBoton(5)
  PMObjetoSeguridad cmdBoton(1)
  'PMObjetoSeguridad cmdBoton(2)
  cmdBoton(2).Enabled = False
  cmdBoton(2).Visible = False
  
  FPrincipal.pnlHelpLine.Caption = "FProCont - Version VSS 5"
  
  PMPasoValores sqlconn&, "@i_tabla", 0, SQLCHAR, "pe_periodicidad"
  PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
  PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR, txtCampo(3).Text  'Se envia para cargar valor por Defaul en el campo periodicidad
  If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_catalogo", True, " Consulta de la Periodicidad ") Then
     PMMapeaObjeto sqlconn&, lblDescripcion(3)
     PMChequea sqlconn&
  End If
             
End Sub

Private Sub Form_Unload(Cancel As Integer)
  FPrincipal.pnlHelpLine.Caption = ""
  FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdProdContractual_Click()
    
  grdProdContractual.Col = 0
  grdProdContractual.SelStartCol = 1
  grdProdContractual.SelEndCol = grdProdContractual.Cols - 1
  If grdProdContractual.Row = 0 Then
     grdProdContractual.SelStartRow = 1
     grdProdContractual.SelEndRow = 1
  Else
     grdProdContractual.SelStartRow = grdProdContractual.Row
     grdProdContractual.SelEndRow = grdProdContractual.Row
  End If

End Sub

Private Sub grdProdContractual_DblClick()
Dim VTRow%
    VTRow% = grdProdContractual.Row
    grdProdContractual.Row = 1
    grdProdContractual.Col = 1

    If Trim$(grdProdContractual.Text) <> "" Then
        grdProdContractual.Row = VTRow%
        PMMarcarRegistro
        
        PLModoInsertar False
    End If

End Sub

Private Sub grdProdContractual_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para habiliar el botón elimiar"
End Sub

Private Sub mskCosto_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Valor dela Cuota"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Saldo minimo Final esperado"
End Select
    mskCosto(Index%).SelStart = 0
    mskCosto(Index%).SelLength = Len(mskCosto(Index%).Text)

End Sub

'! Private Sub optPosteo_GotFocus(Index As Integer)
'!     Select Case Index%
'!     Case 0, 1
'!         FPrincipal!pnlHelpLine.Caption = " Estado de las líneas pendientes"
'!     End Select
'!
'! End Sub
Private Sub mskCosto_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1
        If (KeyAscii < 48 Or KeyAscii > 57) And (KeyAscii <> 8) And (KeyAscii <> 46) Then
            KeyAscii = 0
        End If
        KeyAscii = FMValidarNumero((mskCosto(Index).Text), 16, KeyAscii, "105")
   End Select

End Sub

Private Sub mskCosto_LostFocus(Index As Integer)

Select Case Index%
    
    Case 0
        ' Valor de la cuota
        ' Verifica que el inicial del rango sea menor que el final del rango
        If mskCosto(0).Text <> "0.00" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(0).Text = "0.00"
                mskCosto(0).SetFocus
                Exit Sub
            End If
        End If
        
        If mskCosto(0).Text > "0.00" And txtCampo(4).Text > "0" Then
           If Not (mskCosto(0).Text * txtCampo(4).Text) > "9999999999" Then
                   mskCosto(1).Text = (mskCosto(0).Text * txtCampo(4).Text)
           Else
              MsgBox "Valor excede monto final maximo", 0 + 16, "Mensaje de Error"
              mskCosto(0).Text = "0.00"
              mskCosto(0).SetFocus
           End If
        End If
    Case 1
        'Valor Final esperado del Ahorro Contractual
        'Verifica que el valor final sea mayor que el inicial
        If mskCosto(1).Text <> "" Then
            If Not IsNumeric(mskCosto(0).Text) Then
                mskCosto(1).Text = ""
                mskCosto(1).SetFocus
                Exit Sub
            End If
            If mskCosto(0).Text <> "0.00" Then
                If Val(Format$(mskCosto(1).Text)) < Val(Format$(mskCosto(0).Text)) Then
                    MsgBox "El valor final está incorrecto", 0 + 16, "Mensaje de Error"
                    mskCosto(1).Text = ""
                    mskCosto(1).SetFocus
                    Exit Sub
                End If
            End If
        End If
End Select
End Sub
Private Sub PLLimpiar(tipo As String, Numero As Integer)
'*************************************************************
' PROPOSITO: Limpia los objetos y el grid, bajo ciertas
'            condiciones.
' INPUT    : Tipo = El símbolo que indica el rango de valores
'                   de los objetos y el grid a ser limpiados.
'            Numero = El número desde el cual se parte el
'                     barrido y limpiado de los objetos
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 30-Mar-11      J. Loyo H.      Emisión Inicial
'*************************************************************
Dim i%
    Select Case tipo
        Case "="
            If Numero <= 7 Then
                If Numero <> "4" Then
                   txtCampo(Numero - 1).Text = ""
                End If
                If Numero - 1 < 3 Then
                      lblDescripcion(Numero - 1).Caption = ""
                End If
                If Numero = 2 Then
                    optPlazo(1).Enabled = True
                    optPlazo(0).Enabled = True
                    optPlazo(0).Value = True
                    
                    optCuota(1).Enabled = True
                    optCuota(0).Enabled = True
                    optCuota(0).Value = True
                    
                    optContrac(1).Enabled = True
                    optContrac(0).Enabled = True
                    optContrac(0).Value = True
                    
                    optEstado(1).Enabled = True
                    optEstado(0).Enabled = True
                    optEstado(0).Value = True
                    
                    mskCosto(0).Text = "0.00"
                    mskCosto(1).Text = "0.00"
                    
                    PMLimpiaGrid grdProdContractual
                    
                End If
            ElseIf Numero = 8 Then
                PMLimpiaGrid grdProdContractual
            End If
            
        Case ">"
            For i% = Numero To 5
                PLLimpiar "=", i% + 1
            Next i%
        Case "<"
            For i% = Numero To 2 Step -1
                PLLimpiar "=", i% - 1
            Next i%
    End Select

End Sub

Private Sub PLModoInsertar(Modo As Integer)
'*************************************************************
' PROPOSITO: Habilita o deshabilita ciertos objetos de la
'            forma.
' INPUT    : Modo = Entero que indica si el campo se habilita
'                   o no.
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 30-Mar-11      J. Loyo H.      Emisión Inicial
'*************************************************************
    txtCampo(0).Enabled = Modo 'Sucursal
    txtCampo(1).Enabled = Modo 'Producto final
    txtCampo(2).Enabled = Modo 'Categoría

    
    If Modo Then
         PMObjetoSeguridad cmdBoton(1)
         'cmdBoton(2).Enabled = Not Modo 'Eliminar
         cmdBoton(5).Enabled = Not Modo 'Actualizar
    Else
         cmdBoton(1).Enabled = Modo 'Crear
         'PMObjetoSeguridad cmdBoton(2)
         PMObjetoSeguridad cmdBoton(5)
    End If
End Sub
Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Captura los valores respectivos del grid,
'            y los coloca en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 30-Mar-11      J. Loyo H.      Emisión Inicial
'*************************************************************
    grdProdContractual.Col = 1 'PRODUCTO FINAL
    txtCampo(1).Text = grdProdContractual.Text
    
    grdProdContractual.Col = 2 'DESCRIPCION PRODUCTO FINAL
    lblDescripcion(1).Caption = grdProdContractual.Text
    grdProdContractual.Col = 3 'CATEGORIA
    txtCampo(2).Text = grdProdContractual.Text
    grdProdContractual.Col = 4 'DESCRIPCION CATEGORIA
    lblDescripcion(2).Caption = grdProdContractual.Text
    grdProdContractual.Col = 5 ' PLAZO
    txtCampo(4).Text = grdProdContractual.Text
    grdProdContractual.Col = 6 'NEGOCIA PLAZO
    If grdProdContractual.Text = "S" Then
        optPlazo(0).Value = True
    Else
        optPlazo(1).Value = True
    End If
    grdProdContractual.Col = 7 'CUOTA
    mskCosto(0).Text = grdProdContractual.Text
    grdProdContractual.Col = 8 'NEGOCIA CUOTA
    If grdProdContractual.Text = "S" Then
        optCuota(0).Value = True
    Else
        optCuota(1).Value = True
    End If
    grdProdContractual.Col = 9 'PERIODICIDAD
    txtCampo(3).Text = grdProdContractual.Text
    grdProdContractual.Col = 10 'DESCRIPCION PERIODICIDAD
    lblDescripcion(3).Caption = grdProdContractual.Text
    grdProdContractual.Col = 11 'MONTO
    mskCosto(1).Text = grdProdContractual.Text
    'grdProdContractual.Col = 12 'DIAS
       
    grdProdContractual.Col = 12 'ESTADO
        If grdProdContractual.Text = "V" Then
        optEstado(0).Value = True
    Else
        optEstado(1).Value = True
    End If
    grdProdContractual.Col = 14 'PUNTOS ADIC
    txtCampo(5).Text = grdProdContractual.Text
    grdProdContractual.Col = 17 'SUCURSAL
    txtCampo(0).Text = grdProdContractual.Text
    grdProdContractual.Col = 18 'IMPRIME PLAN
    If grdProdContractual.Text = "S" Then
        optContrac(0).Value = True
    Else
        optContrac(1).Value = True
    End If
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Producto Final [F5 Ayuda]"
       txtCampo(2).Text = ""
       lblDescripcion(2).Caption = ""
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Código de la Categoría [F5 Ayuda]"
       PMBusca_Datos
    Case 3
       FPrincipal.pnlHelpLine.Caption = " Periodicidad del Ahorro Contractual [F5 Ayuda]"
    Case 4
       FPrincipal.pnlHelpLine.Caption = " Plazo del ahorro [F5 Ayuda]"
    Case 5
       FPrincipal.pnlHelpLine.Caption = " Puntos adicionales para el Ahorro Contractual"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTProFinal$

If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    Case 0
        PLLimpiar "=", 2
        VGOperacion$ = "sp_hp_sucursal"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
            Load FRegistros
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            VLPaso% = True 'No permite que se ejecute el lostfocus, cuando se muestre el catalogo
            FRegistros.Show 1
            
            If VGValores(1) <> "" Then
                txtCampo(0).Text = VGValores(1)
                lblDescripcion(0).Caption = VGValores(2)
                VLPaso% = True
            Else
                VGOperacion$ = ""
                PLLimpiar "=", 1
            End If

        Else
            PLLimpiar "=", 1
            VGOperacion$ = ""
        End If

    Case 1
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            PLLimpiar "<", 3
            VLPaso% = True
            txtCampo(0).SetFocus
            Exit Sub
        End If
    
        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin3"
        Load FRegistros
        While VTFilas% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$

             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
                If VTProFinal$ = "0" Then
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                Else
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                End If
                
                 PMChequea sqlconn&
                   
                VTFilas% = Val(FRegistros.grdRegistros.Tag)

                FRegistros.grdRegistros.Col = 1
                FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                VTProFinal$ = FRegistros.grdRegistros.Text
            Else
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                VGOperacion$ = ""
            End If
        Wend

        FRegistros.grdRegistros.Row = 1
        FRegistros.Show 1
            
        If VGValores(1) <> "" Then
            txtCampo(1).Text = VGValores(1)
            lblDescripcion(1).Caption = VGValores(2)
            VLProducto$ = VGValores(5)
            VLPaso% = True
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            VGOperacion$ = ""
            VLProducto$ = ""
        End If

    Case 2
         If txtCampo(6) <> "" Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "N"
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT1, txtCampo(1).Text
            PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(7)
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, txtCampo(6)
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                PMMapeaListaH sqlconn&, FCatalogo.lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo$
                lblDescripcion(2).Caption = VGACatalogo.Descripcion$
                If Trim$(txtCampo(2).Text) <> "" Then
                    VLPaso% = True
                    'If txtCampo(19).Visible And txtCampo(19).Enabled Then txtCampo(19).SetFocus
                End If
            End If
         End If
    Case 3
        PMCatalogo "A", "pe_periodicidad", txtCampo(3), lblDescripcion(3)
        VLPaso% = True
    End Select
End If
End Sub  '46 = .

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 0, 1, 4
        KeyAscii% = FMValidaTipoDato("N", KeyAscii%)
    Case 2, 3
        KeyAscii% = FMValidaTipoDato("A", KeyAscii%)
    Case 5, 7
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or KeyAscii > 57) And (KeyAscii <> 46) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
If VLPaso% = False Then
    Select Case Index%
    Case 0
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""

        If Trim$(txtCampo(0).Text) = "" Then
            lblDescripcion(0).Caption = ""
            Exit Sub
        End If
        If txtCampo(0).Text >= 32000 Then
            MsgBox "La Sucursal no puede ser mayor a 32000", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
             PMMapeaObjeto sqlconn&, lblDescripcion(0)
             PMChequea sqlconn&
        Else
            PLLimpiar "=", 1
            txtCampo(0).SetFocus
            VLPaso% = True
        End If
        
    Case 1
        If Trim$(txtCampo(1).Text) = "" Then
           PLLimpiar "=", 2
           Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
           MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
           PLLimpiar "<", 3
           txtCampo(0).SetFocus
           Exit Sub
        End If
        
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(1).Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
           ReDim VTArreglo(3) As String
           VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
           PMChequea sqlconn&
           lblDescripcion(1).Caption = VTArreglo(1)
           VLProducto$ = VTArreglo(3)
        Else
           PLLimpiar "=", 2
           txtCampo(1).SetFocus
           VLPaso% = True
        End If
        
    Case 2 ' Catalogo de categoria
        If Trim$(txtCampo(2).Text) = "" Then
            lblDescripcion(2).Caption = ""
            Exit Sub
        End If

        If VLPaso% = False Then
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
           PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "Q"
           PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "N"
           PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT1, txtCampo(1).Text
           PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(7)
           PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, txtCampo(6)
           PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
           PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
           PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda$
           PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina$
           PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text

           If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de categorías") Then
              PMMapeaObjeto sqlconn&, lblDescripcion(2)
              PMChequea sqlconn&
           Else
              txtCampo(2).Text = ""
              lblDescripcion(2).Caption = ""
              If txtCampo(2).Enabled Then txtCampo(2).SetFocus
           End If
              VLPaso% = True
        End If
    Case 3
        If VLPaso% = False Then
           If txtCampo(3).Text <> "" Then
              PMCatalogo "V", "pe_periodicidad", txtCampo(3), lblDescripcion(3)
              VLPaso% = True
           Else
              lblDescripcion(3).Caption = ""
           End If
        End If
    Case 5 'Dias Maximo de Mora
         If mskCosto(0).Text <> "0.00" And txtCampo(4).Text > "0" Then
             mskCosto(1).Text = (mskCosto(0).Text * txtCampo(4).Text)
         End If
    End Select
End If
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub
'FIXIT: Declare 'FMValidaTipoDato' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Function FMValidaTipoDato(TipoDato As String, valor As Integer)
    FMValidaTipoDato = valor%
    Select Case TipoDato$
    Case "N"
        If (valor% <> 8) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If
    Case "A"
        If (valor% <> 8) And ((valor% < 65) Or (valor% > 90)) And (valor% <> 241) And (valor% <> 209) And ((valor% < 97) Or (valor% > 122)) And (valor% <> 32) Then
            FMValidaTipoDato = 0
        Else
            FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
        End If
    Case "S"
        If (valor% = 32) Then
            FMValidaTipoDato = 0
        Else
            FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
        End If
    Case "B"
        FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
    Case "M"
        If (valor% <> 8) And (valor% <> 46) And ((valor% < 48) Or (valor% > 57)) Then
            FMValidaTipoDato = 0
        End If
    Case "U"
        If (valor% <> 8) And (valor% <> 32) And (valor% <> 241) And ((valor% < 48) Or (valor% > 57)) And ((valor% < 96) Or (valor% > 123)) And ((valor% < 65) Or (valor% > 90)) And (valor% <> 209) Then
            FMValidaTipoDato = 0
        Else
            FMValidaTipoDato = AscW(UCase$(Chr$(valor%)))
        End If
    End Select
End Function
Private Sub PMBusca_Datos()

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4123"
    PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
    PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
    PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_producto_contractual", True, " Ok... Consulta de Categorías") Then
       PMMapeaObjetoAB sqlconn&, txtCampo(6), txtCampo(7)
       PMChequea sqlconn&
    End If
End Sub


