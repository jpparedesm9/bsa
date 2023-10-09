VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTRAN354 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Autorización de Solicitud de Apertura de Cuentas de Ahorros"
   ClientHeight    =   5715
   ClientLeft      =   1815
   ClientTop       =   2490
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
   ForeColor       =   &H00FFFFFF&
   HelpContextID   =   1131
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5715
   ScaleWidth      =   9300
   Tag             =   "3100"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   0
      Left            =   1815
      MaxLength       =   250
      TabIndex        =   25
      Top             =   4640
      Width           =   6500
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   1815
      MaxLength       =   3
      TabIndex        =   3
      Top             =   3720
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   1890
      MaxLength       =   8
      TabIndex        =   0
      Top             =   15
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   1815
      MaxLength       =   2
      TabIndex        =   5
      Top             =   4320
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   1815
      MaxLength       =   5
      TabIndex        =   6
      Top             =   4980
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   3
      Left            =   1815
      MaxLength       =   2
      TabIndex        =   4
      Top             =   4020
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Index           =   2
      Left            =   1815
      MaxLength       =   2
      TabIndex        =   2
      Top             =   3420
      Width           =   975
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   2745
      Left            =   15
      TabIndex        =   1
      TabStop         =   0   'False
      Top             =   585
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   4842
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
      Cols            =   7
      FixedCols       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   7
      Top             =   3030
      WhatsThisHelpID =   2007
      Width           =   875
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   8
      Top             =   3795
      WhatsThisHelpID =   2003
      Width           =   875
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
      Index           =   4
      Left            =   8415
      TabIndex        =   9
      Top             =   4560
      WhatsThisHelpID =   2008
      Width           =   875
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Observación:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   75
      TabIndex        =   26
      Top             =   4640
      WhatsThisHelpID =   5132
      Width           =   1140
   End
   Begin VB.Label lblmalaref 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H000000FF&
      Height          =   285
      Left            =   60
      TabIndex        =   24
      Top             =   5340
      Visible         =   0   'False
      Width           =   8295
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   23
      Top             =   3720
      WhatsThisHelpID =   5130
      Width           =   915
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   10
      Left            =   2805
      TabIndex        =   22
      Top             =   3720
      Width           =   5535
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   9
      Left            =   2805
      TabIndex        =   15
      Top             =   4320
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   8
      Left            =   2805
      TabIndex        =   12
      Top             =   4980
      Visible         =   0   'False
      Width           =   5535
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   7
      Left            =   2805
      TabIndex        =   13
      Top             =   4020
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   6
      Left            =   2805
      TabIndex        =   14
      Top             =   3420
      Width           =   5535
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   75
      TabIndex        =   16
      Top             =   4320
      WhatsThisHelpID =   5067
      Width           =   660
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Departamento:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   75
      TabIndex        =   17
      Top             =   4980
      Visible         =   0   'False
      WhatsThisHelpID =   5036
      Width           =   1260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   18
      Top             =   4020
      WhatsThisHelpID =   5209
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto bancario:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   19
      Top             =   3420
      WhatsThisHelpID =   5176
      Width           =   1635
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Lista de Propietarios:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   60
      TabIndex        =   20
      Top             =   380
      WhatsThisHelpID =   5055
      Width           =   1815
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H000000FF&
      Height          =   285
      Index           =   1
      Left            =   7200
      TabIndex        =   11
      Top             =   15
      Width           =   1170
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Fecha de la solicitud:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   10
      Left            =   4500
      TabIndex        =   21
      Top             =   15
      WhatsThisHelpID =   5251
      Width           =   2640
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8385
      Y1              =   3375
      Y2              =   3375
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   330
      Y2              =   315
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Número de solicitud:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   10
      Top             =   15
      WhatsThisHelpID =   5250
      Width           =   1755
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   15
      Y2              =   5310
   End
End
Attribute VB_Name = "FTRAN354"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
    '*********************************************************
'   ARCHIVO:        FTRAn354.FRM
'   NOMBRE LOGICO:  FTRAN354
'   PRODUCTO:       Terminal Administrativa
'*********************************************************
'                       IMPORTANTE
' Esta Aplicación es parte de los paquetes bancarios pro-
' piedad de MACOSA, representantes exclusivos para el Ecua-
' dor de la NCR CORPORATION.  Su uso no autorizado queda
' expresamente prohibido así como cualquier alteración o
' agregado hecho por alguno de sus usuarios sin el debido
' consentimiento por escrito de la Presidencia Ejecutiva
' de MACOSA o su representante
'*********************************************************
'                    PROPOSITO
' DESCRIPCION:  Esta forma permite solicitud una cuenta
'               de ahorros personalizada por MACOSA.
'*********************************************************
'                  MODIFICACIONES
'   FECHA          AUTOR                RAZON
' 23-Junio-1995   R. Garzon P.          Emision Inicial
'*********************************************************
Option Explicit

Dim VLNumero As Integer
Dim VLTitular As Integer
Dim VLPaso As Boolean
Dim VLEstadoInicial As String
Dim VLFormatoFecha As String
Dim VLNumSol As String
Dim VLCed As String

Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
    Case 2
        PLActualizar
    Case 3
        PLLimpiar
    Case 4
        PLSalir
    End Select
End Sub

Private Sub Form_Load()
    FTRAN354.Left = 0
    FTRAN354.Top = 0
    FTRAN354.Width = 9450
    FTRAN354.Height = 6120
    PMLoadResStrings Me
    PMLoadResIcons Me
    grdPropietarios.ColWidth(0) = 960
    grdPropietarios.ColWidth(1) = 1440
    grdPropietarios.ColWidth(2) = 300
    grdPropietarios.ColWidth(3) = 3915
    grdPropietarios.ColWidth(4) = 375
    grdPropietarios.ColWidth(5) = 1230
    grdPropietarios.Row = 0
    grdPropietarios.Col = 0
    grdPropietarios.Text = "CODIGO"
    grdPropietarios.Col = 1
    grdPropietarios.Text = "IDENTIFICACION"
    grdPropietarios.Col = 2
    grdPropietarios.Text = "TP."
    grdPropietarios.Col = 3
    grdPropietarios.Text = "NOMBRE"
    grdPropietarios.Col = 4
    grdPropietarios.Text = "TIT."
    grdPropietarios.Col = 5
    grdPropietarios.Text = "DESCRIPCION"
    cmdBoton(2).Enabled = False
    cmdBoton(3).Enabled = False
    txtCampo(7).Enabled = False
    txtCampo(4).Enabled = False
    VLNumero = 0
    VLTitular = 0
    VLEstadoInicial = Space(0)
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdPropietarios_Click()
    grdPropietarios.Col = 0
    grdPropietarios.SelStartCol = 1
    grdPropietarios.SelEndCol = grdPropietarios.Cols - 1
    If grdPropietarios.Row = 0 Then
        grdPropietarios.SelStartRow = 1
        grdPropietarios.SelEndRow = 1
    Else
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
    End If

End Sub

Private Sub grdPropietarios_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta"
End Sub

Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Permite actualizar los datos de la solicitud de
'            apertura.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    ' Validaciones de Mandatoriedades
     'Verificar el manejo de menores de edad
     Dim VTDetProductoAho As String
     Dim VTR1 As Integer
     If Not FLVerificarMenor Then
        Exit Sub
     End If
     
    ' Numero de Solicitud
    If txtCampo(6).Text = "" Then
        MsgBox "El número de solicitud es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
        Exit Sub
    End If

    ' Tipo de cuenta
    If txtCampo(2).Text = "" Then
        MsgBox "El producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
        Exit Sub
    End If

    ' Categoría
    If Trim$(txtCampo(7).Text) = "" Then
        MsgBox "La categoría de la cuenta es mandatoria", 0 + 16, "Mensaje de Error"
        If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).SetFocus
        Exit Sub
    End If
    
    'Estado de la solicitud
    If txtCampo(5).Text = "" Then
        MsgBox "El estado de la solicitud es mandatorio", 0 + 16, "Mensaje de Error"
        If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).SetFocus
        Exit Sub
    Else
        If VLEstadoInicial = txtCampo(5).Text Then
           MsgBox "La solicitud ya se encuentra en ese estado.", 0 + 16, "Mensaje de Error"
           Exit Sub
        End If
        If txtCampo(5).Text <> "AP" And txtCampo(5).Text <> "NE" Then
           MsgBox "Opción no válida. La solicitud debe ser aprobada o negada", 0 + 16, "Mensaje de Error"
           txtCampo(5).Text = ""
           lblDescripcion(9).Caption = ""
           If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).SetFocus
           Exit Sub
        End If
        If txtCampo(5).Text = "NE" And txtCampo(0).Text = "" Then
           MsgBox "Favor emitir la observación por la cual fue negada.", 0 + 16, "Mensaje de Error"
           txtCampo(0).Enabled = True
           txtCampo(0).SetFocus
           Exit Sub
        End If
    End If

    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "354"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
     PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(6).Text)
     PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, (txtCampo(5).Text)
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, (txtCampo(3).Text)
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, (txtCampo(2).Text)
     PMPasoValores sqlconn&, "@i_depart", 0, SQLCHAR, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, (txtCampo(7).Text)
     PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(0).Text)
     If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Actualización Solicitud de la cuenta") Then
        ReDim VTArreglo(20) As String
        ReDim VTArreglo1(20) As String
        If Trim$(txtCampo(2).Text) = "···&&2" Then
            VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo1())
            VTDetProductoAho = VTArreglo1(3)
        End If
        VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        
        cmdBoton(2).Enabled = False
       
    Else
        lblDescripcion(1).Caption = ""
    End If

End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia todos los valores de los objetos y del
'            grid de la forma.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim i As Integer
    For i = 2 To 7
        If i <> 4 Then
        txtCampo(i).Text = ""
        End If
    Next i
    txtCampo(3).Tag = ""
    lblDescripcion(1).Caption = ""
    For i = 6 To 10
        If i <> 8 Then
        lblDescripcion(i).Caption = ""
        End If
    Next i
    lblmalaref.Caption = ""
    lblmalaref.Visible = False
    grdPropietarios.Rows = 2
    grdPropietarios.Row = 1
    For i = 0 To 6
        grdPropietarios.Col = i
        grdPropietarios.Text = ""
    Next i
    grdPropietarios.Tag = ""
    VLNumero = 0
    VLTitular = 0
    VLEstadoInicial = Space(0)
    txtCampo(0).Text = ""
    txtCampo(0).Enabled = False
    If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
    txtCampo(5).Enabled = True
    cmdBoton(3).Enabled = False
    cmdBoton(2).Enabled = False
End Sub

Private Sub PLSalir()
'*************************************************************
' PROPOSITO: Permite cerrar la forma FTRAn354.FRM
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    Unload FTRAN354
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Crea una nueva solicitud de apertura de una cuenta
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    ' Validaciones de Mandatoriedades
    ' Numero de Solicitud
    Dim i As Integer
    Dim VTR1 As Integer
    Dim VTR As Integer
    If txtCampo(6).Text = "" Then
        Exit Sub
    End If

    ' Limpiar la pantalla, para borrar los datos anteriores
    For i = 2 To 6
        If i <> 6 Then
            txtCampo(i).Text = ""
        End If
    Next i
    txtCampo(3).Tag = ""
    lblDescripcion(1).Caption = ""
    For i = 6 To 9
        lblDescripcion(i).Caption = ""
    Next i
    grdPropietarios.Rows = 2
    grdPropietarios.Row = 1
    For i = 0 To 6
        grdPropietarios.Col = i
        grdPropietarios.Text = ""
    Next i
    grdPropietarios.Tag = ""
    VLNumero = 0
    VLTitular = 0
    VLEstadoInicial = Space(0)
    txtCampo(5).Enabled = True
    cmdBoton(3).Enabled = False
    cmdBoton(2).Enabled = False

    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "355"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
     PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(6).Text)
     PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "SI"
     PMPasoValores sqlconn&, "@i_formato_fecha", 0, SQLINT4, VGFecha_SP
     If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta Solicitud de la cuenta") Then
        ReDim VTArreglo(20) As String
        VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        If CInt(VTArreglo(3)) = CInt(VGMoneda) Then
            cmdBoton(2).Enabled = True
            cmdBoton(3).Enabled = True
            txtCampo(3).Text = VGMoneda
            PMCatalogo "V", "cl_moneda", txtCampo(3), lblDescripcion(7)
            txtCampo(3).Enabled = False
            VLPaso = True
    
            txtCampo(4).Text = VTArreglo(4)
            If Trim$(txtCampo(4).Text) <> "" Then
                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "8"
                PMPasoValores sqlconn&, "@i_dep", 0, SQLINT2, (txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_departamento", True, " Ok... Consulta de departamentos") Then
                   PMMapeaObjeto sqlconn&, lblDescripcion(8)
                   PMChequea sqlconn&
                Else
                   txtCampo(4).Text = ""
                   lblDescripcion(8).Caption = ""
                   If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).SetFocus
                End If
            End If
    
            txtCampo(5).Text = VTArreglo(9)
            VLEstadoInicial = VTArreglo(9)
            PMCatalogo "V", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9)
            VLPaso = True

            txtCampo(7).Text = VTArreglo(10)
            PMCatalogo "V", "pe_categoria", txtCampo(7), lblDescripcion(10)
            VLPaso = True
            
            If VTArreglo(11) = "S" Then
                lblmalaref.Caption = "Uno de los prospectos clientes ingresados consta en las listas negras"
                lblmalaref.Visible = True
            Else
                lblmalaref.Caption = ""
                lblmalaref.Visible = False
            End If
    
            VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
            lblDescripcion(1).Caption = Format$(VTArreglo(6), VLFormatoFecha)

            
            
            VLNumSol = VTArreglo(1)
        
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "356"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S1"
            PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, (txtCampo(6).Text)
            PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Consulta Solicitud de la cuenta") Then
                ReDim Valores(8, 40) As String
                VTR = FMMapeaMatriz(sqlconn&, Valores())
                VLTitular = 0
                For i = 1 To VTR
                    If Valores(1, i) <> "" Then
                        VLCed = Valores(1, i)
                    Else
                        VLCed = Valores(2, i)
                    End If
                    grdPropietarios.AddItem Str$(i) & Chr(9) & Valores(0, i) & Chr(9) & VLCed & Chr(9) & Valores(3, i) & Chr(9) & Valores(4, i) & Chr(9) & Valores(5, i) & Chr(9) & Valores(6, i) & Chr(9) & Valores(7, i)

                    If Trim$(Valores(5, i)) = "T" Then
                        VLTitular = i
                    End If
                Next i
                PMChequea sqlconn&
            End If
            If grdPropietarios.Rows > 2 Then
                grdPropietarios.RemoveItem 1
            End If
            grdPropietarios.ColWidth(0) = 1
            grdPropietarios.ColWidth(1) = 960
            grdPropietarios.ColWidth(2) = 1440
            grdPropietarios.ColWidth(3) = 300
            grdPropietarios.ColWidth(4) = 3915
            grdPropietarios.ColWidth(5) = 375
            grdPropietarios.ColWidth(6) = 1230
            grdPropietarios.Row = 0
            grdPropietarios.Col = 1
            grdPropietarios.Text = "CODIGO"
            grdPropietarios.Col = 2
            grdPropietarios.Text = "IDENTIFICACION"
            grdPropietarios.Col = 3
            grdPropietarios.Text = "TP."
            grdPropietarios.Col = 4
            grdPropietarios.Text = "NOMBRE"
            grdPropietarios.Col = 5
            grdPropietarios.Text = "TIT."
            grdPropietarios.Col = 6
            grdPropietarios.Text = "DESCRIPCION"
    
            txtCampo(2).Text = VTArreglo(5)
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
            PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(2).Text)
            PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
            grdPropietarios.Row = VLTitular
            grdPropietarios.Col = 3
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
               PMMapeaObjeto sqlconn&, lblDescripcion(6)
               PMChequea sqlconn&
            Else
               txtCampo(2).Text = ""
               lblDescripcion(6).Caption = ""
               If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
            End If

            If VTArreglo(9) = "PR" Then
               MsgBox "La solicitud ya fue aperturada", 0 + 16, "Mensaje de Error"
               cmdBoton(2).Enabled = False
               txtCampo(2).Enabled = False
               txtCampo(4).Enabled = False
               txtCampo(5).Enabled = False
               txtCampo(7).Enabled = False
               If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
               Exit Sub
            End If
            If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
        Else
            MsgBox "Está trabajando con moneda contraria a la de la solicitud"
            If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
        End If
    Else
        PLLimpiar
        If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
    End If

End Sub



Private Sub txtCampo_Change(Index As Integer)
    Select Case Index
    Case 2, 3, 4, 5, 6, 7
        VLPaso = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Código del producto bancario [F5 Ayuda ]"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Código de la moneda de la cuenta [F5 Ayuda]"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código del departamento que solicita [F5 Ayuda]"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Estado de la cuenta [F5 Ayuda]"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Número de solicitud"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Código de la categoría [F5 Ayuda]"
    
    End Select
    VLPaso = True
    txtCampo(Index).SelStart = 0
    txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    If Keycode = VGTeclaAyuda Then
        VLPaso = True
        Select Case Index
        Case 2 ' Tipo de cuenta
            ' F5 para Productos Bancarios
                
            If VLTitular <= 0 Then
                MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular
                grdPropietarios.Col = 3
            End If

            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
            PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_productoban", True, " Ok... Consulta de Productos Bancarios") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                VLPaso = True
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo
                lblDescripcion(6).Caption = VGACatalogo.Descripcion
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""

                If txtCampo(2).Text <> "" And txtCampo(7).Enabled Then
                    If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).SetFocus
                End If
            End If

        Case 3 ' Moneda
            PMCatalogo "A", "cl_moneda", txtCampo(3), lblDescripcion(7)
            VLPaso = True

        Case 4 'Departamento
            VLPaso = True
            PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "A"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
            PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "8"
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_departamento", True, " Ok... Consulta de departamentos") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(4).Text = VGACatalogo.Codigo
                lblDescripcion(8).Caption = VGACatalogo.Descripcion
                If txtCampo(4).Text <> "" Then
                    If txtCampo(5).Enabled And txtCampo(5).Visible Then txtCampo(5).SetFocus
                End If
            End If

        Case 5 'Estado
                PMCatalogo "A", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9)
                VLPaso = True
                If txtCampo(5).Text = "NE" Then
                   txtCampo(0).Enabled = True
                   txtCampo(0).SetFocus
                Else
                    txtCampo(0).Text = ""
                    txtCampo(0).Enabled = False
                        If txtCampo(5).Text <> "" And cmdBoton(2).Enabled = True Then
                            If cmdBoton(2).Enabled And cmdBoton(2).Visible Then cmdBoton(2).SetFocus
                        End If
                End If
        Case 7 'Categoría
            If Trim$(txtCampo(6).Text) = "" Then
                MsgBox "El número de solicitud es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
                Exit Sub
            End If
            
            If Trim$(txtCampo(2).Text) = "" Then
                MsgBox "El tipo de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                Exit Sub
            End If

            If VLTitular <= 0 Then
                MsgBox "La Solicitud de cuenta debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular
                grdPropietarios.Col = 3
            End If
            
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
            PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "H"
            PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
            PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
            PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
            PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
            PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                PMMapeaListaH sqlconn&, FCatalogo!lstCatalogo, False
                PMChequea sqlconn&
                FCatalogo.Show 1
                txtCampo(7).Text = VGACatalogo.Codigo
                lblDescripcion(10).Caption = VGACatalogo.Descripcion
                If Trim$(txtCampo(7).Text) <> "" Then
                    VLPaso = True
                    If txtCampo(4).Enabled Then
                        If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).SetFocus
                    End If
                End If
            End If

        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index
    Case 0
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
    Case 2, 3, 4, 6
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    Case 5
        If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
            KeyAscii = 0
        Else
            KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
        End If
    Case 7
        KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
    End Select
End Sub

Public Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index
    Case 2
        If VLPaso = False Then
            If txtCampo(2).Text <> "" Then
            
                If VLTitular <= 0 Then
                    MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular
                    grdPropietarios.Col = 3
                End If

                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "424"
                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_prodfin", 0, SQLINT2, (txtCampo(2).Text)
                PMPasoValores sqlconn&, "@i_prodban", 0, SQLINT2, "4"
                PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
                PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_cons_productoban", True, "Ok.. Consulta de Producto Bancaria") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(6)
                    PMChequea sqlconn&
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(6).Caption = ""

                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                End If
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""

            Else
                lblDescripcion(6).Caption = ""
                txtCampo(7).Text = ""
                lblDescripcion(10).Caption = ""
            End If
        End If

    Case 3
        If VLPaso = False Then
            If txtCampo(3).Text <> "" Then
                PMCatalogo "V", "cl_moneda", txtCampo(3), lblDescripcion(7)
            Else
                lblDescripcion(7).Caption = ""
            End If
        End If

    Case 4
        If VLPaso = False Then
            If txtCampo(4).Text <> "" Then
                    If CInt(txtCampo(4)) > 255 Then
                        MsgBox "Valor excede el máximo permitido", 0 + 16, "Mensaje de Error"
                        txtCampo(4).Text = ""
                        If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).SetFocus
                    End If

                PMPasoValores sqlconn&, "@i_help", 0, SQLCHAR, "V"
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                PMPasoValores sqlconn&, "@i_ofi", 0, SQLINT2, VGOficina
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "8"
                PMPasoValores sqlconn&, "@i_dep", 0, SQLINT2, (txtCampo(4).Text)
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_cuentas", "sp_departamento", True, " Ok... Consulta de departamentos") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(8)
                    PMChequea sqlconn&
                Else
                    txtCampo(4).Text = ""
                    lblDescripcion(8).Caption = ""
                    If txtCampo(4).Enabled And txtCampo(4).Visible Then txtCampo(4).SetFocus
                End If

            Else
                lblDescripcion(8).Caption = ""
            End If
        End If

    Case 5
        If VLPaso = False Then
            If txtCampo(5).Text <> "" Then
                 PMCatalogo "V", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9)
                 If lblDescripcion(9).Caption <> "" Then
                    If txtCampo(5).Text = "NE" Then
                       txtCampo(0).Enabled = True
                       txtCampo(0).SetFocus
                    Else
                       txtCampo(0).Text = ""
                       txtCampo(0).Enabled = False
                    End If
                 End If
            Else
                lblDescripcion(9).Caption = ""
            End If
        End If
    Case 6
        If VLPaso = False Then
            PLTransmitir
            VLPaso = True
        End If

    Case 7
    ' Categoría
        If VLPaso = False Then
            If txtCampo(7).Text <> "" Then
                If Trim$(txtCampo(6).Text) = "" Then
                    MsgBox "El número de solicitud es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(6).Enabled And txtCampo(6).Visible Then txtCampo(6).SetFocus
                    Exit Sub
                End If
                
                If Trim$(txtCampo(2).Text) = "" Then
                    MsgBox "El tipo de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(2).Enabled And txtCampo(2).Visible Then txtCampo(2).SetFocus
                    Exit Sub
                End If

                If VLTitular <= 0 Then
                    MsgBox "La Solicitud de cuenta debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular
                    grdPropietarios.Col = 3
                End If

                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
                PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "Q"
                PMPasoValores sqlconn&, "@i_cons_profinal", 0, SQLCHAR, "S"
                PMPasoValores sqlconn&, "@i_pro_bancario", 0, SQLINT2, txtCampo(2).Text
                PMPasoValores sqlconn&, "@i_tipo_ente", 0, SQLCHAR, grdPropietarios.Text
                PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
                PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VGMoneda
                PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, VGOficina
                PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(7).Text
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(10)
                    PMChequea sqlconn&
                Else
                    txtCampo(7).Text = ""
                    lblDescripcion(10).Caption = ""
                    If txtCampo(7).Enabled And txtCampo(7).Visible Then txtCampo(7).SetFocus
                End If

            Else
                lblDescripcion(10).Caption = ""
            End If
        End If

    End Select
End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
     Select Case Index
        Case 2, 3, 5, 6, 7
            Clipboard.Clear
            Clipboard.SetText ""
     End Select
End Sub

'FIXIT: Declare 'FLVerificarMenor' with an early-bound data type                           FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarMenor() As Boolean
'*************************************************************
' PROPOSITO: Determinar el manejo de menores de edad en las
'            cuentas
' INPUT    : Ninguno
' OUTPUT   : FLVerificarMenor   'true si se puede crear
'                                     la nueva cuenta
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 24-Mar-05      D. Villagomez   Emision iniciañ
'*************************************************************
Dim VTCadena As String
Dim vti As Integer
Dim j As Integer
    vti = 0
    FLVerificarMenor = False
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "350"
    For j = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Row = j
        grdPropietarios.Col = 5
        VTCadena = ""
        vti = vti + 1
        grdPropietarios.Col = 1 'codigo
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.Col = 5 'rol
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.Col = 4 'nombre
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        PMPasoValores sqlconn&, "@i_param" + CStr(vti), 0, SQLCHAR&, VTCadena
    Next j
    
    If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_valida_menor", True, " Ok... Valida Titularidad") Then
        PMChequea sqlconn&
        vti = FMRetStatus(sqlconn&)
        If vti <> 0 Then
            Exit Function
        End If
        FLVerificarMenor = True
    Else
        PMChequea sqlconn&
        Exit Function
    End If
End Function

