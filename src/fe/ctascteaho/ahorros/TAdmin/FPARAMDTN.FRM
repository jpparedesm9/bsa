VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{0BA686C6-F7D3-101A-993E-0000C0EF6F5E}#1.0#0"; "Threed32.ocx"
Begin VB.Form FPARAMDTN 
   Appearance      =   0  'Flat
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Mantenimiento de Códigos DTN"
   ClientHeight    =   5865
   ClientLeft      =   870
   ClientTop       =   1335
   ClientWidth     =   9345
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
   ScaleHeight     =   5865
   ScaleWidth      =   9345
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1800
      MaxLength       =   2
      TabIndex        =   3
      Top             =   920
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   3
      TabIndex        =   2
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin MSGrid.Grid grdCodigos 
      Height          =   4200
      Left            =   0
      TabIndex        =   4
      Top             =   1635
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   7408
      _StockProps     =   77
      ForeColor       =   0
      BackColor       =   16777215
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   0
      Left            =   8430
      TabIndex        =   5
      Tag             =   "388;389"
      Top             =   15
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Buscar"
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
      Enabled         =   0   'False
      Picture         =   "FPARAMDTN.frx":0000
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   1
      Left            =   8430
      TabIndex        =   7
      Tag             =   "385"
      Top             =   1685
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Crear"
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
      Enabled         =   0   'False
      Picture         =   "FPARAMDTN.frx":1592
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   825
      Index           =   5
      Left            =   8430
      TabIndex        =   8
      Tag             =   "386"
      Top             =   2520
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1455
      _StockProps     =   78
      Caption         =   "&Actualizar"
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
      Enabled         =   0   'False
      Picture         =   "FPARAMDTN.frx":1E6C
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   2
      Left            =   8430
      TabIndex        =   9
      Tag             =   "387"
      Top             =   3355
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Eliminar"
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
      Enabled         =   0   'False
      Picture         =   "FPARAMDTN.frx":2746
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   4
      Left            =   8430
      TabIndex        =   11
      Top             =   5025
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Salir"
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
      Picture         =   "FPARAMDTN.frx":3020
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   3
      Left            =   8430
      TabIndex        =   10
      Top             =   4190
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "&Limpiar"
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
      Picture         =   "FPARAMDTN.frx":38FA
   End
   Begin Threed.SSCommand cmdBoton 
      Height          =   820
      Index           =   6
      Left            =   8430
      TabIndex        =   6
      Tag             =   "388;389"
      Top             =   850
      Width           =   920
      _Version        =   65536
      _ExtentX        =   1623
      _ExtentY        =   1446
      _StockProps     =   78
      Caption         =   "Si&guiente"
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
      Enabled         =   0   'False
      Picture         =   "FPARAMDTN.frx":41D4
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2750
      TabIndex        =   15
      Top             =   615
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Código para DTN:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   19
      Top             =   950
      Width           =   1545
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   16
      Top             =   650
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   17
      Top             =   350
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2750
      TabIndex        =   18
      Top             =   315
      Width           =   5590
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BackColor       =   &H00C0C0C0&
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2750
      TabIndex        =   13
      Top             =   15
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   14
      Top             =   50
      Width           =   810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackColor       =   &H80000005&
      BackStyle       =   0  'Transparent
      Caption         =   "Relación Códigos DTN - Productos Finales"
      ForeColor       =   &H000000FF&
      Height          =   195
      Index           =   4
      Left            =   45
      TabIndex        =   12
      Top             =   1400
      Width           =   3645
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1320
      Y2              =   1320
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   6000
   End
End
Attribute VB_Name = "FPARAMDTN"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
'FIXIT: Use Option Explicit to avoid implicitly creating variables of type Variant         FixIT90210ae-R383-H1984
'TODO: Auto-fix by Project Analyzer v9.0.05 on 15-Aug-10
'*************************************************************
' ARCHIVO:          FPARAMDTN.FRM
' NOMBRE LOGICO:    FParamDTN
' PRODUCTO:         TAdmin
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
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
'*************************************************************
Option Explicit
Dim VLPaso As Integer
Dim VLTemp(4) As String

Const MB_YESNO = 4
Const MB_ICONQUESTION = 32
Const IDYES = 6
Const MB_DEFBUTTON1 = 0
Const IDNO = 7
Const IDCANCEL = 2
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
Dim DgDef As Integer
Dim Response As Integer



Private Sub cmdBoton_Click(Index As Integer)

DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEFBUTTON1
    
    Select Case Index%
    Case 0 'Buscar
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
         
        If txtCampo(3).Text <> "" And txtCampo(1).Text <> "" And txtCampo(2).Text <> "" Then
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "389"
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "Q"
           PMPasoValores sqlconn&, "@i_codigo_dtn", 0, SQLCHAR, txtCampo(3).Text
           PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
           PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
        Else
           PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "388"
           PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
           If txtCampo(1).Text <> "" Then
               PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
           End If
           
           If txtCampo(2).Text <> "" Then
               PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
           End If
        End If
        PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text
         
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_parametro_dtn", True, " Ok... Consulta de Códigos DTN") Then
            PMMapeaGrid sqlconn&, grdCodigos, False
            PMChequea sqlconn&
            PLSeteaCabeceras
            grdCodigos.Row = grdCodigos.Rows - 1
            grdCodigos.Col = 1
            If grdCodigos.Rows <= 2 And grdCodigos.Text = "" Then
                MsgBox "No existen registros para la consulta dada", 0 + 16, "Mensaje de Error"
                Exit Sub
            Else
                If grdCodigos.Rows >= 20 Then
                    cmdBoton(6).Enabled = True
                End If
            End If
        End If
        PLModoInsertar True
        
    Case 6 'Siguientes
            
            grdCodigos.Row = grdCodigos.Rows - 1
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "388"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
            grdCodigos.Col = 6
            PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT4, grdCodigos.Text
            grdCodigos.Col = 2
            PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, CStr(grdCodigos.Row + 1)
            
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_parametro_dtn", True, " Ok... Consulta de Códigos DTN") Then
                PMMapeaGrid sqlconn&, grdCodigos, True
                PMChequea sqlconn&
                If grdCodigos.Rows Mod 20 <> 0 Then
                    cmdBoton(6).Enabled = False
                End If
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
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(3).Text) = "" Then
            MsgBox "El código DTN es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "385"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_codigo_dtn", 0, SQLCHAR, txtCampo(3).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_parametro_dtn", True, " Ok... Creación de Código DTN por Categoría y Producto Final") Then
            PMChequea sqlconn&
            cmdBoton_Click (0)
            PLLimpiar
        End If
    
    Case 2 'Eliminar
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
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(3).Text) = "" Then
            MsgBox "El código DTN es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        Response = MsgBox("Desea eliminar el registro seleccionado?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "387"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
            PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
            PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, VLTemp(1) 'txtCampo(1).Text
            PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, VLTemp(2) 'txtCampo(2).Text
            PMPasoValores sqlconn&, "@i_codigo_dtn", 0, SQLCHAR, VLTemp(3) 'txtCampo(3).Text
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_parametro_dtn", True, " Ok... Eliminación de Código por Categoría y Producto Final") Then
                PMChequea sqlconn&
                PLLimpiar
                PMLimpiaGrid grdCodigos
                'cmdBoton_Click (0)
            End If
        Else
            Exit Sub
        End If

    Case 3 'Limpiar
        PLLimpiar
        PMLimpiaGrid grdCodigos
        txtCampo(0).SetFocus
         
    Case 4 'Salir
        Unload FPARAMDTN
    
    Case 5 'Actualizar

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
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "El código de la categoría es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(3).Text) = "" Then
            MsgBox "El código DTN es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "386"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, VLTemp(1) 'txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, VLTemp(2) 'txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_codigo_dtn", 0, SQLCHAR, VLTemp(3) 'txtCampo(3).Text
         PMPasoValores sqlconn&, "@i_codigo_dtn_new", 0, SQLCHAR, txtCampo(3).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_ahorros", "sp_parametro_dtn", True, " Ok... Actualización de Código por Categoría y Producto Final") Then
             PMChequea sqlconn&
            cmdBoton_Click (0)
            PLLimpiar
        End If
    End Select
End Sub

Private Sub Form_Load()

'************************************************************
'Objetivo:  Carga la forma que se encargara del mantenimiento
'           de codigos DTN por productos finales y categoria
'************************************************************
'                    MODIFICACIONES
'FECHA      AUTOR               RAZON
'************************************************************

 ' Coordenadas para el despliegue de la forma
 FPARAMDTN.Left = 0
 FPARAMDTN.Top = 0
 FPARAMDTN.Width = 9440
 FPARAMDTN.Height = 6240

 PMLoadResStrings Me
 PMLoadResIcons Me
 PLModoInsertar True
 PMBotonSeguridad FPARAMDTN, 5
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(1)
 PMObjetoSeguridad cmdBoton(2)
 PMObjetoSeguridad cmdBoton(5)
 cmdBoton(6).Enabled = False
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal!pnlHelpLine.Caption = ""
    FPrincipal!pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCodigos_Click()
    
    grdCodigos.Col = 0
    grdCodigos.SelStartCol = 1
    grdCodigos.SelEndCol = grdCodigos.Cols - 1
    If grdCodigos.Row = 0 Then
        grdCodigos.SelStartRow = 1
        grdCodigos.SelEndRow = 1
    Else
        grdCodigos.SelStartRow = grdCodigos.Row
        grdCodigos.SelEndRow = grdCodigos.Row
    End If

End Sub

Private Sub grdCodigos_DblClick()

    Dim VTRow As Integer
    VTRow% = grdCodigos.Row
    grdCodigos.Row = 1
    grdCodigos.Col = 1

    If Trim$(grdCodigos.Text) <> "" Then
        grdCodigos.Row = VTRow%
        PLEscoger
        
        PLModoInsertar False
    End If

End Sub

Private Sub grdCodigos_GotFocus()
    FPrincipal!pnlHelpLine.Caption = " Relación Códigos DTN- Productos Finales "
End Sub

Private Sub PLSeteaCabeceras()

grdCodigos.ColWidth(1) = 1000
grdCodigos.ColWidth(2) = 1000
grdCodigos.ColWidth(3) = 2000
grdCodigos.ColWidth(4) = 1000
grdCodigos.ColWidth(5) = 2000
grdCodigos.ColWidth(6) = 1000
        
grdCodigos.Row = 0
grdCodigos.Col = 1
grdCodigos.Text = "Código DTN"
grdCodigos.Col = 2
grdCodigos.Text = "Cód. Prod."
grdCodigos.Col = 3
grdCodigos.Text = "Producto Final"
grdCodigos.Col = 4
grdCodigos.Text = "Cód. Categ."
grdCodigos.Col = 5
grdCodigos.Text = "Categoría"
grdCodigos.Col = 6
grdCodigos.Text = "Sucursal"
grdCodigos.FixedAlignment(1) = 2
grdCodigos.ColAlignment(1) = 2
grdCodigos.FixedAlignment(2) = 2
grdCodigos.ColAlignment(2) = 2
grdCodigos.FixedAlignment(3) = 2
'grdCodigos.ColAlignment(3) = 2
grdCodigos.FixedAlignment(4) = 2
grdCodigos.ColAlignment(4) = 2
grdCodigos.FixedAlignment(5) = 2
'grdCodigos.ColAlignment(5) = 2
grdCodigos.FixedAlignment(6) = 2
grdCodigos.ColAlignment(6) = 2
grdCodigos.Refresh

End Sub

Private Sub PLLimpiar()

 txtCampo(0).Text = ""
 lblDescripcion(0).Caption = ""
 txtCampo(1).Text = ""
 lblDescripcion(1).Caption = ""
 txtCampo(2).Text = ""
 lblDescripcion(2).Caption = ""
 txtCampo(3).Text = ""
 PLModoInsertar True

End Sub

Private Sub PLModoInsertar(modo As Integer)
'*************************************************************
' PROPOSITO: Habilita o deshabilita ciertos objetos de la
'            forma.
' INPUT    : Modo = Entero que indica si el campo se habilita
'                   o no.
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
'*************************************************************
    txtCampo(0).Enabled = modo 'Sucursal
    txtCampo(1).Enabled = modo 'Producto final
    txtCampo(2).Enabled = modo 'Categoría
    
    If modo Then
         PMObjetoSeguridad cmdBoton(1)
         cmdBoton(2).Enabled = Not modo 'Eliminar
         cmdBoton(5).Enabled = Not modo 'Actualizar
    Else
         cmdBoton(1).Enabled = modo 'Crear
         PMObjetoSeguridad cmdBoton(2)
         PMObjetoSeguridad cmdBoton(5)
    End If
    
End Sub

Private Sub PLEscoger()
'*************************************************************
' PROPOSITO: Captura los valores respectivos del grid,
'            y los coloca en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
'*************************************************************
    
    grdCodigos.Col = 6
    txtCampo(0).Text = grdCodigos.Text
    VLTemp(0) = grdCodigos.Text
    txtCampo_LostFocus 0
            
    grdCodigos.Col = 2
    txtCampo(1).Text = grdCodigos.Text
    VLTemp(1) = grdCodigos.Text
    txtCampo_LostFocus 1
    
    grdCodigos.Col = 4
    txtCampo(2).Text = grdCodigos.Text
    VLTemp(2) = grdCodigos.Text
    txtCampo_LostFocus 2
    
    grdCodigos.Col = 1
    txtCampo(3).Text = grdCodigos.Text
    VLTemp(3) = grdCodigos.Text
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1, 2
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal!pnlHelpLine.Caption = " Código de Sucursal [F5] Ayuda"
    Case 1
       FPrincipal!pnlHelpLine.Caption = " Código del Producto Final [F5] Ayuda"
    Case 2
       FPrincipal!pnlHelpLine.Caption = " Código de la Categoría [F5] Ayuda"
    Case 3
       FPrincipal!pnlHelpLine.Caption = " Código para DTN"
    End Select

    ' Resalta el contenido del objeto
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, Keycode As Integer, Shift As Integer)
Dim VTProFinal As String
If Keycode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    Case 0
        VGOperacion$ = "sp_hp_sucursal"
        txtCampo(0).Text = ""
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
        If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
            PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
            PMChequea sqlconn&
            FRegistros.Show 1
            If Val(FRegistros!grdRegistros.Tag) = VGMaxRows% Then
                FRegistros!cmdSiguientes.Enabled = True
            Else
                FRegistros!cmdSiguientes.Enabled = False
            End If
            txtCampo(0).Text = VGACatalogo.Codigo$
            lblDescripcion(0).Caption = VGACatalogo.Descripcion$
        Else
           PMChequea sqlconn&
           txtCampo(0).Text = ""
           lblDescripcion(0).Caption = ""
           txtCampo(0).SetFocus
        End If
        
    Case 1
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin3"
        txtCampo(1).Text = ""
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
        PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
        PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, VTProFinal$

        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, "Ok... Consulta de Productos") Then
           PMMapeaGrid sqlconn&, FRegistros!grdRegistros, False
           PMChequea sqlconn&
           FRegistros.Show 1
           If Val(FRegistros!grdRegistros.Tag) = VGMaxRows% Then
               FRegistros!cmdSiguientes.Enabled = True
           Else
               FRegistros!cmdSiguientes.Enabled = False
           End If
           txtCampo(1).Text = VGACatalogo.Codigo$
           lblDescripcion(1).Caption = VGACatalogo.Descripcion$
        Else
           PMChequea sqlconn&
           txtCampo(1).Text = ""
           lblDescripcion(1).Caption = ""
           txtCampo(1).SetFocus
        End If
        PMChequea sqlconn&

    Case 2
        PMCatalogo "A", "pe_categoria", txtCampo(2), lblDescripcion(2)
    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 0, 1, 3
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii% = 0
        End If
    Case 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = Asc(UCase$(Chr$(KeyAscii%)))
        End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR As Integer
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
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
        End If
        
    Case 1
        If Trim$(txtCampo(1).Text) = "" Then
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            lblDescripcion(0).Caption = ""
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
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            txtCampo(1).SetFocus
        End If
        
    Case 2
        If Trim$(txtCampo(2).Text) = "" Then
            lblDescripcion(2).Caption = ""
            Exit Sub
        End If

        PMCatalogo "V", "pe_categoria", txtCampo(2), lblDescripcion(2)

        If Trim$(txtCampo(2).Text) = "" And Trim$(lblDescripcion(2).Caption) = "" Then
            txtCampo(2).SetFocus
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

