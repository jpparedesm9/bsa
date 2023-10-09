VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2589 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Oficinas del Banco"
   ClientHeight    =   5370
   ClientLeft      =   90
   ClientTop       =   1845
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
   HelpContextID   =   1099
   Icon            =   "FTRA2589.frx":0000
   LinkTopic       =   "Form14"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5370
   ScaleWidth      =   9300
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   7
      Left            =   1410
      MaxLength       =   7
      TabIndex        =   4
      Top             =   930
      Width           =   1680
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   6
      Left            =   1410
      MaxLength       =   64
      TabIndex        =   3
      Top             =   630
      Width           =   6900
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   5
      Left            =   1410
      MaxLength       =   64
      TabIndex        =   2
      Top             =   330
      Width           =   6900
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   3675
      MaxLength       =   4
      TabIndex        =   1
      Top             =   30
      Width           =   690
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1410
      MaxLength       =   5
      TabIndex        =   0
      Top             =   30
      Width           =   600
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   8415
      TabIndex        =   11
      Top             =   4605
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":030A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   6
      Left            =   8415
      TabIndex        =   5
      Top             =   15
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":0326
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   5
      Left            =   8415
      TabIndex        =   6
      Top             =   780
      WhatsThisHelpID =   2001
      Width           =   875
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Siguien&tes"
      ForeColor       =   0
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":0342
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   2
      Left            =   8415
      TabIndex        =   9
      Tag             =   "2516"
      Top             =   3075
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":035E
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   3
      Left            =   8415
      TabIndex        =   7
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":037A
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   8415
      TabIndex        =   8
      Tag             =   "2549"
      Top             =   2310
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":0396
   End
   Begin MSGrid.Grid grdRegistros 
      Height          =   3705
      Left            =   30
      TabIndex        =   12
      Top             =   1590
      Width           =   8310
      _Version        =   65536
      _ExtentX        =   14659
      _ExtentY        =   6536
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
      Cols            =   4
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   1
      Left            =   8415
      TabIndex        =   10
      Top             =   3840
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
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Picture         =   "FTRA2589.frx":03B2
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código de Ruta:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   2205
      TabIndex        =   21
      Top             =   60
      Width           =   1395
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   6630
      TabIndex        =   20
      Top             =   930
      Width           =   1680
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Teléfono:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   120
      TabIndex        =   19
      Top             =   960
      Width           =   825
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Dirección:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   120
      TabIndex        =   18
      Top             =   660
      Width           =   885
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Fecha:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   5910
      TabIndex        =   17
      Top             =   960
      Width           =   600
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Oficinas del Banco Existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   120
      TabIndex        =   13
      Top             =   1350
      Width           =   2610
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8370
      X2              =   0
      Y1              =   1290
      Y2              =   1290
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3105
      TabIndex        =   16
      Top             =   930
      Visible         =   0   'False
      Width           =   2610
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Nombre:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   120
      TabIndex        =   15
      Top             =   360
      Width           =   720
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código Oficina:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   14
      Top             =   60
      Width           =   1320
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5310
   End
End
Attribute VB_Name = "FTran2589"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
Option Explicit
Dim VLFormatoFecha As String

Private Sub cmdBoton_Click(Index As Integer)

  Select Case Index%
    Case 0 'Salir
      Unload FTran2589
    Case 1 'Limpiar
       PLLimpiar
       txtCampo(1).SetFocus
    Case 2 'Eliminar
       PLEliminar
    Case 3 ' Crear
       PLCrear
    Case 4 ' Actualizar
       PLActualizar
    Case 5 'Siguientes
       PLSiguientes
    Case 6 'Buscar
       PLBuscar
       txtCampo(5).SetFocus
  End Select

End Sub

Private Sub Form_Load()

    FTran2589.Left = 15
    FTran2589.Top = 15
    FTran2589.Width = 9420
    FTran2589.Height = 5880
    PMBotonSeguridad FTran2589, 4  ' Verificar las seguridades a nivel del botones
    VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
    lblDescripcion(1).Caption = Format$(VGFecha$, VLFormatoFecha$)
    cmdBoton(2).Enabled = False
    cmdBoton(4).Enabled = False
    cmdBoton(5).Enabled = False
    
    PMLoadResStrings Me
    PMLoadResIcons Me

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
          MsgBox "No existen Oficinas del Banco", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 1   'Oficina
    txtCampo(1).Text = grdRegistros.Text
    grdRegistros.Col = 2    'Ciudad
    txtCampo(2).Text = grdRegistros.Text
    grdRegistros.Col = 3   'Descripción
    txtCampo(5).Text = grdRegistros.Text
    grdRegistros.Col = 4    'Fecha
    lblDescripcion(1).Caption = grdRegistros.Text
    grdRegistros.Col = 5    'Dirección
    txtCampo(6).Text = grdRegistros.Text
    grdRegistros.Col = 6    'Teléfono
    txtCampo(7).Text = grdRegistros.Text

    'txtcampo(0).Enabled = False
    txtCampo(1).Enabled = False
    txtCampo(2).Enabled = False
    cmdBoton(3).Enabled = False

    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True

End Sub

Private Sub PLActualizar()

   ' Valida Código de Oficina
   If txtCampo(1).Text = "" Then
        MsgBox "    Código de Banco [OFICINA] es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
   ElseIf txtCampo(2).Text = "" Then
          MsgBox "Código de Banco [CIUDAD] es mandatorio", 0 + 16, "Mensaje de Error"
          txtCampo(2).SetFocus
          Exit Sub
   End If

   'Valida Oficina Cobis
   'If txtcampo(3).Text = "" Then
   '   MsgBox "Código de Oficina Cobis es mandatorio", 0 + 16, "Mensaje de Error"
   '   txtcampo(3).SetFocus
   '   Exit Sub
   'End If
   
   'Valida Descripción
   If txtCampo(6).Text = "" Then
      MsgBox "Descripción de la Oficina es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(6).SetFocus
      Exit Sub
   End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2590"
    'PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(1).Text)
    'PMPasoValores sqlconn&, "@i_ofi_cobis", 0, SQLINT2, (txtCampo(3).Text)
    PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, (txtCampo(2).Text)
    'PMPasoValores sqlconn&, "@i_identificacion", 0, SQLVARCHAR, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_direccion", 0, SQLVARCHAR, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_telefono", 0, SQLVARCHAR, (txtCampo(7).Text)
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_ofibanco", True, "Ok... Consulta de Tipos de Oficinas de Banco") Then
       PMChequea sqlconn&
      cmdBoton(4).Enabled = False
      PLLimpiar
      PLBuscar
      'txtCampo(3).SetFocus
     Else
        PLLimpiar
   End If

End Sub

Private Sub PLBuscar()

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2591"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, "0"
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_ofibanco", True, "Ok... Consulta de Tipos de Oficinas de Banco") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
      If Val(grdRegistros.Rows - 1) >= 20 Then
        cmdBoton(5).Enabled = True
      Else
        cmdBoton(5).Enabled = False
      End If
      If grdRegistros.Rows <= 2 Then
         grdRegistros.Col = 1
         grdRegistros.Row = 1
         If grdRegistros.Text = "" Then
            Exit Sub
         End If
      End If
      VLFormatoFecha$ = Get_Preferencia("FORMATO-FECHA")
      lblDescripcion(1).Caption = Format$(VGFecha$, VLFormatoFecha$)
   Else
      PLLimpiar
   End If

End Sub

Private Sub PLCrear()

   ' Valida Código de Banco
   If txtCampo(1).Text = "" Then
        MsgBox "Código de Oficina es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
   ElseIf txtCampo(2).Text = "" Then
          MsgBox "Código de Ruta es mandatorio", 0 + 16, "Mensaje de Error"
          txtCampo(2).SetFocus
          Exit Sub
   End If

   'Valida Descripcion
   If txtCampo(5).Text = "" Then
      MsgBox "Descripción de la Oficina es mandatoria", 0 + 16, "Mensaje de Error"
      txtCampo(5).SetFocus
      Exit Sub
   End If
   
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2589"
    'PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, (txtCampo(2).Text)
    'PMPasoValores sqlconn&, "@i_ofi_cobis", 0, SQLINT2, (txtCampo(3).Text)
    'PMPasoValores sqlconn&, "@i_identificacion", 0, SQLVARCHAR, (txtCampo(4).Text)
    PMPasoValores sqlconn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(5).Text)
    PMPasoValores sqlconn&, "@i_direccion", 0, SQLVARCHAR, (txtCampo(6).Text)
    PMPasoValores sqlconn&, "@i_telefono", 0, SQLVARCHAR, (txtCampo(7).Text)
    PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_ofibanco", True, "Ok... Consulta de Tipos de Oficinas de Banco") Then
        PMChequea sqlconn&
       PLBuscar
   End If
   PLLimpiar
   txtCampo(1).SetFocus

End Sub

Private Sub PLEliminar()

   If txtCampo(1).Text = "" Then
        MsgBox "Código de Oficina es mandatorio", 0 + 16, "Mensaje de Error"
        txtCampo(1).SetFocus
        Exit Sub
   ElseIf txtCampo(2).Text = "" Then
          MsgBox "Código de Ciudad es mandatorio", 0 + 16, "Mensaje de Error"
          txtCampo(2).SetFocus
          Exit Sub
   End If

   'Valida Descripcion
   'If txtCampo(3).Text = "" Then
   '   MsgBox "Descripción de la Ofiocina es mandatoria", 0 + 16, "Mensaje de Error"
   '   txtCampo(3).SetFocus
   '   Exit Sub
   'End If

    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2592"
    'PMPasoValores sqlconn&, "@i_banco", 0, SQLINT2, (txtCampo(0).Text)
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (txtCampo(1).Text)
    PMPasoValores sqlconn&, "@i_ciudad", 0, SQLINT4, (txtCampo(2).Text)
    'PMPasoValores SqlConn&, "@i_desc", 0, SQLVARCHAR, (txtCampo(3).Text)
    'PMPasoValores SqlConn&, "@i_direccion", 0, SQLVARCHAR, (txtCampo(4).Text)
    'PMPasoValores SqlConn&, "@i_telefono", 0, SQLVARCHAR, (txtCampo(5).Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_ofibanco", True, "Ok... Consulta de Tipos de Oficinas de Banco") Then
       PMChequea sqlconn&
      cmdBoton(3).Enabled = True
      cmdBoton(2).Enabled = False
      cmdBoton(4).Enabled = False
      PLLimpiar
      PLBuscar
   End If
   PLBuscar
   txtCampo(5).SetFocus
      
End Sub

Private Sub PLLimpiar()
Dim i As Integer
Dim j As Integer
'   txtcampo(0).Enabled = True
   txtCampo(1).Enabled = True
   txtCampo(2).Enabled = True
'   txtcampo(0).Text = ""
   txtCampo(1).Text = ""
   txtCampo(2).Text = ""
'   txtCampo(3).Text = ""
 '  txtCampo(4).Text = ""
   txtCampo(5).Text = ""
   txtCampo(6).Text = ""
   txtCampo(7).Text = ""
   lblDescripcion(0).Caption = ""
   lblDescripcion(1).Caption = ""

   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   cmdBoton(5).Enabled = False

   grdRegistros.Rows = 2
   grdRegistros.Cols = 2
   For i% = 0 To 1
     grdRegistros.Row = i%
     For j% = 0 To 1
       grdRegistros.Col = j%
       grdRegistros.Text = ""
     Next j%
   Next i%

End Sub

Private Sub PLSiguientes()

   grdRegistros.Row = grdRegistros.Rows - 1
   grdRegistros.Col = 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "2591"
    PMPasoValores sqlconn&, "@i_tran", 0, SQLCHAR, "Q"
    PMPasoValores sqlconn&, "@i_oficina", 0, SQLINT2, (grdRegistros.Text)
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_cuentas", "sp_tr_crea_ofibanco", True, "Ok... Consulta de Tipos de Oficinas de Banco") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
      If Val(grdRegistros.Rows - 1) Mod 20 = 0 Then
         cmdBoton(5).Enabled = True
      Else
         cmdBoton(5).Enabled = False
      End If
     Else
     '   PLLimpiar
   End If

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
  Select Case Index%
  '  Case 0
  '      FPrincipal!pnlHelpLine.Caption = " Código del Banco"
    Case 1
        FPrincipal!pnlHelpLine.Caption = " Código de la Oficina"
    Case 2
        FPrincipal!pnlHelpLine.Caption = " Código de la Ciudad"
  '  Case 3
  '      FPrincipal!pnlHelpLine.Caption = " Código de la Oficina para Cobis [Ayuda F5]"
  '  Case 4
  '      FPrincipal!pnlHelpLine.Caption = " Código de Identificación"
    Case 5
        FPrincipal!pnlHelpLine.Caption = " Nombre de la Oficina"
    Case 6
        FPrincipal!pnlHelpLine.Caption = " Dirección"
    Case 7
        FPrincipal!pnlHelpLine.Caption = " Teléfono"
    End Select

    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2, 7
         KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    Case 5
        If (KeyAscii > 47 And KeyAscii < 58) Or _
           (KeyAscii > 64 And KeyAscii < 91) Or _
           (KeyAscii > 96 And KeyAscii < 123) Or (KeyAscii = 32 Or KeyAscii = 8) Then
           
           KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
        Else
           KeyAscii = 0
        End If
    Case 6
        KeyAscii = Asc(UCase$(Chr$(KeyAscii)))
       
    End Select

    'Select Case Index
    'Case 0:
    '    If Len(txtcampo(Index).Text) = 1 Then
    '        txtcampo(Index + 1).SetFocus
    '    End If
    'Case 1:
    '    If Len(txtcampo(Index).Text) = 2 Then
    '        txtcampo(Index + 1).SetFocus
    '    End If
    'End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)

If Val(txtCampo(1).Text) > 32767 Then
    MsgBox "El Código de la Oficina es incorrecto", 0 + 16, "Mensaje de Error"
    txtCampo(1).Text = ""
    txtCampo(1).SetFocus
End If

End Sub

