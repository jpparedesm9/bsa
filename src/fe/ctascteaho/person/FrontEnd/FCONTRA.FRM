VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FContratacion 
   Appearance      =   0  'Flat
   Caption         =   "Contratación de Servicios"
   ClientHeight    =   5325
   ClientLeft      =   300
   ClientTop       =   1290
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
   ForeColor       =   &H80000008&
   Icon            =   "FCONTRA.frx":0000
   LinkTopic       =   "Form2"
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
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
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   6
      Top             =   1590
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
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
      Height          =   285
      Index           =   6
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   7
      Top             =   1845
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
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Transmitir"
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
      Index           =   0
      Left            =   8385
      Picture         =   "FCONTRA.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   11
      Tag             =   "4068"
      Top             =   3045
      Width           =   875
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1530
      Index           =   1
      Left            =   15
      TabIndex        =   10
      TabStop         =   0   'False
      Top             =   3770
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14632
      _ExtentY        =   2699
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
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   5
      Top             =   1335
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
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   2
      Top             =   570
      Width           =   930
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Buscar"
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
      Left            =   8385
      Picture         =   "FCONTRA.frx":0670
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "4070"
      Top             =   15
      Width           =   875
   End
   Begin VB.ComboBox cmbEnte 
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
      Left            =   1920
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   270
      Width           =   2400
   End
   Begin MSGrid.Grid grdServicios 
      Height          =   1110
      Index           =   0
      Left            =   15
      TabIndex        =   9
      TabStop         =   0   'False
      Top             =   2460
      Width           =   8295
      _Version        =   65536
      _ExtentX        =   14632
      _ExtentY        =   1958
      _StockProps     =   77
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
      Left            =   1920
      MaxLength       =   2
      TabIndex        =   3
      Top             =   825
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
      Index           =   2
      Left            =   1920
      MaxLength       =   10
      TabIndex        =   4
      Top             =   1080
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
      Height          =   750
      Index           =   2
      Left            =   8385
      Picture         =   "FCONTRA.frx":08D2
      Style           =   1  'Graphical
      TabIndex        =   13
      Top             =   4560
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
      Height          =   750
      Index           =   1
      Left            =   8385
      Picture         =   "FCONTRA.frx":0C38
      Style           =   1  'Graphical
      TabIndex        =   12
      Top             =   3795
      Width           =   875
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio:"
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
      Left            =   60
      TabIndex        =   34
      Top             =   1590
      Width           =   690
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
      Left            =   2865
      TabIndex        =   33
      Top             =   1590
      Width           =   5445
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
      Index           =   9
      Left            =   2865
      TabIndex        =   32
      Top             =   1845
      Width           =   5445
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
      Left            =   60
      TabIndex        =   31
      Top             =   1845
      Width           =   525
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
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
      Left            =   60
      TabIndex        =   30
      Top             =   30
      Width           =   1320
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
      Left            =   2865
      TabIndex        =   29
      Top             =   15
      Width           =   5445
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   1965
      TabIndex        =   28
      Top             =   2500
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto - Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   90
      TabIndex        =   27
      Top             =   2500
      Width           =   1695
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   3870
      TabIndex        =   26
      Top             =   2500
      Width           =   4245
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2910
      TabIndex        =   25
      Top             =   2500
      Width           =   930
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicios Personalizables:"
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
      TabIndex        =   22
      Top             =   3590
      Width           =   2040
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
      Index           =   5
      Left            =   2865
      TabIndex        =   23
      Top             =   1335
      Width           =   5445
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
      Left            =   2865
      TabIndex        =   16
      Top             =   570
      Width           =   5445
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Persona:"
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
      Left            =   45
      TabIndex        =   17
      Top             =   570
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Personalización:"
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
      Index           =   4
      Left            =   45
      TabIndex        =   24
      Top             =   270
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Valores de Servicios Contratados: "
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
      Index           =   3
      Left            =   45
      TabIndex        =   18
      Top             =   2300
      Width           =   2685
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rol:"
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
      TabIndex        =   19
      Top             =   825
      Width           =   330
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
      Left            =   2865
      TabIndex        =   21
      Top             =   825
      Width           =   5445
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
      Left            =   2865
      TabIndex        =   14
      Top             =   1080
      Width           =   5445
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
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
      TabIndex        =   15
      Top             =   1080
      Width           =   1200
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
      Index           =   2
      Left            =   60
      TabIndex        =   20
      Top             =   1335
      Width           =   825
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -30
      X2              =   8310
      Y1              =   2200
      Y2              =   2200
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8340
      X2              =   8340
      Y1              =   15
      Y2              =   5325
   End
End
Attribute VB_Name = "FContratacion"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
Dim VLPaso As Integer
Dim VLTipo As String
Dim VLEnte As String
Dim VLCol As Integer
Dim VLMoneda As String

Private Sub cmbEnte_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Tipo Personalización"
End Sub

Private Sub cmbEnte_LostFocus()
Dim VLConsulta$
    Select Case cmbEnte.Text
    Case "PERSONAL"
        txtCampo(4).Text = ""
        lblDescripcion(5).Caption = ""
        txtCampo(4).Enabled = True
        lblEtiqueta(7).Caption = "Código Persona"
        VLConsulta$ = "FBuscarCliente"
        txtCampo(1).Text = "1"
        txtCampo(1).Enabled = False
        lblDescripcion(1).Caption = "PROPIETARIO"
        txtCampo(4).Enabled = True
        VLEnte$ = "P"
     Case "EMPRESARIAL"
        VLEnte$ = "C"
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""
        txtCampo(1).Enabled = True
        lblEtiqueta(7).Caption = "Código Empresa"
        txtCampo(1).Enabled = True
        txtCampo(4).Text = "N"
        txtCampo(4).Enabled = False
        lblDescripcion(5).Caption = "NORMAL"
        
        VLConsulta$ = "FBuscarCliente"
        VLEnte$ = "E"

    Case "GRUPO ECONOMICO"
        
        txtCampo(1).Text = ""
        lblDescripcion(1).Caption = ""
        txtCampo(1).Enabled = True
        
        lblEtiqueta(7).Caption = "Código Grupo"
        txtCampo(1).Enabled = True
        txtCampo(4).Text = "N"
        txtCampo(4).Enabled = False
        lblDescripcion(5).Caption = "NORMAL"
        
        VLConsulta$ = "FBuscarGrupo"
        VLEnte$ = "G"
    
    End Select

End Sub

Private Sub cmdBoton_Click(Index As Integer)
Dim i%
Dim VTFilas1%
Dim VTServicio1$
Dim VTRango1$
Dim VTFilas2%
Dim VTServicio2$
Dim VTRango2$
    Select Case Index%
    Case 0
        'Crear Nuevo valor contratado

        If cmbEnte.Text = "" Then
            MsgBox "El Tipo de ente es mandatorio", 0 + 16, "Mensaje de Error"
            cmbEnte.SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El código del ente es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If txtCampo(1).Text = "" Then
            MsgBox "El código del rol es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        If txtCampo(2).Text = "" Then
            MsgBox "El código de producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(4).Text = "" Then
            MsgBox "El código de categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If
        grdServicios(1).Row = 1
        grdServicios(1).Col = 1
        If grdServicios(1).Text = "" Then
            Exit Sub
        End If
        For i% = 1 To grdServicios(1).Rows - 1
            grdServicios(1).Row = i%
            grdServicios(1).Col = grdServicios(1).Cols - 2
            If grdServicios(1).Text <> "" Then
                grdServicios(1).Col = grdServicios(1).Cols - 1
                If grdServicios(1).Text <> "" Then
                         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4068" 'Ojo Cambiar transaccion
                         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "T"
                         PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
                         PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, txtCampo(1).Text
                         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, lblDescripcion(6).Caption
                         PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(0).Text
                         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text
                         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, lblDescripcion(3).Caption
                         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
                        grdServicios(1).Col = 2
                         PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, grdServicios(1).Text
                        grdServicios(1).Col = 4
                         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT2, grdServicios(1).Text
                        grdServicios(1).Col = 6
                         PMPasoValores sqlconn&, "@i_grupo_rango", 0, SQLINT2, grdServicios(1).Text
                        grdServicios(1).Col = 8
                         PMPasoValores sqlconn&, "@i_rango", 0, SQLINT4, grdServicios(1).Text
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                         PMPasoValores sqlconn&, "@i_tipo_variacion", 0, SQLCHAR, grdServicios(1).Text 'P o M
                        grdServicios(1).Col = grdServicios(1).Cols - 1
                         PMPasoValores sqlconn&, "@i_valor_con", 0, SQLFLT8&, (grdServicios(1).Text)
                         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                             PMChequea sqlconn&
                            'cmdBoton(0).Enabled = False
                        Else
                            MsgBox "Fallo el registro " + (grdServicios(1).Row), 0 + 16, "Mensaje de Error"
                        End If
                End If
            End If
            grdServicios(1).Col = grdServicios(1).Cols - 2
            grdServicios(1).Text = ""
            grdServicios(1).Col = grdServicios(1).Cols - 1
            grdServicios(1).Text = ""
        Next i%
               
    Case 1 'Limpiar
        cmbEnte.Clear
        cmbEnte.AddItem "PERSONAL", 0
        cmbEnte.AddItem "EMPRESARIAL", 1
        cmbEnte.AddItem "GRUPO ECONOMICO", 2
        cmbEnte.ListIndex = 0
        
        For i% = 0 To 5
            txtCampo(i%).Text = ""
            txtCampo(i%).Enabled = True
        Next i%
        txtCampo(6).Text = ""

        For i% = 0 To 9
            lblDescripcion(i%).Caption = ""
        Next i%
        
        For i% = 0 To 1
            PMLimpiaGrid grdServicios(i%)
        Next i%
        
        lblEtiqueta(7).Caption = "Código Persona"
        txtCampo(1).Text = "1"
        txtCampo(1).Enabled = False
        lblDescripcion(1).Caption = "PROPIETARIO"
        
        cmdBoton(0).Enabled = False
        txtCampo(3).SetFocus
        
    Case 2 'Salir
        
        Unload FContratacion
        Unload FBuscarGrupo
        Unload FBuscarCliente

    Case 3
        If txtCampo(3).Text = "" Then
            MsgBox "El código de sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If cmbEnte.Text = "" Then
            MsgBox "El Tipo de personalización es mandatorio", 0 + 16, "Mensaje de Error"
            cmbEnte.SetFocus
            Exit Sub
        End If

        If txtCampo(0).Text = "" Then
            MsgBox "El código del ente es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If

        If txtCampo(1).Text = "" Then
            MsgBox "El código del rol es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "El código de producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If

        If txtCampo(4).Text = "" Then
            MsgBox "El código de categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If

        'Buscar
        VLTipo$ = ""
        VTFilas1% = VGMaxRows%
        VTServicio1$ = "0"
        VTRango1$ = "0"
        While VTFilas1% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4070"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "C"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, VTServicio1$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango1$
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, lblDescripcion(3).Caption
             PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
             PMPasoValores sqlconn&, "@i_rol", 0, SQLCHAR, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, lblDescripcion(6).Caption
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, txtCampo(0).Text
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(4).Text
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Ok... Consulta de Servicios") Then
                If VTServicio1$ = "0" And VTRango1$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios(0), False
                Else
                     PMMapeaGrid sqlconn&, grdServicios(0), True
                End If
                 PMChequea sqlconn&

                grdServicios(0).Col = 1
                grdServicios(0).Row = grdServicios(0).Rows - 1
                VTServicio1$ = grdServicios(0).Text
                grdServicios(0).Col = 3
                grdServicios(0).Row = grdServicios(0).Rows - 1
                VTRango1$ = grdServicios(0).Text
                
                ' Determinar que existan servicions bancarios
                If Val(grdServicios(0).Tag) > 0 Then
                    grdServicios(0).ColAlignment(4) = 1
                    grdServicios(0).ColAlignment(5) = 1
                    grdServicios(0).ColAlignment(7) = 1
                End If
            End If
             
            VTFilas1% = Val(grdServicios(0).Tag)
        Wend

        grdServicios(0).Row = 1

        If txtCampo(5).Text = "" Then
            MsgBox "El código del servicio es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(5).SetFocus
            Exit Sub
        End If
        
        VTFilas2% = VGMaxRows%
        VTServicio2$ = "0"
        VTRango2$ = "0"

        While VTFilas2% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_servicio_per", 0, SQLINT2, VTServicio2$
             PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango2$
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, (lblDescripcion(3).Caption)
             PMPasoValores sqlconn&, "@i_tipo_default", 0, SQLCHAR, VLEnte$
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, (lblDescripcion(6).Caption)
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, (txtCampo(4).Text)
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, (txtCampo(2).Text)
             PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, (txtCampo(5).Text)
             PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, (txtCampo(6).Text)
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Ok... Consulta de Servicios") Then
                If VTServicio2$ = "0" And VTRango2$ = "0" Then
                     PMMapeaGrid sqlconn&, grdServicios(1), False
                    If Val(grdServicios(1).Tag) > 0 Then
                        grdServicios(1).Cols = grdServicios(1).Cols + 2
                        grdServicios(1).Row = 0
                        grdServicios(1).Col = grdServicios(1).Cols - 2
                        grdServicios(1).Text = "M / P"
                        grdServicios(1).Col = grdServicios(1).Cols - 1
                        grdServicios(1).Text = "VALOR"
                        grdServicios(1).ColWidth(grdServicios(1).Cols - 2) = 500
                        grdServicios(1).ColWidth(grdServicios(1).Cols - 1) = 1800
                        grdServicios(1).ColWidth(2) = 1
                        grdServicios(1).ColWidth(4) = 1
                        grdServicios(1).ColWidth(6) = 1
                        grdServicios(1).ColWidth(8) = 1
                        grdServicios(1).ColWidth(9) = 1
                        grdServicios(1).ColAlignment(3) = 1
                        grdServicios(1).ColAlignment(5) = 1
                        grdServicios(1).ColAlignment(7) = 1
                        cmdBoton(0).Enabled = True
                    End If
                Else
                     PMMapeaGrid sqlconn&, grdServicios(1), True
                End If
                 PMChequea sqlconn&

                grdServicios(1).Col = 2
                grdServicios(1).Row = grdServicios(1).Rows - 1
                VTServicio2$ = grdServicios(1).Text
                grdServicios(1).Col = 8
                grdServicios(1).Row = grdServicios(1).Rows - 1
                VTRango2$ = grdServicios(1).Text
            Else
                Exit Sub
            End If
            If Val(grdServicios(1).Tag) = 50 Then
                VTFilas2% = 15
            Else
                VTFilas2% = 0
            End If
        Wend
        grdServicios(1).Row = 1

    End Select
End Sub

'*********************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'---------  J.Uria              Emisión Inicial
'28/May/98  Geovanna Bonilla B. Migracion VB3 a VB5
'*********************************************************

'GBB28MAY98001 II:Permite que al cargar la forma los campos obligatorios se pongan por defecto
    
    
Private Sub Form_Load()
Dim VLConsulta$
Dim i%
    FContratacion.Left = 15
    FContratacion.Top = 15
    FContratacion.Width = 9420
    FContratacion.Height = 5730
    PMBotonSeguridad FContratacion, 3
    
    PMObjetoSeguridad cmdBoton(0)
    PMObjetoSeguridad cmdBoton(3)
    
    cmbEnte.Clear
    cmbEnte.AddItem "PERSONAL", 0
    cmbEnte.AddItem "EMPRESARIAL", 1
    cmbEnte.AddItem "GRUPO ECONOMICO", 2
    cmbEnte.ListIndex = 0
    'GBB28MAY98001 II:
    'Permite que al cargar la forma los campos obligatorios se pongan por defecto
       txtCampo(4).Text = ""
        lblDescripcion(5).Caption = ""
        txtCampo(4).Enabled = True
        lblEtiqueta(7).Caption = "Código Persona"
        VLConsulta$ = "FBuscarCliente"
        txtCampo(1).Text = "1"
        txtCampo(1).Enabled = False
        lblDescripcion(1).Caption = "PROPIETARIO"
        txtCampo(4).Enabled = True
        VLEnte$ = "P"
       'GBB28MAY98001 IF:
    cmdBoton(0).Enabled = False
    For i% = 0 To 6
        txtCampo(i%).Height = 240
    Next
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdServicios_Click(Index As Integer)
    If Index% = 1 Then
        VLCol% = grdServicios(1).Col
    End If
    If Index = 1 And VLCol% > 0 Then
        grdServicios(1).Col = VLCol%
    End If
End Sub

Private Sub grdServicios_GotFocus(Index As Integer)
 Select Case Index%
 Case 0
    FPrincipal.pnlHelpLine.Caption = "Servicios Contratados"
 Case 1
    
    FPrincipal.pnlHelpLine.Caption = "Servicios Disponibles"
 End Select
End Sub

Private Sub grdServicios_KeyPress(Index As Integer, KeyAscii As Integer)
Dim VTRow%
Dim VTCol%
Dim VTDato$
If Index% = 1 Then
    
    If VLCol% > 0 Then
    grdServicios(1).Col = VLCol%
    End If
    
    VTRow% = grdServicios(1).Row
    VTCol% = grdServicios(1).Col
    grdServicios(1).Row = 1
    grdServicios(1).Col = 1
    If grdServicios(1).Text = "" Then
        Exit Sub
    End If
    grdServicios(1).Row = VTRow%
    grdServicios(1).Col = VTCol%
    
    
    ' Columna de Tipo de Dato
    
    If grdServicios(1).Col = grdServicios(1).Cols - 2 Then
       
        ' rutina de Backspace
        
        If (KeyAscii% = 8) Then
            If Len(grdServicios(1).Text) > 0 Then
                grdServicios(1).Text = Mid$(grdServicios(1).Text, 1, Len(grdServicios(1).Text) - 1)
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            End If
        End If
        
        If (Len(grdServicios(1).Text) > 0) Then
            KeyAscii% = 0
            Exit Sub
        End If
        ' Validar que el KeyAscii% solo sea "M" o P" con Uppercase
        If (UCase$(Chr$(KeyAscii%)) = "P" Or UCase$(Chr$(KeyAscii%)) = "M") Then
                KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
                grdServicios(1).Text = (UCase$(Chr$(KeyAscii%)))
                VLTipo$ = grdServicios(1).Text
        Else
                KeyAscii% = 0
        End If
        
        ' Columna de valores
    ElseIf grdServicios(1).Col = grdServicios(1).Cols - 1 Then
        
        VTCol% = grdServicios(1).Col
        grdServicios(1).Col = grdServicios(1).Cols - 3
        VTDato$ = grdServicios(1).Text
        grdServicios(1).Col = VTCol%

        'Solo permite ingresar si se ingresado algo en la columna anterior
        
        If VLTipo$ = "" Then
            KeyAscii% = 0
            MsgBox "El tipo de dato es mandatorio", 0 + 16, "Mensaje de Error"
            VLCol% = grdServicios(1).Col
            grdServicios_Click (1)
            Exit Sub
        End If
        'Rutina de Backspace
        If (KeyAscii% = 8) Then
            If Len(grdServicios(1).Text) > 0 Then
                grdServicios(1).Text = Mid$(grdServicios(1).Text, 1, Len(grdServicios(1).Text) - 1)
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            End If
        End If
        
        'Valida que se pueda ingresar decimales de acuerdo al tipo de dato y la moneda
        
        If VLTipo$ = "P" Then
            If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (Chr$(KeyAscii%)) <> "." And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                    KeyAscii% = 0
                    VLCol% = grdServicios(1).Col
                    grdServicios_Click (1)
                    Exit Sub
            Else
                grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                
            End If
        Else
            If VLMoneda$ = "N" And VLTipo$ = "M" And VTDato$ = "M" Then
                
                If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                        KeyAscii% = 0
                        VLCol% = grdServicios(1).Col
                        grdServicios_Click (1)
                        Exit Sub
                Else
                    grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                    
                End If
                
                
            Else
                If ((KeyAscii% < 48) Or (KeyAscii% > 57)) And (Chr$(KeyAscii%)) <> "." And UCase$(Chr$(KeyAscii%)) <> "+" And UCase$(Chr$(KeyAscii%)) <> "-" Then
                        KeyAscii% = 0
                        VLCol% = grdServicios(1).Col
                        grdServicios_Click (1)
                        Exit Sub
                Else
                    grdServicios(1).Text = grdServicios(1).Text & Chr$(KeyAscii%)
                    
                End If

            End If
        End If
        
        'Valida que no tenga más de un punto
        
        If Len(grdServicios(1).Text) > 0 And (grdServicios(1).Text <> "." And grdServicios(1).Text <> "+" And grdServicios(1).Text <> "-") Then
            If IsNumeric(grdServicios(1).Text) = False Or (InStr(1, grdServicios(1).Text, "+") > 1) Or (InStr(1, grdServicios(1).Text, "-") > 1) Then
               'Mensaje de Error
                MsgBox "Valor Incorrecto", 0 + 16, "Mensaje de Error"
                grdServicios(1).Text = ""
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            End If
        End If
        'Valida que sea menor que 100 si es porcentaje
        If VLTipo$ = "P" Then
            If Abs(Val(Format$(grdServicios(1).Text))) > 100 Then
                MsgBox "Valor Incorrecto", 0 + 16, "Mensaje de Error"
                grdServicios(1).Text = ""
                VLCol% = grdServicios(1).Col
                grdServicios_Click (1)
                Exit Sub
            End If
        End If
    End If
    
VLCol% = grdServicios(1).Col
grdServicios_Click (1)
    
End If
End Sub

Private Sub grdServicios_KeyUp(Index As Integer, KeyCode As Integer, Shift As Integer)
    
    Select Case Index%
    Case 0, 1

        grdServicios(Index%).Col = 0
       ' grdServicios(Index%).SelStartCol = 1
        grdServicios(Index%).SelEndCol = grdServicios(Index%).Cols - 1
        If grdServicios(Index%).Row = 0 Then
            grdServicios(Index%).SelStartRow = 1
            grdServicios(Index%).SelEndRow = 1
        Else
            grdServicios(Index%).SelStartRow = grdServicios(Index%).Row
            grdServicios(Index%).SelEndRow = grdServicios(Index%).Row
        End If
    End Select
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4, 5, 6
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    If cmbEnte.Text = "" Then
        MsgBox "Tipo de Personalización es mandatoria", 0 + 16, "Mensaje de Error"
        cmbEnte.SetFocus
        Exit Sub
    End If
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código del Ente [F5 Ayuda]"
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Rol del Ente [F5 Ayuda]"
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Producto Final [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Categoría [F5 Ayuda]"
    Case 5
        FPrincipal.pnlHelpLine.Caption = " Servicio disponible [F5 Ayuda]"
    Case 6
        FPrincipal.pnlHelpLine.Caption = " Rubro del servicio [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTProFinal$
    If KeyCode% <> VGTeclaAyuda% Then Exit Sub

    VLPaso% = True
    Select Case Index%
    Case 0
        Select Case VLEnte$
        Case "P"
            FBuscarCliente.optCliente(1).Enabled = False 'Compañía
            FBuscarCliente.optCliente(0).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(1).Enabled = True
        Case "E"
            FBuscarCliente.optCliente(0).Enabled = False 'Persona
            FBuscarCliente.optCliente(1).Value = True
            FBuscarCliente.Show 1
            FBuscarCliente.optCliente(0).Enabled = True '
        Case "G"
        Load FBuscarGrupo
            FBuscarGrupo.Show 1
        End Select
        If VGBusqueda(1) <> "" Then
            txtCampo(0).Text = VGBusqueda(1)
            If VLEnte$ = "P" Then
                lblDescripcion(0).Caption = VGBusqueda(2) & " " & VGBusqueda(3) & " " & VGBusqueda(4)
            Else
                lblDescripcion(0).Caption = VGBusqueda(2)
            End If
        End If

    Case 1 'Rol
    
        PMCatalogo "A", "cl_rol_empresa", txtCampo(1), lblDescripcion(1)

    Case 2
        If txtCampo(3).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
    
        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin2"
        While VTFilas% = VGMaxRows%
        'GBB27May98003 II:
        Load FRegistros
        'GBB27May98003 IF:
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S2"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(3).Text
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
                txtCampo(2).Text = ""
                lblDescripcion(2).Caption = ""
                VGOperacion$ = ""
            End If
        Wend

        FRegistros.grdRegistros.Row = 1
            
        FRegistros.Show 1
            
         ' PMChequea SqlConn&
        If VGValores(1) <> "" Then
            txtCampo(2).Text = VGValores(1)
            lblDescripcion(2).Caption = VGValores(2)
        Else
            txtCampo(2).Text = ""
            lblDescripcion(2).Caption = ""
            VGOperacion$ = ""
        End If

    Case 3
        VGOperacion$ = "sp_hp_sucursal"
        'GBB26May98008 II:
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
                txtCampo(3).Text = VGValores(1)
                lblDescripcion(7).Caption = VGValores(2)
            Else
                txtCampo(3).Text = ""
                lblDescripcion(7).Caption = ""
                VGOperacion$ = ""
            End If
            
        Else
            txtCampo(3).Text = ""
            lblDescripcion(7).Caption = ""
            VGOperacion$ = ""
        End If

    Case 4
        VGOperacion$ = ""
        PMCatalogo "A", "pe_categoria", txtCampo(4), lblDescripcion(5)
    
    Case 5
    'GBB27May98004 II:
    Load FCatalogoServ
    'GBB27May98004 IF:
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, (txtCampo(4).Text)
         PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
             PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
             PMChequea sqlconn&
            VGOperacion$ = "operacionHCont"
            FCatalogoServ.Show 1
            If txtCampo(5).Text <> "" Then
                txtCampo(5).Enabled = False
            End If
        End If
    End Select
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 1, 4, 6
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    Case 0, 2, 3, 5
        If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    Select Case Index%
    Case 0
        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                ReDim VTArreglo(7) As String
                Select Case VLEnte$
                Case "P"
                    
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                     PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(0).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", False, "") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTArreglo(2) = "P" Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                            VLPaso% = True
                        Else
                            MsgBox "Código No corresponde a Persona", 0 + 16, "Mensaje de Error"
                            txtCampo(0).Text = ""
                            txtCampo(0).SetFocus

                        End If
                    Else
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Caption = ""

                    End If
                Case "E"
                    
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1190"
                     PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4, (txtCampo(0).Text)
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_qrente", False, "") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        If VTArreglo(2) = "C" Then
                            lblDescripcion(0).Caption = VTArreglo(1)
                        Else
                            MsgBox "Código No corresponde a Compañía", 0 + 16, "Mensaje de Error"
                            txtCampo(0).Text = ""
                            txtCampo(0).SetFocus
                        End If
                    Else
                        lblDescripcion(0).Caption = ""

                    End If
            
                Case "G"
                     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1184"
                     PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT4, (txtCampo(0).Text)
                     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
                     If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_grupo", False, "") Then
                         VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                         PMChequea sqlconn&
                        lblDescripcion(0).Caption = VTArreglo(2)
                        VLPaso% = True
                    Else
                        txtCampo(0).Text = ""
                        lblDescripcion(0).Caption = ""

                    End If
                End Select
            Else
                lblDescripcion(0).Caption = ""
            End If
        End If

    Case 1
        If VLPaso% = False Then
            If txtCampo(1).Text <> "" Then
                PMCatalogo "V", "cl_rol_empresa", txtCampo(1), lblDescripcion(1)
            Else
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
            End If
        End If
    
    Case 2 'Producto Final
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(2)
                     PMChequea sqlconn&
                    
                Else
                    lblDescripcion(2).Caption = ""
                    txtCampo(2).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(2).Caption = ""
            End If
        End If

    Case 3
        If VLPaso% = False Then
            If txtCampo(3).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(3).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(7)
                     PMChequea sqlconn&
                Else
                    lblDescripcion(7).Caption = ""
                    txtCampo(3).Text = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(7).Caption = ""
            End If
        End If
        
    Case 4
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then
                PMCatalogo "V", "pe_categoria", txtCampo(4), lblDescripcion(5)
            Else
                lblDescripcion(5).Caption = ""
            End If
        End If

    Case 5
        If VLPaso% = False Then
            If txtCampo(5).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
                 PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "0"
                 PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, ""
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT2, "0"
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, (txtCampo(5).Text)
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                     PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
                     PMChequea sqlconn&
                    VGOperacion$ = "operacionH2Cont"
                    FCatalogoServ.Show 1
                    If txtCampo(5).Text <> "" Then
                        txtCampo(5).Enabled = False
                    End If
                End If
            End If
        End If
    End Select
End Sub



