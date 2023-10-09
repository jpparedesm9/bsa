VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Object = "{F856EC8B-F03C-4515-BDC6-64CBD617566A}#6.0#0"; "fpSpr60.ocx"
Begin VB.Form FconVarCosto 
   Appearance      =   0  'Flat
   Caption         =   "Consulta histórica de costos y tasas"
   ClientHeight    =   5325
   ClientLeft      =   1335
   ClientTop       =   1530
   ClientWidth     =   9315
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
   Icon            =   "FCONVARC.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9315
   Tag             =   "3008"
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   4
      Left            =   2220
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   2
      Top             =   615
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   1
      Top             =   315
      Width           =   930
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   2220
      MaxLength       =   3
      TabIndex        =   3
      Top             =   1215
      Width           =   930
   End
   Begin MSGrid.Grid grdtasasold 
      Height          =   570
      Left            =   8640
      TabIndex        =   4
      Top             =   1680
      Visible         =   0   'False
      Width           =   660
      _Version        =   65536
      _ExtentX        =   1164
      _ExtentY        =   1005
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
      Caption         =   "Sig&tes."
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
      Height          =   735
      Index           =   3
      Left            =   8415
      Picture         =   "FCONVARC.frx":030A
      Style           =   1  'Graphical
      TabIndex        =   27
      Tag             =   "4086"
      Top             =   825
      Width           =   870
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
      Index           =   0
      Left            =   8415
      Picture         =   "FCONVARC.frx":053C
      Style           =   1  'Graphical
      TabIndex        =   28
      Tag             =   "4086"
      Top             =   45
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
      Height          =   735
      Index           =   2
      Left            =   8415
      Picture         =   "FCONVARC.frx":079E
      Style           =   1  'Graphical
      TabIndex        =   29
      Top             =   4575
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
      Height          =   735
      Index           =   1
      Left            =   8415
      Picture         =   "FCONVARC.frx":0B04
      Style           =   1  'Graphical
      TabIndex        =   30
      Top             =   3825
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Imprimir"
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
      Left            =   8415
      Picture         =   "FCONVARC.frx":0E6A
      Style           =   1  'Graphical
      TabIndex        =   26
      Tag             =   "4119"
      Top             =   3045
      Width           =   870
   End
   Begin FPSpreadADO.fpSpread grdtasas 
      Height          =   3375
      Left            =   0
      TabIndex        =   31
      Top             =   1920
      Width           =   8295
      _Version        =   393216
      _ExtentX        =   14631
      _ExtentY        =   5953
      _StockProps     =   64
      BackColorStyle  =   1
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Tahoma"
         Size            =   6.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      MaxCols         =   11
      MaxRows         =   0
      RetainSelBlock  =   0   'False
      SpreadDesigner  =   "FCONVARC.frx":11D0
      VisibleCols     =   11
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Código Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   10
      Left            =   45
      TabIndex        =   25
      Top             =   15
      Width           =   1455
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   12
      Left            =   3165
      TabIndex        =   24
      Top             =   15
      Width           =   5190
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   150
      TabIndex        =   8
      Top             =   3765
      Width           =   840
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Moneda:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   165
      TabIndex        =   10
      Top             =   3435
      Width           =   750
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   45
      TabIndex        =   11
      Top             =   4620
      Width           =   1545
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   3060
      TabIndex        =   15
      Top             =   4515
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   4
      Left            =   3120
      TabIndex        =   16
      Top             =   3990
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   6
      Left            =   2160
      TabIndex        =   18
      Top             =   4500
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   7
      Left            =   2160
      TabIndex        =   19
      Top             =   3495
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   8
      Left            =   3090
      TabIndex        =   20
      Top             =   3570
      Width           =   5175
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   10
      Left            =   2070
      TabIndex        =   22
      Top             =   3825
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   11
      Left            =   2220
      TabIndex        =   23
      Top             =   915
      Width           =   930
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   9
      Left            =   3165
      TabIndex        =   21
      Top             =   1215
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   5
      Left            =   3165
      TabIndex        =   17
      Top             =   915
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   3165
      TabIndex        =   14
      Top             =   600
      Width           =   5190
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   3165
      TabIndex        =   13
      Top             =   315
      Width           =   5190
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Lista de Servicios Personalizables"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   8
      Left            =   60
      TabIndex        =   5
      Top             =   1620
      Width           =   2940
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   45
      TabIndex        =   12
      Top             =   315
      Width           =   1305
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Rubro del Servicio:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   45
      TabIndex        =   6
      Top             =   915
      Width           =   1650
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Servicio Disponible:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   45
      TabIndex        =   7
      Top             =   615
      Width           =   1710
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Tipo de Rango:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   45
      TabIndex        =   9
      Top             =   1215
      Width           =   1335
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   2
      X1              =   0
      X2              =   8370
      Y1              =   1560
      Y2              =   1560
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
Attribute VB_Name = "FconVarCosto"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FCONVARC.FRM
' NOMBRE LOGICO:    FConVarCosto
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
' Permite la consulta histórica de costos y tasas.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 26-Ene-95      Angela Rodríguez    Emisión Inicial
'*************************************************************
Dim VLPaso As Integer
'! removed Dim VLProducto As String

Dim VLMoneda As String
Dim VLPosGrid As Long           'Fila marcada del grid


Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const MB_DEFBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    '! removed Const IDNO = 7
'! removed Const IDYES = 6

    '! removed Dim Response
'FIXIT: Declare 'DgDef' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim i%
    Dim VTi As Integer
     DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
    
    Select Case Index%
    Case 0    'Buscar
        If txtCampo(4).Text = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(4).SetFocus
            Exit Sub
        End If

        If txtCampo(2).Text = "" Then
            MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        If txtCampo(0).Text = "" Then
            MsgBox "El código del servicio disponible  es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4086"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "0"
         PMPasoValores sqlconn&, "@i_servicio_disp", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(11).Caption
         PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, "0"
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, "0"
         PMPasoValores sqlconn&, "@i_desde", 0, SQLMONEY, "0"
         
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_var_costos", True, "Ok...Consulta historica de tasas") Then
             PMMapeaGrid sqlconn&, grdtasas, False
             PMChequea sqlconn&
             cmdBoton(4).Enabled = True
      '       cmdBoton(0).Enabled = False
             'grdtasas.ColWidth(1) = 20
             'grdtasas.AL.ColAlignment(1) = 2
             For i% = 1 To 6
                 grdtasas.ColWidth(i) = 12
                 'grdtasas.ColAlignment(i) = 1
             Next i%
             'For i% = 4 To 6
              '   grdtasas.ColWidth(i) = 20
                 'grdtasas.ColAlignment(i) = 2
             'Next i%
             grdtasas.ColWidth(7) = 20
             'grdtasas.ColAlignment(7) = 0
             grdtasas.ColWidth(9) = 0
             
            For VTi = 1 To grdtasas.MaxRows
                grdtasas.RowHeight(VTi) = 8.59
            Next VTi
             
             'cambiar fila activa
                grdtasas.Col = 1
                If grdtasas.Tag = "" Then
                    grdtasas.Tag = 0
                End If
                VLPosGrid& = grdtasas.MaxRows - Val(grdtasas.Tag) + 1
                grdtasas.Row = VLPosGrid&
                grdtasas.TopRow = grdtasas.Row
                grdtasas.Action = 0
                'Marcar fila seleccionada
                PMMarcaFilaGrid grdtasas, VLPosGrid&
                PMBloqueaGrid grdtasas
        Else
            cmdBoton_Click (1)
        End If
        FPrincipal.pnlHelpLine.Caption = ""
        If Val(grdtasas.Tag) = VGMaxRows% Then
            cmdBoton(3).Enabled = True
        Else
            cmdBoton(3).Enabled = False
        End If


    Case 1 'Limpiar
        If txtCampo(0).Text <> "" Then

            txtCampo(1).Text = ""
            txtCampo(1).Enabled = True
            lblDescripcion(9).Caption = ""
            
            txtCampo(0).Text = ""
            txtCampo(0).Enabled = True
            lblDescripcion(1).Caption = ""
            lblDescripcion(5).Caption = ""
            lblDescripcion(11).Caption = ""

            txtCampo(0).SetFocus
        Else
            If txtCampo(2).Text <> "" Then
                txtCampo(2).Text = ""
                lblDescripcion(0).Caption = ""
                txtCampo(2).Enabled = True
                'PMLimpiaGrid grdtasas
                PMBorrarGrid grdtasas
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                txtCampo(2).SetFocus
            Else
                txtCampo(4).Text = ""
                lblDescripcion(0).Caption = ""
                lblDescripcion(1).Caption = ""
                lblDescripcion(5).Caption = ""
                lblDescripcion(9).Caption = ""
                lblDescripcion(11).Caption = ""
                lblDescripcion(12).Caption = ""
                txtCampo(4).Enabled = True
                'PMLimpiaGrid grdtasas
                PMBorrarGrid grdtasas
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
                txtCampo(4).SetFocus
            End If
        End If
        FPrincipal.pnlHelpLine.Caption = ""
        FPrincipal.pnlTransaccionLine.Caption = ""
        cmdBoton(0).Enabled = True
        cmdBoton(3).Enabled = False
        cmdBoton(4).Enabled = False
    Case 2 'Salir
        
        Unload FconVarCosto
        Unload FAyudaProdFinal
        Unload FAyudaSubserv
    
    Case 3  'Siguientes
         grdtasas.Row = grdtasas.MaxRows
         'PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4013"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4086"
         PMPasoValores sqlconn&, "@i_modo", 0, SQLINT2, "1"
         PMPasoValores sqlconn&, "@i_servicio_disp", 0, SQLINT2, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT4, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_rubro", 0, SQLCHAR, lblDescripcion(11).Caption
         grdtasas.Col = 9
         PMPasoValores sqlconn&, "@i_secuencial", 0, SQLINT4, grdtasas.Text
         grdtasas.Col = 7
         PMPasoValores sqlconn&, "@i_tipo_rango", 0, SQLINT1, grdtasas.Text
         grdtasas.Col = 2
         PMPasoValores sqlconn&, "@i_desde", 0, SQLMONEY, grdtasas.Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_cons_var_costos", True, "Ok...Consulta historica de tasas") Then
            PMMapeaGrid sqlconn&, grdtasas, True
            PMChequea sqlconn&
           
            If Val(grdtasas.Tag) = VGMaxRows% Then
                cmdBoton(3).Enabled = True
            Else
                cmdBoton(3).Enabled = False
            End If
                        For VTi = 1 To grdtasas.MaxRows
                grdtasas.RowHeight(VTi) = 8.59
            Next VTi
             
             'cambiar fila activa
                grdtasas.Col = 1
                If grdtasas.Tag = "" Then
                    grdtasas.Tag = 0
                End If
                VLPosGrid& = grdtasas.MaxRows - Val(grdtasas.Tag) + 1
                grdtasas.Row = VLPosGrid&
                grdtasas.TopRow = grdtasas.Row
                grdtasas.Action = 0
                'Marcar fila seleccionada
                PMMarcaFilaGrid grdtasas, VLPosGrid&
                PMBloqueaGrid grdtasas

        End If
    Case 4  'Imprimir
        PLConfigurarImpresion
End Select
End Sub

Private Sub Form_Load()
    FconVarCosto.Left = 0    '15
    FconVarCosto.Top = 0    '15
    FconVarCosto.Width = 9450   '9420
    FconVarCosto.Height = 5900   '5730
    PMLoadResStrings Me
    PMLoadResIcons Me
'    cmdBoton(0).Enabled = True
    'txtCampo(4).Text = VGOficina$
    'Inicialización de variables
    VLPosGrid& = -1
    
    'PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078" '"4079"
    'PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
    'PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT1, VGOficina$
    'PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V" '"A"
    'If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
    '     PMMapeaObjeto sqlconn&, lblDescripcion(12)
    '     PMChequea sqlconn&
    'End If
'cmdBoton(4).Enabled = False

 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(3)
 PMObjetoSeguridad cmdBoton(4)
 
FPrincipal.pnlHelpLine.Caption = "FconVarCosto - Version VSS 3"

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

'Private Sub grdtasas_Click()
'
'    grdtasas.Col = 0
'    grdtasas.SelStartCol = 1
'    grdtasas.SelEndCol = grdtasas.Cols - 1
'    If grdtasas.Row = 0 Then
'        grdtasas.SelStartRow = 1
'        grdtasas.SelEndRow = 1
'    Else
'        grdtasas.SelStartRow = grdtasas.Row
'        grdtasas.SelEndRow = grdtasas.Row
'    End If
'End Sub
'
'Private Sub grdtasas_DblClick()
'    VTRow% = grdtasas.Row
'    grdtasas.Row = 1
'    grdtasas.Col = 1
'
'    If grdtasas.Text <> "" Then
'        grdtasas.Row = VTRow%
'        PMMarcarRubro
'    End If
'End Sub

Private Sub grdtasas_GotFocus()
FPrincipal.pnlHelpLine.Caption = " Haga Doble Click para Eliminar/Actualizar Límites"
End Sub

'! 'Private Sub grdtasas_KeyUp(KeyCode As Integer, Shift As Integer)
'! '    grdtasas.Col = 0
'! '    grdtasas.SelStartCol = 1
'! '    grdtasas.SelEndCol = grdtasas.Cols - 1
'! '    If grdtasas.Row = 0 Then
'! '        grdtasas.SelStartRow = 1
'! '        grdtasas.SelEndRow = 1
'! '    Else
'! '        grdtasas.SelStartRow = grdtasas.Row
'! '        grdtasas.SelEndRow = grdtasas.Row
'! '    End If
'! '
'! 'End Sub
'!
'! Private Sub PMMarcarRubro()
'! '*************************************************************
'! ' PROPOSITO: Captura los valores respectivos del grid,
'! '            y los almacena en ciertos campos de la forma.
'! ' INPUT    : Ninguno
'! ' OUTPUT   : Ninguno
'! '*************************************************************
'! '                       MODIFICACIONES
'! ' FECHA          AUTOR           RAZON
'! ' 27-Ene-94      A.Rodríguez     Emisión Inicial
'! '*************************************************************
'!     cmdBoton(0).Enabled = False
'!     grdtasas.Col = 1
'!
'!     txtCampo(4).Enabled = False
'!
'!     grdtasas.Col = 7  'tipo rango cod
'!     txtCampo(1).Text = grdtasas.Text
'!     txtCampo(1).Enabled = False
'!     grdtasas.Col = 8  'tipo rango des
'!     lblDescripcion(9).Caption = grdtasas.Text
'! End Sub
'!
'! Private Sub PMProducto()
'! '*************************************************************
'! ' PROPOSITO: Llena ciertos campos de la forma con los valores
'! '            almacenados en un arreglo.
'! ' INPUT    : Ninguno
'! ' OUTPUT   : Ninguno
'! '*************************************************************
'! '                       MODIFICACIONES
'! ' FECHA          AUTOR           RAZON
'! ' 27-Ene-94      A.Rodríguez     Emisión Inicial
'! '*************************************************************
'!     If VGProd$ = "R" Then
'!         If VGProducto(0) = "P" Then
'!             If txtCampo(2).Text = "" Then
'!
'!                 txtCampo(2).Text = VGProducto(2) 'cod prod final
'!                 lblDescripcion(0).Caption = VGProducto(1)
'!                 lblDescripcion(6).Caption = VGProducto(4)  'producto cobis
'!                 lblDescripcion(4).Caption = VGProducto(5)
'!                 lblDescripcion(7).Caption = VGProducto(6) 'cod mon
'!                 lblDescripcion(8).Caption = VGProducto(7) ' des moneda
'!                 lblDescripcion(10).Caption = VGProducto(8) ' tipo produ cod
'!                 If lblDescripcion(10).Caption = "R" Then
'!                     lblDescripcion(2).Caption = "REGIONAL"
'!                 End If
'!
'!             Else
'!                 lblDescripcion(0).Caption = VGProducto(1) 'Descripcion de Producto Final
'!                 lblDescripcion(6).Caption = VGProducto(2)  'cod producto cobis
'!                 lblDescripcion(4).Caption = VGProducto(3) 'des producto cobis
'!                 lblDescripcion(7).Caption = VGProducto(4) 'cod mon
'!                 lblDescripcion(8).Caption = VGProducto(5) ' des moneda
'!                 lblDescripcion(10).Caption = VGProducto(6) ' tipo produ cod
'!                 If lblDescripcion(10).Caption = "R" Then
'!                     lblDescripcion(2).Caption = "REGIONAL"
'!                 End If
'!             End If
'!         End If
'!     End If
'! End Sub
'!
'! Private Sub PMSubserv()
'! '*************************************************************
'! ' PROPOSITO: Llena ciertos campos de la forma con los valores
'! '            almacenados en un arreglo.
'! ' INPUT    : Ninguno
'! ' OUTPUT   : Ninguno
'! '*************************************************************
'! '                       MODIFICACIONES
'! ' FECHA          AUTOR           RAZON
'! ' 27-Ene-94      A.Rodríguez     Emisión Inicial
'! '*************************************************************
'!     If VGDetalle(0) = "S" Then
'!         If txtCampo(0).Text = "" Then
'!
'!             lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
'!             lblDescripcion(5).Caption = VGDetalle(2) 'des rubro
'!             txtCampo(0).Text = VGDetalle(3) 'cod serv dis
'!             lblDescripcion(11).Caption = VGDetalle(4) 'cod rubro
'!
'!         Else
'!
'!             lblDescripcion(1).Caption = VGDetalle(1) 'des serv dis
'!             lblDescripcion(5).Caption = VGDetalle(2) 'des rubro
'!             lblDescripcion(11).Caption = VGDetalle(3) 'cod rubro
'!
'!         End If
'!     End If
'! End Sub
'!
Private Sub txtCampo_Change(Index As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4
        VLPaso% = False
    End Select

End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Servicio Disponible [F5 Ayuda]"
    
    Case 1
        FPrincipal.pnlHelpLine.Caption = " Tipo de rango [F5 Ayuda]"
    
    Case 2
        FPrincipal.pnlHelpLine.Caption = " Producto Final [F5 Ayuda]"
    Case 3
        FPrincipal.pnlHelpLine.Caption = " Grupo de Rango [F5 Ayuda]"
    Case 4
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    
    End Select
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTCodigo$
Dim VTMoneda$
Dim VTProFinal$
Dim VTGrupo$
Dim VTRango$
    If KeyCode% = VGTeclaAyuda% Then
        VLPaso% = True
        Select Case Index%
            
        Case 0
            
            If txtCampo(2).Text = "" Then
                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
            'FAyudaSubserv.Show 1
            'If VGDetalle(1) <> "" Then
            '    PMSubserv
            '    VLPaso% = True
            'End If
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
             PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VLMoneda
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                 Load FCatalogoServ
                 PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
                 PMChequea sqlconn&
                VGOperacion$ = "FCONVAR2-1"
                FCatalogoServ.Show 1
            End If

        
        Case 1
            If txtCampo(2).Text = "" Then
                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
            VLPaso% = True
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "T"
            VTFilas% = VGMaxRows%
            VTCodigo$ = "0"
            VTMoneda$ = VLMoneda
            Load FRegistros
            While VTFilas% = VGMaxRows%
                    
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, VTCodigo$
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VTMoneda$
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTCodigo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTCodigo$ = FRegistros.grdRegistros.Text
                 
                    FRegistros.grdRegistros.Col = 3
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTMoneda$ = FRegistros.grdRegistros.Text
                    
                Else
                   VGOperacion$ = ""
                   VGTipo$ = ""
                End If

            Wend
            FRegistros.grdRegistros.Row = 1
                FRegistros.Show 1
                If VGValores(1) <> "" Then
                    txtCampo(1).Text = VGValores(1)
                    lblDescripcion(9).Caption = VGValores(2)
                    VLPaso% = True
                End If
        Case 2
            If txtCampo(4).Text = "" Then
                MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(4).SetFocus
                Exit Sub
            End If
    
            VTFilas% = VGMaxRows%
            VTProFinal$ = "0"
            VGOperacion$ = "sp_prodfin2"
            Load FRegistros
            While VTFilas% = VGMaxRows%
                  PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
                  PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
                  PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                  PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
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
                    lblDescripcion(0).Caption = ""
                    VGOperacion$ = ""
                 End If
            Wend

            FRegistros.grdRegistros.Row = 1
            
                FRegistros.Show 1
            
                 ' PMChequea SqlConn&
                If VGValores(1) <> "" Then
                    txtCampo(2).Text = VGValores(1)
                    lblDescripcion(0).Caption = VGValores(2)
                    VLMoneda$ = VGValores(3)
                    VLPaso% = True
                Else
                    txtCampo(2).Text = ""
                    lblDescripcion(0).Caption = ""
                    
                    'PMLimpiaGrid grdtasas
                    PMBorrarGrid grdtasas
                    cmdBoton(0).Enabled = True
                    cmdBoton(3).Enabled = False
                    VLMoneda$ = ""
                    VGOperacion$ = ""
                End If
                 
        Case 3 'Grupo
            If txtCampo(1).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
            VGOperacion$ = "sp_help_rango_pe"
            VGTipo$ = "G"
            VTFilas% = VGMaxRows%
            VTGrupo$ = "0"
            VTRango$ = "0"
            Load FRegistros
            While VTFilas% = VGMaxRows%
                    
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
                 PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, VTGrupo$
                 PMPasoValores sqlconn&, "@i_rango", 0, SQLINT2, VTRango$
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Rangos") Then
                    If VTGrupo$ = "0" Then
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                    Else
                         PMMapeaGrid sqlconn&, FRegistros.grdRegistros, True
                    End If
                     PMChequea sqlconn&
                    VTFilas% = Val(FRegistros.grdRegistros.Tag)

                    FRegistros.grdRegistros.Col = 1
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTGrupo$ = FRegistros.grdRegistros.Text
                 
                    FRegistros.grdRegistros.Col = 2
                    FRegistros.grdRegistros.Row = FRegistros.grdRegistros.Rows - 1
                    VTRango$ = FRegistros.grdRegistros.Text
                    
                Else
                   VGOperacion$ = ""
                   VGTipo$ = ""

                End If

            Wend
            FRegistros.grdRegistros.Row = 1
            
                FRegistros.Show 1
                If VGACatalogo.Codigo$ <> "" Then
                    txtCampo(3).Text = VGACatalogo.Codigo$
                    VLPaso% = True
                End If
        Case 4
                VGOperacion$ = "sp_hp_sucursal"
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
                 'If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_hp_sucursal", True, " Consulta del producto ") Then
                    Load FRegistros
                     PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
                     PMChequea sqlconn&
                    FRegistros.Show 1
                    ' PMChequea SqlConn&
                    If VGValores(1) <> "" Then
                        txtCampo(4).Text = VGValores(1)
                        lblDescripcion(12).Caption = VGValores(2)
                    Else
                        txtCampo(4).Text = ""
                        lblDescripcion(12).Caption = ""
                        'PMLimpiaGrid grdtasas
                        PMBorrarGrid grdtasas
                        cmdBoton(0).Enabled = True
                        cmdBoton(3).Enabled = False
                        VGOperacion$ = ""
                    End If
                     
                    VLPaso% = True
                Else
                    txtCampo(4).Text = ""
                    lblDescripcion(12).Caption = ""
                    VGOperacion$ = ""
                End If

        End Select
    End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
    Select Case Index%
    Case 0, 1, 2, 3, 4
    If (KeyAscii% <> 8) And ((KeyAscii% < 48) Or (KeyAscii% > 57)) Then
            KeyAscii% = 0
    End If
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
    Select Case Index%
    Case 0
        'If VLPaso% = False Then
        '    If txtCampo(0).Text <> "" Then
        '       'VLPaso% = True
        '       FAyudaSubserv.Show 1
        '       If VGDetalle(1) <> "" Then
        '            PMSubserv
        '       Else
        '            If lblDescripcion(1).Caption = "" Then
        '                txtCampo(0).Text = ""
        '                VLPaso% = True
        '            End If
        '       End If
        '    End If
        'End If

        If VLPaso% = False Then
            If txtCampo(0).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4069"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H2"
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, "0"
                 PMPasoValores sqlconn&, "@i_servicio", 0, SQLINT2, (txtCampo(0).Text)
                 PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VLMoneda
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_contrato_servicios", True, "Creación de Valor Contratado") Then
                     Load FCatalogoServ
                     PMMapeaGrid sqlconn&, FCatalogoServ.grdRegistros, False
                     PMChequea sqlconn&
                    VGOperacion$ = "FCONVAR2-2"
                    FCatalogoServ.Show 1
                    'If txtCampo(0).Text <> "" Then
                    '    txtCampo(0).Enabled = False
                    'End If
                End If
            Else
                lblDescripcion(1).Caption = ""
                lblDescripcion(11).Caption = ""
                lblDescripcion(5).Caption = ""
            End If
        End If

    
    Case 1
        If VLPaso% = False Then
        If txtCampo(1).Text <> "" Then
            If txtCampo(2).Text = "" Then
                MsgBox "El código del producto final es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).Text = ""
                txtCampo(2).SetFocus
                Exit Sub
            End If
            
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_moneda", 0, SQLINT1, VLMoneda$
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "T"
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMMapeaObjeto sqlconn&, lblDescripcion(9)
                 PMChequea sqlconn&
            Else
                txtCampo(1).Text = ""
                lblDescripcion(9).Caption = ""
                VLPaso% = True
            End If
        Else
           VLPaso% = True
           lblDescripcion(5).Caption = ""
        End If
        End If
    Case 2
        If VLPaso% = False Then
            If txtCampo(2).Text <> "" Then
                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4077"
                 PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "H"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
                 PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(4).Text
                 PMPasoValores sqlconn&, "@i_pro_final", 0, SQLINT2, txtCampo(2).Text
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_prodfin", True, " Consulta del producto ") Then
                    ReDim VTArreglo(3) As String
                     VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
                     PMChequea sqlconn&
                    lblDescripcion(0).Caption = VTArreglo(1)
                    VLMoneda$ = VTArreglo(2)
                     'PMMapeaObjeto SqlConn&, lblDescripcion(0)
                     'PMChequea SqlConn&
                Else
                    lblDescripcion(0).Caption = ""
                    txtCampo(2).Text = ""
                    VLMoneda$ = ""
                    VLPaso% = True
                End If
            Else
                lblDescripcion(0).Caption = ""
                'PMLimpiaGrid grdtasas
                PMBorrarGrid grdtasas
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
            End If
        End If
    
    Case 3
        If VLPaso% = False Then
            If txtCampo(1).Text = "" Then
                MsgBox "El tipo de rango es mandatorio", 0 + 16, "Mensaje de Error"
                txtCampo(1).SetFocus
                Exit Sub
            End If
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4038"
             PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
             PMPasoValores sqlconn&, "@i_grupo", 0, SQLINT2, txtCampo(3).Text
             PMPasoValores sqlconn&, "@i_modo", 0, SQLCHAR, "G"
             PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(1).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_help_rango_pe", False, "Ok...Consulta de Servicios") Then
                 PMChequea sqlconn&
            Else
                txtCampo(3).Text = ""
                VLPaso% = True
            End If
       End If

    Case 4
        If VLPaso% = False Then
            If txtCampo(4).Text <> "" Then

                 PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4078"
                 PMPasoValores sqlconn&, "@i_codigo", 0, SQLINT2, txtCampo(4).Text
                 PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "V"
                 PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial
                 If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", True, " Consulta del producto ") Then
                 'If FMTransmitirRPC(SqlConn&, ServerName$, "cob_remesas", "sp_hp_sucursal", True, " Consulta del producto ") Then
                     PMMapeaObjeto sqlconn&, lblDescripcion(12)
                     PMChequea sqlconn&
                Else
                    lblDescripcion(12).Caption = ""
                    txtCampo(4).Text = ""
                    VLPaso% = True
                    txtCampo(4).SetFocus
                End If
            Else
                lblDescripcion(12).Caption = ""
                'PMLimpiaGrid grdtasas
                PMBorrarGrid grdtasas
                cmdBoton(0).Enabled = True
                cmdBoton(3).Enabled = False
            End If
        End If
    
    End Select

End Sub

Private Sub grdtasas_LeaveCell(ByVal Col As Long, ByVal Row As Long, ByVal NewCol As Long, ByVal NewRow As Long, Cancel As Boolean)
'****************************************************************
' PROPOSITO: Marcar la fila seleccionada y no permitir
'            que se desmarque la selección
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'****************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 21-Dic-98      X. Ramos        Emision Inicial
'****************************************************************

    If NewRow > -1 Then     'el grid no pierde el foco
        'marcar registro seleccionado
        PMMarcaFilaGrid grdtasas, NewRow
        VLPosGrid& = NewRow
    End If
End Sub
Sub PLConfigurarImpresion()
'**************************************************************
' PROPOSITO: Configura los datos requeridos para la impresión de
'            reportes.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'**************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 10-Ene-05      D. Villagomez   Emision Inicial
'**************************************************************

'FIXIT: Declare 'VTColumnas' with an early-bound data type                                 FixIT90210ae-R1672-R1B8ZE
    Dim VTColumnas As Integer         'Contiene los índices de las columnas a imprimir
'FIXIT: Declare 'VTSepColumnas' with an early-bound data type                              FixIT90210ae-R1672-R1B8ZE
    Dim VTSepColumnas As Integer      'Contiene las separaciones en caracteres de las columnas
'FIXIT: Declare 'VTCapSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTCapSubtitulos As Integer    'Contiene los números de recursos para los Nombres de los subtítulos
'FIXIT: Declare 'VTValSubtitulos' with an early-bound data type                            FixIT90210ae-R1672-R1B8ZE
    Dim VTValSubtitulos As Variant    'Contiene los números de recursos para los Valores de los subtítulos
    Dim VTNumColumnas As Integer      'Contiene el número de filas a imprimir
'FIXIT: Declare 'VTAlineacion' with an early-bound data type                               FixIT90210ae-R1672-R1B8ZE
    Dim VTAlineacion As Integer

        VTNumColumnas% = 6
        
        VTSepColumnas = Array(10, 20, 15, 15, 15, 15)
        VTColumnas = Array(1, 8, 2, 3, 5, 10)
        VTCapSubtitulos = Array(5020, 5021, 5022, 5014, 5023, 5024, 5025)
       
        'Configuración de los valores de los subtítulos
        VTValSubtitulos = Array("", "", "", "", "", "", "", "") 'Inicialización del arreglo
        VTValSubtitulos(0) = LoadResString(5026)    'Tipo de ejecución
        VTValSubtitulos(1) = VGLogin$
        VTValSubtitulos(2) = txtCampo(4).Text + "  " + lblDescripcion(12).Caption 'sucursal
        VTValSubtitulos(3) = txtCampo(2).Text + "  " + lblDescripcion(0).Caption ' producto final
        VTValSubtitulos(4) = txtCampo(0).Text + "  " + lblDescripcion(1).Caption ' servicio disponible
        VTValSubtitulos(5) = lblDescripcion(11).Caption + "  " + lblDescripcion(5).Caption ' rubro
        If txtCampo(1).Text = "" Then
            VTValSubtitulos(6) = LoadResString(9001)
        Else
            VTValSubtitulos(6) = txtCampo(1).Text + "  " + lblDescripcion(9).Caption ' tipo de rango
        End If
        
        
        VTAlineacion = Array(CG_LEFT_ALIGN%, CG_LEFT_ALIGN%, CG_RIGHT_ALIGN%, CG_RIGHT_ALIGN%, CG_RIGHT_ALIGN%, CG_RIGHT_ALIGN%)
        'Llamada al procedimiento de Impresión de Reportes
        PMImprimirReporte grdtasas, VTNumColumnas%, VTColumnas, VTSepColumnas, 3008, VTCapSubtitulos, VTValSubtitulos, VTAlineacion, CG_LANDSCAPE%

End Sub

Private Sub txtCampo_MouseDown(Index As Integer, Button As Integer, Shift As Integer, X As Single, Y As Single)
    Select Case Index
        Case 0, 1, 2, 4
             Clipboard.Clear
             Clipboard.SetText ""
    End Select
End Sub


