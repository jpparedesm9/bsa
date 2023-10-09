VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{00025600-0000-0000-C000-000000000046}#5.2#0"; "Crystl32.ocx"
Begin VB.Form FTran351 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "*Solicitud de Apertura de Cuenta de Ahorros"
   ClientHeight    =   5325
   ClientLeft      =   2625
   ClientTop       =   2100
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
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Tag             =   "3091"
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   3
      Left            =   1815
      MaxLength       =   3
      TabIndex        =   5
      Top             =   3840
      Width           =   975
   End
   Begin Crystal.CrystalReport rptReporte 
      Left            =   4200
      Top             =   360
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   348160
      WindowWidth     =   480
      WindowControlBox=   -1  'True
      WindowMaxButton =   -1  'True
      WindowMinButton =   -1  'True
      PrintFileType   =   2
      WindowControls  =   -1  'True
      PrintFileLinesPerPage=   60
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8415
      TabIndex        =   11
      Tag             =   "6335"
      Top             =   2260
      Visible         =   0   'False
      WhatsThisHelpID =   2009
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*&Imprimir"
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
      Height          =   540
      Index           =   1
      Left            =   8415
      TabIndex        =   3
      Top             =   1320
      WhatsThisHelpID =   2058
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Eliminar"
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   5
      Left            =   1815
      MaxLength       =   8
      TabIndex        =   6
      Top             =   4140
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   4
      Left            =   1815
      MaxLength       =   5
      TabIndex        =   7
      Top             =   4440
      Visible         =   0   'False
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   2
      Left            =   1810
      MaxLength       =   2
      TabIndex        =   4
      Top             =   3540
      Width           =   975
   End
   Begin MSGrid.Grid grdPropietarios 
      Height          =   2460
      Left            =   15
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   975
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   4339
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
      Cols            =   6
      FixedCols       =   0
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   540
      Index           =   0
      Left            =   8415
      TabIndex        =   2
      Top             =   765
      WhatsThisHelpID =   2069
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Añadir"
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
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   0
      Left            =   0
      MaxLength       =   8
      TabIndex        =   0
      Top             =   510
      Width           =   975
   End
   Begin VB.TextBox txtCampo 
      Height          =   285
      Index           =   1
      Left            =   6705
      MaxLength       =   2
      TabIndex        =   1
      Top             =   510
      Width           =   375
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   8
      Top             =   3030
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   9
      Top             =   3795
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
      Index           =   4
      Left            =   8415
      TabIndex        =   10
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
   Begin VB.Label lblmalaref 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H000000FF&
      Height          =   285
      Left            =   60
      TabIndex        =   32
      Top             =   4920
      Visible         =   0   'False
      Width           =   8235
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   7
      Left            =   2805
      TabIndex        =   31
      Top             =   3840
      Width           =   5535
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoría:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   2
      Left            =   60
      TabIndex        =   30
      Top             =   3840
      WhatsThisHelpID =   5130
      Width           =   1710
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   9
      Left            =   2805
      TabIndex        =   19
      Top             =   4140
      Width           =   2235
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   8
      Left            =   2805
      TabIndex        =   22
      Top             =   4440
      Visible         =   0   'False
      Width           =   5535
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   6
      Left            =   2805
      TabIndex        =   29
      Top             =   3540
      Width           =   5535
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Estado:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   4
      Left            =   75
      TabIndex        =   20
      Top             =   4140
      WhatsThisHelpID =   5067
      Width           =   1695
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Departamento:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   3
      Left            =   75
      TabIndex        =   21
      Top             =   4440
      Visible         =   0   'False
      WhatsThisHelpID =   5036
      Width           =   1695
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto bancario:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   1
      Left            =   60
      TabIndex        =   23
      Top             =   3540
      WhatsThisHelpID =   5176
      Width           =   1710
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
      TabIndex        =   24
      Top             =   780
      WhatsThisHelpID =   5055
      Width           =   1815
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Rol:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   9
      Left            =   6705
      TabIndex        =   25
      Top             =   330
      WhatsThisHelpID =   5253
      Width           =   360
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Cliente:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   27
      Top             =   330
      WhatsThisHelpID =   5252
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   1
      Left            =   7185
      TabIndex        =   14
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
      Left            =   5000
      TabIndex        =   28
      Top             =   15
      WhatsThisHelpID =   5251
      Width           =   2265
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   3
      Left            =   2460
      TabIndex        =   26
      Top             =   510
      UseMnemonic     =   0   'False
      Width           =   300
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   60
      X2              =   8445
      Y1              =   3480
      Y2              =   3480
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8385
      Y1              =   330
      Y2              =   330
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   5
      Left            =   7095
      TabIndex        =   18
      Top             =   510
      Width           =   1260
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   4
      Left            =   2775
      TabIndex        =   17
      Top             =   510
      UseMnemonic     =   0   'False
      Width           =   3915
   End
   Begin VB.Label lblDescripcion 
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   2
      Left            =   1005
      TabIndex        =   16
      Top             =   510
      UseMnemonic     =   0   'False
      Width           =   1440
   End
   Begin VB.Label lblDescripcion 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Height          =   285
      Index           =   0
      Left            =   2220
      TabIndex        =   15
      Top             =   15
      Width           =   1995
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BackStyle       =   0  'Transparent
      Caption         =   "*Número de solicitud:"
      ForeColor       =   &H00800000&
      Height          =   225
      Index           =   0
      Left            =   60
      TabIndex        =   13
      Top             =   15
      WhatsThisHelpID =   5250
      Width           =   2130
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   15
      Y2              =   5350
   End
End
Attribute VB_Name = "FTran351"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTran351.frm
' NOMBRE LOGICO:    FTran351
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
' Esta forma permite solicitud una cuenta de ahorros
' personalizada por MACOSA.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-84      R. Garzon P.    Emisión Inicial
' 10-Ene-02      C. Milán        Personalización AgroMercantil
'*************************************************************
Option Explicit

Dim VLNumero As Integer
Dim VLContador As Integer
Dim VLNumSol As String
Dim VLTitular As Integer
Dim VLTipoEnteTitular As String
Dim VLPaso As Boolean
Dim VLFormatoFecha As String
Dim VLImprimio As Boolean

Dim VLReferencia As String
Dim VLyaingreso As Integer
Private Sub cmdBoton_Click(Index As Integer)
    Select Case Index
    Case 0
        PLAniadir
    Case 1
        PLEliminar
    Case 2
        PLTransmitir
    Case 3
        PLLimpiar
    Case 4
        PLSalir
    Case 5
        PLImprimir
    End Select
End Sub

Private Sub Form_Load()
    FTran351.Left = 0
    FTran351.Top = 0
    FTran351.Width = 9450
    FTran351.Height = 5900
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
    txtCampo(5).Enabled = False
    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    lblDescripcion(1).Caption = Format$(VGFecha, VLFormatoFecha)
    VLNumero = 0
    VLContador = 0
    VLTitular = 0
    txtCampo(5).Text = "SO"
    lblDescripcion(9) = "SOLICITADA"
    txtCampo(3).Text = ""
    lblDescripcion(7) = ""
    txtCampo(3).Enabled = True
    VLImprimio = True
    VLyaingreso = 0
End Sub

Private Sub Form_QueryUnload(Cancel As Integer, UnloadMode As Integer)
'FIXIT: Declare 'Msg' with an early-bound data type                                        FixIT90210ae-R1672-R1B8ZE
Dim Msg As String

    If Not VLImprimio Then
        Msg = "¿Realmente desea Cerrar la Ventana Activa?"
        If MsgBox(Msg, 36, Me.Caption) = 7 Then Cancel = True
    End If
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
    FPrincipal!pnlHelpLine.Caption = " Lista de propietarios de la cuenta de ahorros"
    
End Sub

Private Sub PLAniadir()
'*************************************************************
' PROPOSITO: Permite añadir un propietario al grid
'            propietarios de la cuenta, controlando que exista
'            un solo propietario con el rol de Alternante.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VTCadena As String
Dim vti As Integer
Dim VTR1 As Integer
Dim i As Integer
vti = 1

If VLContador < 20 Then

   If txtCampo(0).Text <> "" Then
        For i = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Col = 0
            grdPropietarios.Row = i
            If grdPropietarios.Text = txtCampo(0).Text Then
                MsgBox "Cliente duplicado como Titular o Alternante", 0 + 16, "Mensaje de Error"
                txtCampo(0).Text = ""
                lblDescripcion(2).Caption = ""
                lblDescripcion(4).Caption = ""
                lblDescripcion(3).Caption = ""
                txtCampo(1).Text = ""
                lblDescripcion(5).Caption = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
        Next i
        If lblDescripcion(3).Caption = "C" And lblDescripcion(2).Caption = "" Then
           lblDescripcion(2).Caption = "Sin Identificación"
        End If
        
        If lblDescripcion(2).Caption <> "" Then
            If lblDescripcion(4).Caption <> "" Then
                If lblDescripcion(3).Caption <> "" Then
                    If txtCampo(1).Text <> "" Then
                        If txtCampo(1).Text <> "T" And VLyaingreso = 0 Then
                            MsgBox "Debe Ingresar Primero el Titular de la Cuenta", vbInformation
                            Exit Sub
                        End If
                        If txtCampo(1).Text = "U" Then
                            MsgBox "No es Posible Asignar un Tutor desde esta Pantalla. Remitase al modulo de Clientes", vbInformation
                            txtCampo(1).SetFocus
                            Exit Sub
                        End If
                            ' Se Valida la Existencia de tutores
                            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "350"
                            PMPasoValores sqlconn&, "@i_retorna", 0, SQLINT1, "1"
                            VTCadena = ""
                            VTCadena = VTCadena + (txtCampo(0).Text) + "@"           'codigo
                            VTCadena = VTCadena + (txtCampo(1).Text) + "@"           'rol
                            VTCadena = VTCadena + (lblDescripcion(4).Caption) + "@"  'nombre
                            PMPasoValores sqlconn&, "@i_param" + CStr(vti), 0, SQLCHAR&, VTCadena
                            If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_valida_menor", True, " Ok... Valida Titularidad") Then
                               ReDim VTValores(15) As String
                               VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                               PMChequea sqlconn&
                               If VTR1 > 0 Then
                                    ' Se carga valor de catalogo de tutor
                                    PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR&, "V"
                                    PMPasoValores sqlconn&, "@i_tabla", 0, SQLVARCHAR&, "cl_rol"
                                    PMPasoValores sqlconn&, "@i_codigo", 0, SQLVARCHAR&, "U"    'Cod. tutor
                                    If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_hp_catalogo", False, "") Then
                                       ReDim VTArreglo(10) As String
                                       VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
                                       PMChequea sqlconn&
                                    End If
                               End If
                            Else
                               PMChequea sqlconn&
                               txtCampo(0).Text = ""
                               txtCampo(0).SetFocus
                               lblDescripcion(2).Caption = ""
                               lblDescripcion(3).Caption = ""
                               lblDescripcion(4).Caption = ""
                               txtCampo(1).Text = ""
                               lblDescripcion(5).Caption = ""
                               Exit Sub
                            End If

                        If ((lblDescripcion(3).Caption = "P") Or (lblDescripcion(3).Caption = "C")) And (txtCampo(1).Text = "T") And (grdPropietarios.Tag <> "T") Then
                            VLTitular = VLNumero + 1
                            grdPropietarios.Tag = "T"
                            If VLNumero = 0 Then
                                grdPropietarios.Row = 1
                                grdPropietarios.Col = 0
                                grdPropietarios.Text = txtCampo(0).Text
                                grdPropietarios.Col = 1
                                grdPropietarios.Text = lblDescripcion(2).Caption
                                grdPropietarios.Col = 2
                                grdPropietarios.Text = lblDescripcion(3).Caption
                                VLTipoEnteTitular = lblDescripcion(3).Caption
                                grdPropietarios.Col = 3
                                grdPropietarios.Text = lblDescripcion(4).Caption
                                grdPropietarios.Col = 4
                                grdPropietarios.Text = txtCampo(1).Text
                                grdPropietarios.Col = 5
                                grdPropietarios.Text = lblDescripcion(5).Caption
                                
                            Else
                                grdPropietarios.AddItem txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero + 1
                            End If
                            
                            ' Se Add. el tutor al cliente si existe
                            If VTR1 > 0 Then
                              grdPropietarios.AddItem VTValores(1) & Chr$(9) & VTValores(2) & Chr$(9) & VTValores(3) & Chr$(9) & VTValores(4) & Chr$(9) & "U" & Chr$(9) & VTArreglo(1), VLNumero + 2
                              VLNumero = VLNumero + 1
                              VLContador = VLContador + 1
                              txtCampo(0).SetFocus
                            End If
                            
                            If txtCampo(1).Text = "T" Then
                                VLyaingreso = 1
                            End If
                            VLNumero = VLNumero + 1
                            VLContador = VLContador + 1
                            txtCampo(0).Text = ""
                            grdPropietarios.Row = grdPropietarios.Rows - 1
                            grdPropietarios.Col = 4
                            lblDescripcion(2).Caption = ""
                            lblDescripcion(3).Caption = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Caption = ""
                        ElseIf (lblDescripcion(3).Caption = "P") And (txtCampo(1).Text <> "T") Then
                            If VLNumero = 0 Then
                                grdPropietarios.Row = 1
                                grdPropietarios.Col = 0
                                grdPropietarios.Text = txtCampo(0).Text
                                grdPropietarios.Col = 1
                                grdPropietarios.Text = lblDescripcion(2).Caption
                                grdPropietarios.Col = 2
                                grdPropietarios.Text = lblDescripcion(3).Caption
                                grdPropietarios.Col = 3
                                grdPropietarios.Text = lblDescripcion(4).Caption
                                grdPropietarios.Col = 4
                                grdPropietarios.Text = txtCampo(1).Text
                                grdPropietarios.Col = 5
                                grdPropietarios.Text = lblDescripcion(5).Caption
                            Else
                                If VLTipoEnteTitular = "C" Then ' titular es compania
                                   If txtCampo(1).Text = "C" Then ' se quiere ingresar un cotitular
                                      MsgBox "El Titular es Persona Juridica por tanto no puede tener cotitulares", 0 + 16, "Mensaje de Error"
                                      If grdPropietarios.Tag <> "T" Then
                                        VLNumero = VLNumero - 1
                                      End If

                                      Exit Sub
                                   Else
                                      grdPropietarios.AddItem txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero + 1
                                   End If
                                Else
                                   grdPropietarios.AddItem txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero + 1
                                End If

                            End If
                            VLNumero = VLNumero + 1
                            VLContador = VLContador + 1
                            txtCampo(0).Text = ""
                            lblDescripcion(2).Caption = ""
                            lblDescripcion(3).Caption = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Caption = ""
                        ElseIf (lblDescripcion(3).Caption = "C") And (txtCampo(1).Text = "T") And (grdPropietarios.Tag <> "T") Then
                            VLTitular = VLNumero + 1
                            grdPropietarios.Tag = "T"
                            If VLNumero = 0 Then
                                grdPropietarios.Row = 1
                                grdPropietarios.Col = 0
                                grdPropietarios.Text = txtCampo(0).Text
                                grdPropietarios.Col = 1
                                grdPropietarios.Text = lblDescripcion(2).Caption
                                grdPropietarios.Col = 2
                                grdPropietarios.Text = lblDescripcion(3).Caption
                                grdPropietarios.Col = 3
                                grdPropietarios.Text = lblDescripcion(4).Caption
                                grdPropietarios.Col = 4
                                grdPropietarios.Text = txtCampo(1).Text
                                grdPropietarios.Col = 5
                                grdPropietarios.Text = lblDescripcion(5).Caption
                                grdPropietarios.Col = 2
                                VLTipoEnteTitular = grdPropietarios.Text

                            Else
                                grdPropietarios.AddItem txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero + 1
                            End If
                            VLNumero = VLNumero + 1
                            VLContador = VLContador + 1
                            txtCampo(0).Text = ""
                            grdPropietarios.Row = grdPropietarios.Rows - 1
                            grdPropietarios.Col = 4
                            lblDescripcion(2).Caption = ""
                            lblDescripcion(3).Caption = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Caption = ""
                        ElseIf (lblDescripcion(3).Caption = "C") And (txtCampo(1).Text <> "T") Then
                            MsgBox "Un cliente juridico siempre debe ser titular", vbExclamation, "Mensaje de Error"
                            Exit Sub
                            If VLNumero = 0 Then
                                grdPropietarios.Row = 1
                                grdPropietarios.Col = 0
                                grdPropietarios.Text = txtCampo(0).Text
                                grdPropietarios.Col = 1
                                grdPropietarios.Text = lblDescripcion(2).Caption
                                grdPropietarios.Col = 2
                                grdPropietarios.Text = lblDescripcion(3).Caption
                                grdPropietarios.Col = 3
                                grdPropietarios.Text = lblDescripcion(4).Caption
                                grdPropietarios.Col = 4
                                grdPropietarios.Text = txtCampo(1).Text
                                grdPropietarios.Col = 5
                                grdPropietarios.Text = lblDescripcion(5).Caption
                            Else
                                grdPropietarios.AddItem txtCampo(0).Text & Chr$(9) & lblDescripcion(2).Caption & Chr$(9) & lblDescripcion(3).Caption & Chr$(9) & lblDescripcion(4).Caption & Chr$(9) & txtCampo(1).Text & Chr$(9) & lblDescripcion(5).Caption, VLNumero + 1
                            End If
                            VLNumero = VLNumero + 1
                            VLContador = VLContador + 1
                            txtCampo(0).Text = ""
                            lblDescripcion(2).Caption = ""
                            lblDescripcion(3).Caption = ""
                            lblDescripcion(4).Caption = ""
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Caption = ""
                        
                        Else
                            MsgBox "La cuenta de ahorros solo puede tener un titular", 0 + 16, "Mensaje de Error"
                            txtCampo(1).Text = ""
                            lblDescripcion(5).Caption = ""
                            txtCampo(1).SetFocus
                            Exit Sub
                        End If
                    Else
                        MsgBox "El código del rol del cliente es mandatorio", 0 + 16, "Mensaje de Error"
                        txtCampo(1).SetFocus
                        Exit Sub
                    End If
                Else
                    MsgBox "El tipo de cliente es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(0).SetFocus
                End If
            Else
                MsgBox "El nombre del cliente es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
            End If
        Else
            MsgBox "La identificación es mandatoria", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
        End If
    Else
        MsgBox "El código del cliente es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(0).Text = ""
        txtCampo(0).SetFocus
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        lblDescripcion(4).Caption = ""
        txtCampo(1).Text = ""
        lblDescripcion(5).Caption = ""
    End If
    txtCampo(0).SetFocus
 Else
        MsgBox "No pueden haber mas de 20 participantes en la cuenta", 0 + 16, "Mensaje de Error"
        lblDescripcion(2).Caption = ""
        lblDescripcion(3).Caption = ""
        lblDescripcion(4).Caption = ""
        txtCampo(0).Text = ""
        txtCampo(1).Text = ""
        lblDescripcion(5).Caption = ""
        Exit Sub
 End If

End Sub


Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Rutina que permite eliminar un propietario del grid
'            propietarios de la cuenta, controlando que el cliente
'            a eliminar no sea Titular.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VTFlag As Boolean
Dim VTPosTmp As Integer
Dim i As Integer

VTFlag = False

    grdPropietarios.Col = 4
    If grdPropietarios.Text = "U" Then
        MsgBox "No es Posible Eliminar un Tutor desde esta Pantalla. Remitase al modulo de Clientes", vbInformation
        Exit Sub
    End If
    
    If grdPropietarios.Text = "T" Then
        grdPropietarios.Tag = ""
        VLTitular = 0

        txtCampo(2).Text = ""
        lblDescripcion(6).Caption = ""
        VLyaingreso = 0
        VTFlag = True
    End If

    If grdPropietarios.Rows = 2 Then
        VLNumero = 0
        VLContador = 0
        grdPropietarios.Row = 1
        For i = 0 To 5
            grdPropietarios.Col = i
            grdPropietarios.Text = ""
        Next i
    Else
        VLNumero = VLNumero - 1
        VLContador = VLContador - 1
        grdPropietarios.RemoveItem grdPropietarios.Row
        grdPropietarios.SelStartRow = grdPropietarios.Row
        grdPropietarios.SelEndRow = grdPropietarios.Row
        
        'Si se Elimina el titular se elimina el tutor si existe
        If VTFlag Then
           If grdPropietarios.Rows = 2 Then
                VLNumero = 0
                VLContador = 0
                grdPropietarios.Row = 1
                grdPropietarios.Col = 4
                If grdPropietarios.Text = "U" Then
                    For i = 0 To 5
                        grdPropietarios.Col = i
                        grdPropietarios.Text = ""
                    Next i
                End If
           Else
                grdPropietarios.Row = 1
                grdPropietarios.Col = 4
                 For i = 1 To (grdPropietarios.Rows - 1)
                    grdPropietarios.Row = i
                    If grdPropietarios.Text = "U" Then
                       VTPosTmp = i
                       Exit For
                    End If
                 Next i
                   If VTPosTmp > 0 Then
                        VLNumero = VLNumero - 1
                        VLContador = VLContador - 1
                        grdPropietarios.SelStartRow = VTPosTmp
                        grdPropietarios.SelEndRow = VTPosTmp
                        grdPropietarios.RemoveItem VTPosTmp
                   End If
           End If
        End If
    End If
    txtCampo(0).SetFocus
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime la solicitud de Apertura de cuenta
'            de ahorros con la información relacionada a la
'            cuenta.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    
    Dim baseDatoss As Database
    Dim tablas1 As Recordset
    Dim tablas2 As Recordset
    Dim archivos As String
    Dim reporte As String
    Dim i As Integer
    Screen.MousePointer = 11
    archivos = VGPath & "\solicitu.mdb"
    Set baseDatoss = DBEngine.OpenDatabase(archivos)
    Set tablas1 = baseDatoss.OpenRecordset("solici")
    Set tablas2 = baseDatoss.OpenRecordset("propietarioss")
    baseDatoss.Execute "delete from solici"
    baseDatoss.Execute "delete from propietarioss"
    tablas1.AddNew
    tablas1("oficina") = VGOficina
    tablas1("fecha") = VGFecha
    tablas1("numero") = lblDescripcion(0).Caption
    tablas1("moneda") = FPrincipal!cmbMoneda.Text
    tablas1("departamento") = lblDescripcion(8).Caption
    tablas1("producto") = lblDescripcion(6).Caption
    tablas1("categoria") = lblDescripcion(7).Caption
    tablas1("secuencial") = 1
    tablas1("filial") = Val(VGLOGO)
    tablas1.Update
    For i = 1 To (grdPropietarios.Rows - 1)
        grdPropietarios.Row = i
        tablas2.AddNew
        grdPropietarios.Col = 1
        tablas2("cedula") = grdPropietarios.Text
        grdPropietarios.Col = 3
        tablas2("nombre") = grdPropietarios.Text
        grdPropietarios.Col = 5
        tablas2("descripcion") = grdPropietarios.Text
        tablas2("secuencial") = 1
        tablas2("filial") = Val(VGLOGO)
        tablas2.Update
    Next i
    tablas2.Close
    reporte = VGPath + "\solicte.rpt"
    rptReporte.ReportFileName = reporte
    For i = 1 To 2
        tablas1.MoveFirst
        tablas1.Edit
        If i = 1 Then
            tablas1("tipo") = "ORIGINAL"
        Else
            tablas1("tipo") = "COPIA"
            rptReporte.CopiesToPrinter = 2
        End If
        tablas1("filial") = Val(VGLOGO)
        tablas1.Update
        rptReporte.DataFiles(0) = archivos
        rptReporte.Destination = 1
        rptReporte.Action = 1
    Next i
    tablas1.Close
    baseDatoss.Close
    Screen.MousePointer = 0
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
    Dim Msg As String
    If Not VLImprimio Then
        Msg = "¿Realmente desea limpiar los datos, sin posibilidad de ReImprimir?"
        If MsgBox(Msg, 36, Me.Caption) = 7 Then
            Exit Sub
        Else
            VLImprimio = True
        End If
    End If
    For i = 0 To 5
        If i <> 4 Then
        txtCampo(i).Text = ""
        End If
    Next i

    For i = 0 To 9
        If i <> 8 Then
        lblDescripcion(i).Caption = ""
        End If
    Next i

    VLFormatoFecha = Get_Preferencia("FORMATO-FECHA")
    lblDescripcion(1).Caption = Format$(VGFecha, VLFormatoFecha)

    grdPropietarios.Rows = 2
    grdPropietarios.Row = 1
    For i = 0 To 5
        grdPropietarios.Col = i
        grdPropietarios.Text = ""
    Next i
    grdPropietarios.Tag = ""
    VLNumero = 0
    VLTitular = 0
    txtCampo(0).SetFocus
    cmdBoton(0).Enabled = True
    cmdBoton(1).Enabled = True
    cmdBoton(2).Enabled = True
    txtCampo(5).Text = "SO"
    lblDescripcion(9) = "SOLICITADA"
    lblmalaref.Caption = ""
    txtCampo(5).Enabled = False
    VLContador = 0
    VLTipoEnteTitular = ""
    VLyaingreso = 0
End Sub

Private Sub PLSalir()
'*************************************************************
' PROPOSITO: Sale de la forma de Solicitud de Apertura de
'            Cuenta Corriente.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    
    Unload FTran351
End Sub

Private Sub PLTransmitir()
'*************************************************************
' PROPOSITO: Efectúa la llamada al stored procedure de apertura
'            de cuentas de ahorros bajo ciertas restricciones.
' INPUT    : Ninguna.
' OUTPUT   : Ninguna.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    ' Validaciones de Mandatoriedades
    Dim cadena1 As String
    Dim cadena2 As String
    Dim VTDetProductoAho As String
    Dim registro As Integer
    Dim j As Integer
    Dim VTR1 As Integer
    ' Existencia del Titular
    If VLTitular <= 0 Then
        MsgBox "La Solicitud de cuenta de ahorros debe tener al menos un titular", 0 + 16, "Mensaje de Error"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    ' Tipo de cuenta
    If txtCampo(2).Text = "" Then
        MsgBox "El producto bancario es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(2).SetFocus
        Exit Sub
    End If
    
    ' Categoría
    If txtCampo(3).Text = "" Then
        MsgBox "La categoría es mandatoria", 0 + 16, "Mensaje de Error"
        txtCampo(3).SetFocus
        Exit Sub
    End If
    
    If Not FLVerificarTitularidad Then
        Exit Sub
    End If


    'Verificar el manejo de menores de edad
    If Not FLVerificarMenor Then
        Exit Sub
    End If
    
    registro = grdPropietarios.Row - 1
    cadena1 = ""
    cadena2 = ""

    If registro < 5 Then
      For j = 1 To VLContador
        grdPropietarios.Row = j
        grdPropietarios.Col = 0
        If cadena1 = "" Then
            cadena1 = grdPropietarios.Text
        Else
            cadena1 = cadena1 & "|" & grdPropietarios.Text
        End If
      Next j
   Else
      For j = 1 To 5
        grdPropietarios.Row = j
        grdPropietarios.Col = 0
        If cadena1 = "" Then
            cadena1 = grdPropietarios.Text
        Else
            cadena1 = cadena1 & "|" & grdPropietarios.Text
        End If
      Next j

      For j = 6 To VLContador
        grdPropietarios.Row = j
        grdPropietarios.Col = 0
        If cadena2 = "" Then
            cadena2 = grdPropietarios.Text
        Else
            cadena2 = cadena2 & "|" & grdPropietarios.Text
        End If
      Next j
   End If

        
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "352"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
     PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, (txtCampo(5).Text)
     PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda
     PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, (txtCampo(2).Text)
     PMPasoValores sqlconn&, "@i_depart", 0, SQLCHAR, (txtCampo(4).Text)
     PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, (txtCampo(3).Text)
    If cadena1 <> "" Then
     cadena1 = cadena1 + "|"
      PMPasoValores sqlconn&, "@i_codigos1", 0, SQLVARCHAR, cadena1
      If cadena2 <> "" Then
        cadena2 = cadena2 + "|"
        PMPasoValores sqlconn&, "@i_codigos2", 0, SQLVARCHAR, cadena2
      End If
    End If
     If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Solicitud de la cuenta corriente") Then
        ReDim VTArreglo(20) As String
        ReDim VTArreglo1(20) As String
        If Trim$(txtCampo(2).Text) = "···&&2" Then
            VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo1())
            VTDetProductoAho = VTArreglo1(3)
        End If
        VTR1 = FMMapeaArreglo(sqlconn&, VTArreglo())
        PMChequea sqlconn&
        
        cmdBoton(0).Enabled = False
        cmdBoton(1).Enabled = False
        cmdBoton(2).Enabled = False
   
        lblDescripcion(0).Caption = VTArreglo(1)
        VLNumSol = VTArreglo(1)
        
        If VTArreglo(2) = "S" Then
            lblmalaref.Caption = "Uno de los prospectos clientes ingresados consta en las listas negras"
            lblmalaref.Visible = True
        Else
            lblmalaref.Caption = ""
            lblmalaref.Visible = False
        End If
        

        ' Registrar los demas propietarios de la cuenta
        For j = 1 To grdPropietarios.Rows - 1
            grdPropietarios.Row = j
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "353"
            PMPasoValores sqlconn&, "@i_numsol", 0, SQLINT4, VLNumSol
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I1"
            grdPropietarios.Col = 0
            PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT4, (grdPropietarios.Text)
            
            grdPropietarios.Col = 4
            PMPasoValores sqlconn&, "@i_tiptit", 0, SQLCHAR, (grdPropietarios.Text)
            
            If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_solicitud_apertura", True, " Ok... Ingresando los propietarios") Then
                PMChequea sqlconn&
            End If
        Next j

        
    Else
        lblDescripcion(0).Caption = ""
        lblDescripcion(1).Caption = ""
    End If

End Sub



Private Sub txtCampo_Change(Index As Integer)
    Select Case Index
    Case 0, 1, 2, 3, 4, 5
        VLPaso = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código del cliente [F5 Ayuda]"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código del rol del cliente [F5 Ayuda]"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Código del producto bancario [F5 Ayuda]"
    Case 3
        FPrincipal!pnlHelpLine.Caption = " Código de la categoría [F5 Ayuda]"
    Case 4
        FPrincipal!pnlHelpLine.Caption = " Código del departamento que solicita [F5 Ayuda]"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Estado de la cuenta"
    End Select

    VLPaso = True
    txtCampo(Index).SelStart = 0
    txtCampo(Index).SelLength = Len(txtCampo(Index).Text)
End Sub

    Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
    Dim VTRes As Boolean
    Dim VTCliente As String
    If Keycode = VGTeclaAyuda Then
        VLPaso = True
        Select Case Index
        Case 0
            ' F5 para ayuda de cliente
            ' Forma de busqueda de clientes
            txtCampo(0).Text = ""
            If VGFBusCliente Is Nothing Then
               Set VGFBusCliente = New BuscarClientes
            End If
            Set FMain = FPrincipal
            'Abrir forma de búsqueda de clientes
            VTRes = VGFBusCliente.FMBuscarCliente(FMain, VGMap, sqlconn&, ServerName, ServerNameLocal, VLFormatoFecha, VGRol)
            'Si se selecciona un cliente visualizar datos
              If VTRes = True Then
                If VGFBusCliente.DatosCliente(1) <> "" Then
                    txtCampo(0).Text = VGFBusCliente.DatosCliente(1)
                    lblDescripcion(3).Caption = VGFBusCliente.DatosCliente(0)
                    If VGFBusCliente.DatosCliente(0) = "P" Then
                        lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(5)
                        VTCliente = VGFBusCliente.DatosCliente(2) + " " + VGFBusCliente.DatosCliente(3) + " " + VGFBusCliente.DatosCliente(4)
                        lblDescripcion(4).Caption = VTCliente
                        VLReferencia = VGFBusCliente.DatosCliente(9)
                    Else
                        lblDescripcion(2).Caption = VGFBusCliente.DatosCliente(3)
                        lblDescripcion(4).Caption = VGFBusCliente.DatosCliente(2)
                        VLReferencia = VGFBusCliente.DatosCliente(5)
                    End If
                End If
                VLPaso = True
                txtCampo(1).SetFocus
             End If

        Case 1

            ' F5 para ayuda de Rol de propietrario
            ' Alternante o Titular - Catalogo
            PMCatalogo "A", "cl_rol", FTran351!txtCampo(1), FTran351!lblDescripcion(5)
            VLPaso = True
            If txtCampo(1).Text <> "" Then
                cmdBoton(0).SetFocus
            End If
        Case 2 'Tipo de cuenta
            ' F5 para Productos Bancarios

            If VLTitular <= 0 Then
                MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular
                grdPropietarios.Col = 2
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
                FCatalogo.Show 1
                txtCampo(2).Text = VGACatalogo.Codigo
                lblDescripcion(6).Caption = VGACatalogo.Descripcion
                If txtCampo(2).Text <> "" Then
                    VLPaso = True
                End If

            End If
        
        Case 3 'Categoría
            If Trim$(txtCampo(2).Text) = "" Then
                MsgBox "El tipo de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(3).Text = ""
                lblDescripcion(7).Caption = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If

            If VLTitular <= 0 Then
                MsgBox "La Solicitud debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                txtCampo(0).SetFocus
                Exit Sub
            Else
                grdPropietarios.Row = VLTitular
                grdPropietarios.Col = 2
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
                txtCampo(3).Text = VGACatalogo.Codigo
                lblDescripcion(7).Caption = VGACatalogo.Descripcion
                If Trim$(txtCampo(3).Text) <> "" Then
                    VLPaso = True
                End If
            End If

        Case 4
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
                    VLPaso = True
                    cmdBoton(2).SetFocus
                End If
            End If

        Case 5
            PMCatalogo "A", "cc_tipo_solicitud", txtCampo(5), lblDescripcion(9)
            VLPaso = True


        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index
    Case 0, 2, 4
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    Case 1
        If (KeyAscii <> 8) And ((KeyAscii < 65) Or (KeyAscii > 90)) And ((KeyAscii < 97) Or (KeyAscii > 122)) Then
            KeyAscii = 0
        Else
            KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
        End If
    Case 3
        KeyAscii = FMVAlidaTipoDato("A", KeyAscii)
    Case 14
        If (KeyAscii <> 8) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii = 0
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Dim VTRefercliente As String
    Dim VLMensajeBlq As String
    Dim VLBloqueado As String
    Dim VLMalaref As String
    Dim VLLista As String
    Dim VTR1 As String
    Dim VTSubtipo As String
    Dim VTCliente As String
    Select Case Index
    Case 0
        If VLPaso = False Then
            If txtCampo(0).Text <> "" Then
                PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q" '"H"
                PMPasoValores sqlconn&, "@i_cliente", 0, SQLINT4, (txtCampo(0).Text)
                PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "1181" '"1225"
                If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_desc_cliente", True, " Ok... Consulta del cliente " & "[" & txtCampo(0).Text & "]") Then
                    ReDim VTValores(15) As String
                    VTR1 = FMMapeaArreglo(sqlconn&, VTValores())
                    PMChequea sqlconn&
                    VTSubtipo = VTValores(3)
                        VTRefercliente = VTValores(5)
                        lblDescripcion(3).Caption = VTSubtipo
                        If VTSubtipo = "P" Then
                            lblDescripcion(2).Caption = VTValores(1)
                            VTCliente = VTValores(2)
                            lblDescripcion(4).Caption = VTCliente
                            VLReferencia = VTValores(5)
                        Else
                            lblDescripcion(2).Caption = VTValores(1)
                            lblDescripcion(4).Caption = VTValores(2)
                            VLReferencia = VTValores(5)
                        End If
                        If txtCampo(1).Text = "" Then
                            txtCampo(1).SetFocus
                        Else
                            cmdBoton(0).SetFocus
                        End If

                Else
                    txtCampo(0).Text = ""
                    lblDescripcion(2).Caption = ""
                    lblDescripcion(4).Caption = ""
                    lblDescripcion(3).Caption = ""
                    txtCampo(0).SetFocus
                End If
            Else
                lblDescripcion(2).Caption = ""
                lblDescripcion(4).Caption = ""
                lblDescripcion(3).Caption = ""
            End If
        End If
        If txtCampo(0).Text <> "" Then
            VLMensajeBlq = ""
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "175"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "B"
            PMPasoValores sqlconn&, "@i_ente", 0, SQLINT4&, txtCampo(0)
            If FMTransmitirRPC(sqlconn&, ServerName, "cobis", "sp_ente_bloqueado", True, "Ok..Consulta Clientes Bloqueados") Then
                PMMapeaVariable sqlconn&, VLBloqueado
                PMMapeaVariable sqlconn&, VLMalaref
                PMMapeaVariable sqlconn&, VLLista
                PMMapeaVariable sqlconn&, VLMensajeBlq
                PMChequea sqlconn&
            Else
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
    
            If VLBloqueado = "S" And VLMalaref = "N" Then
               MsgBox "Cliente está Bloqueado", 48, "Control de Datos del Clientes"
               lblDescripcion(2).Caption = ""
               lblDescripcion(3).Caption = ""
               lblDescripcion(4).Caption = ""
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               txtCampo(0).Text = ""
               txtCampo(0).SetFocus
               Exit Sub
            End If
    
            If VLMalaref = "S" Then
                MsgBox VLMensajeBlq, 48, "Control de Clientes Reportados"
                lblDescripcion(2).Caption = ""
                lblDescripcion(3).Caption = ""
                lblDescripcion(4).Caption = ""
                txtCampo(0).Text = ""
                txtCampo(0).SetFocus
                Exit Sub
            End If
            
            If VLMalaref = "N" And VLMensajeBlq <> "" Then
               MsgBox VLMensajeBlq, 48, "Control de Clientes Reportados"
            End If
        End If
        
    Case 1
        If VLPaso = False Then
            If txtCampo(1).Text <> "" Then
                PMCatalogo "V", "cl_rol", txtCampo(1), lblDescripcion(5)
            Else
                lblDescripcion(5).Caption = ""
            End If
        End If
    Case 2
        If VLPaso = False Then
            If txtCampo(2).Text <> "" Then
                
                If VLTitular <= 0 Then
                    MsgBox "Tipo de Cliente del Titular es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(2).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular
                    grdPropietarios.Col = 2
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
                    txtCampo(2).SetFocus
                End If

            Else
                lblDescripcion(6).Caption = ""
                txtCampo(3).Text = ""
                lblDescripcion(7).Caption = ""

            End If
        End If

    Case 3
        If VLPaso = False Then
            If txtCampo(3).Text <> "" Then
                If Trim$(txtCampo(2).Text) = "" Then
                    MsgBox "El tipo de cuenta es mandatorio", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Caption = ""
                    txtCampo(2).SetFocus
                    Exit Sub
                End If

                If VLTitular <= 0 Then
                    MsgBox "La Solicitud debe tener al menos un titular", 0 + 16, "Mensaje de Error"
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Caption = ""
                    txtCampo(0).SetFocus
                    Exit Sub
                Else
                    grdPropietarios.Row = VLTitular
                    grdPropietarios.Col = 2
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
                PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(3).Text
                If FMTransmitirRPC(sqlconn&, ServerName, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías") Then
                    PMMapeaObjeto sqlconn&, lblDescripcion(7)
                    PMChequea sqlconn&
                Else
                    txtCampo(3).Text = ""
                    lblDescripcion(7).Caption = ""
                    txtCampo(3).SetFocus
                End If

            Else
                lblDescripcion(7).Caption = ""
            End If
        End If

    Case 4
        If VLPaso = False Then
            If txtCampo(4).Text <> "" Then
                If CInt(txtCampo(4)) > 32767 Then
                    MsgBox "Valor excede el máximo permitido", 0 + 16, "Mensaje de Error"
                    txtCampo(4).Text = ""
                    lblDescripcion(8).Caption = ""
                    txtCampo(4).SetFocus
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
                    txtCampo(4).SetFocus
                End If

            Else
                lblDescripcion(8).Caption = ""
            End If
        End If
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
        grdPropietarios.Col = 4
        VTCadena = ""
        vti = vti + 1
        grdPropietarios.Col = 0 'codigo
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.Col = 4 'rol
        VTCadena = VTCadena + (grdPropietarios.Text) + "@"
        grdPropietarios.Col = 3 'nombre
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

'FIXIT: Declare 'FLVerificarTitularidad' with an early-bound data type                     FixIT90210ae-R1672-R1B8ZE
Private Function FLVerificarTitularidad() As Boolean
'*************************************************************
' PROPOSITO: Determinar que todos los propietarios no tengan
'            mas de una cuenta super cash y una super plus
' INPUT    : Ninguno
' OUTPUT   : FLVerificarTitularidad   'true si se puede crear
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
    FLVerificarTitularidad = False
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "344"
    PMPasoValores sqlconn&, "@i_prod_banc", 0, SQLINT2, txtCampo(2).Text
    For j = 1 To grdPropietarios.Rows - 1
        grdPropietarios.Row = j
        grdPropietarios.Col = 4
        VTCadena = ""
        If grdPropietarios.Text = "T" Or grdPropietarios.Text = "C" Then
            vti = vti + 1
            grdPropietarios.Col = 0 'codigo
            VTCadena = VTCadena + (grdPropietarios.Text) + "@"
            grdPropietarios.Col = 3 'nombre
            VTCadena = VTCadena + (grdPropietarios.Text) + "@"
            PMPasoValores sqlconn&, "@i_param" + CStr(vti), 0, SQLCHAR&, VTCadena
        End If
    Next j
    
    If FMTransmitirRPC(sqlconn&, ServerName, "cob_ahorros", "sp_valida_titularidad", True, " Ok... Valida Titularidad") Then
        PMChequea sqlconn&
        vti = FMRetStatus(sqlconn&)
        If vti <> 0 Then
            Exit Function
        End If
        FLVerificarTitularidad = True
    Else
        PMChequea sqlconn&
        Exit Function
    End If
 End Function

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
     Select Case Index
        Case 0, 1, 2, 3, 4, 5
            Clipboard.Clear
            Clipboard.SetText ""
     End Select
End Sub

