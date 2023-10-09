VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FBusArchAlianza 
   Caption         =   "Consulta de Archivos de Alianzas"
   ClientHeight    =   3870
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   6420
   LinkTopic       =   "Form1"
   ScaleHeight     =   3870
   ScaleWidth      =   6420
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox txtTipoId 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Left            =   660
      MaxLength       =   60
      TabIndex        =   9
      Top             =   15
      Width           =   390
   End
   Begin VB.TextBox txtCliente 
      Appearance      =   0  'Flat
      Enabled         =   0   'False
      Height          =   285
      Left            =   1065
      MaxLength       =   60
      TabIndex        =   0
      Top             =   15
      Width           =   1080
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   4
      Left            =   5475
      TabIndex        =   1
      Top             =   2290
      WhatsThisHelpID =   2003
      Width           =   870
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
      Index           =   1
      Left            =   5475
      TabIndex        =   2
      Top             =   770
      WhatsThisHelpID =   2001
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Sig&tes."
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
      Height          =   750
      Index           =   2
      Left            =   5475
      TabIndex        =   3
      Top             =   0
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
      Index           =   3
      Left            =   5475
      TabIndex        =   4
      Top             =   3060
      WhatsThisHelpID =   2008
      Width           =   870
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
   Begin MSGrid.Grid grdArchivos 
      Height          =   3440
      Left            =   0
      TabIndex        =   5
      Top             =   360
      Width           =   5400
      _Version        =   65536
      _ExtentX        =   9525
      _ExtentY        =   6068
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Small Fonts"
         Size            =   6.01
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   750
      Index           =   0
      Left            =   5475
      TabIndex        =   6
      Top             =   1530
      WhatsThisHelpID =   2002
      Width           =   870
      _Version        =   65536
      _ExtentX        =   2646
      _ExtentY        =   1323
      _StockProps     =   78
      Caption         =   "*Escoger"
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
   Begin VB.Label lblFecha 
      Alignment       =   2  'Center
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Left            =   4200
      TabIndex        =   8
      Top             =   15
      Width           =   1170
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   5430
      X2              =   5430
      Y1              =   0
      Y2              =   5265
   End
   Begin VB.Label lbletiqueta 
      Appearance      =   0  'Flat
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Cliente:"
      ForeColor       =   &H00800000&
      Height          =   285
      Index           =   0
      Left            =   60
      TabIndex        =   7
      Top             =   30
      Width           =   840
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   5430
      Y1              =   350
      Y2              =   350
   End
End
Attribute VB_Name = "FBusArchAlianza"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'*************************************************************
' ARCHIVO:          FBusArchAlianza.frm
' NOMBRE LOGICO:    FBusArchAlianza
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
' Permite realizar la Consulta de Archivos de Alianza
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 26-Mar-13      LMoreno         Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLUltLinea As Long
Dim VLSec As String
Dim VLAlt As String
Public VLExisteCliente As Boolean

Private Sub cmdBoton_Click(Index As Integer)
    Dim i%
    Select Case Index%
    Case 0 'Escoger
        PLEscoger
    Case 1 'Siguientes
        PLSiguientes
    Case 2 'Buscar
        PLBuscar
    Case 3 'Salir
        Unload FBusArchAlianza
    Case 4 'Limpiar
        PLLimpiar
    End Select
End Sub

Private Sub Form_Activate()
    PLBuscar
End Sub

Private Sub Form_Load()
    FBusCta.Left = FPrincipal.Left + 50
    FBusCta.Top = FPrincipal.Top + 1000
    FBusCta.Width = 6450
    FBusCta.Height = 4200
    PMLoadResStrings Me
    PMLoadResIcons Me
    cmdBoton(2).Enabled = True
End Sub

Private Sub grdArchivos_Click()
    grdArchivos.Col = 0
    grdArchivos.SelStartCol = 1
    grdArchivos.SelEndCol = grdArchivos.Cols - 1
    If grdArchivos.Row = 0 Then
       grdArchivos.SelStartRow = 1
       grdArchivos.SelEndRow = 1
    Else
       grdArchivos.SelStartRow = grdArchivos.Row
       grdArchivos.SelEndRow = grdArchivos.Row
    End If

End Sub

Private Sub grdArchivos_DblClick()
     PLEscoger
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

    PMLimpiaGrid grdArchivos
    'grdArchivos.ColWidth(1) = 650
    cmdBoton(0).Enabled = False
    cmdBoton(1).Enabled = False
End Sub

Private Sub PLSiguientes()
   If Trim(txtCampo.Text) = "" Then
      MsgBox "El nombre es mandatorio", 0 + 16, "Mensaje de Error"
      txtCampo.SetFocus
      Exit Sub
   End If
 
   grdArchivos.Row = grdArchivos.Rows - 1
   grdArchivos.Col = 2
   VLSecuencial$ = grdArchivos.Text
        
   If VLExisteCliente Then
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_tipo_ident", 0, SQLCHAR, txtTipoId.Text
        PMPasoValores sqlconn&, "@i_identificacion", 0, SQLCHAR, txtCliente.Text
   Else
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
   End If
   
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
   VTFecha$ = FMConvFecha((lblFecha.Caption), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
   PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, VLSecuencial$
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
      PMMapeaGrid sqlconn&, grdArchivos, True
      grdArchivos.ColWidth(3) = 0
      grdArchivos.ColWidth(4) = 0
      PMChequea sqlconn&
      If grdArchivos.Tag = 20 Then
         cmdBoton(1).Enabled = True
      Else
         cmdBoton(1).Enabled = False
      End If
   Else
      MsgBox "Error en la consulta del archivo de alizanza", vbCritical, "Error Consulta"
   End If
   
End Sub

Private Sub PLBuscar()

   If VLExisteCliente Then
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "A"
        PMPasoValores sqlconn&, "@i_tipo_ident", 0, SQLCHAR, txtTipoId.Text
        PMPasoValores sqlconn&, "@i_identificacion", 0, SQLCHAR, txtCliente.Text
   Else
        PMPasoValores sqlconn&, "@i_opcion", 0, SQLCHAR, "T"
   End If
          
   PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "702"
   PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "0"
   VTFecha$ = FMConvFecha((lblFecha.Caption), VGFormatoFecha$, CGFormatoBase$)
   PMPasoValores sqlconn&, "@i_fecha", 0, SQLDATETIME, VTFecha$
   
   If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_consulta_alianza", True, " Ok... Consulta del cliente " & "[" & txtCliente.Text & "]") Then
      PMMapeaGrid sqlconn&, grdArchivos, False
      PMChequea sqlconn&
      cmdBoton(0).Enabled = True
      If grdArchivos.Tag = 20 Then
         cmdBoton(1).Enabled = True
      Else
         cmdBoton(1).Enabled = False
      End If
   Else
      MsgBox "Error en la consulta del archivo de alizanza", vbCritical, "Error Consulta"
   End If
End Sub

Private Sub PLEscoger()
     grdArchivos.Col = 1
     If Trim$(grdArchivos.Text) = "" Or grdArchivos.Row = 0 Then
        Exit Sub
     End If
     
     If Trim$(grdArchivos.Text) <> "" Then
        VGADatosO(1) = grdArchivos.Text
     End If
     grdArchivos.Col = 2
     If Trim$(grdArchivos.Text) <> "" Then
        VGADatosO(0) = grdArchivos.Text
     End If
     grdArchivos.Col = 3
     If Trim$(grdArchivos.Text) <> "" Then
        VGADatosO(2) = grdArchivos.Text
     End If
     grdArchivos.Col = 4
     If Trim$(grdArchivos.Text) <> "" Then
        VGADatosO(3) = grdArchivos.Text
     End If
     Unload Me
End Sub

