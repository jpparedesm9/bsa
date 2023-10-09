VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FTran2581 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   Caption         =   "Mantenimiento de Acción de Notas de Débitos"
   ClientHeight    =   5415
   ClientLeft      =   465
   ClientTop       =   1935
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
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5415
   ScaleWidth      =   9300
   Begin VB.Frame Frame3 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Valida Saldo Mínimo"
      ForeColor       =   &H00000080&
      Height          =   855
      Left            =   5520
      TabIndex        =   25
      Top             =   1560
      Width           =   1965
      Begin VB.OptionButton optsaldo 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Si"
         Height          =   240
         Index           =   1
         Left            =   600
         TabIndex        =   27
         Top             =   465
         Width           =   1140
      End
      Begin VB.OptionButton optsaldo 
         BackColor       =   &H00C0C0C0&
         Caption         =   "No"
         Height          =   240
         Index           =   0
         Left            =   600
         TabIndex        =   26
         Top             =   240
         Value           =   -1  'True
         Width           =   1350
      End
   End
   Begin VB.Frame Frame2 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Exencion Imp. GMF"
      ForeColor       =   &H00000080&
      Height          =   855
      Left            =   3000
      TabIndex        =   23
      Top             =   1560
      Width           =   2070
      Begin VB.OptionButton optimp 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Si"
         Height          =   285
         Index           =   1
         Left            =   480
         TabIndex        =   24
         Top             =   460
         Width           =   1140
      End
      Begin VB.OptionButton optimp 
         BackColor       =   &H00C0C0C0&
         Caption         =   "No"
         Height          =   240
         Index           =   0
         Left            =   480
         TabIndex        =   4
         Top             =   240
         Value           =   -1  'True
         Width           =   1350
      End
   End
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "IVA"
      ForeColor       =   &H00000080&
      Height          =   855
      Left            =   600
      TabIndex        =   21
      Top             =   1560
      Width           =   1965
      Begin VB.OptionButton optcom 
         BackColor       =   &H00C0C0C0&
         Caption         =   "No"
         Height          =   240
         Index           =   0
         Left            =   600
         TabIndex        =   3
         Top             =   240
         Value           =   -1  'True
         Width           =   1350
      End
      Begin VB.OptionButton optcom 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Si"
         Height          =   240
         Index           =   1
         Left            =   600
         TabIndex        =   22
         Top             =   465
         Width           =   1140
      End
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   0
      Left            =   8415
      TabIndex        =   11
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
   Begin VB.ComboBox cmbTipo 
      Appearance      =   0  'Flat
      Height          =   300
      Left            =   1095
      Style           =   2  'Dropdown List
      TabIndex        =   0
      Top             =   75
      Width           =   2445
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   6
      Left            =   8415
      TabIndex        =   5
      Tag             =   "2583"
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
      TabIndex        =   6
      Tag             =   "2583"
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
      TabIndex        =   9
      Tag             =   "2584"
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
      Height          =   735
      Index           =   3
      Left            =   8400
      TabIndex        =   7
      Tag             =   "2581"
      Top             =   1545
      WhatsThisHelpID =   2030
      Width           =   870
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
      TabIndex        =   8
      Tag             =   "2582"
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
      Height          =   2400
      Left            =   0
      TabIndex        =   12
      Top             =   2880
      Width           =   8340
      _Version        =   65536
      _ExtentX        =   14711
      _ExtentY        =   4233
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
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      Caption         =   "Accion "
      ForeColor       =   &H00000080&
      Height          =   555
      Left            =   1095
      TabIndex        =   16
      Top             =   690
      Width           =   7230
      Begin Threed.SSOption optVigente 
         Height          =   195
         Index           =   2
         Left            =   5265
         TabIndex        =   14
         TabStop         =   0   'False
         Top             =   260
         Width           =   1155
         _Version        =   65536
         _ExtentX        =   2037
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Sobregiro"
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
      Begin Threed.SSOption optVigente 
         Height          =   195
         Index           =   1
         Left            =   2880
         TabIndex        =   13
         TabStop         =   0   'False
         Top             =   260
         Width           =   1785
         _Version        =   65536
         _ExtentX        =   3149
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Mensaje de Error"
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
      Begin Threed.SSOption optVigente 
         Height          =   195
         Index           =   0
         Left            =   75
         TabIndex        =   2
         Top             =   260
         Width           =   2145
         _Version        =   65536
         _ExtentX        =   3784
         _ExtentY        =   344
         _StockProps     =   78
         Caption         =   "Valores en Suspenso"
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
         Value           =   -1  'True
      End
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1095
      MaxLength       =   3
      TabIndex        =   1
      Top             =   390
      Width           =   915
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   740
      Index           =   1
      Left            =   8415
      TabIndex        =   10
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
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Notas de Débito Existentes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   17
      Top             =   2640
      Width           =   2385
   End
   Begin VB.Line Line2 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      X1              =   8370
      X2              =   0
      Y1              =   2570
      Y2              =   2570
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Accion:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   75
      TabIndex        =   20
      Top             =   795
      Width           =   660
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   2025
      TabIndex        =   15
      Top             =   390
      Width           =   6300
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
      Left            =   75
      TabIndex        =   19
      Top             =   435
      Width           =   645
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
      TabIndex        =   18
      Top             =   75
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8385
      X2              =   8385
      Y1              =   0
      Y2              =   5400
   End
End
Attribute VB_Name = "FTran2581"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FTRA2581.frm
' NOMBRE LOGICO:    FTran2581
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
' Realiza el Mantenimiento de Acción de Notas de Débitos
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************
Option Explicit
Dim VLPaso As Integer
Dim VTProducto As String

Private Sub cmbTipo_Click()
    txtCampo(0).Text = ""
    lblDescripcion.Caption = ""
    optVigente(0).Value = True
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        optVigente(2).Enabled = True
    Else
        optVigente(2).Enabled = False
    End If
   grdRegistros.Rows = 2
   grdRegistros.Cols = 2
   grdRegistros.Row = 0
   grdRegistros.Col = 1
   grdRegistros.Text = ""
   grdRegistros.Row = 1
   grdRegistros.Col = 0
   grdRegistros.Text = ""
   grdRegistros.Row = 1
   grdRegistros.Col = 1
   grdRegistros.Text = ""
 
End Sub

Private Sub cmbTipo_GotFocus()
     FPrincipal!pnlHelpLine.Caption = " Tipo de Producto"
     FPrincipal!pnlTransaccionLine.Caption = " FTRA2581 - V. 4"
End Sub

Private Sub cmdBoton_Click(Index As Integer)

    Select Case Index%
       Case 0 'Salir
          Unload FTran2581
       Case 1 'Limpiar
          PLLimpiar
       Case 2 'Eliminar
          PLEliminar
       Case 3 ' Crear un nuevo tipo accion de Notas de débito
          PLCrear
       Case 4 ' Actualizar un tipo de acción de Notas de débito
          PLActualizar
       Case 5 'Siguientes
          PLSiguientes
       Case 6 'Buscar
          PLBuscar
    End Select

End Sub

Private Sub Form_Load()
    FTran2581.Left = 0   '15
    FTran2581.Top = 0   '15
    FTran2581.Width = 9450   '9420
    FTran2581.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmbTipo.AddItem "CUENTA CORRIENTE", 0
    cmbTipo.AddItem "CUENTA DE AHORRO", 1
    cmbTipo.ListIndex = 0
    cmdBoton(5).Enabled = False
    optsaldo(1).Value = True
    
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
          MsgBox "No existen Notas de Débito", 0 + 16, "Mensaje de Error"
          Exit Sub
       End If
    End If

    grdRegistros.Col = 2
    txtCampo(0).Text = grdRegistros.Text
    txtCampo(0).Enabled = False

    grdRegistros.Col = 3
    lblDescripcion.Caption = grdRegistros.Text

    grdRegistros.Col = 4
    If grdRegistros.Text = "V" Then
       optVigente(0).Value = True
    End If

    If grdRegistros.Text = "E" Then
       optVigente(1).Value = True
    End If

    If grdRegistros.Text = "S" Then
       optVigente(2).Value = True
    End If

    grdRegistros.Col = 5
    If grdRegistros.Text = "S" Then
       optcom(1).Value = True
    Else
       optcom(0).Value = True
    End If
   
    grdRegistros.Col = 6
    If grdRegistros.Text = "S" Then
       optimp(1).Value = True
    Else
       optimp(0).Value = True
    End If

    grdRegistros.Col = 1
    If grdRegistros.Text = "3" Then
       cmbTipo.ListIndex = 0
       cmbTipo.Enabled = False
    Else
       cmbTipo.ListIndex = 1
       cmbTipo.Enabled = False
    End If
    
    grdRegistros.Col = 7
    If grdRegistros.Text = "S" Then
       optsaldo(1).Value = True
    Else
       optsaldo(0).Value = True
    End If
    
    cmdBoton(3).Enabled = False
    cmdBoton(4).Enabled = True
    cmdBoton(2).Enabled = True
End Sub

Private Sub PLActualizar()
'*************************************************************
' PROPOSITO: Actualiza la accion a realizar en una determinada
'            nota de debito
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

        ' Validacion de mandatoriedades
        If txtCampo(0).Text = "" Then
           MsgBox "El Causal de la Nota de Débito es madatorio", 0 + 16, "Mensaje de Error"
           txtCampo(0).SetFocus
           Exit Sub
        End If

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "699" '"2582"
        If cmbTipo.Text = "CUENTA CORRIENTE" Then
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
        Else
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
        End If

        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
        If optVigente(0).Value = True Then
           PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "V"
        ElseIf optVigente(1).Value = True Then
               PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "E"
           ElseIf optVigente(2).Value = True Then
               PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "S"
           Else
               MsgBox "Campo Acción es mandatorio", 0 + 16, "Mensaje de Error"
               Exit Sub
        End If
        
        If optcom(0).Value = True Then
           PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
        ElseIf optcom(1).Value = True Then
           PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
        End If
        
        If optimp(0).Value = True Then
            PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "N"
        ElseIf optimp(1).Value = True Then
            PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "S"
        End If
        
        If optsaldo(0).Value = True Then
           PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "N"
        ElseIf optsaldo(1).Value = True Then
           PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "S"
        End If


        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$

        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
           PMChequea sqlconn&
           PLBuscar    ' Refrescrar los aciones de notas de débito
        Else
           PLLimpiar
        End If

   
End Sub

Private Sub PLBuscar()
'*************************************************************
' PROPOSITO: Llena el grid de las notas de debito existentes
'            con los datos retornados por el stored procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

    If cmbTipo.Text = "CUENTA CORRIENTE" Then
       VTProducto$ = "3"
    Else
       VTProducto$ = "4"
    End If
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "700" '"2583"
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, "0"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
    
    If optcom(0).Value = True Then
       PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
    ElseIf optcom(1).Value = True Then
       PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
    End If
   
   If optimp(0).Value = True Then
       PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "N"
    ElseIf optimp(1).Value = True Then
       PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "S"
    End If
    
    If optsaldo(0).Value = True Then
       PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "N"
    ElseIf optsaldo(1).Value = True Then
       PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "S"
    End If

    
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
       PMMapeaGrid sqlconn&, grdRegistros, False
       PMChequea sqlconn&
       cmbTipo.Enabled = False
       If txtCampo(0).Enabled = True Then
          txtCampo(0).SetFocus
       End If
       If grdRegistros.Tag >= 20 Then
          cmdBoton(5).Enabled = True
       Else
          cmdBoton(5).Enabled = False
       End If
    Else
       PLLimpiar
       PMLimpiaG grdRegistros
       cmdBoton(5).Enabled = False
    End If
    PLAjustaGrid grdRegistros, Me
End Sub

Private Sub PLCrear()
'*************************************************************
' PROPOSITO: Crea una nota de debto conn su causal y accion
'            respectiva
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************


    ' Validacion de mandatoriedades
    If txtCampo(0).Text = "" Then
       MsgBox "El Causal de Nota de Débito es madatorio", 0 + 16, "Mensaje de Error"
       txtCampo(0).SetFocus
       Exit Sub
    End If
    
     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "698" '"2581"
    If cmbTipo.Text = "CUENTA CORRIENTE" Then
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
      Else
        PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
    End If
     PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
    
    If optVigente(0).Value = True Then
        PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "V"
      ElseIf optVigente(1).Value = True Then
          PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "E"
        ElseIf optVigente(2).Value = True Then
            PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "S"
          Else
             MsgBox "Campo Acción es mandatorio", 0 + 16, "Mensaje de Error"
             Exit Sub
    End If
         
    If optcom(0).Value = True Then
       PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
    ElseIf optcom(1).Value = True Then
       PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
    End If
      
    If optimp(0).Value = True Then
        PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "N"
    ElseIf optimp(1).Value = True Then
        PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "S"
    End If
      
    If optsaldo(0).Value = True Then
       PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "N"
    ElseIf optsaldo(1).Value = True Then
       PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "S"
    End If


     PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
        PMChequea sqlconn&
        PLBuscar ' Refrescrar las acciones de notas de débito existentes
      Else
         PLLimpiar
    End If

End Sub

Private Sub PLEliminar()
'*************************************************************
' PROPOSITO: Permite eliminar el registro de nota de debito
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

       If txtCampo(0).Text = "" Then
            MsgBox "El Causal de Nota de Débito es madatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
       End If

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "701" '"2584"
       If cmbTipo.Text = "CUENTA CORRIENTE" Then
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "3"
         Else
             PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, "4"
       End If

        PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, (txtCampo(0).Text)
       If optVigente(0).Value = True Then
           PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "V"
         ElseIf optVigente(1).Value = True Then
             PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "E"
          ElseIf optVigente(2).Value = True Then
             PMPasoValores sqlconn&, "@i_accion", 0, SQLCHAR, "S"
           Else
              MsgBox "Campo Acción es mandatorio", 0 + 16, "Mensaje de Error"
              Exit Sub
       End If
       
       If optcom(0).Value = True Then
          PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "N"
       ElseIf optcom(1).Value = True Then
          PMPasoValores sqlconn&, "@i_comision", 0, SQLCHAR, "S"
       End If
       
       If optimp(0).Value = True Then
           PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "N"
       ElseIf optimp(1).Value = True Then
           PMPasoValores sqlconn&, "@i_impuesto", 0, SQLCHAR, "S"
       End If
       
        If optsaldo(0).Value = True Then
           PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "N"
        ElseIf optsaldo(1).Value = True Then
           PMPasoValores sqlconn&, "@i_saldomin", 0, SQLCHAR, "S"
        End If
       

        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
             PMChequea sqlconn&
            PLBuscar    'Refresca acciones de notas de débito existentes
          Else
             PLLimpiar
       End If

       txtCampo(0).Enabled = True
       txtCampo(0).Text = ""
       lblDescripcion.Caption = ""
   
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

   txtCampo(0).Enabled = True
   txtCampo(0).Text = ""
   txtCampo(0).SetFocus
   lblDescripcion.Caption = ""
   cmdBoton(3).Enabled = True
   cmdBoton(2).Enabled = False
   cmdBoton(4).Enabled = False
   If cmbTipo.Enabled = False Then
      cmbTipo.Enabled = True
   End If
   grdRegistros.Rows = 2
   grdRegistros.Cols = 2
   grdRegistros.Row = 0
   grdRegistros.Col = 1
   grdRegistros.Text = ""
   grdRegistros.Row = 1
   grdRegistros.Col = 0
   grdRegistros.Text = ""
   grdRegistros.Row = 1
   grdRegistros.Col = 1
   grdRegistros.Text = ""
   optVigente(0).Value = True
   
   optimp(0).Enabled = True
   optcom(0).Value = True
   optsaldo(1).Value = True
End Sub

Private Sub PLSiguientes()
'*************************************************************
' PROPOSITO: Llena el grid de notas de debito existentes con
'            los siguientes 20 registros retornados por el stored
'            procedure
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-02      C. Milán        Emisión Inicial
'*************************************************************

   If cmbTipo.Text = "CUENTA CORRIENTE" Then
      VTProducto$ = "3"
     Else
        VTProducto$ = "4"
   End If
   grdRegistros.Col = 2
   grdRegistros.Row = grdRegistros.Rows - 1
    PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "700" '"2583"
    PMPasoValores sqlconn&, "@i_producto", 0, SQLINT1, VTProducto$
    PMPasoValores sqlconn&, "@i_causal", 0, SQLVARCHAR, grdRegistros.Text
    If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_tr_crea_acciond", True, "Ok... Consulta de Acción de Notas de Débito") Then
       PMMapeaGrid sqlconn&, grdRegistros, True
       PMChequea sqlconn&
      If txtCampo(0).Enabled Then
        txtCampo(0).SetFocus
      End If
      If grdRegistros.Tag >= 20 Then
         cmdBoton(5).Enabled = True
        Else
           cmdBoton(5).Enabled = False
      End If
   End If
   PLAjustaGrid grdRegistros, Me
End Sub

Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0
        VLPaso% = False
    End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0
         FPrincipal!pnlHelpLine.Caption = "Causal de la Acción de Nota de Débito [F5 Ayuda]"
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)
End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)

    If Keycode% = VGTeclaAyuda% Then
        VLPaso% = True
        txtCampo(Index%) = ""
        Select Case Index%
           Case 0
              If cmbTipo.Text = "CUENTA CORRIENTE" Then
                 PMCatalogo "A", "cc_causa_nd", txtCampo(Index%), lblDescripcion
                Else
                   PMCatalogo "A", "ah_causa_nd", txtCampo(Index%), lblDescripcion
              End If
              If txtCampo(Index%).Text = "" Then
                 txtCampo(Index%).Text = ""
                 lblDescripcion.Caption = ""
              End If
        End Select
    End If

End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0
        KeyAscii% = FMVAlidaTipoDato("N", KeyAscii%)
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
    Select Case Index%
       Case 0
          If VLPaso% = False And txtCampo(Index%) <> "" Then
              If cmbTipo.Text = "CUENTA CORRIENTE" Then
                  PMCatalogo "V", "cc_causa_nd", txtCampo(Index%), lblDescripcion
                  optVigente(2).Enabled = True
              Else
                   PMCatalogo "V", "ah_causa_nd", txtCampo(Index%), lblDescripcion
                   VLPaso% = True
                   optVigente(2).Enabled = False
              End If
              If txtCampo(Index%).Text = "" Then
                 lblDescripcion.Caption = ""
              End If
          End If
    End Select
End Sub


