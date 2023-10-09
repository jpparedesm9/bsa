VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "MSMASK32.OCX"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FTran094 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Detalle de Planillas"
   ClientHeight    =   5325
   ClientLeft      =   2340
   ClientTop       =   2415
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
   HelpContextID   =   1096
   LinkTopic       =   "Form14"
   LockControls    =   -1  'True
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9300
   Begin VB.TextBox txtoficinacta 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      BackColor       =   &H80000004&
      Enabled         =   0   'False
      Height          =   285
      Left            =   6300
      MaxLength       =   6
      TabIndex        =   7
      Top             =   2490
      Width           =   915
   End
   Begin VB.Frame Frame1 
      Caption         =   "Detalles de Planilla"
      ForeColor       =   &H00800000&
      Height          =   2020
      Left            =   60
      TabIndex        =   21
      Top             =   1140
      Width           =   8115
      Begin VB.TextBox txtcomentario 
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   1440
         MaxLength       =   50
         TabIndex        =   36
         Top             =   1680
         Width           =   5710
      End
      Begin VB.ComboBox cmbTipo 
         Appearance      =   0  'Flat
         Height          =   315
         Left            =   1440
         Style           =   2  'Dropdown List
         TabIndex        =   3
         Top             =   360
         Width           =   1725
      End
      Begin VB.TextBox txtcodemp 
         Alignment       =   1  'Right Justify
         Appearance      =   0  'Flat
         Height          =   285
         Left            =   6240
         MaxLength       =   6
         TabIndex        =   6
         Top             =   1030
         Width           =   915
      End
      Begin MSMask.MaskEdBox mskCuenta 
         Height          =   285
         Left            =   5190
         TabIndex        =   4
         Top             =   360
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
         _Version        =   393216
         Appearance      =   0
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskvalor 
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   5
         Top             =   1030
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
         _Version        =   393216
         ClipMode        =   1
         Appearance      =   0
         Format          =   "#,##0.00;(#,##0.00)"
         PromptChar      =   "_"
      End
      Begin MSMask.MaskEdBox mskvalor 
         Height          =   285
         Index           =   1
         Left            =   1440
         TabIndex        =   31
         Top             =   1350
         Width           =   1965
         _ExtentX        =   3466
         _ExtentY        =   503
         _Version        =   393216
         ClipMode        =   1
         Appearance      =   0
         Format          =   "#,##0.00;(#,##0.00)"
         PromptChar      =   "_"
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Comentario:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   13
         Left            =   60
         TabIndex        =   35
         Top             =   1680
         Width           =   1020
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Oficina de la Cta:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   12
         Left            =   4560
         TabIndex        =   34
         Top             =   1350
         Width           =   1500
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Diferencia:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   9
         Left            =   60
         TabIndex        =   30
         Top             =   1350
         Width           =   945
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Producto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   0
         Left            =   75
         TabIndex        =   28
         Top             =   360
         Width           =   840
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Nombre:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   6
         Left            =   75
         TabIndex        =   27
         Top             =   735
         Width           =   720
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "No. de cuenta credito"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   1
         Left            =   3240
         TabIndex        =   26
         Top             =   360
         Width           =   1875
      End
      Begin VB.Label lblDescripcion 
         Appearance      =   0  'Flat
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         BorderStyle     =   1  'Fixed Single
         ForeColor       =   &H00000000&
         Height          =   285
         Index           =   0
         Left            =   1440
         TabIndex        =   25
         Top             =   720
         UseMnemonic     =   0   'False
         Width           =   5715
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   3
         Left            =   60
         TabIndex        =   24
         Top             =   660
         Width           =   75
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Codigo Empleado:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   8
         Left            =   4560
         TabIndex        =   23
         Top             =   1030
         Width           =   1545
      End
      Begin VB.Label lblEtiqueta 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H80000005&
         BackStyle       =   0  'Transparent
         Caption         =   "Monto:"
         ForeColor       =   &H00800000&
         Height          =   195
         Index           =   10
         Left            =   60
         TabIndex        =   22
         Top             =   1030
         Width           =   600
      End
   End
   Begin VB.ComboBox cmbtipodst 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   315
      Left            =   2340
      Style           =   2  'Dropdown List
      TabIndex        =   1
      Top             =   360
      Width           =   1965
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   0
      Left            =   8415
      TabIndex        =   15
      Top             =   4545
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   6
      Left            =   8415
      TabIndex        =   9
      Top             =   45
      WhatsThisHelpID =   2000
      Width           =   875
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
      Height          =   740
      Index           =   5
      Left            =   8415
      TabIndex        =   10
      Top             =   795
      WhatsThisHelpID =   2020
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   2
      Left            =   8415
      TabIndex        =   13
      Tag             =   "2516"
      Top             =   3045
      WhatsThisHelpID =   2006
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
      Height          =   740
      Index           =   3
      Left            =   8415
      TabIndex        =   11
      Tag             =   "2548"
      Top             =   1545
      WhatsThisHelpID =   2030
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
      Height          =   740
      Index           =   4
      Left            =   8415
      TabIndex        =   12
      Tag             =   "2549"
      Top             =   2295
      WhatsThisHelpID =   2031
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
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
   Begin MSGrid.Grid grdDetRegistros 
      Height          =   1740
      Left            =   0
      TabIndex        =   8
      Top             =   3560
      Width           =   8145
      _Version        =   65536
      _ExtentX        =   14367
      _ExtentY        =   3069
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
      Cols            =   4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   1
      Left            =   8415
      TabIndex        =   14
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
   Begin TxtinLib.TextValid txtplanilla 
      Height          =   285
      Left            =   2340
      TabIndex        =   0
      Top             =   30
      Width           =   1365
      _Version        =   65536
      _ExtentX        =   2408
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
      Enabled         =   0   'False
      Range           =   ""
      MaxLength       =   0
      Character       =   0
      Type            =   4
      HelpLine        =   ""
      Pendiente       =   ""
      Connection      =   0
      AsociatedLabelIndex=   0
      TableName       =   ""
      MinChar         =   0
      Error           =   0
   End
   Begin MSMask.MaskEdBox Mskcuentadst 
      Height          =   285
      Left            =   4380
      TabIndex        =   2
      Top             =   360
      Width           =   1875
      _ExtentX        =   3307
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      Enabled         =   0   'False
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   7
      Left            =   7500
      TabIndex        =   29
      Tag             =   "6335"
      Top             =   4560
      Visible         =   0   'False
      WhatsThisHelpID =   2009
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
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
   Begin MSMask.MaskEdBox mskvalor 
      Height          =   285
      Index           =   2
      Left            =   5280
      TabIndex        =   33
      Top             =   45
      Width           =   1965
      _ExtentX        =   3466
      _ExtentY        =   503
      _Version        =   393216
      ClipMode        =   1
      Appearance      =   0
      Enabled         =   0   'False
      Format          =   "#,##0.00;(#,##0.00)"
      PromptChar      =   "_"
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Monto Total:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   11
      Left            =   4080
      TabIndex        =   32
      Top             =   45
      Width           =   1095
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de Cuenta Destino:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   75
      TabIndex        =   20
      Top             =   360
      Width           =   2010
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   75
      TabIndex        =   19
      Top             =   720
      Width           =   1845
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      Enabled         =   0   'False
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2340
      TabIndex        =   18
      Top             =   720
      UseMnemonic     =   0   'False
      Width           =   5805
   End
   Begin VB.Line Line3 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8160
      X2              =   0
      Y1              =   1080
      Y2              =   1080
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Detalles existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   16
      Top             =   3300
      Width           =   1680
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8160
      X2              =   -120
      Y1              =   3240
      Y2              =   3240
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. Planilla:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   75
      TabIndex        =   17
      Top             =   45
      Width           =   1050
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8280
      X2              =   8280
      Y1              =   0
      Y2              =   5520
   End
End
Attribute VB_Name = "FTran094"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
'*************************************************************
' ARCHIVO:          FTran094.frm
' NOMBRE LOGICO:    FTran094
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
'    Mantenimiento de detalles de planillas
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim VLValor As Double
Public VLmoneda As String
Public VLEstadoPLa As String

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto cuenta credito"
End Sub

Private Sub cmbTipodst_LostFocus()
     If cmbtipodst.ListIndex = 0 Then  '' Corrientes
          Mskcuentadst.Mask = VGMascaraCtaCte$
     Else
          Mskcuentadst.Mask = VGMascaraCtaAho$
     End If
     Call mskCuentadst_LostFocus
End Sub
Private Sub cmbTipodst_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto cuenta credito"
End Sub

Private Sub cmbTipo_LostFocus()
     If cmbTipo.ListIndex = 0 Then  '' Corrientes
          mskCuenta.Mask = VGMascaraCtaCte$
     Else
          mskCuenta.Mask = VGMascaraCtaAho$
     End If
     Call mskCuenta_LostFocus
End Sub


Private Sub cmdBoton_Click(Index As Integer)
    Dim VTRet As Integer
    Select Case Index%
       Case 0 'Salir
        If mskValor(1).Text > 0 Then
            VTRet = MsgBox("Total de Planilla no coincide con el encabezado", vbOKOnly, "Mensaje del Sistema")
        End If
          Unload FTran094
       Case 1 'Limpiar
          PLLimpiar
          
       Case 2 'Eliminar
          PLEliminar
       Case 3 ' Inserta nuevo
          PLCrear
       Case 4 ' Actualizar
          PLActualizar
       Case 5 'Siguientes
          PLSiguientes
       Case 6 'Buscar
          PLBuscar
       Case 7  'Imprmir
          PLImprimir
    End Select

End Sub

Private Sub Form_Load()
    FTran094.Left = 0   '15
    FTran094.Top = 0   '15
    FTran094.Width = 9450   '9420
    FTran094.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbTipo.AddItem "CORRIENTES", 0
    cmbTipo.AddItem "AHORROS", 1
    cmbTipo.ListIndex = 0
    cmbtipodst.AddItem "CORRIENTES", 0
    cmbtipodst.AddItem "AHORROS", 1
    
    cmbtipodst.AddItem "SIN CUENTA", 2
    
    cmbtipodst.ListIndex = 0
    cmdBoton(5).Enabled = False
    'txtplanilla.Connection = VGMap
    'Set txtplanilla.AsociatedLabel = lblDescripcion(1)
    'txtplanilla.TableName = "re_tipo_transfer"
    mskValor(0).Text = "0.00"
    mskValor(1).Text = "0.00"
       
    mskCuenta.Mask = VGMascaraCtaAho$
    Mskcuentadst.Mask = VGMascaraCtaAho$
    mskValor(1).Enabled = False
    VLValor = 0
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdDetRegistros_Click()
    grdDetRegistros.Col = 0
    grdDetRegistros.SelStartCol = 1
    grdDetRegistros.SelEndCol = grdDetRegistros.Cols - 1
    If grdDetRegistros.Row = 0 Then
       grdDetRegistros.SelStartRow = 1
       grdDetRegistros.SelEndRow = 1
    Else
       grdDetRegistros.SelStartRow = grdDetRegistros.Row
       grdDetRegistros.SelEndRow = grdDetRegistros.Row
    End If
End Sub

Private Sub grdDetRegistros_DblClick()
    
    txtoficinacta.Text = ""
    txtcomentario.Text = ""
    
    Dim VLProcesado As Boolean
    
    If grdDetRegistros.Rows <= 2 Then
       grdDetRegistros.Row = 1
       grdDetRegistros.Col = 1
       If Trim$(grdDetRegistros.Text) = "" Then
          MsgBox "No existen Registros de Transferencias Automaticas", 0 + 16, "Mensaje de Error"
          PLLimpiar
          Exit Sub
       End If
    End If

    grdDetRegistros.Col = 2
    If grdDetRegistros.Text = "CTE" Then
       cmbTipo.ListIndex = 0
       cmbTipo.Enabled = False
       grdDetRegistros.Col = 3
       mskCuenta.Text = FMMascara(grdDetRegistros.Text, VGMascaraCtaCte$)
    Else
       cmbTipo.ListIndex = 1
       cmbTipo.Enabled = False
       grdDetRegistros.Col = 3
       mskCuenta.Text = FMMascara(grdDetRegistros.Text, VGMascaraCtaAho$)
    End If
    grdDetRegistros.Col = 4
    lblDescripcion(0).Caption = grdDetRegistros.Text
    grdDetRegistros.Col = 5
    mskValor(0).Text = grdDetRegistros.Text
    grdDetRegistros.Col = 6
    If grdDetRegistros.Text = "" Then
        txtcodemp.Text = "0"
    Else
        txtcodemp.Text = grdDetRegistros.Text
    End If
    grdDetRegistros.Col = 7
'FIXIT: Replace 'UCase' function with 'UCase$' function                                    FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Left' function with 'Left$' function                                      FixIT90210ae-R9757-R1B8ZE
    VLProcesado = (UCase(Left(grdDetRegistros.Text, 1)) <> "P")
'    grdDetRegistros.Col = 11
 '   txtcontrato.Text = grdDetRegistros.Text
 
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = VLProcesado
    cmdBoton(2).Enabled = VLProcesado
    mskCuenta.Enabled = False
    cmbTipo.Enabled = False
    
    grdDetRegistros.Col = 9
    txtoficinacta.Text = grdDetRegistros.Text
    
    grdDetRegistros.Col = 10
    txtcomentario.Text = grdDetRegistros.Text
    
End Sub

Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Actualizar los datos del detalle de una planilla
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim fila As Integer
Dim val_ant As String
Dim i As Integer
Dim dif As String
VLValor = 0
    ' Validacion de mandatoriedades
    If VLEstadoPLa = "P" Then
       MsgBox "La planilla ya fue procesada, no puede ser modificada", 0 + 16, "Mensaje de Error"
       Exit Sub
    End If
    
    If mskCuenta.ClipText = "" Then
       MsgBox "La cuenta a acreditar es mandatoria", 0 + 16, "Mensaje de Error"
       mskCuenta.SetFocus
       Exit Sub
    End If
    
   
    If Val(mskValor(0).ClipText) <= 0 Then
       MsgBox "El monto a acreditar es mandatorio y debe ser mayor a 0.00", 0 + 16, "Mensaje de Error"
       mskValor(0).SetFocus
       Exit Sub
    End If
        
    fila% = grdDetRegistros.Row
    grdDetRegistros.Col = 5
    val_ant$ = grdDetRegistros.Text
    'Consultar la diferencia
    If Trim$(grdDetRegistros.Text) <> "" Then
       For i = 1 To grdDetRegistros.Rows - 1
         grdDetRegistros.Col = 5
         grdDetRegistros.Row = i
         If i = fila% Then
            VLValor = VLValor + CCur(mskValor(0).Text)
         Else
            VLValor = VLValor + CCur(grdDetRegistros.Text)
         End If
       Next i
       'dif% = Val(mskvalor(2).Text) - VLValor
       dif = CCur(mskValor(2).Text) - VLValor
       If CCur(dif) < 0 Then
            MsgBox "El monto excede al valor permitido segun la diferencia", 0 + 16, "Mensaje de Error"
            mskValor(0).SetFocus
            mskValor(0).Text = val_ant$
            Exit Sub
       End If
    End If
  
    'Verficar que fecha de consulta sea menor que la fecha del sistema
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2815"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "UD"
    PMPasoValores sqlconn&, "@i_planilla", 0, SQLINT4, txtplanilla.Text
    If cmbTipo.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "AHO"
    End If
    PMPasoValores sqlconn&, "@i_cuenta_det", 0, SQLVARCHAR, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_monto_det", 0, SQLMONEY, mskValor(0).ClipText
    PMPasoValores sqlconn&, "@i_cod_empleado", 0, SQLINT4, txtcodemp.Text
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT4, (VGMoneda$)
    
    grdDetRegistros.Row = fila%
    grdDetRegistros.Col = 8
    PMPasoValores sqlconn&, "@i_secuencial_det", 0, SQLINT4, grdDetRegistros.Text
    
    If txtcomentario.Text <> "" Then
        PMPasoValores sqlconn&, "@i_comentario", 0, SQLVARCHAR, txtcomentario.Text
    End If
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_planilla", True, "Ok... Actualización de Detalle de Planilla") Then
       PMChequea sqlconn&
       PLBuscar    ' Refrescar los detalles de planillas
    Else
       PLLimpiar
    End If
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid de Detalles existentes con los datos
'            retornados por el stored procedure que busca los
'            detalles de la planilla.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Dim dif As Currency
Dim i As Integer
'VLValor = 0
Dim VLValor As Currency
         ' Validacion de mandatoriedades
    If txtplanilla.Text = "" Then
       MsgBox "El numero de planilla es mandatorio", 0 + 16, "Mensaje de Error"
       txtplanilla.SetFocus
       Exit Sub
    End If

    If Mskcuentadst.ClipText = "" Then
       MsgBox "La cuenta a acreditar es mandatoria", 0 + 16, "Mensaje de Error"
       Mskcuentadst.SetFocus
       Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2816"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "SD"
    PMPasoValores sqlconn&, "@i_planilla", 0, SQLINT4, txtplanilla.Text
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_planilla", True, "Ok... Consulta de Detalle de Planillas") Then
       PMMapeaGrid sqlconn&, grdDetRegistros, False
       PMChequea sqlconn&
       txtplanilla.Enabled = False
       Mskcuentadst.Enabled = False
       cmbtipodst.Enabled = False
       cmdBoton(7).Enabled = True
       If grdDetRegistros.Tag >= 20 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
       
       'Consultar la diferencia
       grdDetRegistros.Row = 1
       grdDetRegistros.Col = 1
       If Trim$(grdDetRegistros.Text) <> "" Then
           For i = 1 To grdDetRegistros.Rows - 1
            grdDetRegistros.Col = 5
            grdDetRegistros.Row = i
            VLValor = VLValor + Val(Format(grdDetRegistros.Text, "###########.##")) '(grdDetRegistros.Text)
           Next i
           dif = Val(Format(mskValor(2).Text, "###########.##")) - VLValor
           mskValor(1).Text = dif
       End If
    Else
       PLLimpiar
       PMLimpiaGrid grdDetRegistros
       cmdBoton(5).Enabled = False
    End If
End Sub

Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Ingresa un detalle a una planilla validando que
'            se hayan ingresado los datos indispensables.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    VLValor = 0
  
    If VLEstadoPLa = "P" Then
       MsgBox "La planilla ya fue procesada, no puede ser modificada", 0 + 16, "Mensaje de Error"
       Exit Sub
    End If

    If mskCuenta.ClipText = "" Then
       MsgBox "La cuenta credito es mandatoria", 0 + 16, "Mensaje de Error"
       mskCuenta.SetFocus
       Exit Sub
    End If
    
    If Val(mskValor(0).ClipText) <= 0 Then
       MsgBox "El monto a acreditar es mandatorio y debe ser mayor a 0.00", 0 + 16, "Mensaje de Error"
       mskValor(0).SetFocus
       Exit Sub
    End If
    
    If CCur(mskValor(1).Text - mskValor(0).Text) < 0 And CCur(mskValor(1).Text) <> 0 Then
       MsgBox "El monto a acreditar excede al monto permitido, segun el total", 0 + 16, "Mensaje de Error"
       mskValor(0).SetFocus
       Exit Sub
    End If
    
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2813"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "ID"
    PMPasoValores sqlconn&, "@i_planilla", 0, SQLINT4, txtplanilla.Text
    If cmbTipo.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "AHO"
    End If
    PMPasoValores sqlconn&, "@i_cuenta_det", 0, SQLVARCHAR, mskCuenta.ClipText
    PMPasoValores sqlconn&, "@i_nombre_det", 0, SQLVARCHAR, lblDescripcion(0).Caption
    PMPasoValores sqlconn&, "@i_monto_det", 0, SQLMONEY, mskValor(0).Text
    PMPasoValores sqlconn&, "@i_cod_empleado", 0, SQLINT4, txtcodemp.Text
    PMPasoValores sqlconn&, "@i_mon", 0, SQLINT4, (VGMoneda$)
    PMPasoValores sqlconn&, "@i_operacion", 0, SQLVARCHAR, "C" '--Crédito
    
    PMPasoValores sqlconn&, "@i_oficina_cta", 0, SQLINT2, txtoficinacta.Text
    
    If txtcomentario.Text <> "" Then
        PMPasoValores sqlconn&, "@i_comentario", 0, SQLVARCHAR, txtcomentario.Text
    End If
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_planilla", True, "Ok... Inserción de Detalle Planilla") Then
        PMChequea sqlconn&
        PLLimpiar
        PLBuscar ' Refrescar el detalle de la planilla
        mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
    Else
        PLLimpiar
    End If

End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Elimina un detalle de una planilla validando que
'            la planilla no haya sido procesada.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    If VLEstadoPLa = "P" Then
       MsgBox "La planilla ya fue procesada, no puede ser modificada", 0 + 16, "Mensaje de Error"
       Exit Sub
    End If
   
    If mskCuenta.ClipText = "" Then
       MsgBox "La cuenta a acreditar es mandatoria", 0 + 16, "Mensaje de Error"
       mskCuenta.SetFocus
       Exit Sub
    End If
    
If MsgBox("Esta seguro de eliminar esta planilla?", 4 + 32 + 0, "Mensaje del Sistema") = 6 Then
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2814"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "DD"
    PMPasoValores sqlconn&, "@i_planilla", 0, SQLINT4, txtplanilla.Text
    If cmbTipo.Text = "CORRIENTES" Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, "AHO"
    End If
    PMPasoValores sqlconn&, "@i_cuenta_det", 0, SQLVARCHAR, mskCuenta.ClipText
    
    grdDetRegistros.Col = 8
    PMPasoValores sqlconn&, "@i_secuencial_det", 0, SQLINT4, grdDetRegistros.Text
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_planilla", True, "Ok... Eliminación de Detalle de Planilla") Then
       PMChequea sqlconn&
       PLBuscar    'Refresca detalles de planillas existentes
       grdDetRegistros.Row = 1
       grdDetRegistros_DblClick
    End If
End If
End Sub

Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia los objetos de la pantalla
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
   Dim VTRet As Integer
   mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
   lblDescripcion(0).Caption = ""
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   If cmbTipo.Enabled = False Then
      cmbTipo.Enabled = True
   End If
   mskCuenta.Enabled = True
   cmbTipo.Enabled = True
    
   mskValor(0).Text = "0.00"
   If mskValor(1).Text > 0 Then
    VTRet = MsgBox("Total de Planilla no coincide con el encabezado", vbOKOnly, "Mensaje del Sistema")
   End If
   mskValor(1).Text = "0.00"
   PMLimpiaGrid grdDetRegistros
   cmdBoton(7).Enabled = False
   txtcodemp.Text = ""
   VLValor = 0
   txtoficinacta.Text = ""
   txtcomentario.Text = ""
   
   PLBuscar
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid de Detalle de la planilla con los
'            siguientes 20 registros retornados por el stored
'            procedure de consulta del detalle de una planilla
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim i As Integer
    Dim dif As Integer
    VLValor = 0
         ' Validacion de mandatoriedades
    grdDetRegistros.Col = 1
    grdDetRegistros.Row = grdDetRegistros.Rows - 1
         
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2816"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "SD"
    PMPasoValores sqlconn&, "@i_planilla", 0, SQLINT4, txtplanilla.Text
    
    grdDetRegistros.Col = 2
    PMPasoValores sqlconn&, "@i_producto_det", 0, SQLVARCHAR, grdDetRegistros.Text
    grdDetRegistros.Col = 3
    PMPasoValores sqlconn&, "@i_cuenta_det", 0, SQLVARCHAR, grdDetRegistros.Text
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_planilla", True, "Ok... Consulta de Detalles de Planilla") Then
       PMMapeaGrid sqlconn&, grdDetRegistros, True
       PMChequea sqlconn&
       grdDetRegistros.Row = 1
       grdDetRegistros.Col = 1
       If Trim$(grdDetRegistros.Text) <> "" Then
           For i% = 1 To grdDetRegistros.Rows - 1
            grdDetRegistros.Col = 5
            grdDetRegistros.Row = i
            VLValor = VLValor + Int(grdDetRegistros.Text)
           Next i
           dif% = Val(mskValor(2).Text) - VLValor
           mskValor(1).Text = dif%
       End If
  
       If grdDetRegistros.Tag >= 20 Then
         cmdBoton(5).Enabled = True
       Else
           cmdBoton(5).Enabled = False
       End If
     End If
End Sub

Private Sub PLImprimir()
'*************************************************************
' PROPOSITO: Imprime los registros del detalla de la planilla
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
    Dim Linea As String
    Dim i As Integer
    Dim j As Integer
    If MsgBox("Esta seguro de imprimir esta pantalla?", 4 + 32 + 0, "Mensaje del Sistema") = 6 Then
        Screen.MousePointer = 11
''        Printer.FontName = "Courier New"
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 10
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print "                                                                    Fecha: " & VGFecha$
''
''        Printer.FontBold = True
''        Printer.CurrentX = 0
''        Printer.CurrentY = 0
''        Printer.FontSize = 24
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print VGBanco$
''        Printer.FontSize = 10
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print ""
''        Printer.FontSize = 16
''        Printer.Print "TRANSFERENCIAS AUTOMATICAS"
''        Printer.Print ""
''        Printer.Print ""
''        Printer.Print ""
        FMCabeceraReporte VGBanco$, Date, "TRANSFERENCIAS AUTOMATICAS", _
                          Time(), Me.Caption, VGFecha$, Printer.Page
        Printer.FontSize = 10
        Printer.Print String$(98, "-")
        Linea = "Tipo Transferencia:    " & txtplanilla.Text
        Printer.Print Linea
        Linea = "No. de Cuenta Destino: " & cmbtipodst & "    " & Mskcuentadst.Text
        Printer.Print Linea
        Linea = "Nombre de la Cuenta :  " & lblDescripcion(3).Caption
        Printer.Print Linea
        Printer.Print String$(98, "-")
        Printer.Print ""
        Printer.Print ""
        Linea = "TIPO No. CUENTA NOMBRE                PER DIA       MONTO    PROX.COBRO  ULT.COBRO     TOTAL.DEB."
        Printer.Print Linea
        Printer.Print String$(98, "-")
        Printer.Print ""
        For i = 1 To grdDetRegistros.Rows - 1
             Linea = ""
             grdDetRegistros.Row = i
             For j = 1 To grdDetRegistros.Cols - 1
                 grdDetRegistros.Col = j
                 Select Case j
                 Case 1
                       Linea = Linea & grdDetRegistros.Text & Space$(2)
                 Case 2
                       Linea = Linea & grdDetRegistros.Text & Space$(1)
                 Case 3
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
'FIXIT: Replace 'Mid' function with 'Mid$' function                                        FixIT90210ae-R9757-R1B8ZE
                       Linea = Linea & Mid(grdDetRegistros.Text, 1, 20) & Space$(23 - Len(Mid(grdDetRegistros.Text, 1, 20)))
                 Case 4
                       Linea = Linea & grdDetRegistros.Text & Space$(2)
                 Case 5
                       Linea = Linea & grdDetRegistros.Text & Space$(4 - Len(grdDetRegistros.Text))
                 Case 6
                       Linea = Linea & Space$(12 - Len(grdDetRegistros.Text)) & grdDetRegistros.Text & Space$(3)
                 Case 7
                       Linea = Linea & grdDetRegistros.Text & Space$(10 - Len(grdDetRegistros.Text)) + Space$(2)
                 Case 8
                       Linea = Linea & grdDetRegistros.Text & Space$(10 - Len(grdDetRegistros.Text)) + Space$(2)
                 Case 12
                       Linea = Linea & Space$(12 - Len(grdDetRegistros.Text)) & grdDetRegistros.Text & Space$(3)
                 End Select
             Next j
             
             Printer.Print Linea
        Next i
        Printer.Print ""
        Printer.Print ""
        Printer.Print ""
        If VGCodPais$ <> "CO" Then
            Printer.Print "---  U L T I M A   L I N E A  ---"
        End If
        Printer.EndDoc
        Screen.MousePointer = 0
    End If
End Sub


Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta a acreditar"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub

Private Sub mskCuenta_LostFocus()
 
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
       If cmbTipo.ListIndex = 0 Then          '  corriente
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 
                 PMPasoValores sqlconn&, "@i_oficina", 0, SQLCHAR, "S"
                 
                 'Requerimiento AgroMercantil para que la moneda de la cuenta a buscar
                 'sea la misma que la moneda de la cuenta origen, mas no la moneda del módulo
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjetoAB sqlconn&, lblDescripcion(0), txtoficinacta
                     PMChequea sqlconn&
                     'cmdBoton(4).Enabled = True
                Else
                    MsgBox "La moneda de la cuenta de " + cmbTipo.Text + " debe ser la misma que la cuenta del encabezado", 0 + 16, "Mensaje de Error"
                    cmdBoton_Click (1)
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de Corriente está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.SetFocus
                cmdBoton_Click (1)
                Exit Sub
            End If
      Else  '  Ahorros
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 'Requerimiento AgroMercantil para que la moneda de la cuenta a buscar
                 'sea la misma que la moneda de la cuenta origen, mas no la moneda del módulo
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VLmoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjetoAB sqlconn&, lblDescripcion(0), txtoficinacta
                     PMChequea sqlconn&
                     'cmdBoton(4).Enabled = True
                Else
                    cmdBoton_Click (1)
                    mskCuenta.SetFocus
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                mskCuenta.SetFocus
                cmdBoton_Click (1)
                Exit Sub
            End If
      End If
    End If
   
End Sub

Private Sub mskCuentadst_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta a acreditar"
    Mskcuentadst.SelStart = 0
    Mskcuentadst.SelLength = Len(Mskcuentadst.Text)
End Sub

Private Sub mskCuentadst_LostFocus()
 
    On Error Resume Next
    If Mskcuentadst.ClipText <> "" Then
       If cmbtipodst.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((Mskcuentadst.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadst.ClipText)
                 'Requerimiento AgroMercantil para que la moneda de la cuenta a buscar
                 'sea la misma que la moneda de la cuenta origen, mas no la moneda del módulo
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VLmoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & Mskcuentadst.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(3)
                     PMChequea sqlconn&
                 Else
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de Corriente está incorrecto", 0 + 16, "Mensaje de Error"
                Exit Sub
            End If
      Else  '  Ahorros
            If FMChequeaCtaAho((Mskcuentadst.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (Mskcuentadst.ClipText)
                 'Requerimiento AgroMercantil para que la moneda de la cuenta a buscar
                 'sea la misma que la moneda de la cuenta origen, mas no la moneda del módulo
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VLmoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & Mskcuentadst.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(3)
                     PMChequea sqlconn&
                Else
                      Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                Exit Sub
            End If
      End If
    End If
   
End Sub





Private Sub txtcodemp_KeyPress(KeyAscii As Integer)
'    KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
       KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskValor(1).Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub

Private Sub mskValor_GotFocus(Index As Integer)

    Select Case Index%
       Case 0
            FPrincipal!pnlHelpLine.Caption = " Monto a acreditar"
            mskValor(0).SelStart = 0
            mskValor(0).SelLength = Len(mskValor(0).Text)
       Case 1
            FPrincipal!pnlHelpLine.Caption = " Diferencia del monto total"
            mskValor(1).SelStart = 0
            mskValor(1).SelLength = Len(mskValor(1).Text)
       Case 2
            FPrincipal!pnlHelpLine.Caption = " Monto total"
            mskValor(2).SelStart = 0
            mskValor(2).SelLength = Len(mskValor(2).Text)
    End Select
End Sub

Private Sub mskValor_KeyPress(KeyAscii As Integer, Index As Integer)
If Index% = 0 Or Index% = 1 Or Index% = 2 Then
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
       KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, mskValor(Index).Text, ".") Then
            KeyAscii = 0
        End If
    End If
End If
End Sub
Private Sub txtcodemp_LostFocus()
    If txtcodemp.Text = "" Then
        txtcodemp.Text = "0"
    End If
End Sub
Private Sub txtcomentario_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Comentario"
    txtcomentario.SelStart = 0
    txtcomentario.SelLength = Len(txtcomentario.Text)
End Sub
Private Sub txtcomentario_KeyPress(KeyAscii As Integer)
KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
End Sub

