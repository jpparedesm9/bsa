VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{C932BA88-4374-101B-A56C-00AA003668DC}#1.1#0"; "Msmask32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Object = "{9AED8C43-3F39-11D1-8BB4-0000C039C248}#2.0#0"; "txtin.ocx"
Begin VB.Form FTran2577 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Transferencias Automaticas (Encabezado)"
   ClientHeight    =   5295
   ClientLeft      =   1350
   ClientTop       =   2445
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
   ScaleHeight     =   5295
   ScaleWidth      =   9300
   Begin VB.TextBox txtporcentaje 
      Alignment       =   1  'Right Justify
      Appearance      =   0  'Flat
      Height          =   285
      Left            =   5700
      TabIndex        =   4
      Text            =   "0.0"
      Top             =   1440
      Visible         =   0   'False
      Width           =   1095
   End
   Begin Threed.SSCheck sscobracomision 
      Height          =   315
      Left            =   1980
      TabIndex        =   3
      Top             =   1440
      Width           =   2235
      _Version        =   65536
      _ExtentX        =   3942
      _ExtentY        =   556
      _StockProps     =   78
      Caption         =   "Cobra comisión"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   315
      Left            =   1980
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   90
      Width           =   2445
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   0
      Left            =   8415
      TabIndex        =   12
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
      Height          =   735
      Index           =   6
      Left            =   8400
      TabIndex        =   6
      Top             =   45
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
      Height          =   740
      Index           =   5
      Left            =   8415
      TabIndex        =   7
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
      TabIndex        =   10
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
      TabIndex        =   8
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
      TabIndex        =   9
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
   Begin MSGrid.Grid grdRegistros 
      Height          =   3120
      Left            =   0
      TabIndex        =   5
      Top             =   2160
      Width           =   7380
      _Version        =   65536
      _ExtentX        =   13017
      _ExtentY        =   5503
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
      TabIndex        =   11
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
   Begin TxtinLib.TextValid txttipo_transf 
      Height          =   285
      Left            =   1980
      TabIndex        =   1
      Top             =   450
      Width           =   1095
      _Version        =   65536
      _ExtentX        =   1931
      _ExtentY        =   503
      _StockProps     =   253
      BorderStyle     =   1
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
   Begin MSMask.MaskEdBox mskCuenta 
      Height          =   285
      Left            =   1980
      TabIndex        =   2
      Top             =   780
      Width           =   2205
      _ExtentX        =   3889
      _ExtentY        =   503
      _Version        =   393216
      Appearance      =   0
      PromptChar      =   "_"
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   735
      Index           =   7
      Left            =   7500
      TabIndex        =   22
      Top             =   4545
      Width           =   870
      _Version        =   65536
      _ExtentX        =   1535
      _ExtentY        =   1296
      _StockProps     =   78
      Caption         =   "Detalle"
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
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Porcentaje:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   4500
      TabIndex        =   21
      Top             =   1440
      Visible         =   0   'False
      Width           =   990
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
      TabIndex        =   20
      Top             =   1560
      Width           =   75
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H00000000&
      Height          =   285
      Index           =   0
      Left            =   1980
      TabIndex        =   19
      Top             =   1110
      UseMnemonic     =   0   'False
      Width           =   5415
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "No. de cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   75
      TabIndex        =   18
      Top             =   800
      Width           =   1290
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre de la cuenta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   75
      TabIndex        =   17
      Top             =   1140
      Width           =   1845
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Transferencias existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   14
      Top             =   1920
      Width           =   2250
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   7440
      X2              =   -60
      Y1              =   1860
      Y2              =   1860
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3120
      TabIndex        =   13
      Top             =   450
      Width           =   4260
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo Transferencia:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   75
      TabIndex        =   16
      Top             =   460
      Width           =   1680
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
      TabIndex        =   15
      Top             =   120
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   7440
      X2              =   7440
      Y1              =   0
      Y2              =   5400
   End
End
Attribute VB_Name = "FTran2577"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRA2577.frm
' NOMBRE LOGICO:    FTran2577
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
' Mantenimiento de Transferencias Automáticas, cuenta destino
' incluye declaración de comisión y tipo de servicio
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
option explicit

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
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

    Select Case Index%
       Case 0 'Salir
          Unload FTran2577
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
       Case 7 ' Ir a detalle
          PLDetalle
    End Select

End Sub

Private Sub Form_Load()
    FTran2577.Left = 0   '15
    FTran2577.Top = 0   '15
    FTran2577.Width = 9450   '9420
    FTran2577.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbTipo.AddItem "CORRIENTES", 0
    cmbTipo.AddItem "AHORROS", 1
    cmbTipo.ListIndex = 0
    cmdBoton(5).Enabled = False
    txttipo_transf.Connection = VGMap
    Set txttipo_transf.AsociatedLabel = lblDescripcion(1)
    txttipo_transf.TableName = "re_tipo_transfer"
    
    mskCuenta.Mask = VGMascaraCtaAho$
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdRegistros_Click()
    grdRegistros.Col = 0
    grdRegistros.SelStartCol = 1
    grdRegistros.SelEndCol = grdRegistros.Cols - 1
    If grdRegistros.Row = 0 Then
       grdRegistros.SelStartRow = 1
       grdRegistros.SelEndRow = 1
    Else
       grdRegistros.SelStartRow = grdRegistros.Row
       grdRegistros.SelEndRow = grdRegistros.Row
    End If
End Sub

Private Sub grdregistros_DblClick()
    If grdRegistros.Rows <= 2 Then
       grdRegistros.Row = 1
       grdRegistros.Col = 1
       If Trim$(grdRegistros.Text) = "" Then
          MsgBox "No existen Registros de Transferencias Automaticas", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1
    txttipo_transf.Text = grdRegistros.Text
    grdRegistros.Col = 2
    txttipo_transf.Enabled = False
    lblDescripcion(1).Caption = grdRegistros.Text
    grdRegistros.Col = 3
    If grdRegistros.Text = "CTE" Then
       cmbTipo.ListIndex = 0
       cmbTipo.Enabled = False
       grdRegistros.Col = 4
       mskCuenta.Text = FMMascara(grdRegistros.Text, VGMascaraCtaCte$)
    Else
       cmbTipo.ListIndex = 1
       cmbTipo.Enabled = False
       grdRegistros.Col = 4
       mskCuenta.Text = FMMascara(grdRegistros.Text, VGMascaraCtaAho$)
    End If
    mskCuenta.Enabled = False
    grdRegistros.Col = 5
    lblDescripcion(0).Caption = grdRegistros.Text
    grdRegistros.Col = 6
    If grdRegistros.Text = "S" Then
        sscobracomision.Value = True
        lbletiqueta(5).Visible = True
        grdRegistros.Col = 7
        txtporcentaje.Visible = True
        txtporcentaje.Text = grdRegistros.Text
    Else
        sscobracomision.Value = False
        lbletiqueta(5).Visible = False
        txtporcentaje.Visible = False
        txtporcentaje.Text = "0.0"
    End If
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True
End Sub

Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Permite actualizar los datos respectivos del
'            encabezado de la transferencia automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

         ' Validacion de mandatoriedades
         
         If txttipo_transf.Text = "" Then
            MsgBox "El tipo de transferencia es mandatorio", 0 + 16, "Mensaje de Error"
            txttipo_transf.SetFocus
            Exit Sub
         End If

         If mskCuenta.ClipText = "" Then
            MsgBox "La cuenta destino es mandatoria", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
         End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2758"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txttipo_transf.Text
         If cmbTipo.ListIndex = 0 Then   '  corriente
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
         Else
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
         End If
         PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, mskCuenta.ClipText
         PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If sscobracomision.Value = True Then
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, txtporcentaje.Text
         Else
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
             PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, "0.0"
         End If
         
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Actualización de Transferencia Automatica") Then
           PMChequea sqlconn&
           PLBuscar    ' Refrescrar los aciones de notas de débito
        Else
           PLLimpiar
        End If

   
End Sub
Private Sub PLDetalle()
'*************************************************************
' PROPOSITO: Obtiene los datos de detalle de la transferencia
'            automatica, obtenidos de la pantalla FTran2576
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    'FTran2576.txttipo_transf = txttipo_transf
    'FTran2576.cmbtipodst.ListIndex = cmbTipo.ListIndex
    'FTran2576.Mskcuentadst.Mask = mskCuenta.Mask
    'FTran2576.Mskcuentadst.Text = mskCuenta.Text
    FTran2576.lblDescripcion(3) = lblDescripcion(0)
    FTran2576.Show
End Sub
Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid del detalle de las transferencias
'            automaticas existentes con los datos retornados
'            por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2756"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "C"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, "X"
    If cmbTipo.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, "1"
    PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, "X"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
    PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, "0.0"
    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       cmbTipo.Enabled = False
       If grdRegistros.Tag >= 20 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
    Else
       PLLimpiar
       PMLimpiaGrid grdRegistros
       cmdBoton(5).Enabled = False
    End If
End Sub

Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Crea un  nuevo contrato de transferencia
'            automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

         ' Validacion de mandatoriedades
         If txttipo_transf.Text = "" Then
            MsgBox "El tipo de transferencia es mandatorio", 0 + 16, "Mensaje de Error"
            txttipo_transf.SetFocus
            Exit Sub
         End If

         If mskCuenta.ClipText = "" Then
            MsgBox "La cuenta destino es mandatoria", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
         End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2757"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txttipo_transf.Text
         If cmbTipo.ListIndex = 0 Then   '  corriente
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
         Else
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
         End If
         PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, mskCuenta.ClipText
         PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If sscobracomision.Value = True Then
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, txtporcentaje.Text
         Else
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
             PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, "0.0"
         End If
         PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, txtporcentaje.Text
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Inserción de Transferencia Automatica") Then
             PMChequea sqlconn&
            PLBuscar ' Refrescrar las acciones de notas de débito existentes
         Else
              PLLimpiar
         End If

End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar el registro de contrato de
'            transferencia automatica
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

         ' Validacion de mandatoriedades
         If txttipo_transf.Text = "" Then
            MsgBox "El tipo de transferencia es mandatorio", 0 + 16, "Mensaje de Error"
            txttipo_transf.SetFocus
            Exit Sub
         End If

         If mskCuenta.ClipText = "" Then
            MsgBox "La cuenta destino es mandatoria", 0 + 16, "Mensaje de Error"
            mskCuenta.SetFocus
            Exit Sub
         End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2759"
         PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "D"
         PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, txttipo_transf.Text
         If cmbTipo.ListIndex = 0 Then   '  corriente
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
         Else
             PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
         End If
         PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, mskCuenta.ClipText
         PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, lblDescripcion(0).Caption
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
         If sscobracomision.Value = True Then
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
         Else
             PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
         End If
         PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, txtporcentaje.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mantenca_transfer", True, "Ok... Eliminación de Transferencia Automatica") Then
            PMChequea sqlconn&
            PLBuscar    'Refresca acciones de notas de débito existentes
            grdRegistros.Row = 1
            grdregistros_DblClick
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


   txtporcentaje.Text = "0.0"
   txttipo_transf.Text = ""
   txttipo_transf.Enabled = True
   mskCuenta.Enabled = True
   mskCuenta.Text = FMMascara("", VGMascaraCtaAho$)
   lblDescripcion(0).Caption = ""
   lblDescripcion(1).Caption = ""
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   If cmbTipo.Enabled = False Then
      cmbTipo.Enabled = True
   End If
   lbletiqueta(5).Visible = False
   txtporcentaje.Visible = False
   sscobracomision.Value = False
   PMLimpiaGrid grdRegistros
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid de contratos existentes con los si-
'            guientes 20 registros retornados por el stored
'            procedure de consulta de transferencias automaticas.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    grdRegistros.Col = 4
    grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2756"
    PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "C"
    PMPasoValores sqlconn&, "@i_tipo_transfer", 0, SQLVARCHAR, "X"
    If cmbTipo.ListIndex = 0 Then   '  corriente
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "CTE"
    Else
        PMPasoValores sqlconn&, "@i_producto_dst", 0, SQLVARCHAR, "AHO"
    End If
    PMPasoValores sqlconn&, "@i_cta_banco_dst", 0, SQLVARCHAR, grdRegistros.Text
    PMPasoValores sqlconn&, "@i_nombre_dst", 0, SQLVARCHAR, "X"
    PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
    PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
    PMPasoValores sqlconn&, "@i_tasa_com", 0, SQLFLT8, "0.0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_mantenca_transfer", True, "Ok... Consulta de Transferencias Automaticas") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
       If grdRegistros.Tag >= 20 Then
         cmdBoton(5).Enabled = True
        Else
           cmdBoton(5).Enabled = False
      End If
   End If
End Sub
Private Sub mskCuenta_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Número de la cuenta que destino"
    mskCuenta.SelStart = 0
    mskCuenta.SelLength = Len(mskCuenta.Text)
End Sub
Private Sub mskCuenta_LostFocus()
    On Error Resume Next
    If mskCuenta.ClipText <> "" Then
       If cmbTipo.ListIndex = 0 Then          '  Corrientes
            If FMChequeaCtaCte((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "16"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_query_nom_ctacte", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                     cmdBoton(4).Enabled = True
                Else
                    cmdBoton_Click (1)
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta está incorrecto", 0 + 16, "Mensaje de Error"
                cmdBoton_Click (1)
                Exit Sub
            End If
      Else  '  Ahorros
            If FMChequeaCtaAho((mskCuenta.ClipText)) Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLVARCHAR, "206"
                 PMPasoValores sqlconn&, "@i_cta", 0, SQLVARCHAR, (mskCuenta.ClipText)
                 PMPasoValores sqlconn&, "@i_mon", 0, SQLINT1, VGMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_tr_query_nom_ctahorro", True, " Ok... Cuenta " & "[" & mskCuenta.Text & "]") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(0)
                     PMChequea sqlconn&
                     cmdBoton(4).Enabled = True
                Else
                    cmdBoton_Click (1)
                    Exit Sub
                End If
            Else
                MsgBox "El dígito verificador de la cuenta de ahorros está incorrecto", 0 + 16, "Mensaje de Error"
                cmdBoton_Click (1)
                Exit Sub
            End If
      End If
    End If
End Sub
Private Sub sscobracomision_Click(Value As Integer)
    lbletiqueta(5).Visible = sscobracomision.Value
    txtporcentaje.Visible = sscobracomision.Value
    If txtporcentaje.Visible = True Then
        txtporcentaje.SetFocus
    End If
End Sub
Private Sub txtporcentaje_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Porcentaje de comisión"
    txtporcentaje.SelStart = 0
    txtporcentaje.SelLength = Len(txtporcentaje.Text)
End Sub

Private Sub txtporcentaje_KeyPress(KeyAscii As Integer)
    If KeyAscii <> 46 And KeyAscii <> 8 And (KeyAscii < 48 Or KeyAscii > 57) Then
       KeyAscii = 0
    End If
    If KeyAscii = 46 Then
        If InStr(1, txtporcentaje.Text, ".") Then
            KeyAscii = 0
        End If
    End If
End Sub
Private Sub txtporcentaje_LostFocus()
    If Val(txtporcentaje) > 100 Or Val(txtporcentaje) <= 0 Then
         MsgBox "El porcentaje debe estar en un rango de 0.01 a 100%", 0 + 16, "Mensaje de Error"
         txtporcentaje.Text = "0.0"
         txtporcentaje.SetFocus
    End If
End Sub


