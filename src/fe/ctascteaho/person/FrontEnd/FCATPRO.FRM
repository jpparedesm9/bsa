VERSION 5.00
Object = "{A8B3B723-0B5A-101B-B22E-00AA0037B2FC}#1.0#0"; "Grid32.ocx"
Begin VB.Form FCatProFinal 
   Appearance      =   0  'Flat
   Caption         =   "Categorías por Producto Final"
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
   Begin VB.Frame Frame1 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   6735
      TabIndex        =   21
      Top             =   920
      Width           =   1590
      Begin VB.OptionButton optContrac 
         Caption         =   "Si"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   2
         Left            =   120
         TabIndex        =   22
         Top             =   150
         Width           =   600
      End
      Begin VB.OptionButton optContrac 
         Caption         =   "No"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   3
         Left            =   900
         TabIndex        =   23
         TabStop         =   0   'False
         Top             =   150
         Value           =   -1  'True
         Width           =   600
      End
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
   Begin MSGrid.Grid grdCategorias 
      Height          =   3675
      Left            =   15
      TabIndex        =   5
      Top             =   1635
      Width           =   8325
      _Version        =   65536
      _ExtentX        =   14685
      _ExtentY        =   6483
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
   Begin VB.Frame frmEstado 
      Appearance      =   0  'Flat
      ForeColor       =   &H80000008&
      Height          =   435
      Left            =   1800
      TabIndex        =   13
      Top             =   920
      Width           =   2430
      Begin VB.OptionButton optPosteo 
         Caption         =   "Postear"
         ForeColor       =   &H00800000&
         Height          =   225
         Index           =   0
         Left            =   90
         TabIndex        =   3
         Top             =   135
         Value           =   -1  'True
         Width           =   990
      End
      Begin VB.OptionButton optPosteo 
         Caption         =   "No Postear"
         ForeColor       =   &H00800000&
         Height          =   210
         Index           =   1
         Left            =   1110
         TabIndex        =   4
         TabStop         =   0   'False
         Top             =   135
         Width           =   1230
      End
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
      Left            =   8430
      Picture         =   "FCATPRO.frx":0000
      Style           =   1  'Graphical
      TabIndex        =   15
      Tag             =   "4101"
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
      Left            =   8430
      Picture         =   "FCATPRO.frx":0262
      Style           =   1  'Graphical
      TabIndex        =   16
      Tag             =   "4113"
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
      Picture         =   "FCATPRO.frx":056C
      Style           =   1  'Graphical
      TabIndex        =   17
      Tag             =   "4114"
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
      Picture         =   "FCATPRO.frx":0876
      Style           =   1  'Graphical
      TabIndex        =   18
      Tag             =   "4115"
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
      Picture         =   "FCATPRO.frx":0BDC
      Style           =   1  'Graphical
      TabIndex        =   19
      Top             =   4560
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
      Picture         =   "FCATPRO.frx":0F42
      Style           =   1  'Graphical
      TabIndex        =   20
      Top             =   3795
      Width           =   870
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Caracteristicas Especiales:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   3
      Left            =   4260
      TabIndex        =   24
      Top             =   1050
      Width           =   2310
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   2
      Left            =   2750
      TabIndex        =   9
      Top             =   615
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Líneas Pendientes:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   1
      Left            =   60
      TabIndex        =   14
      Top             =   1050
      Width           =   1665
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categoría:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   0
      Left            =   60
      TabIndex        =   10
      Top             =   650
      Width           =   915
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   2
      Left            =   60
      TabIndex        =   11
      Top             =   350
      Width           =   1305
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   1
      Left            =   2750
      TabIndex        =   12
      Top             =   315
      Width           =   5590
   End
   Begin VB.Label lblDescripcion 
      Appearance      =   0  'Flat
      BorderStyle     =   1  'Fixed Single
      ForeColor       =   &H80000008&
      Height          =   285
      Index           =   0
      Left            =   2750
      TabIndex        =   7
      Top             =   15
      Width           =   5590
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Sucursal:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   7
      Left            =   60
      TabIndex        =   8
      Top             =   50
      Width           =   810
   End
   Begin VB.Label lblEtiqueta 
      Appearance      =   0  'Flat
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Categorías por Producto Final:"
      ForeColor       =   &H00800000&
      Height          =   195
      Index           =   4
      Left            =   45
      TabIndex        =   6
      Top             =   1425
      Width           =   2625
   End
   Begin VB.Line Line1 
      BorderColor     =   &H00800000&
      BorderWidth     =   2
      Index           =   1
      X1              =   -15
      X2              =   8355
      Y1              =   1395
      Y2              =   1395
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
Attribute VB_Name = "FCatProFinal"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
'TODO: Auto-fix by Project Analyzer v9.0.05 on 14/08/2010
'*************************************************************
' ARCHIVO:          FCATPRO.FRM
' NOMBRE LOGICO:    FCatProFinal
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
' Realiza el mantenimiento de las Categorías por Producto Final
'*************************************************************
'                       MODIFICACIONES
' FECHA          AUTOR               RAZON
' 26-Ene-95      Angela Rodríguez    Emisión Inicial
'*************************************************************

Dim VLPaso As Integer
Dim VLProducto As String

Private Sub cmdBoton_Click(Index As Integer)
    Const MB_YESNO = 4
    Const MB_ICONQUESTION = 32
    Const MB_DEBUTTON1 = 0
    '! removed Const IDCANCEL = 2
    '! removed Const IDNO = 7
    '! removed Const MB_DEFBUTTON1 = 0
    Const IDYES = 6
'FIXIT: Declare 'DgDef' and 'Response' with an early-bound data type                       FixIT90210ae-R1672-R1B8ZE
    Dim DgDef As Integer
    Dim Response As String
    Dim VTPosteo$
    Dim VTContrac$
    DgDef = MB_YESNO + MB_ICONQUESTION + MB_DEBUTTON1
    
    Select Case Index%
    Case 0
        'Buscar
        
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

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "S"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Consulta de Categorías por Producto Final") Then
             PMMapeaGrid sqlconn&, grdCategorias, False
             PMChequea sqlconn&

            grdCategorias.ColWidth(1) = 1000
            grdCategorias.ColWidth(2) = 5750
            grdCategorias.ColWidth(3) = 1000

            PLModoInsertar True
            PLLimpiar "=", 3
            PLLimpiar "=", 4
        End If
        

    Case 1
        'Crear
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
        
        If optPosteo(0).Value Then
            VTPosteo$ = "S"
        ElseIf optPosteo(1).Value Then
            VTPosteo$ = "N"
        End If

        If optContrac(2).Value Then
            VTContrac$ = "S"
        ElseIf optContrac(3).Value Then
            VTContrac$ = "N"
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "I"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_posteo", 0, SQLCHAR, VTPosteo$
         PMPasoValores sqlconn&, "@i_contractual", 0, SQLCHAR, VTContrac$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Creación de Categoría por Producto Final") Then
             PMChequea sqlconn&
            cmdBoton_Click (0)
        End If
    
    Case 2
        'Eliminar
        Response = MsgBox("Desea Eliminar la Categoria por Producto Final?", DgDef, "Mensaje de Seguridad")
        If Response = IDYES Then
             PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
             PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "D"
             PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
             PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
             If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Creación de Categoría por Producto Final") Then
                 PMChequea sqlconn&
                cmdBoton_Click (0)
            End If
        Else
            Exit Sub
        End If

    Case 3

        'Limpiar
        PLLimpiar ">", 0
        PLModoInsertar True
        txtCampo(0).SetFocus
         
    Case 4
        'Salir
        Unload FCatProFinal
    
    Case 5
        'Actualizar
        If optPosteo(0).Value Then
            VTPosteo$ = "S"
        ElseIf optPosteo(1).Value Then
            VTPosteo$ = "N"
        End If

        If optContrac(2).Value Then
            VTContrac$ = "S"
        ElseIf optContrac(3).Value Then
            VTContrac$ = "N"
        End If

         PMPasoValores sqlconn&, "@t_trn", 0, SQLINT2, "4101"
         PMPasoValores sqlconn&, "@i_oper", 0, SQLCHAR, "U"
         PMPasoValores sqlconn&, "@i_profinal", 0, SQLINT2, txtCampo(1).Text
         PMPasoValores sqlconn&, "@i_categoria", 0, SQLCHAR, txtCampo(2).Text
         PMPasoValores sqlconn&, "@i_posteo", 0, SQLCHAR, VTPosteo$
         PMPasoValores sqlconn&, "@i_contractual", 0, SQLCHAR, VTContrac$
         If FMTransmitirRPC(sqlconn&, ServerName$, "cob_remesas", "sp_categoria_profinal", True, " Ok... Actualización de Categoría por Producto Final") Then
             PMChequea sqlconn&
            cmdBoton_Click (0)
        End If

    End Select
End Sub

Private Sub Form_Load()

    '*********************************************************
    'Objetivo:  Carga la forma que se encargara de crear
    '           y eliminar categorías por productos finales
    '*********************************************************
    '                    MODIFICACIONES
    'FECHA      AUTOR               RAZON
    '20/Ene/99  J. Salazar          Emisión Inicial
    '*********************************************************

    ' Coordenadas para el despliegue de la forma
    
    FCatProFinal.Left = 0    '15
    FCatProFinal.Top = 0    '15
    FCatProFinal.Width = 9450   '9420
    FCatProFinal.Height = 5900   '5730

 PMLoadResStrings Me
 PMLoadResIcons Me
 PLModoInsertar True
 PMBotonSeguridad FCatProFinal, 5
 
 PMObjetoSeguridad cmdBoton(0)
 PMObjetoSeguridad cmdBoton(5)
 PMObjetoSeguridad cmdBoton(1)
 PMObjetoSeguridad cmdBoton(2)
 
 FPrincipal.pnlHelpLine.Caption = "FCatProFinal - Version VSS 5"

End Sub

Private Sub Form_Unload(Cancel As Integer)
    FPrincipal.pnlHelpLine.Caption = ""
    FPrincipal.pnlTransaccionLine.Caption = ""
End Sub

Private Sub grdCategorias_Click()
    
    grdCategorias.Col = 0
    grdCategorias.SelStartCol = 1
    grdCategorias.SelEndCol = grdCategorias.Cols - 1
    If grdCategorias.Row = 0 Then
        grdCategorias.SelStartRow = 1
        grdCategorias.SelEndRow = 1
    Else
        grdCategorias.SelStartRow = grdCategorias.Row
        grdCategorias.SelEndRow = grdCategorias.Row
    End If

End Sub

Private Sub grdCategorias_DblClick()
Dim VTRow%
    VTRow% = grdCategorias.Row
    grdCategorias.Row = 1
    grdCategorias.Col = 1

    If Trim$(grdCategorias.Text) <> "" Then
        grdCategorias.Row = VTRow%
        PMMarcarRegistro
        
        PLModoInsertar False
    End If

End Sub

Private Sub grdCategorias_GotFocus()
    FPrincipal.pnlHelpLine.Caption = " Haga doble click para habiliar el botón elimiar"
End Sub

Private Sub optPosteo_GotFocus(Index As Integer)
    Select Case Index%
    Case 0, 1
        FPrincipal.pnlHelpLine.Caption = " Estado de las líneas pendientes"
    End Select

End Sub

Private Sub PLLimpiar(tipo As String, Numero As Integer)
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
    Select Case tipo
        Case "="
            If Numero <= 3 Then
                txtCampo(Numero - 1).Text = ""
                lblDescripcion(Numero - 1).Caption = ""
                If Numero = 2 Then
                    optPosteo(0).Value = True
                    optPosteo(0).Enabled = True
                    optPosteo(1).Enabled = True
                    optContrac(3).Value = True

                End If
            ElseIf Numero = 5 Then
                PMLimpiaGrid grdCategorias
            End If
            
        Case ">"
            For i% = Numero To 4
                PLLimpiar "=", i% + 1
            Next i%
        Case "<"
            For i% = Numero To 2 Step -1
                PLLimpiar "=", i% - 1
            Next i%
    End Select

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
    txtCampo(0).Enabled = Modo 'Sucursal
    txtCampo(1).Enabled = Modo 'Producto final
    txtCampo(2).Enabled = Modo 'Categoría

    'optPosteo(0).Enabled = Modo 'Postear
    'optPosteo(1).Enabled = Modo 'No postear

    
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
    grdCategorias.Col = 1
    txtCampo(2).Text = grdCategorias.Text
    
    grdCategorias.Col = 2
    lblDescripcion(2).Caption = grdCategorias.Text
    
    grdCategorias.Col = 3
    If grdCategorias.Text = "S" Then
        optPosteo(0).Value = True
    Else
        optPosteo(1).Value = True
    End If
    grdCategorias.Col = 4
    If grdCategorias.Text = "S" Then
        optContrac(2).Value = True
    Else
        optContrac(3).Value = True
    End If

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
        FPrincipal.pnlHelpLine.Caption = " Código de Sucursal [F5 Ayuda]"
    Case 1
       FPrincipal.pnlHelpLine.Caption = " Código del Producto Final [F5 Ayuda]"
    Case 2
       FPrincipal.pnlHelpLine.Caption = " Código de la Categoría [F5 Ayuda]"
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
        PLLimpiar "=", 2
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
                PLLimpiar "=", 1
            End If

        Else
            PLLimpiar "=", 1
            VGOperacion$ = ""
        End If

    Case 1
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            PLLimpiar "<", 3
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
            If VLProducto = "3" Then
                optPosteo(1).Value = True
                optPosteo(0).Enabled = False
                optPosteo(1).Enabled = False
            Else
                optPosteo(0).Value = True
                optPosteo(0).Enabled = True
                optPosteo(1).Enabled = True
            End If
            VLPaso% = True
        Else
            txtCampo(1).Text = ""
            lblDescripcion(1).Caption = ""
            optPosteo(0).Value = True
            optPosteo(0).Enabled = True
            optPosteo(1).Enabled = True
            VGOperacion$ = ""
            VLProducto$ = ""
        End If

    Case 2
        PMCatalogo "A", "pe_categoria", txtCampo(2), lblDescripcion(2)
        VLPaso% = True
    End Select
End If
End Sub

Private Sub txtCampo_KeyPress(Index As Integer, KeyAscii As Integer)
 Select Case Index%
    Case 0, 1
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) Then
            KeyAscii% = 0
        End If
    Case 2
        If (KeyAscii% <> 8) And (KeyAscii <> 32) And ((KeyAscii < 48) Or (KeyAscii > 57)) And ((KeyAscii < 96) Or (KeyAscii > 123)) Then
            KeyAscii% = 0
        Else
            KeyAscii% = AscW(UCase$(Chr$(KeyAscii%)))
        End If
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
            PLLimpiar "=", 1
            txtCampo(0).SetFocus
            VLPaso% = True
        End If
        
    Case 1
        If Trim$(txtCampo(1).Text) = "" Then
            PLLimpiar "=", 2
            Exit Sub
        End If
        
        If Trim$(txtCampo(0).Text) = "" Then
            MsgBox "El código de la sucursal es mandatorio", 0 + 16, "Mensaje de Error"
            PLLimpiar "<", 3
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
            If VLProducto <> "4" Then
                optPosteo(1).Value = True
                optPosteo(0).Enabled = False
                optPosteo(1).Enabled = False
            Else
                optPosteo(0).Value = True
                optPosteo(0).Enabled = True
                optPosteo(1).Enabled = True
            End If
        Else
            PLLimpiar "=", 2
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


