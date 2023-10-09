VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FMantTranAutorizada 
   Appearance      =   0  'Flat
   Caption         =   "*Autorizacion de Transacciones en Caja"
   ClientHeight    =   5325
   ClientLeft      =   885
   ClientTop       =   1350
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
   MaxButton       =   0   'False
   MDIChild        =   -1  'True
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   5325
   ScaleWidth      =   9345
   Tag             =   "3009"
   Begin VB.ComboBox cmbModulo 
      Height          =   315
      Left            =   1800
      TabIndex        =   4
      Top             =   1220
      Width           =   1215
   End
   Begin VB.ComboBox cmbAutoriza 
      Height          =   315
      Left            =   1800
      TabIndex        =   5
      Top             =   1530
      Width           =   1215
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   3
      Left            =   1800
      MaxLength       =   10
      TabIndex        =   3
      Top             =   920
      Width           =   1170
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   2
      Left            =   1800
      MaxLength       =   3
      TabIndex        =   2
      Top             =   615
      Width           =   1170
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   1
      Left            =   1800
      MaxLength       =   4
      TabIndex        =   1
      Top             =   315
      Width           =   1170
   End
   Begin VB.TextBox txtCampo 
      Appearance      =   0  'Flat
      Height          =   285
      Index           =   0
      Left            =   1800
      MaxLength       =   5
      TabIndex        =   0
      Top             =   15
      Width           =   1170
   End
   Begin MSGrid.Grid grdTransacciones 
      Height          =   2955
      Left            =   15
      TabIndex        =   12
      Top             =   2355
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14684
      _ExtentY        =   5212
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
      Caption         =   "&Buscar"
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
      Height          =   750
      Index           =   0
      Left            =   8400
      Picture         =   "fmantrn.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   6
      Tag             =   "730"
      Top             =   45
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Crear"
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
      Height          =   750
      Index           =   1
      Left            =   8400
      Picture         =   "fmantrn.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   7
      Tag             =   "728"
      Top             =   1515
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Actualizar"
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
      Height          =   750
      Index           =   5
      Left            =   8430
      Picture         =   "fmantrn.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   8
      Tag             =   "729"
      Top             =   2280
      Width           =   870
   End
   Begin VB.CommandButton cmdBoton 
      Caption         =   "&Eliminar"
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
      Index           =   2
      Left            =   8430
      Picture         =   "fmantrn.frx":0E36
      Style           =   1  'Graphical
      TabIndex        =   9
      Tag             =   "729"
      Top             =   3045
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
      Height          =   750
      Index           =   4
      Left            =   8430
      Picture         =   "fmantrn.frx":119C
      Style           =   1  'Graphical
      TabIndex        =   11
      Top             =   4545
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
      Height          =   750
      Index           =   3
      Left            =   8430
      Picture         =   "fmantrn.frx":1502
      Style           =   1  'Graphical
      TabIndex        =   10
      Top             =   3795
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Módulo:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   6
      Left            =   60
      TabIndex        =   23
      Top             =   1230
      WhatsThisHelpID =   5029
      Width           =   765
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Autorizada:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   5
      Left            =   60
      TabIndex        =   22
      Top             =   1560
      WhatsThisHelpID =   5030
      Width           =   1050
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   3
      Left            =   2985
      TabIndex        =   21
      Top             =   920
      Width           =   5355
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Transacción:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   60
      TabIndex        =   20
      Top             =   920
      WhatsThisHelpID =   5028
      Width           =   1200
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2985
      TabIndex        =   16
      Top             =   615
      Width           =   5355
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Categoria:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   17
      Top             =   600
      WhatsThisHelpID =   5027
      Width           =   960
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Producto:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   18
      Top             =   300
      WhatsThisHelpID =   5014
      Width           =   915
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2985
      TabIndex        =   19
      Top             =   315
      Width           =   5355
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2985
      TabIndex        =   14
      Top             =   15
      Width           =   5355
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   15
      Top             =   15
      WhatsThisHelpID =   5019
      Width           =   885
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "*Autorización de Transacciones por Caja:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   0
      TabIndex        =   13
      Top             =   2040
      WhatsThisHelpID =   5031
      Width           =   3540
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   0
      X2              =   8370
      Y1              =   1920
      Y2              =   1920
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   0
      X1              =   8370
      X2              =   8370
      Y1              =   0
      Y2              =   5385
   End
End
Attribute VB_Name = "FMantTranAutorizada"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FMANTRN.FRM
' NOMBRE LOGICO:    FMantTranAutorizada
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
' Permite el mantenimiento de los ciclos por Producto Final.
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
'*************************************************************

Dim VLPaso As Integer
Dim VLProducto As String
'! removed Dim VLCicloAnt As String

'! removed Dim VLEstado As String


Const MB_YESNO = 4
Const MB_ICONQUESTION = 32
Const MB_DEBUTTON1 = 0
'! removed Const IDCANCEL = 2
'! removed Const IDNO = 7
'! removed Const MB_DEFBUTTON1 = 0
Const IDYES = 6
'FIXIT: Declare 'DgDef' with an early-bound data type                                      FixIT90210ae-R1672-R1B8ZE
Dim DgDef As Integer

Private Sub cmdBoton_Click(Index As Integer)
    
    
    Select Case Index%
    Case 0
        'Buscar
        PLBuscar

    Case 1
        'Crear
        PLCrear
    
    Case 2
        'Eliminar
        PLActualizar True, "E"

    Case 3

        'Limpiar
        PLLimpiar
        PLModoInsertar True
        txtCampo(0).SetFocus
         
    Case 4
        'Salir
        Unload FMantTranAutorizada
    
    Case 5
        'Actualizar
        PLActualizar False, "V"

    End Select
End Sub

Private Sub PLActualizar(VLElimina As Boolean, VLEstado As String)

'FIXIT: Declare 'Response' with an early-bound data type                                   FixIT90210ae-R1672-R1B8ZE
Dim Response As String

DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1

If VLElimina = True Then
    Response = MsgBox("Desea Eliminar la Transacción para el Producto?", DgDef, "Mensaje de Seguridad")
Else
    Response = IDYES
End If

If Response = IDYES Then

    If Trim$(txtCampo(0).Text) = "" Then
        MsgBox "El código del sucursal es mandatorio", vbCritical + vbOKOnly, "Atención"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(1).Text) = "" Then
        MsgBox "El código del producto es mandatorio", vbCritical + vbOKOnly, "Atención"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(2).Text) = "" Then
        MsgBox "La categoria es mandatorio", vbCritical + vbOKOnly, "Atención"
        txtCampo(0).SetFocus
        Exit Sub
    End If

    If Trim$(txtCampo(3).Text) = "" Then
        MsgBox "El código de la transacción es mandatorio", vbCritical + vbOKOnly, "Atención"
        txtCampo(0).SetFocus
        Exit Sub
    End If
    
'    If Trim$(txtCampo(4).Text) = "" Then
'        MsgBox "El código de la transacción es mandatorio", vbCritical + vbOKOnly, "Atención"
'        txtCampo(0).SetFocus
'        Exit Sub
'    End If
    
    If cmbAutoriza.Text = "" Then
        MsgBox "Debe seleccionar un valor para el campo Autorizada ", vbCritical + vbOKOnly, "Atención"
        txtCampo(3).SetFocus
        Exit Sub
    End If

     PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "729"
     PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "U"
     PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
     PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, txtCampo(1).Text
     PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
     PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4, txtCampo(3).Text
     PMPasoValores sqlconn&, "@i_modulo", 0, SQLCHAR, cmbModulo.Text
     Select Case cmbAutoriza.Text
     Case "SI"
       PMPasoValores sqlconn&, "@i_autorizada", 0, SQLCHAR, "S"
     Case "NO"
       PMPasoValores sqlconn&, "@i_autorizada", 0, SQLCHAR, "N"
     End Select
     PMPasoValores sqlconn&, "@i_estado", 0, SQLCHAR, VLEstado 'now() PENDIENTE
     If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, " Ok... Actualización de ciclo por Producto Final") Then
        PMChequea sqlconn&
        PLLimpiar
        cmdBoton_Click (0)
    Else
        PMChequea sqlconn&
    End If
Else
    Exit Sub
End If

End Sub
Private Sub PLBuscar()

        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "730"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
        If Trim$(txtCampo(0).Text) <> "" Then
            PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
        End If

        If Trim$(txtCampo(1).Text) <> "" Then
            PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, txtCampo(1).Text
        End If

        If Trim$(txtCampo(2).Text) <> "" Then
            PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
        End If

        If Trim$(txtCampo(3).Text) <> "" Then
            PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4, txtCampo(3).Text
        End If
        
        If Trim$(cmbModulo.Text) <> "" Then
            PMPasoValores sqlconn&, "@i_modulo", 0, SQLCHAR, cmbModulo.Text
        End If
         
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, " Ok... Consulta de Transacciones Autorizadas") Then
             PMMapeaGrid sqlconn&, grdTransacciones, False
             PMChequea sqlconn&
            
            PLModoInsertar True
            'PLLimpiar "=", 3
            'PLLimpiar "=", 4
        End If

End Sub

Private Sub PLCrear()

        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código del sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(0).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(1).Text) = "" Then
            MsgBox "El código del producto es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(2).Text) = "" Then
            MsgBox "La categoria es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(2).SetFocus
            Exit Sub
        End If
        
        If Trim$(txtCampo(3).Text) = "" Then
            MsgBox "El código de la transacción es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If cmbModulo.Text = "" Then
            MsgBox "Debe seleccionar un valor para el campo Modulo ", vbCritical + vbOKOnly, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
        
        If cmbAutoriza.Text = "" Then
            MsgBox "Debe seleccionar un valor para el campo Autorizada ", vbCritical + vbOKOnly, "Mensaje de Error"
            txtCampo(3).SetFocus
            Exit Sub
        End If
'        If Trim$(txtCampo(3).Text) = "" Then
'            MsgBox "El código del tipo de capitalización es mandatorio", 0 + 16, "Mensaje de Error"
'            txtCampo(3).SetFocus
'            Exit Sub
'        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "728"
         PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_modulo", 0, SQLCHAR, cmbModulo.Text
         PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT4, txtCampo(0).Text
         PMPasoValores sqlconn&, "@i_producto", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4, txtCampo(3).Text
         Select Case cmbAutoriza.Text
         Case "SI"
            PMPasoValores sqlconn&, "@i_autorizada", 0, SQLCHAR, "S"
         Case "NO"
            PMPasoValores sqlconn&, "@i_autorizada", 0, SQLCHAR, "N"
         End Select
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, " Ok... Autorización de Transacción") Then
            PMChequea sqlconn&
            PLLimpiar
            cmdBoton_Click (0)
        Else
            PMChequea sqlconn&
        End If
        
End Sub

'Private Sub PLEliminar()
'Dim Response
'
'DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
'
'Response = MsgBox("Desea Eliminar la Transacción para el Producto?", DgDef, "Mensaje de Seguridad")
'        If Response = IDYES Then
'             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "XXXXX"
'             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "D"
'             PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
'             PMPasoValores sqlconn&, "@i_ciclo", 0, SQLCHAR, txtCampo(2).Text
'             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_mant_trn_autorizadas", True, " Ok... Creación de Ciclo por Producto Final") Then
'                 PMChequea sqlconn&
'                cmdBoton_Click (0)
'             End If
'        Else
'            Exit Sub
'        End If
'End Sub

Private Sub Form_Load()

    '*********************************************************
    'PROPOSITO:  Carga la forma que se encargara de crear
    '           y eliminar categorías por productos finales
    'INPUT   :  ninguno
    'OUTPUT  :  ninguno
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '20/Ene/99  J. Salazar          Emisión Inicial
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FMantTranAutorizada.Left = 0    '15
    FMantTranAutorizada.Top = 0    '15
    FMantTranAutorizada.Width = 9450   '9420
    FMantTranAutorizada.Height = 5900   '5730

 PMLoadResStrings Me
 PMLoadResIcons Me
 PLModoInsertar True
 PMBotonSeguridad FMantTranAutorizada, 5
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(5)
 PMObjetoSeguridad cmdBoton(1)
 PMObjetoSeguridad cmdBoton(2)
 
 cmbAutoriza.Clear
 cmbAutoriza.AddItem "SI", 0
 cmbAutoriza.AddItem "NO", 1
 cmbAutoriza.ListIndex = 0
 
 cmbModulo.Clear
 cmbModulo.AddItem "AHO", 0
 cmbModulo.AddItem "CTE", 1
 cmbModulo.ListIndex = 0
 
 FPrincipal.pnlHelpLine.Caption = "FMantTranAutorizada - Version VSS 4"
 
End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdTransacciones_Click()
    
    grdTransacciones.Col = 0
    grdTransacciones.SelStartCol = 1
    grdTransacciones.SelEndCol = grdTransacciones.Cols - 1
    If grdTransacciones.Row = 0 Then
        grdTransacciones.SelStartRow = 1
        grdTransacciones.SelEndRow = 1
    Else
        grdTransacciones.SelStartRow = grdTransacciones.Row
        grdTransacciones.SelEndRow = grdTransacciones.Row
    End If

End Sub

Private Sub grdTransacciones_DblClick()
Dim VTRow%
    VTRow% = grdTransacciones.Row
    grdTransacciones.Row = 1
    grdTransacciones.Col = 1

    If Trim$(grdTransacciones.Text) <> "" Then
        grdTransacciones.Row = VTRow%
        PMMarcarRegistro
        
        PLModoInsertar False
        'txtCampo(2).Enabled = Not Modo
        cmbModulo.Enabled = False
    End If

End Sub

Private Sub grdTransacciones_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para habiliar el botón elimiar"
End Sub

'! Private Sub optPosteo_GotFocus(Index As Integer)
'!     Select Case Index%
'!     Case 0, 1
'!         FPrincipal!pnlHelpLine.Caption = " Estado de las líneas pendientes"
'!     End Select
'!
'! End Sub
'!
Private Sub PLLimpiar()
'*************************************************************
' PROPOSITO: Limpia los objetos y el grid, bajo ciertas
'            condiciones.
' INPUT    : Tipo = El símbolo que indica el rango de valores
'                   de los objetos y el grid a ser limpiados.
'            Numero = El número desde el cual se parte el
'                     barrido y limpiado de los objetos
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    Dim i%
For i% = 0 To 3
    lblDescripcion(i%).Caption = ""
Next i%

For i% = 0 To 3
    txtCampo(i%).Text = ""
    txtCampo(i%).Enabled = True
Next i%

cmbModulo.Enabled = True
cmbModulo.ListIndex = 0
cmbAutoriza.ListIndex = 0
PMLimpiaGrid grdTransacciones
End Sub

Private Sub PLModoInsertar(Modo As Integer)
'*************************************************************
' PROPOSITO: Habilita o deshabilita ciertos objetos de la
'            forma.
' INPUT    : Modo = Entero que indica si el campo se habilita
'                   o no.
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    txtCampo(0).Enabled = Modo 'Modulo
    txtCampo(1).Enabled = Modo 'Producto
    txtCampo(2).Enabled = Modo 'Transaccion
    txtCampo(3).Enabled = Modo 'Autorizada
    
    If Modo Then
         PMObjetoSeguridad cmdBoton(1)
         cmdBoton(2).Enabled = Not Modo 'Eliminar
         cmdBoton(5).Enabled = Not Modo 'Actualizar
    Else
         cmdBoton(1).Enabled = Modo 'Crear
         PMObjetoSeguridad cmdBoton(2)
         PMObjetoSeguridad cmdBoton(5)
    End If
    
    'cmdBoton(1).Enabled = Modo 'Crear
    'cmdBoton(2).Enabled = Not Modo 'Eliminar
    'cmdBoton(5).Enabled = Not Modo 'Actualizar
    
End Sub

Private Sub PMMarcarRegistro()
'*************************************************************
' PROPOSITO: Captura los valores respectivos del grid,
'            y los coloca en ciertos objetos de la forma.
' INPUT    : Ninguno
' OUTPUT   : Ninguno
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR           RAZON
' 27-Ene-94      A.Rodríguez     Emisión Inicial
'*************************************************************
    grdTransacciones.Col = 1
    Select Case grdTransacciones.Text
        Case "AHO"
            cmbModulo.ListIndex = 0
        Case "CTE"
            cmbModulo.ListIndex = 1
    End Select
    grdTransacciones.Col = 2
    txtCampo(3).Text = grdTransacciones.Text
    txtCampo_LostFocus 3
    grdTransacciones.Col = 3
    txtCampo(0).Text = grdTransacciones.Text
    txtCampo_LostFocus 0
    grdTransacciones.Col = 4
    txtCampo(1).Text = grdTransacciones.Text
    txtCampo_LostFocus 1
    grdTransacciones.Col = 5
    txtCampo(2).Text = grdTransacciones.Text
    txtCampo_LostFocus 2
    grdTransacciones.Col = 6
    Select Case grdTransacciones.Text
        Case "S"
            cmbAutoriza.ListIndex = 0
        Case "N"
            cmbAutoriza.ListIndex = 1
    End Select
    
End Sub

Private Sub txtCampo_Change(Index As Integer)
Select Case Index%
    Case 0, 1, 2, 3
        VLPaso% = False
End Select
End Sub

Private Sub txtCampo_GotFocus(Index As Integer)
    VLPaso% = True
    Select Case Index%
    Case 0
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Producto Final [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Código de la Categoría [F5 Ayuda]"
    Case 3
       FPrincipal.pnlHelpLine.Caption = " Código de la Transacción [F5 Ayuda]"
    End Select

    ' Resalta el contenido del objeto
    
    txtCampo(Index%).SelStart = 0
    txtCampo(Index%).SelLength = Len(txtCampo(Index%).Text)

End Sub

Private Sub txtCampo_KeyDown(Index As Integer, KeyCode As Integer, Shift As Integer)
Dim VTFilas%
Dim VTProFinal$

If KeyCode% = VGTeclaAyuda% Then
    VLPaso% = True
    Select Case Index%
    Case 0
        VGOperacion$ = "sp_hp_sucursal"
         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "4079"
         PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
         PMPasoValores sqlconn&, "@i_tipo", 0, SQLCHAR, "A"
         If FMTransmitirRPC(sqlconn&, ServerName$, "cobis", "sp_hp_sucursal", False, "") Then
            Load FRegistros
             PMMapeaGrid sqlconn&, FRegistros.grdRegistros, False
             PMChequea sqlconn&
            VLPaso% = True 'No permite que se ejecute el lostfocus, cuando se muestre el catalogo
            FRegistros.Show 1
            
            If VGValores(1) <> "" Then
                txtCampo(0).Text = VGValores(1)
                lblDescripcion(0).Caption = VGValores(2)
                VLPaso% = True
            Else
                VGOperacion$ = ""
                txtCampo(0).Text = ""
                lblDescripcion(0).Caption = ""
            End If

        Else
            txtCampo(0).Text = ""
            lblDescripcion(0).Caption = ""
            VGOperacion$ = ""
        End If

    Case 1
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).Text = ""
            VLPaso% = True
            txtCampo(0).SetFocus
            Exit Sub
        End If
    
        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_prodfin3"
        Load FRegistros
        While VTFilas% = VGMaxRows%
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2&, "4011"
             PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "S"
             PMPasoValores sqlconn&, "@i_filial", 0, SQLINT1, VGFilial$
             PMPasoValores sqlconn&, "@i_sucursal", 0, SQLINT2, txtCampo(0).Text
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
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                VGOperacion$ = ""
            End If
        Wend

        FRegistros.grdRegistros.Row = 1
        FRegistros.Show 1
            
        If VGValores(1) <> "" Then
            txtCampo(1).Text = VGValores(1)
            lblDescripcion(1).Caption = VGValores(2)
            VLProducto$ = VGValores(5)
            VLPaso% = True
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            VGOperacion$ = ""
            VLProducto$ = ""
        End If

    Case 2
        PMCatalogo "A", "pe_categoria", txtCampo(2), lblDescripcion(2)
        VLPaso% = True
        
    Case 3

        VTFilas% = VGMaxRows%
        VTProFinal$ = "0"
        VGOperacion$ = "sp_autoriza_trn_caja"
        Load FRegistros
        While VTFilas% = VGMaxRows%
            PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4&, "731"
            PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR&, "N"
            PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1&, "0"
            PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4&, VTProFinal$
    
            If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, "Ok... Consulta de Transacciones") Then
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
                txtCampo(1).Text = ""
                lblDescripcion(1).Caption = ""
                VGOperacion$ = ""
            End If
        Wend
        
        FRegistros.grdRegistros.Row = 1
        FRegistros.Show 1
            
        If VGValores(1) <> "" Then
            txtCampo(3).Text = VGValores(1)
            lblDescripcion(3).Caption = VGValores(2)
            VLPaso% = True
        Else
            txtCampo(3).Text = ""
            lblDescripcion(3).Caption = ""
            VGOperacion$ = ""
        End If
        
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
        KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
    End Select
End Sub

Private Sub txtCampo_LostFocus(Index As Integer)
Dim VTR%
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
            txtCampo(0).Text = ""
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
            lblDescripcion(0).Caption = ""
            txtCampo(0).SetFocus
            VLPaso% = True
        End If
        
    Case 1
        If Trim$(txtCampo(1).Text) = "" Then
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
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
            VLProducto$ = VTArreglo(3)

        Else
            lblDescripcion(1).Caption = ""
            txtCampo(1).SetFocus
            VLPaso% = True
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
        
    Case 3
        PMPasoValores sqlconn&, "@t_trn", 0, SQLINT4, "731"
        PMPasoValores sqlconn&, "@i_operacion", 0, SQLCHAR, "N"
        PMPasoValores sqlconn&, "@i_modo", 0, SQLINT1, "1"
        PMPasoValores sqlconn&, "@i_tran", 0, SQLINT4, txtCampo(3).Text
        If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_autoriza_trn_caja", True, " Consulta de Transaccion Caja ") Then
            ReDim VTArreglo(3) As String
            VTR% = FMMapeaArreglo(sqlconn&, VTArreglo())
            PMChequea sqlconn&
            lblDescripcion(3).Caption = VTArreglo(2)
        Else
            lblDescripcion(3).Caption = ""
            txtCampo(3).Text = ""
            txtCampo(3).SetFocus
            VLPaso% = True
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


